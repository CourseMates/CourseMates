package com.coursematesclient;


import static com.coursematesclient.Utils.SENDER_ID;
import com.google.android.gcm.GCMRegistrar;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.NotificationManager;
import android.content.ClipData;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.support.v4.app.NotificationCompat.Builder;
import android.util.Log;

public class About extends Activity {
	
final Context context = this;
Button btn1,btn2,btn3,btnCopy;
private EditText mDisplay;

private String TAG = "** pushAndroidActivity **";
		@SuppressLint("ServiceCast")
		protected void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			setContentView(R.layout.about_screen);
			
			
			btn1 = (Button) findViewById(R.id.button1);
			btn2 = (Button) findViewById(R.id.button2);
			btn2 = (Button) findViewById(R.id.button3);
			mDisplay = (EditText) findViewById(R.id.editText1);	
			btnCopy = (Button) findViewById(R.id.button_copy);
			
//			final ClipboardManager clipboard = (ClipboardManager)
//			        getSystemService(Context.CLIPBOARD_SERVICE);
			
			btn1.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							checkNotNull(SENDER_ID, "SENDER_ID");
							 
							GCMRegistrar.checkDevice(context);
							GCMRegistrar.checkManifest(context);
							final String regId = GCMRegistrar.getRegistrationId(context);
							Log.i(TAG, "registration id =====  "+regId);
							 
								if (regId.equals("")) {
								GCMRegistrar.register(context, SENDER_ID);
								} else {
								Log.v(TAG, "Already registered");
								}
							 
							mDisplay.setText(regId);
							}
			});
			
			btn2.setOnClickListener(new View.OnClickListener() {
				
				@Override
				public void onClick(View v) {
					GCMRegistrar.unregister(context);
				}
			});
			
btn2.setOnClickListener(new View.OnClickListener() {
				
				@Override
				public void onClick(View v) {
					
//			    	Builder mBuilder = Utils.createNotificationBuilder(context,R.drawable.ic_launcher,"CourseMates","test notification");
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



		}
		
	
	
		private void checkNotNull(Object reference, String name) {
			if (reference == null) {
			throw new NullPointerException();
			}
		}
}

