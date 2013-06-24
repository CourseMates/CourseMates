package com.coursematesclient;


import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.NotificationManager;
import android.content.ClipData;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.support.v4.app.NotificationCompat.Builder;

public class Debug extends Activity {
	
final Context context = this;
Button btn1,btn2,btn3,btnCopy;
EditText mDisplay;

//private String TAG = "** pushAndroidActivity **";
		@SuppressLint("ServiceCast")
		protected void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			
			
			setContentView(R.layout.debug_screen);
			
			
			btn1 = (Button) findViewById(R.id.debug_but_register);
			btn2 = (Button) findViewById(R.id.debug_but_unregister);
			btn3 = (Button) findViewById(R.id.debug_but_push);
			mDisplay = (EditText) findViewById(R.id.debug_editTextID);	
			btnCopy = (Button) findViewById(R.id.debug_but_copy);
//			final ClipboardManager clipboard = (ClipboardManager)
//			        getSystemService(Context.CLIPBOARD_SERVICE);
			
			btn1.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							
							final String regId = Utils.GCMregisterIfNotRegistered(context);
							mDisplay.setText(regId);
							}
			});
			
			btn2.setOnClickListener(new View.OnClickListener() {
				
				@Override
				public void onClick(View v) {
					Utils.GCMUnregister(context);
				//	GCMRegistrar.unregister(context);
					mDisplay.getText().clear();
				}
			});
			
		btn3.setOnClickListener(new View.OnClickListener() {
				
				@Override
				public void onClick(View v) {
					
					//simple notification
					//Builder mBuilder = Utils.createNotificationBuilder(context,R.drawable.ic_launcher,"CourseMates","test notification");
					//expandable notification
					Builder mBuilder = Utils.createNotificationListBuilder(context,R.drawable.ic_launcher,"CourseMates","test notification");
			    	NotificationManager mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
			    	int mId = 0;
					// mId allows you to update the notification later on.
			    	mNotificationManager.notify(mId, mBuilder.build());
				}
			});
			

	btnCopy.setOnClickListener(new View.OnClickListener() {
				@SuppressLint("NewApi")
				@Override
				public void onClick(View v) {
					
					android.content.ClipboardManager clipboard = (android.content.ClipboardManager) getSystemService(Context.CLIPBOARD_SERVICE); 
			        android.content.ClipData clip = ClipData.newPlainText("simple text", mDisplay.getText());
			        clipboard.setPrimaryClip(clip);
					
				}
			});



		}//end of onCreate
		
	//---------------------------------------------------------------------------------------------------//
	//menu
		//create "Back" button on menu
		 @Override
		    public boolean onPrepareOptionsMenu(Menu menu) {
		        menu.findItem(R.id.action_settings).setVisible(true);
		        return super.onPrepareOptionsMenu(menu);
		    }
		@Override
	   public boolean onCreateOptionsMenu(Menu menu) {
	       // Inflate the menu; this adds items to the action bar if it is present.
	       getMenuInflater().inflate(R.menu.main, menu);
	       return true;
	   }
		@Override
		public boolean onOptionsItemSelected(MenuItem item) {
			finish();
			Intent intent = new Intent(Debug.this, Authentication.class);
			Debug.this.startActivity(intent);
			return true;
		}
		
}

