package com.coursematesclient;

import java.io.IOException;
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
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

public class Home extends Activity {
	
	IPadressHelper IPadress = new IPadressHelper();
	ArrayAdapter<String> adapter ;
	//---------------------------------------------------------------------------------------------------//
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.home_screen);
		UserData ud = new UserData();
		TextView username = (TextView) findViewById(R.id.textView1);
		username.setText(ud.getUserName(getApplicationContext()));
		Button logout = (Button) findViewById(R.id.button3);
		logout.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				UserData ud = new UserData();
				
				ud.logout(getApplicationContext());
				TextView username = (TextView) findViewById(R.id.textView1);
				username.setText("");
				finish();
				 // start the home screen if logout button was pressed 
                Intent intent = new Intent(Home.this, Authentication.class);
                Home.this.startActivity(intent);
			}			
		});
		Button button_mycourses = (Button) findViewById(R.id.button1_mycourses);
		button_mycourses.setOnClickListener(new OnClickListener() {
		
			@Override
			public void onClick(View v) {
				CallForCoursesListTask callTask = new CallForCoursesListTask(getApplicationContext());
				callTask.execute("http://"+IPadress.HOME_IP+":8089/CM_restfullWS/rest/course_service/get_list");
			}			
		});

		ListView listView = (ListView) findViewById(R.id.listView1);
		
		// Define a new Adapter
		// First parameter - Context
		// Second parameter - Layout for the row
		// Third parameter - ID of the TextView to which the data is written
		// Forth - the Array of data

		adapter = new ArrayAdapter<String>(this,
				  android.R.layout.simple_list_item_1);

		// Assign adapter to ListView
		listView.setAdapter(adapter); 
		
		listView.setOnItemClickListener(new AdapterView.OnItemClickListener(){

			@Override
			public void onItemClick(AdapterView<?> parentAdapter, View view, int pos,
					long id) {
				// TODO Auto-generated method stub
				Log.i("debug","positiom : "+ pos);
				Log.i("debug","id : "+ pos);
				//parentAdapter.get
			}
			
		});
	}
	
	//---------------------------------------------------------------------------------------------------//
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.splash_screen, menu);
		return true;
	}
	//---------------------------------------------------------------------------------------------------//
	@Override
    public void onStop() {
        super.onStop();
        UserData ud = new UserData();
        if(!ud.isPasswordSaved(getApplicationContext())){
        	ud.logout(getApplicationContext());
        }
    }
	//---------------------------------------------------------------------------------------------------//
	//Override Async task to call web service it paralell thread

	class CallForCoursesListTask extends AsyncTask<String,Void,String> {
		
		Context app_context; 
		//Adapter adapter;
	//---------------------------------------------------------------------------------------------------//	
	//override constructor 
	//Need to pass App Context for getting access to shared preferences 
		public CallForCoursesListTask (Context context){
			this.app_context = context;
		}
	//---------------------------------------------------------------------------------------------------//
	//runs in background 
	    @Override
	    protected String doInBackground(String... uri) {
	    	
	        HttpClient httpclient = new DefaultHttpClient();
//	        ((AbstractHttpClient) httpclient).getCredentialsProvider().setCredentials( new AuthScope(null, -1),new UsernamePasswordCredentials("joeuser", "mypassword"));
	        HttpContext  localContext = new BasicHttpContext();
	        
	        
	        HttpResponse response;
	        String responseString = "";
	        UserData ud = new UserData();
	        HttpGet do_get = new HttpGet(uri[0]+"/" +ud.getUserName(app_context) +"/" +ud.getUserPassword(app_context));
//	        Log.i("SharedParams test :",ud.getUserName(this.app_context));
	        
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
	     //   Log.i("onPost",result );
	        if(!result.equals(""))
	        try {
	        	
			
				
				JSONObject jsonResponse = new JSONObject(new String(result));
				JSONArray respJSON = jsonResponse.getJSONArray("courseEntity");
				adapter.clear();
				for (int i=0 ; i <respJSON.length() ; i++) {
					JSONObject json = respJSON.optJSONObject(i);
					Gson gson =  new Gson();
					CourseEntity ce = gson.fromJson(json.toString(),CourseEntity.class);
					adapter.add(ce.toString());
				//	adapter.
//					Log.i(ce.getName(), ce.toString());
				}
			
			} catch (JSONException e) {
				e.printStackTrace();
			}
	        
	        
	    }
	 //---------------------------------------------------------------------------------------------------//	
	}
}
