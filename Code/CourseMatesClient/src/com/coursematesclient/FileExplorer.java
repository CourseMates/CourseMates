package com.coursematesclient;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.ActionBarDrawerToggle;
import android.support.v4.widget.DrawerLayout;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ListView;
import android.widget.Toast;

public class FileExplorer extends Activity {

	//double press interval
	private static final long DOUBLE_PRESS_INTERVAL = 1442268014;/* some value in ns. */;
	private long lastPressTime;
	Activity activity = this;
//	Dialog dialog;

	ImageAndTextAdapter ia;
	int UserID , courseID;
	String session;
	GridView gridview ;
	FileItem rootfile;
	final Context context = this;
	ArrayList<ImageAndTextAdoptable> files = new  ArrayList<ImageAndTextAdoptable>() ;
	private FileItem parentFileObj;
	Toast toast ;
	 
	// Within which the entire activity is enclosed
    DrawerLayout mDrawerLayout;
 // ActionBarDrawerToggle indicates the presence of Navigation Drawer in the action bar
    ActionBarDrawerToggle mDrawerToggle;
 // Title of the action bar
    String mTitle="";
     ListView mDrawerList;
	//---------------------------------------------------------------------------------------------------//
	
	
	@SuppressLint("NewApi")
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.file_explorer_drawer_screen);
		
		
		//Navigation drawer region
		mTitle = (String) getTitle();
		//get string array from recourses
		String[] drawer_options_list  = getResources().getStringArray(R.array.fileEplorerDrawerOptions);
		mDrawerList = (ListView) (findViewById(R.id.left_drawer));
        // Getting reference to the DrawerLayout
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);  
        // Getting reference to the ActionBarDrawerToggle
        mDrawerToggle = new ActionBarDrawerToggle( this,
            mDrawerLayout,
            R.drawable.ic_drawer,
            R.string.drawer_open,
            R.string.drawer_close){
 
                /** Called when drawer is closed */
                public void onDrawerClosed(View view) {
                    getActionBar().setTitle(mTitle);
                    invalidateOptionsMenu();
                    mDrawerList.setItemChecked(-1, true);
                }
 
                /** Called when a drawer is opened */
                public void onDrawerOpened(View drawerView) {
                    getActionBar().setTitle("File Explorer Options");
                    invalidateOptionsMenu();
                }
        };
		
        // Setting DrawerToggle on DrawerLayout
        mDrawerLayout.setDrawerListener(mDrawerToggle);
        // Set the adapter for the list view
        mDrawerList.setAdapter(new ArrayAdapter<String>(this,R.layout.drawer_list_item, drawer_options_list));
        // Enabling Home button
        getActionBar().setHomeButtonEnabled(true);
        // Enabling Up navigation
        getActionBar().setDisplayHomeAsUpEnabled(true);
        // Setting item click listener for the listview mDrawerList
        mDrawerList.setOnItemClickListener(new OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent,
                View view,
                int position,
                long id) {
 
            	//get string array from recourses
        		String[] drawer_options_list  = getResources().getStringArray(R.array.fileEplorerDrawerOptions);
				switch (position) {
				case 3:
					Settings settingDialog = new Settings().newInstance(getApplicationContext());
					//animation
//					FragmentTransaction ft = activyty.getFragmentManager().beginTransaction();
//					ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_OPEN);
//					ft.add(R.id.fragment_holder, settingDialog);
//					ft.show(settingDialog);
//					ft.addToBackStack(null);
//					ft.commit();
					settingDialog.setCancelable(false);
					settingDialog.show(getFragmentManager(), "settings dialog");
					break;
				case 4:
					Utils.showLogoutDialog(context ,activity);
					break;
				case 5:
					//create and call intent in order to pass to other screen
					Intent intent = new Intent(FileExplorer.this, About.class);
					FileExplorer.this.startActivity(intent);
					break;

				default:
					if (toast!=null) toast.cancel();
	    			toast= 	Toast.makeText(FileExplorer.this, drawer_options_list[position] +" - No time to integrate this feature ..." , Toast.LENGTH_LONG);
	    			toast.show();
					
					break;
				}
 
                    // Closing the drawer
                    mDrawerLayout.closeDrawer(mDrawerList);
            }
        });
      //End of Navigation drawer region
        
        
        
		//get Intent for gathering data;
		Bundle extras = getIntent().getExtras();
	    if (extras != null) {
	    	UserID = getIntent().getIntExtra("userID", -1);
			session = getIntent().getStringExtra("sessionID");
			courseID  = getIntent().getIntExtra("courseID",-1);
			Log.i("FileExplorer.UserID", Integer.toString(UserID) );
			Log.i("FileExplorer.courseID", Integer.toString(courseID) );
			FileStructureTask fileTask = new FileStructureTask(getApplicationContext());
			//fileTask.execute("http://79.181.54.22:8090/CM_restfullWS/rest/course_service/getFileStructure/abdula");
			fileTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMatesREST.svc/rest/GetCourseFiles/");
			
			//grid view it list of files generation
			gridview = (GridView) findViewById(R.id.gridView_files);
		    
		    //listener for click on item from grid view
		    gridview.setOnItemClickListener(new  AdapterView.OnItemClickListener() {
		    	
		    	@Override
				public void onItemClick(AdapterView<?> parent, View v, int position,long id) {
					//Toast.makeText(files.this, "" + position +" - " +ia.getItem(position), Toast.LENGTH_SHORT).show();
		    		
		    		//if back icon press
		    		if (position==0) {
		    			//if back icon press when in root directory = > back to courses screen
			    		
		    			if(parentFileObj.equals(rootfile)) {
		    			    long pressTime = System.nanoTime();
//		    			    String s = String.valueOf(pressTime);
//		    			    Log.i("debug back press", s );
		    			    if(pressTime - lastPressTime <= DOUBLE_PRESS_INTERVAL) {
		    			        // this is a double click event
		    			    	finish();
					        	Intent intent = new Intent(FileExplorer.this, Courses.class);
					        	intent.putExtra("userID", UserID);
					        	intent.putExtra("sessionID", session);
					        	FileExplorer.this.startActivity(intent);
		    			    }
		    			    else
		    			    {
		    			    	if (toast!=null) toast.cancel();
		    			    	toast =Toast.makeText(FileExplorer.this, "PRESS TWICE TO BACK TO COURSES.", Toast.LENGTH_SHORT);
		    			    	toast.show();
		    			    }
		    			    	lastPressTime = pressTime;
		    			} 
		    			else {
		    			 //if back icon press in any sub folder
		    			 files = buildFilesArrayList( getParentFile(rootfile,parentFileObj)  );
		    			 ia.clear();
		    			 ia = new ImageAndTextAdapter(context, R.layout.course_item,files);
						 gridview.setAdapter(ia);
		    			}
		    		}
		    		else if (position >0 && ((FileItem) files.get(position)).isIsFolder()) {
		    			
//		    			Log.i("FileExplorer.clicked item",((FileItem) files.get(position)).getFileName() );
//		    			Log.i("FileExplorer.clicked item",((FileItem) files.get(position)).getSubItems().toString() );
		    			 files = buildFilesArrayList(((FileItem) files.get(position)));
		    			 ia.clear();
		    			 ia = new ImageAndTextAdapter(context, R.layout.course_item,files);
						 gridview.setAdapter(ia);
		    		}
		    		else {
//		    			if (toast!=null) toast.cancel();
//		    			toast= 	Toast.makeText(FileExplorer.this, "" + position +" - " + ((FileItem) files.get(position)).getOwnerName()  
//		    					+ " id:"+  ((FileItem) files.get(position)).getFileName() , Toast.LENGTH_SHORT);
//		    			toast.show();
		    			
		    			// custom dialog
						DetailsAndActionDialogFragment detailsDialog = new DetailsAndActionDialogFragment().newInstance(((FileItem) files.get(position)).getFileName(),
								((FileItem) files.get(position)).getOwnerName() ,((FileItem) files.get(position)).getSize() ,((FileItem) files.get(position)).getType().getExtension() ,
								((FileItem) files.get(position)).getLastModify(),((FileItem) files.get(position)).getRate());
						detailsDialog.show(getFragmentManager(), "details dialog");
		    		}
				}
		    });
		    
		    //Buttons click listeners
		    Button btnPhoto = (Button) findViewById(R.id.button_postphoto);
//		    btnPhoto.setEnabled(false);
		    btnPhoto.setOnClickListener( new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					Utils.showMyDialog(context," Purchase PRO version"," This feature aviable on PRO version only", true);
					
				}
			});
		    
		    Button btnMake = (Button) findViewById(R.id.button_MakeDirectory);
		    btnMake.setOnClickListener( new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					Utils.showMyDialog(context," Purchase PRO version"," This feature aviable on PRO version only", true);
					
				}
			});
		    
		    Button btnRoot = (Button) findViewById(R.id.button_RootFolder);
		    btnRoot.setOnClickListener( new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					files = buildFilesArrayList(rootfile);
					ia.clear();
	    			ia = new ImageAndTextAdapter(context, R.layout.course_item,files);
				    gridview.setAdapter(ia);
				}
			});
		    
		    Button btnRefrsh = (Button) findViewById(R.id.button_Refresh);
		    btnRefrsh.setOnClickListener( new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					FileStructureTask fileTask = new FileStructureTask(getApplicationContext());
					fileTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMatesREST.svc/rest/GetCourseFiles/");
					files = buildFilesArrayList(rootfile);
	    			ia.clear();
	    			ia = new ImageAndTextAdapter(context, R.layout.course_item,files);
					gridview.setAdapter(ia);
				}
			});
		    
	    }
	}
	//---------------------------------------------------------------------------------------------------//
	@Override
	public void onBackPressed() {
		
	    long pressTime = System.nanoTime();
//	    String s = String.valueOf(pressTime);
//	    Log.i("debug back press", s );
	    if(pressTime - lastPressTime <= DOUBLE_PRESS_INTERVAL) {
	        // this is a double click event
	    	//Toast.makeText(files.this, "double press", Toast.LENGTH_SHORT).show();
	    	finish();
	    }
	    else
	    {
	    	if (toast!=null) toast.cancel();
	    	toast = Toast.makeText(FileExplorer.this, "Press again for exit", Toast.LENGTH_SHORT);	
	    	toast.show();
	    }
	    lastPressTime = pressTime;
	}
	//---------------------------------------------------------------------------------------------------//
	
	
	
	class FileStructureTask extends AsyncTask<String,Void,String> {
		
		Context app_context; 
		Dialog dialog  = new Dialog(context, R.style.custom_dialog);
		 
		 
		public FileStructureTask (Context context){
				this.app_context = context;
			}
		
		//---------------------------------------------------------------------------------------------------//
		 protected void onPreExecute() {
		 super.onPreExecute();
	     
	     dialog.setTitle("Building file structure ...");
			dialog.setContentView(R.layout.loading_dilalog);
			dialog.setCancelable(false);
			Button cancelDialogButton = (Button) dialog.findViewById(R.id.button_cancel_loading);
			cancelDialogButton.setVisibility(View.GONE);
			if (!dialog.isShowing()) {
	            dialog.show();
	         }
		}
		 
		//---------------------------------------------------------------------------------------------------//
		//runs in background 
		    @Override
		    protected String doInBackground(String... uri) {
		    	
		        HttpClient httpclient = new DefaultHttpClient();
		        HttpContext  localContext = new BasicHttpContext();
		        
		        
		        HttpResponse response;
		        String responseString = "";
		        HttpGet do_get = new HttpGet(uri[0]+session+"/"+UserID+"/"+courseID);
		        
		        do_get.addHeader("accept", "application/json");

		        try {
		            response = httpclient.execute(do_get,localContext);
		         // Get the response entity
		            HttpEntity entity = response.getEntity();
		            // If response entity is not null
		           
		            if (entity != null) {
		                // get entity contents and convert it to string
		            	responseString = EntityUtils.toString(response.getEntity());
		               
		            }
		        } catch (ClientProtocolException e) {
		            e.printStackTrace();
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
		        return responseString;
		    }
		//---------------------------------------------------------------------------------------------------//	
		    @Override
		    protected void onPostExecute(String result) {
		        super.onPostExecute(result);
		        Log.i("onPost - result",result );
		        //test from here
		        
		     	
		        if(!result.equals("")) {
		        	try {
							        	
		        		/*
										//from test jersey server
										JSONObject json = (JSONObject) new JSONTokener(result).nextValue();
										
										JSONObject object= json.getJSONObject("rootFolder");
										
										 rootfile = Utils.parseRecursiveFileItemFromJson(object);
							*/	
		        		
		        						//CM server integration
						        		JSONObject	jsonobj =  new JSONObject(result);
										JSONObject object= jsonobj.getJSONObject("RootFolder");
										rootfile = Utils.parseRecursiveFileItemFromJsonCM(object);
						 
						 				//end of integration
										 files = buildFilesArrayList(rootfile);
										//Adapter list that gridview able to display
										ia = new ImageAndTextAdapter(context, R.layout.course_item,files);
									    gridview.setAdapter(ia);
										 if (dialog.isShowing()) {
									            dialog.dismiss();
									         }	
							
										} catch (JSONException e) {
											// TODO Auto-generated catch block
											e.printStackTrace();
										}
										
				}
		       
		       
		    }
}
	//---------------------------------------------------------------------------------------------------//	
	ArrayList<ImageAndTextAdoptable> buildFilesArrayList (FileItem file){
		//create list of file objects
		ArrayList<ImageAndTextAdoptable> mylist  = new ArrayList<ImageAndTextAdoptable>();
		
		parentFileObj = file;
		FileItem empty = new FileItem();
		empty.setIconID(getResources().getIdentifier ("goback", "drawable", context.getPackageName()));
		empty.setFileName("");
		mylist.add(empty);
		for(int i=0;i<file.getSubItems().size();i++ ) {
			if(file.getSubItems().get(i).isIsFolder()) {
			int resourceID = getResources().getIdentifier ("folder", "drawable", context.getPackageName());
			file.getSubItems().get(i).setIconID(resourceID);
			 } 
			   else { 
			int resourceID =  getResources().getIdentifier (file.getSubItems().get(i).getType().getExtension(), "drawable", context.getPackageName());
			file.getSubItems().get(i).setIconID(resourceID);
			   }
			mylist.add(file.getSubItems().get(i));
//			Log.i("buildFilesArrayList: ",i+ ": "+ file.getSubItems().get(i).getFileName());
		}
		return mylist;
	}
	//---------------------------------------------------------------------------------------------------//	
	public FileItem getParentFile (FileItem currentFile , FileItem fileToFind) {
		
		
//		Log.i("getParentFile: ","before if contains:   "+currentFile.getFileName());
		if( currentFile.getSubItems().contains(fileToFind)) {
//			Log.i("getParentFile: ","in if contains");
			return currentFile;
		} 
		else 
		{
//			Log.i("getParentFile: ","before for"+rootfile.getSubItems().size());
			for (int i=0;i<currentFile.getSubItems().size();i++) {
				FileItem parentFile ;
//				Log.i("getParentFile: ",i+ ": "+ currentFile.getSubItems().get(i).getFileName());
				parentFile = getParentFile(currentFile.getSubItems().get(i), fileToFind);
				if (parentFile != rootfile && parentFile != null) 
					return parentFile;
			}
		}
		return rootfile;
	}
	//---------------------------------------------------------------------------------------------------//	
	
	//Handling option menu
	 @Override
	    protected void onPostCreate(Bundle savedInstanceState) {
	        super.onPostCreate(savedInstanceState);
	        mDrawerToggle.syncState();
	    }
	 
	    /** Handling the touch event of app icon */
	    @Override
	    public boolean onOptionsItemSelected(MenuItem item) {
	        if (mDrawerToggle.onOptionsItemSelected(item)) {
	            return true;
	        }
	        return super.onOptionsItemSelected(item);
	    }
	 
	    /** Called whenever we call invalidateOptionsMenu() */
	    @Override
	    public boolean onPrepareOptionsMenu(Menu menu) {
	        // If the drawer is open, hide action items related to the content view
	       // boolean drawerOpen = mDrawerLayout.isDrawerOpen(mDrawerList);
	    	//disable the setting option 
	        menu.findItem(R.id.action_settings).setVisible(false);
	        return super.onPrepareOptionsMenu(menu);
	    }
	 
	    @Override
	    public boolean onCreateOptionsMenu(Menu menu) {
	        // Inflate the menu; this adds items to the action bar if it is present.
	        getMenuInflater().inflate(R.menu.main, menu);
	        return true;
	    }
}
