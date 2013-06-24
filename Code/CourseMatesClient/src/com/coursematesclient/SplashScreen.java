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
		
		
		//clear all pending notification
		Utils.numMessages=0;
		Utils.msgList.clear();
		
		
		//change color of progress bar
		ProgressBar	pb =  (ProgressBar) findViewById(R.id.progressBar1);
		pb.getIndeterminateDrawable().setColorFilter(0xff0000a0, android.graphics.PorterDuff.Mode.MULTIPLY);
		

//		finish();
//		Intent intent = new Intent(SplashScreen.this, SettingsActivity.class);
//		intent.putExtra("userID",1);
//    	intent.putExtra("sessionID", "dsdsds");
//    	intent.putExtra("courseID", 1);
//        SplashScreen.this.startActivity(intent);
	
		//getting the user data and check if autologin turned on
		UserData ud = new UserData();
		if(ud.getAutologin(getApplicationContext()) && Utils.isLettersAndNumber(ud.getUserName(getApplicationContext())))  {
			
	    	//create and execute LoginTask in background 
    		LoginTask loginTask = new LoginTask(getApplicationContext(),this,false);
			loginTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMatesREST.svc/rest/login");
		}
		else 
		{
       //show basic splash screen
			        
					Handler handler = new Handler();
					 
			        // run a thread after t seconds to start the  authentication screen
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
	

	
}
