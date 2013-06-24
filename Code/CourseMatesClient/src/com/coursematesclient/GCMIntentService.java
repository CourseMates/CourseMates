package com.coursematesclient;


import static com.coursematesclient.Utils.SENDER_ID;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.support.v4.app.NotificationCompat.Builder;
import android.util.Log;
 
import com.google.android.gcm.GCMBaseIntentService;
 
public class GCMIntentService extends GCMBaseIntentService{
 
    Context ctx;
	public GCMIntentService() {
	super(SENDER_ID);
	}
 
private static final String TAG = "===GCMIntentService===";
 
	//---------------------------------------------------------------------------------------------------//	
	@Override
	protected void onRegistered(Context arg0, String registrationId) {
	Log.i(TAG, "Device registered: regId = " + registrationId);
	ctx = arg0;
	}
	//---------------------------------------------------------------------------------------------------//
	@Override
	protected void onUnregistered(Context arg0, String arg1) {
	Log.i(TAG, "unregistered = "+arg1);
	}
	//---------------------------------------------------------------------------------------------------//
	@Override
	protected void onMessage(Context arg0, Intent arg1) {
	Log.i(TAG, "new message= ");
	String action = arg1.getAction();
	
    if ("com.google.android.c2dm.intent.RECEIVE".equals(action)) { 
	    	String message1 = arg1.getStringExtra("data");
	    	Log.i(TAG+"in if",message1);
	    	//Log.i(TAG+"in if",arg1.getStringExtra("payload"));
	    	sendNotification(arg0,message1);
	    }
 
	}
	 //---------------------------------------------------------------------------------------------------//
	@Override
	protected void onError(Context arg0, String errorId) {
	Log.i(TAG, "Received error: " + errorId);
	}
	//---------------------------------------------------------------------------------------------------//
	@Override
	protected boolean onRecoverableError(Context context, String errorId) {
	return super.onRecoverableError(context, errorId);
	}
	//---------------------------------------------------------------------------------------------------//
	
	 // Put the GCM message into a notification and post it.
	private void sendNotification(Context context , String msg) {

		
		//Builder mBuilder = Utils.createNotificationBuilder(context,R.drawable.ic_launcher,"CourseMates",msg);
		
		//get the running OS version
		int currentapiVersion = Build.VERSION.SDK_INT;
	//	Log.i(TAG,Integer.toString(currentapiVersion));
		Builder mBuilder;
		if (currentapiVersion >= android.os.Build.VERSION_CODES.JELLY_BEAN){
			 mBuilder = Utils.createNotificationListBuilder(context,R.drawable.ic_launcher,"CourseMates",msg);
		} else{
			 mBuilder = Utils.createNotificationBuilder(context,R.drawable.ic_launcher,"CourseMates",msg);
		}
		
		
		
    	NotificationManager mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
    	int mId = 0;
    	
		// mId allows you to update the notification later on.
    	mNotificationManager.notify(mId, mBuilder.build());
    }
	//---------------------------------------------------------------------------------------------------//
}