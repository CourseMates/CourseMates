package com.coursematesclient;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Intent;
import android.view.Menu;

public class SplashScreen extends Activity {

	
	// used to know if the back button was pressed in the splash screen activity and avoid opening the next activity
    private boolean mIsBackButtonPressed;
    private static final int SPLASH_DURATION = 5000; // 5 seconds
    IPadressHelper IPadress = new IPadressHelper();
    
  //---------------------------------------------------------------------------------------------------//
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.splash_screen);
		
		finish();
		Intent intent = new Intent(SplashScreen.this, Courses.class);
        SplashScreen.this.startActivity(intent);
        
        /*
        
		Handler handler = new Handler();
		 
        // run a thread after 2 seconds to start the home screen
        handler.postDelayed(new Runnable() {
 
            @Override
            public void run() {
 
                // make sure we close the splash screen so the user won't come back when it presses back key
 
                finish();
                 
                if (!mIsBackButtonPressed) {
                   
                	 // try to login  if the back button wasn't pressed already 
                	
                	
                	 Intent intent = new Intent(SplashScreen.this, Authentication.class);
                     SplashScreen.this.startActivity(intent);
                     
                	//LoginTask loginTask = new LoginTask();
            	//	loginTask.execute("http://"+IPadress.HOME_IP+":8089/CM_restfullWS/rest/course_service/login");

                	
                	//Show error dialog
//					AlertDialog.Builder builder = new AlertDialog.Builder(SplashScreen.this);
//		        	builder.setMessage("Check your internet connection... !");
//		        	builder.setTitle("Ooops");
//		        	AlertDialog dialog = builder.create();
//		        	dialog.show();
		        //	loginTask.cancel(true);
	                //finish();
            		
               }
                 
            }
 
        }, SPLASH_DURATION); // time in milliseconds (1 second = 1000 milliseconds) until the run() method will be called
 */
    }
 
   
	//---------------------------------------------------------------------------------------------------//
	@Override
	public void onBackPressed() {
	
	     // set the flag to true so the next activity won't start up
	     mIsBackButtonPressed = true;
	     super.onBackPressed();
	
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
		    	final int timeout = 10000; //ms
		    	HttpParams httpParams = new BasicHttpParams(); 
				HttpConnectionParams.setConnectionTimeout(httpParams, timeout);
		    	HttpConnectionParams.setSoTimeout(httpParams, timeout);
		    	final HttpClient httpclient = new DefaultHttpClient(httpParams);
		       // HttpClient httpclient = new DefaultHttpClient();
		        HttpContext  localContext = new BasicHttpContext();
		        HttpResponse response;
		        String responseString = "false";
		      //  UserData ud = new UserData();
        		String name = "" ;//= ud.getUserName(getApplicationContext());
        		String password ="";// = ud.getUserPassword(getApplicationContext());
        	//	Log.i("splash_debug", uri[0]+"/" +name +"/" +password);
        		//if there is NOT data in shared preferences ,return FALSE
        		if( name.equals("") || password.equals("")) {
        		//	return "false";
        			// start the Authentication screen 
					finish();
                    Intent intent = new Intent(SplashScreen.this, Authentication.class);
                    SplashScreen.this.startActivity(intent);
        		}
        	//	Log.i("splash_debug", uri[0]+"/" +name +"/" +password);
		        HttpGet do_get = new HttpGet(uri[0]+"/" +name +"/" +password);
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
		        } catch (ConnectTimeoutException e) {
		        	//Show error dialog
					AlertDialog.Builder builder = new AlertDialog.Builder(SplashScreen.this);
		        	builder.setMessage("Please retry later !");
		        	builder.setTitle("No connection to server");
		        	AlertDialog dialog = builder.create();
		        	dialog.show();
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
		     //   Log.i("splash_debug - onPostExecute", result);
		        try {
					JSONObject jsonResponse = new JSONObject(new String(result));
					Gson gson =  new Gson();
					LoginEntity login = gson.fromJson(jsonResponse.toString(),LoginEntity.class);
					
					   if(login.getAuthorized()) {
						   	finish();
				        	Intent intent = new Intent(SplashScreen.this, Home.class);
				        	SplashScreen.this.startActivity(intent);
					   }
					   else {
						   // start the Authentication screen 
							finish();
		                    Intent intent = new Intent(SplashScreen.this, Authentication.class);
		                    SplashScreen.this.startActivity(intent);
					   }
		        } catch (JSONException e) {
//		        	 Log.i("splash_debug - onPostExecute", "error");
				}
		        
		    }
	 //---------------------------------------------------------------------------------------------------//	
	}
	public String md5(String s) {
	    try {
	        // Create MD5 Hash
	        MessageDigest digest = java.security.MessageDigest.getInstance("MD5");
	        digest.update(s.getBytes());
	        byte messageDigest[] = digest.digest();
	
	        // Create Hex String
	        StringBuffer hexString = new StringBuffer();
	        for (int i=0; i<messageDigest.length; i++)
	            hexString.append(Integer.toHexString(0xFF & messageDigest[i]));
	        return hexString.toString();
	
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	    }
	    return "";
	}
}
