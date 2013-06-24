/**
*  This class loads and shows the courses that user is subscribed .  
*  
*  
 */
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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

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
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ListView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class Courses extends Activity {
	
	//variable that helps to switching IP between servers
	IPadressHelper IPadress = new IPadressHelper();
	
	//local context shortcut
	final Context context = this;
	
	private static final long DOUBLE_PRESS_INTERVAL = 1442268014;/* some value in ns. */;
	private long lastPressTime;
	Dialog dialog;
	ArrayAdapter<String> adapter ;
	ImageAndTextAdapter ia;
	int userID;
	String session;
	GridView gridview ;
	ArrayList<ImageAndTextAdoptable> courses = new  ArrayList<ImageAndTextAdoptable>() ;
	
	
	// Within which the entire activity is enclosed
    DrawerLayout mDrawerLayout;
    // ActionBarDrawerToggle indicates the presence of Navigation Drawer in the action bar
    ActionBarDrawerToggle mDrawerToggle;
    // Title of the action bar
    String mTitle="";
     ListView mDrawerList;
     Toast toast ;
     private Activity activity=this;
	//---------------------------------------------------------------------------------------------------//
	
	@SuppressLint("NewApi")
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.my_drawer);
		
	
		
		 //navigation drawer region
		mDrawerList = (ListView) findViewById(R.id.left_drawer);
		mTitle = (String) getTitle();
		//get string array from recourses
		String[] drawer_options_list  = getResources().getStringArray(R.array.CoursesDrawerOptions);
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
                    getActionBar().setTitle("Course Explorer Options");
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
        		String[] drawer_options_list  = getResources().getStringArray(R.array.CoursesDrawerOptions);
        		switch (position) {
				case 2:
					Settings settingDialog = new Settings().newInstance(getApplicationContext());
					settingDialog.setCancelable(false);
					settingDialog.show(getFragmentManager(), "settings dialog");
					break;
				case 3:
					Utils.showLogoutDialog(context ,activity);
					break;
				case 0:
					ia.clear();
					CoursesListTask callTask = new CoursesListTask(getApplicationContext());
					callTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMatesREST.svc/rest/GetCourseByUserId");
					break;
				case 4:
					//create and call intent in order to pass to other screen
					Intent intent = new Intent(Courses.this, About.class);
					Courses.this.startActivity(intent);
					break;	
				default:
					if (toast!=null) toast.cancel();
	    			toast= 	Toast.makeText(Courses.this, drawer_options_list[position] +"- No time to integrate this feature ..." , Toast.LENGTH_LONG);
	    			toast.show();
					
					break;
				}
                    // Closing the drawer
                    mDrawerLayout.closeDrawer(mDrawerList);
            }
        });
        //end of navigation drawer region
		
		
		Intent intent = getIntent();
		Bundle extras = getIntent().getExtras();
	    if (extras != null) {
	    	userID = intent.getIntExtra("userID", -1);
			session = intent.getStringExtra("sessionID");
			Log.i("getExtra", session );
			Log.i("getExtra", Integer.toString(userID) );
			CoursesListTask callTask = new CoursesListTask(getApplicationContext());
			callTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMatesREST.svc/rest/GetCourseByUserId");
	    }
//	    String[] course_names = {"Linear Algebra","Physics-2","Algorithmics-2","Software Engineering","Databases","Formular Languages","Cryptography",
//	    		"Hedva","Networking","Discrete Mathematics","Economics","Internet Intro"};//res.getStringArray(R.array.country_names);
	    
	    dialog = new Dialog(context, R.style.custom_dialog);
	    
	    //testing
	    adapter = new ArrayAdapter<String>(this,
				  android.R.layout.simple_list_item_1);
	    
	    //grid view it list of courses generation
		gridview = (GridView) findViewById(R.id.gridView1);
	    
	    //listener for click on item from grid view
	    gridview.setOnItemClickListener(new  AdapterView.OnItemClickListener() {
	    	
	    	@Override
			public void onItemClick(AdapterView<?> parent, View v, int position,long id) {
	    		//Toast.makeText(Courses.this, "" + position +" - " +((CourseEntity) courses.get(position)).getCourseName() + " id:"+ ((CourseEntity) courses.get(position)).getID() , Toast.LENGTH_SHORT).show();
	    		Intent intent = new Intent(Courses.this, FileExplorer.class);
	        	intent.putExtra("userID", userID);
	        	intent.putExtra("sessionID", session);
	        	intent.putExtra("courseID", ((CourseEntity) courses.get(position)).getID());
	        	finish();
	        	Courses.this.startActivity(intent);
			}
	    });
	    

			
			Button add_course_button = (Button) findViewById(R.id.button3);
			add_course_button.setOnClickListener(new OnClickListener() {
				@Override
				public void onClick(View v) {
					// custom dialog
					final NewCourseDialog dialog = new NewCourseDialog(context, R.style.custom_dialog);
					dialog.show();
				}			
			});
			
			Button exit = (Button) findViewById(R.id.button_exit);
			exit.setOnClickListener(new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					finish();
					
				}
			});
		 
	}
	//---------------------------------------------------------------------------------------------------//
	@Override
	public void onBackPressed() {
		
	    long pressTime = System.nanoTime();
//	    String s = String.valueOf(pressTime);
//	    Log.i("debug back press", s );
	    if(pressTime - lastPressTime <= DOUBLE_PRESS_INTERVAL) {
	        // this is a double click event
	    	//Toast.makeText(Courses.this, "double press", Toast.LENGTH_SHORT).show();
	    	finish();
	    }
	    else
	    	Toast.makeText(Courses.this, "Press again for exit", Toast.LENGTH_SHORT).show();	
	    lastPressTime = pressTime;
	}
	//---------------------------------------------------------------------------------------------------//
	
