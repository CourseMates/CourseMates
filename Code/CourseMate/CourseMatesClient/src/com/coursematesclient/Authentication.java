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
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;

public class Authentication extends Activity {
	
	IPadressHelper IPadress = new IPadressHelper();
	//---------------------------------------------------------------------------------------------------//
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.authentication_screen);
		UserData ud = new UserData();
		String name = ud.getUserName(getApplicationContext());
		String password = ud.getUserPassword(getApplicationContext());
		if( !name.equals("") && !password.equalsIgnoreCase("")) {
			
			EditText test = (EditText) findViewById(R.id.autoCompleteTextView_username);
			test.setText(name);
			EditText pass = (EditText) findViewById(R.id.editText_password);
			pass.setText(password);
			final CheckBox checkBox = (CheckBox) findViewById(R.id.checkBox_savepassword);
			checkBox.setChecked(ud.isPasswordSaved(getApplicationContext()));
			
		}
		Button login_button = (Button) findViewById(R.id.Login_button);
		login_button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				UserData ud = new UserData();
				EditText text = (EditText) findViewById(R.id.autoCompleteTextView_username);
				String username =text.getText().toString();
				String password = ((TextView) findViewById(R.id.editText_password)).getText().toString();
				Log.i("Auth debug",username + " " +password);
				final CheckBox checkBox = (CheckBox) findViewById(R.id.checkBox_savepassword);
				ud.saveUserAuthenticationData(getApplicationContext(), username, password ,checkBox.isChecked());
				LoginTask loginTask = new LoginTask();
				loginTask.execute("http://"+IPadress.HOME_IP+":8089/CM_restfullWS/rest/course_service/login");
			}			
		});
		
		Button reg_button = (Button) findViewById(R.id.register_button);
		reg_button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(Authentication.this, Registaration.class);
				Authentication.this.startActivity(intent);
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
	
	
	private class LoginTask extends AsyncTask<String,Void,String> {
		
		
		//---------------------------------------------------------------------------------------------------//
		//runs in background 
		    @Override
		    protected String doInBackground(String... uri) {
		    	
		        HttpClient httpclient = new DefaultHttpClient();
		        HttpContext  localContext = new BasicHttpContext();
		        HttpResponse response;
		        String responseString = "false";
		        UserData ud = new UserData();
		        HttpGet do_get = new HttpGet(uri[0]+"/" +ud.getUserName(getApplicationContext()) +"/" +ud.getUserPassword(getApplicationContext()));
		        //Log.i("SharedParams test :",ud.GetUserName(this.app_context));
		        
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
		        //Log.i("LoginTask: onPost",result );
		        try {
					JSONObject jsonResponse = new JSONObject(new String(result));
					Gson gson =  new Gson();
					LoginEntity login = gson.fromJson(jsonResponse.toString(),LoginEntity.class);
					
					   if(login.getAuthorized()) {
				        	finish();
				        	Intent intent = new Intent(Authentication.this, Home.class);
							Authentication.this.startActivity(intent);
			        	}
				        else {
				        	//Show error dialog
							AlertDialog.Builder builder = new AlertDialog.Builder(Authentication.this);
				        	builder.setMessage("UserName or password are incorect !");
				        	builder.setTitle("Ooops");
				        	AlertDialog dialog = builder.create();
				        	dialog.show();
					    }
					
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				//JSONArray respJSON = jsonResponse.getJSONArray("courseEntity");
		     
		    }
		 //---------------------------------------------------------------------------------------------------//	
	}
	
}

