/**
*  This class operates LoginScreen . It checks if there is user's credentials stored locally ( UserData class ). 
*  Communicates with RESTfull web service to validate password. 
*  It retrieves UserID and SessionID from the server
 */

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
import android.app.Dialog;
import android.content.Context;
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
import android.widget.ImageButton;
import android.widget.TextView;


public class Authentication extends Activity  {
	
	//IPadressHelper IPadress = new IPadressHelper();
	final Context context = this;
	
	//---------------------------------------------------------------------------------------------------//
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.authentication_screen);
		
		
		
		
		//create progress bar for loading notification
//		ProgressBar pb = new ProgressBar(context, null, android.R.attr.progressBarStyleSmall);
//        pb.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
//        pb.setIndeterminate(true);
//        
//        LinearLayout linlay = new LinearLayout(this);
//        linlay.addView(pb);
//        pb.setVisibility(View.VISIBLE);
		//create object that operate with user's data ,stored locally.
		UserData ud = new UserData();
		
		//get user name
		String name = ud.getUserName(getApplicationContext());
		//get password
		String password = ud.getUserPassword(getApplicationContext());
		
		//check if there is user's data
		if( !name.equals("") && !password.equals("")) {
			
			//update views with relevant information
			EditText test = (EditText) findViewById(R.id.autoCompleteTextView_username);
			test.setText(name);
			EditText pass = (EditText) findViewById(R.id.editText_password);
			pass.setText(password);
			final CheckBox checkBox = (CheckBox) findViewById(R.id.checkBox_savepassword);
			checkBox.setChecked(ud.isPasswordSaved(getApplicationContext()));
			
		}
		
		//autologin from notification
		Bundle extras = getIntent().getExtras();
	    if (extras != null) {
	    	
	    	 Log.i("auto login",getIntent().getStringExtra("from"));
	    	 if(getIntent().getStringExtra("from").equals("notification")) {
	    		
	    		//create and execute LoginTask in background 
	    		LoginTask loginTask = new LoginTask();
				loginTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMates.svc/rest/login");
	    	 }
	    }
		
		
		
		//create button object to handle login button
		Button login_button = (Button) findViewById(R.id.Login_button);
		//create listener for login button
		login_button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//insert user-name ,password and "save password" choice into UserData object 
				UserData ud = new UserData();
				EditText text = (EditText) findViewById(R.id.autoCompleteTextView_username);
				String username =text.getText().toString();
				
				String password = ((TextView) findViewById(R.id.editText_password)).getText().toString();
				//TODO to save md5 of password and not real password
				
				
				//String passwordmd5 = md5(((TextView) findViewById(R.id.editText_password)).getText().toString()); 
				
				
				//for debugging purposes
				//Log.i("Auth debug",username + " " +password);
				final CheckBox checkBox = (CheckBox) findViewById(R.id.checkBox_savepassword);
				//store user's data in device , uses SharedPrefences mechanism  
				ud.saveUserAuthenticationData(getApplicationContext(), username, password ,checkBox.isChecked());
				
				
				
				//for debugging purposes till WebService is down 
				if(username.equals("test") && password.equals("12345678")) {
					finish();
		        	Intent intent = new Intent(Authentication.this, Courses.class);
					Authentication.this.startActivity(intent);
				}
				
				else
					{
					//create and execute LoginTask in background 
					LoginTask loginTask = new LoginTask();
					loginTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMates.svc/rest/login");
					}
			}			
		});
		
		//create button object to handle registration  button
		Button reg_button = (Button) findViewById(R.id.register_button);
		//create listener for register button
		reg_button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//create and call intent in order to pass to other screen
				Intent intent = new Intent(Authentication.this, Registaration.class);
				//kill this activity
				finish();
				Authentication.this.startActivity(intent);
				overridePendingTransition(R.layout.push_right_out ,R.layout.push_right_in);
			}			
		});
		
		
	//create button and listener for clear button	
	ImageButton clear_username = (ImageButton) findViewById(R.id.imageButtonclear);
		clear_username.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//clear user name
				EditText username = (EditText) findViewById(R.id.autoCompleteTextView_username);
				username.getText().clear();
				EditText pass = (EditText) findViewById(R.id.editText_password);
				pass.getText().clear();
			}			
		});
		
		
		
		//create button and listener for About button
		Button about_button = (Button) findViewById(R.id.button_about);
		//create listener for register button
		about_button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//create and call intent in order to pass to other screen
				Intent intent = new Intent(Authentication.this, About.class);
				Authentication.this.startActivity(intent);
				overridePendingTransition(R.layout.push_right_out ,R.layout.push_right_in);
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
		
		 Dialog dialog  = new Dialog(context, R.style.custom_dialog);
		//---------------------------------------------------------------------------------------------------//
		@Override
	    protected void onPreExecute() {
	        super.onPreExecute();
	       
	        dialog.setTitle("Verifying ...");
			dialog.setContentView(R.layout.loading_dilalog);
//			dialog.setCanceledOnTouchOutside(false);
			dialog.setCancelable(false);
			
			if (!dialog.isShowing()) {
	            dialog.show();
	         }
			Button cancelDialogButton = (Button) dialog.findViewById(R.id.button_cancel_loading);
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
			
		}
		//runs in background 
		    @Override
		    protected String doInBackground(String... uri) {
		    	
		    	
		    	
		        HttpClient httpclient = new DefaultHttpClient();
		        HttpContext  localContext = new BasicHttpContext();
		        HttpResponse response;
		        String responseString = "false";
		        UserData ud = new UserData();
		        String username = ud.getUserName(getApplicationContext());
		        String password = Utils.md5(ud.getUserPassword(getApplicationContext()));
		        HttpGet do_get = new HttpGet(uri[0] + "/" +username + "/" + password);
		        Log.i("md5 test :",password);
		        
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
		 //       Log.i("LoginTask: onPost",result );
		        
		        if (dialog.isShowing()) {
		            dialog.dismiss();
		         }
		        
		        try {
					JSONObject jsonResponse = new JSONObject(new String(result));
					Log.i("LoginTask: onPost",jsonResponse.toString() );
					Gson gson =  new Gson();
					LoginEntity login = gson.fromJson(jsonResponse.toString(),LoginEntity.class);
					Log.i("LoginTask: onPost : userID",Integer.toString(login.getId()));
					Log.i("LoginTask: onPost : sessionID",login.getLoginResult() );
					
					   if(login.getAuthorized()) {
						  
				        	finish();
				        	Intent intent = new Intent(Authentication.this, Courses.class);
				        	intent.putExtra("userID", login.getId());
				        	intent.putExtra("sessionID", login.getLoginResult());
							Authentication.this.startActivity(intent);
			        	}
				        else {
				        	//Show error dialog
				        	Utils.showMyDialog(context," Ooops"," UserName or password are incorect !", true);
					    }
					
				} catch (JSONException e) {
					e.printStackTrace();
				}
		     
		    }
		 	
	}
	//---------------------------------------------------------------------------------------------------//

	
}

