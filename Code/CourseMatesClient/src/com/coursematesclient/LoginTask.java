/**
*  This class is async task that tries to log-in . It checks if there is user's credentials stored locally ( UserData class ). 
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
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class LoginTask extends AsyncTask<String,Void,String> {
	
	private Context app_context;	
	private Activity activity;
	private Boolean isLoadingDialog;
    Dialog dialog ;
	
	 public LoginTask (Context context, Activity activity ,Boolean withdialog ){
			this.app_context = context;
			this.activity = activity;
			this.isLoadingDialog = withdialog;
		}
	
	 
	//---------------------------------------------------------------------------------------------------//
	@Override
   protected void onPreExecute() {
       super.onPreExecute();
       if(isLoadingDialog) {
		       	dialog  = new Dialog(app_context, R.style.custom_dialog);
		       	dialog.setTitle("Verifying ...");
				dialog.setContentView(R.layout.loading_dilalog);
				//dialog.setCanceledOnTouchOutside(false);
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
	} 
		
	//---------------------------------------------------------------------------------------------------//	
	
	
	//runs in background 
    @Override
    protected String doInBackground(String... uri) {
    	
    	
    	
        HttpClient httpclient = new DefaultHttpClient();
        HttpContext  localContext = new BasicHttpContext();
        HttpResponse response;
        String responseString = "false";
        UserData ud = new UserData();
        String username = ud.getUserName(app_context);
        String password = Utils.md5(ud.getUserPassword(app_context));
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
	        //Log.i("LoginTask: onPost",result );
	        
	        if (isLoadingDialog && dialog.isShowing()) {
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
					  
					   	activity.finish();
					    
						//create object that operate with user's data ,stored locally.
						UserData ud = new UserData();
						//Enable push notification
					   	ud.setPushnotification(app_context, true);
					   	//Register for GCM server 
						Utils.GCMregisterIfNotRegistered(app_context);
						
						
			        	Intent intent = new Intent(activity, Courses.class);
			        	intent.putExtra("userID", login.getId());
			        	intent.putExtra("sessionID", login.getLoginResult());
			        	activity.startActivity(intent);
		        	}
			        else {
			        	//Log.i("test",activity.getClass().getSimpleName());
			        	if(activity.getClass().getSimpleName().equals("SplashScreen")) {
			        		activity.finish();
		            		Intent intent = new Intent(activity, Authentication.class);
		            		Toast toast = Toast.makeText(activity, "User's name or password are incorect !", Toast.LENGTH_LONG);	
		        	    	toast.show();
		            		activity.startActivity(intent);
			        	}
			        	else
			        	//Show error dialog
			        	Utils.showMyDialog(app_context," Ooops"," User's name or password are incorect !", true);
				    }
				
			} catch (JSONException e) {
				e.printStackTrace();
			}
	     
	    }
	 	
}
//---------------------------------------------------------------------------------------------------//
