package com.coursematesclient;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;

public class Registaration extends Activity {
			
		protected void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			setContentView(R.layout.register_screen);
			
		}


		@Override
		public boolean onCreateOptionsMenu(Menu menu) {
			// Inflate the menu; this adds items to the action bar if it is present.
			getMenuInflater().inflate(R.menu.splash_screen, menu);
			return true;
		}

	}

