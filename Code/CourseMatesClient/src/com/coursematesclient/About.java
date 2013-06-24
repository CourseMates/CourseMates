package com.coursematesclient;


import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

public class About extends Activity {
	

		protected void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			setContentView(R.layout.about_screen);
			

		
		
		
		}
		
		//create "back" button on menu
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
		//handle the back button
		@Override
		public boolean onOptionsItemSelected(MenuItem item) {
			finish();
		//	Intent intent = new Intent(About.this, Authentication.class);
	//		About.this.startActivity(intent);
//        	overridePendingTransition(R.layout.push_right_out ,R.layout.push_right_in);
			return true;
		}
		
		//back pressed
//		@Override
//		public void onBackPressed() {
//			finish();
//			Intent intent = new Intent(About.this, Authentication.class);
//			About.this.startActivity(intent);
//        	overridePendingTransition(R.layout.push_right_out ,R.layout.push_right_in);
//		 }

}