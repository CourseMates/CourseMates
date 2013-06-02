/**
 This class is implementation of SPLASH SCREEN that displayed when application is lunched
 */
package com.coursematesclient;

import android.os.Bundle;
import android.os.Handler;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.WindowManager;
import android.widget.ProgressBar;

public class SplashScreen extends Activity {

	
	// used to know if the back button was pressed in the splash screen activity and avoid opening the next activity
    private boolean mIsBackButtonPressed;
    private static final int SPLASH_DURATION = 2000; // 2 seconds 
    IPadressHelper IPadress = new IPadressHelper();
  //---------------------------------------------------------------------------------------------------//
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		//turns on screen , for development  comfort
		getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
		//set xml view for this activity 
		setContentView(R.layout.splash_screen);
		
		Utils.numMessages=0;
		Utils.msgList.clear();
		
		
		//change color of progress bar
		ProgressBar	pb =  (ProgressBar) findViewById(R.id.progressBar1);
		pb.getIndeterminateDrawable().setColorFilter(0xff0000a0, android.graphics.PorterDuff.Mode.MULTIPLY);
        
       
        
		Handler handler = new Handler();
		 
        // run a thread after t seconds to start the home screen or authentication screen
        handler.postDelayed(new Runnable() {
 
            @Override
            public void run() {
 
                // make sure we close the splash screen so the user won't come back when it presses back key
 
                finish();
                 
                if (!mIsBackButtonPressed) {
                   
                	 // try to login  if the back button wasn't pressed already 
                	
                	finish();
            		Intent intent = new Intent(SplashScreen.this, Authentication.class);
                    SplashScreen.this.startActivity(intent);
            		
               }
                 
            }
 
        }, SPLASH_DURATION); // time in milliseconds (1 second = 1000 milliseconds) until the run() method will be called
 
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
	
	
	/*
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
	}*/
	
}
