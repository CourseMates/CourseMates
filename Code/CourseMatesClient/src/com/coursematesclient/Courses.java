/**
*  This class loads courses that user is subscribed .  
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

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.Toast;

public class Courses extends Activity {
	
	//variable that helps to switching IP between servers
	IPadressHelper IPadress = new IPadressHelper();
	
	//local context shortcut
	final Context context = this;
//	ArrayAdapter<String> adapter ;
	
	private static final long DOUBLE_PRESS_INTERVAL = 1442268014;/* some value in ns. */;
	private long lastPressTime;
	Dialog dialog;
	ArrayAdapter<String> adapter ;
	ImageAndTextAdapter ia;
	int id;
	String session;
	GridView gridview ;
	Context ctx;
	ArrayList<CourseEntity> courses = new  ArrayList<CourseEntity>() ;
	//---------------------------------------------------------------------------------------------------//
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.my_courses_screen);
		
		ctx = getApplicationContext();
		
		Intent intent = getIntent();
//		String action = intent.getAction();
//		Log.i("action",  action );
//		if(Intent.ACTION_SEND.equals(action)) {
//			id = intent.getIntExtra("userID", -1);
//			session = intent.getStringExtra("sessionID");
//			Log.i("getExtra", session );
//			Log.i("getExtra", Integer.toString(id) );
//			CoursesListTask callTask = new CoursesListTask(getApplicationContext());
//			callTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMates.svc/rest/GetCourseByUserId");
//		}
		
		Bundle extras = getIntent().getExtras();
	    if (extras != null) {
	    	id = intent.getIntExtra("userID", -1);
			session = intent.getStringExtra("sessionID");
			Log.i("getExtra", session );
			Log.i("getExtra", Integer.toString(id) );
			CoursesListTask callTask = new CoursesListTask(getApplicationContext());
			callTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMates.svc/rest/GetCourseByUserId");
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
				//Toast.makeText(Courses.this, "" + position +" - " +ia.getItem(position), Toast.LENGTH_SHORT).show();
	    		Toast.makeText(Courses.this, "" + position +" - " +courses.get(position).getCourseName() + " id:"+ courses.get(position).getID() , Toast.LENGTH_SHORT).show();
			}
	    });
	    
	    
	    //logout button handler and listener definition
	    Button logout = (Button) findViewById(R.id.button2);
		logout.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				UserData ud = new UserData();
				
				ud.logout(getApplicationContext());
				finish();
				
				 // start the home screen if logout button was pressed 
                Intent intent = new Intent(Courses.this, Authentication.class);
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
		//Adapter adapter;
	//override constructor 
		//Need to pass App Context for getting access to shared preferences 
			public CoursesListTask (Context context){
				this.app_context = context;
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
		        HttpGet do_get = new HttpGet(uri[0]+"/" +session +"/" +id);
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
						courses.add(ce);
						course_names.add(ce.getCourseName());
						//ia.add(ce.toString());
						Log.i("test- course entity:", course_names.toString());
					}
					ia = new ImageAndTextAdapter(ctx, R.layout.course_item,course_names);
				    gridview.setAdapter(ia);
				} catch (JSONException e) {
					e.printStackTrace();
				}
		       
		        
		    }
		 //---------------------------------------------------------------------------------------------------//	
		}
}
