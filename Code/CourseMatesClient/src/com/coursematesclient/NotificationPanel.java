package com.coursematesclient;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

public class NotificationPanel extends Activity {
	
	Context ctx = this;
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.notification_panel);
		
		
		ListView notificationListView = (ListView) findViewById(R.id.listView_notification);
		
//		ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, 
//		        android.R.layout.simple_list_item_1, Utils.msgList);
//		notificationListView.setAdapter(adapter);
		
		
		
		ImageAndTextAdapter ia = new ImageAndTextAdapter(ctx, R.layout.notification_item,Utils.msgList);
		
		notificationListView.setAdapter(ia);
		
		notificationListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {

				finish();
	        	Intent intent = new Intent(NotificationPanel.this, Authentication.class);
	        	intent.putExtra("from","notification");
	        	NotificationPanel.this.startActivity(intent);
	        	
				
			}
			
			
		});
	}
	
	 @Override
	    public void onStop() {
	        super.onStop();
	        Utils.numMessages=0;
	    	Utils.msgList.clear();
	    }
	
}
