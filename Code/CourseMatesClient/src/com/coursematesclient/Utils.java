/**
*  This class contains utilities
*  
 */
package com.coursematesclient;


import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.PendingIntent;
import android.app.TaskStackBuilder;
import android.content.Context;
import android.content.Intent;
import android.media.RingtoneManager;
import android.net.Uri;
import android.support.v4.app.NotificationCompat;
import android.util.Log;

final class Utils {

	
	
	static final String SENDER_ID = "472038630738";
	public static int numMessages;
	public static ArrayList<String> msgList = new ArrayList<String>();
	//---------------------------------------------------------------------------------------------------//
	//converts input string into md5 hash 
	public static String md5(String input) {
	        
	        String md5 = null;
	         
	        if(null == input) return null;
	         
	        try {
	             
	        //Create MessageDigest object for MD5
	        MessageDigest digest = MessageDigest.getInstance("MD5");
	        //Update input string in message digest
	        digest.update(input.getBytes(), 0, input.length());
	        //Converts message digest value in base 16 (hex) 
	        md5 = new BigInteger(1, digest.digest()).toString(16);
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        }
	        return md5;
	    }
	//---------------------------------------------------------------------------------------------------//
	//Show simple dialog  
	public static  void showMyDialog(Context ctx,String title ,String message ,boolean cancellable ) {
			AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
			builder.setMessage(message);
			builder.setTitle(title);
			AlertDialog dialog = builder.create();
			dialog.setCancelable(cancellable);
			dialog.show();
	}
	//---------------------------------------------------------------------------------------------------//
	public static boolean validateEmailAddress (String email) {
		
		return (email.matches("[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+") && email.length() > 0);
        
	}
	//---------------------------------------------------------------------------------------------------//
	public static boolean isLettersOnly (String str) {
		
		
		Log.i("isLetter string:  ", str );
		
		
		if( str.matches("[a-z]+") )
		Log.i("isLetter test ", str +" is true");
				else 
		Log.i("isLetter test ",str + " is false");
		
		
		return ( str.matches("[a-z]+"));
        
	}
	//---------------------------------------------------------------------------------------------------//
	//simple notification for <  OS 4.1
	@SuppressLint("NewApi")
	public static NotificationCompat.Builder createNotificationBuilder(Context context, int icon, CharSequence title, CharSequence text){
		NotificationCompat.Builder mBuilder =  new NotificationCompat.Builder(context)
        .setSmallIcon(icon)
        .setContentTitle(title)
        .setContentText(text);
		
		mBuilder.setContentText(text)
	        .setNumber(++numMessages);
		// Creates an explicit intent for an Activity in your app
		Intent resultIntent = new Intent(context, NotificationPanel.class);
		
		
		// The stack builder object will contain an artificial back stack for the
		// started Activity.
		// This ensures that navigating backward from the Activity leads out of
		// your application to the Home screen.
		TaskStackBuilder stackBuilder = TaskStackBuilder.create(context);
		// Adds the back stack for the Intent (but not the Intent itself)
		stackBuilder.addParentStack(NotificationPanel.class);
		// Adds the Intent that starts the Activity to the top of the stack
		stackBuilder.addNextIntent(resultIntent);
		PendingIntent resultPendingIntent =
		        stackBuilder.getPendingIntent(
		            0,
		            PendingIntent.FLAG_UPDATE_CURRENT
		        );
		mBuilder.setContentIntent(resultPendingIntent);
		
		//add default notification sound
		Uri uri= RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
		mBuilder.setSound(uri);
		
		//dismiss the notification after click
		mBuilder.setAutoCancel(true);
		
		
		return mBuilder;
	}
	
	//---------------------------------------------------------------------------------------------------//
	//Notification with sub list for OS >= 4.1
	@SuppressLint("NewApi")
	public static NotificationCompat.Builder createNotificationListBuilder(Context context, int icon, CharSequence title, CharSequence text) {
		NotificationCompat.Builder mBuilder =  new NotificationCompat.Builder(context)
        .setSmallIcon(icon)
        .setContentTitle(title)
        .setContentText(text)
		.setContentText(text)
	    .setNumber(++numMessages);
		// Creates an explicit intent for an Activity in your app
		Intent resultIntent = new Intent(context, NotificationPanel.class);
		
		
		// The stack builder object will contain an artificial back stack for the
		// started Activity.
		// This ensures that navigating backward from the Activity leads out of
		// your application to the Home screen.
		TaskStackBuilder stackBuilder = TaskStackBuilder.create(context);
		// Adds the back stack for the Intent (but not the Intent itself)
		stackBuilder.addParentStack(NotificationPanel.class);
		// Adds the Intent that starts the Activity to the top of the stack
		stackBuilder.addNextIntent(resultIntent);
		PendingIntent resultPendingIntent =
		        stackBuilder.getPendingIntent(
		            0,
		            PendingIntent.FLAG_UPDATE_CURRENT
		        );
		mBuilder.setContentIntent(resultPendingIntent);
		
		
		NotificationCompat.InboxStyle inboxStyle =
		        new NotificationCompat.InboxStyle();
		//Log.i("list of notification", Integer.toString(events.length));
		// Sets a title for the Inbox style big view
		//inboxStyle.setBigContentTitle("Event tracker details:");
		// Moves events into the big view
		
		
		//adding last msg to msg_list
		msgList.add((String) text);
		
		
		//displays the notification sub list
		for (int i=0; i < msgList.size(); i++) {

		    inboxStyle.addLine((i+1) +": " +msgList.get(i));
		}
		// Moves the big view style object into the notification object.
		mBuilder.setStyle(inboxStyle);
		//add default notification sound
		Uri uri= RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
		mBuilder.setSound(uri);
		
		//dismiss the notification after click
		mBuilder.setAutoCancel(true);
		
		return mBuilder;
	}
	//---------------------------------------------------------------------------------------------------//	
}