class CoursesListTask extends AsyncTask<String,Void,String> {
		
	 Context app_context; 
	 Dialog dialog  = new Dialog(context, R.style.custom_dialog);
	 
	 public CoursesListTask (Context context){
				this.app_context = context;
			}
		//---------------------------------------------------------------------------------------------------//
	 protected void onPreExecute() {
	 super.onPreExecute();
     
     dialog.setTitle("Fetching data ...");
		dialog.setContentView(R.layout.loading_dilalog);
		dialog.setCancelable(false);
		Button cancelDialogButton = (Button) dialog.findViewById(R.id.button_cancel_loading);
		//cancelDialogButton.setVisibility(View.GONE);
		cancelDialogButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Log.i("auth","cancel clicked");
				cancel(true);
				 if (dialog.isShowing()) {
			            dialog.dismiss();
			         }
				
			}
		});
		if (!dialog.isShowing()) {
            dialog.show();
         }
	}
	 
	 	//---------------------------------------------------------------------------------------------------//
		//runs in background 
		    @Override
		    protected String doInBackground(String... uri) {
		    	
		        HttpClient httpclient = new DefaultHttpClient();
//		        ((AbstractHttpClient) httpclient).getCredentialsProvider().setCredentials( new AuthScope(null, -1),new UsernamePasswordCredentials("joeuser", "mypassword"));
		        HttpContext  localContext = new BasicHttpContext();
		        
		        
		        HttpResponse response;
		        String responseString = "";
		        HttpGet do_get = new HttpGet(uri[0]+"/" +session +"/" +userID);
//		        HttpGet do_get = new HttpGet("http://192.168.2.106:8089/CM_restfullWS/rest/course_service/get_list/dima/12345");
//		        Log.i("SharedParams test :",ud.getUserName(this.app_context));
		        
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
		        
		        ArrayList<String> course_names = new  ArrayList<String>() ;
		      //  ia.clear();
		        if(!result.equals(""))
		        try {
		        	
		        	
// 					if needed to convert from JERSEY - TOMCAT WebService					
//					JSONObject jsonResponse = new JSONObject(new String(result));
//					JSONArray respJSON = jsonResponse.getJSONArray("courseEntity");
//					Log.i("onPost - result",respJSON.toString() );
					
					
		        	//Convert responded from server string to json array
		        	JSONArray respJSON = new JSONArray(result);
		        	
					for (int i=0 ; i <respJSON.length() ; i++) {
						JSONObject json = respJSON.optJSONObject(i);
						
						Gson gson =  new Gson();
						CourseEntity ce = gson.fromJson(json.toString(),CourseEntity.class);
						
						String extracted = ce.getIconClass().substring(ce.getIconClass().indexOf('-')+1,ce.getIconClass().lastIndexOf('-'));
//						Log.i("icon name:", extracted);
						int resourceId =  getResources().getIdentifier (extracted, "drawable", context.getPackageName());
//						Log.i("resourceID",Integer.toString(resourceId));
						ce.setIconID(resourceId);
						courses.add(ce);
						course_names.add(ce.getCourseName());
						//ia.add(ce.toString());
//						Log.i("test- course entity:", course_names.toString());
					}
					ia = new ImageAndTextAdapter(context, R.layout.course_item,courses);
				    gridview.setAdapter(ia);
				    //dismiss dialog if it showing
				    if (dialog.isShowing()) {
			            dialog.dismiss();
			         }
				} catch (JSONException e) {
					e.printStackTrace();
				}
		       
		        
		    }
		 //---------------------------------------------------------------------------------------------------//	
		}

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
