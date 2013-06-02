package com.coursematesclient;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
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
import android.widget.EditText;

public class Registaration extends Activity {
			
		public Context context  = this;


		protected void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			setContentView(R.layout.register_screen);
			
			//get handle object for all views
			Button btnCancel = (Button) findViewById(R.id.button_cancel);
			Button btnRegister = (Button) findViewById(R.id.rs_button_register);
			 
			
			
			
			//events listeners
			
			//create click listener for register button 
			btnRegister.setOnClickListener(new OnClickListener() {
					@Override
					public void onClick(View v) {
						//check the inputs
						 EditText etFirstname = (EditText) findViewById(R.id.editText_firstName);
						 EditText etLastname =(EditText) findViewById(R.id.editText_lastName);
						 EditText etEmail =(EditText) findViewById(R.id.editText_email);
						 EditText etPassword =(EditText) findViewById(R.id.editText_password);
						 EditText etConfirmPassword =(EditText) findViewById(R.id.editText_confirm);
						 EditText userName =(EditText) findViewById(R.id.editText_userName);
						 
						 if(!Utils.isLettersOnly(userName.getText().toString()) )
								Utils.showMyDialog(context, "Ooops", "Not valid user name", true);
							else
						if(!Utils.isLettersOnly(etFirstname.getText().toString()) )
							Utils.showMyDialog(context, "Ooops", "Not valid First name", true);
						else
						if(!Utils.isLettersOnly(etLastname.getText().toString()))
							Utils.showMyDialog(context, "Ooops", "Not valid Last name", true);
						else
						if(!Utils.validateEmailAddress(etEmail.getText().toString()))  
								Utils.showMyDialog(context, "Ooops", "Not valid email", true);
						else
						if(etPassword.getText().toString().length()<8)
							Utils.showMyDialog(context, "Ooops", "Password is minimum 8 characters ", true);
						else
							if(!etPassword.getText().toString().equals(etConfirmPassword.getText().toString()))
								Utils.showMyDialog(context, "Ooops", "Passwords don't match", true);
							else {
						
						RegisterTask task = new RegisterTask();
						task.execute("http://79.181.54.22:8090/CM_restfullWS/rest/course_service/register");
							}
					}
				});
			
			//click listener for cancel button
			btnCancel.setOnClickListener(new OnClickListener() {
				@Override
				public void onClick(View v) {
					finish();
					Intent intent = new Intent(Registaration.this, Authentication.class);
		        	Registaration.this.startActivity(intent);
		        	overridePendingTransition(R.layout.push_right_out ,R.layout.push_right_in);
				}
			});
			
		}


		@Override
		public boolean onCreateOptionsMenu(Menu menu) {
			// Inflate the menu; this adds items to the action bar if it is present.
			getMenuInflater().inflate(R.menu.splash_screen, menu);
			return true;
		}
		//---------------------------------------------------------------------------------------------------//
		@Override
		public void onBackPressed() {
		
//		     super.onBackPressed();
			finish();
			Intent intent = new Intent(Registaration.this, Authentication.class);
        	Registaration.this.startActivity(intent);
        	overridePendingTransition(R.layout.push_right_out ,R.layout.push_right_in);
			
		
		 }
		//---------------------------------------------------------------------------------------------------//
		
	private class RegisterTask extends AsyncTask<String,Void,String> {
			
			Dialog dialog ; 
			//---------------------------------------------------------------------------------------------------//
			@Override
		    protected void onPreExecute() {
		        super.onPreExecute();
		        dialog = new Dialog(context, R.style.custom_dialog);
		        dialog.setTitle("Uploading ...");
				dialog.setContentView(R.layout.loading_dilalog);
				dialog.setCancelable(false);
				if (!dialog.isShowing()) {
		            dialog.show();
		         }
				//cancel button listener for aborting async task
		    	Button cancelDialogButton = (Button) dialog.findViewById(R.id.button_cancel_loading);
				cancelDialogButton.setOnClickListener(new View.OnClickListener() {
					
					@Override
					public void onClick(View v) {
						Log.i("register","cancel clicked");
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
			        HttpPost doPost = new HttpPost(uri[0]);
			        
			        doPost.addHeader("accept", "application/json");
			        doPost.setHeader("Content-type", "application/json");
			        
//					JSONObject jsonObj;
					try {
					//jsonObj ="" {"id":"10","name":"Dimaasasa"}"";
					//String str = "{\"id\":\"10\",\"name\":\"Dima\"}";
					
					EditText etFirstname = (EditText) findViewById(R.id.editText_firstName);
					EditText etLastname =(EditText) findViewById(R.id.editText_lastName);
					EditText etEmail =(EditText) findViewById(R.id.editText_email);
					EditText etPassword =(EditText) findViewById(R.id.editText_password);
					String md5password = Utils.md5(etPassword.getText().toString());
					Log.i("md5password",md5password);
					
					
					//create json representation string for registration data 
					String str = "{\"FirstName\":\""+etFirstname.getText().toString()+"\"," +
							"\"LastName\":\""+ etLastname.getText().toString()+ "\"," +
							"\"Email\":\""+ etEmail.getText().toString()+ "\"," +
							"\"Password\":\""+md5password + "\"" +
							"}";
					
					//debug
					Log.i("json representation string",str);
					
					
					
			        doPost.setEntity((HttpEntity) new StringEntity(str, "UTF-8"));
			        
			        response = httpclient.execute(doPost,localContext);
			        
			        // Get the response entity
		            HttpEntity entity = response.getEntity();
		            // If response entity is not null
		           
		            if (entity != null) {
	                // get entity contents and convert it to string
	            	responseString = EntityUtils.toString(response.getEntity());
		               
		            }
			        
								} catch (UnsupportedEncodingException e) {
									e.printStackTrace();
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
			        
			        //dismiss the dialog
			        if (dialog.isShowing()) {
			            dialog.dismiss();
			         }
			        
			Log.i("registration screen :: onPost ::", result);
			    }
			 	
		}
		//---------------------------------------------------------------------------------------------------//
	}

