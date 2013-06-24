/**
*  This class operates LoginScreen . It checks if there is user's credentials stored locally ( UserData class ). 
*  Uses LoginTask to Communicates with RESTfull web service to validate password. 
*  It retrieves UserID and SessionID from the server 
 */

package com.coursematesclient;


import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;


public class Authentication extends Activity  {
	
	//IPadressHelper IPadress = new IPadressHelper();
	final Context context = this;
	final Activity myActivity = this;
	//---------------------------------------------------------------------------------------------------//
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.authentication_screen);
		
		 final CheckBox checkBox = (CheckBox) findViewById(R.id.checkBox_savepassword);
		 final CheckBox checkBoxAutoLogin = (CheckBox) findViewById(R.id.checkBox_autologin);
		 
		 //set checkboxs  "true" and hide them. now the control from setting dialog only
		 checkBox.setChecked(true);
		 checkBoxAutoLogin.setChecked(true);
		 checkBoxAutoLogin.setVisibility(View.GONE);
		 checkBox.setVisibility(View.GONE);
		 
		 
		//create object that operate with user's data ,stored locally.
		UserData ud = new UserData();
		
		//get user name
		String name = ud.getUserName(getApplicationContext());
		//get password
		String password = ud.getUserPassword(getApplicationContext());
		
		//check if there is user's data
		if( !name.equals("") && !password.equals("")) {
			
			//update views with relevant information
			EditText test = (EditText) findViewById(R.id.autoCompleteTextView_username);
			test.setText(name);
			EditText pass = (EditText) findViewById(R.id.editText_password);
			pass.setText(password);
			checkBox.setChecked(ud.isPasswordSaved(context));
			checkBoxAutoLogin.setChecked(ud.getAutologin(context));
		}
		
		
		
		checkBox.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				if (checkBox.isChecked())
				checkBoxAutoLogin.setChecked(Boolean.TRUE);
				else
					checkBoxAutoLogin.setChecked(Boolean.FALSE);
			}
		});
		
		
		//create button object to handle login button
		Button login_button = (Button) findViewById(R.id.Login_button);
		//create listener for login button
		login_button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//insert user-name ,password and "save password" choice into UserData object 
				UserData ud = new UserData();
				EditText text = (EditText) findViewById(R.id.autoCompleteTextView_username);
				String username =text.getText().toString();
				
				String password = ((TextView) findViewById(R.id.editText_password)).getText().toString();
				//TODO to save md5 of password and not real password
				
				
				//String passwordmd5 = md5(((TextView) findViewById(R.id.editText_password)).getText().toString()); 
				
				
				//for debugging purposes
				//Log.i("Auth debug",username + " " +password);
				final CheckBox checkBoxAutoLogin = (CheckBox) findViewById(R.id.checkBox_autologin);
				//store user's data in device , uses SharedPrefences mechanism  
				ud.saveUserAuthenticationData(getApplicationContext(), username, password ,checkBox.isChecked(),checkBoxAutoLogin.isChecked());
				if(!Utils.isLettersAndNumber(username)) {
					 Utils.showMyDialog(context, "Ooops", "Not valid user name", true);
				 }
				 else if(password.length()<8)
							Utils.showMyDialog(context, "Ooops", "Password is minimum 8 characters ", true);
				else	 
				//for debugging purposes when WebService is down 
				if(username.equals("test") && password.equals("12345678")) {
					finish();
//		        	Intent intent = new Intent(Authentication.this, Courses.class);
//					Authentication.this.startActivity(intent);
					
					Intent intent = new Intent(Authentication.this, FileExplorer.class);
		        	intent.putExtra("userID", 10);
		        	intent.putExtra("sessionID", 1);
		        	intent.putExtra("courseID", 5);
		        	Authentication.this.startActivity(intent);
				}
				
				else
					{
					//create and execute LoginTask in background 
					LoginTask loginTask = new LoginTask(context,myActivity,true);
					loginTask.execute("http://coursemate.mooo.com:8090/cmws/CourseMatesREST.svc/rest/login");
					}
			}			
		});
		
		//create button object to handle registration  button
		Button reg_button = (Button) findViewById(R.id.register_button);
		//create listener for register button
		reg_button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//create and call intent in order to pass to other screen
				Intent intent = new Intent(Authentication.this, Registaration.class);
				//kill this activity
				finish();
				Authentication.this.startActivity(intent);
				overridePendingTransition(R.layout.push_right_out ,R.layout.push_right_in);
			}			
		});
		
		
	//create button and listener for clear button	
	ImageButton clear_username = (ImageButton) findViewById(R.id.imageButtonclear);
		clear_username.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//clear user name
				EditText username = (EditText) findViewById(R.id.autoCompleteTextView_username);
				username.getText().clear();
				EditText pass = (EditText) findViewById(R.id.editText_password);
				pass.getText().clear();
			}			
		});
		
		
		
		//create button and listener for About button
		Button about_button = (Button) findViewById(R.id.button_about);
		//create listener for register button
		about_button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//create and call intent in order to pass to other screen
				Intent intent = new Intent(Authentication.this, About.class);
				Authentication.this.startActivity(intent);
				overridePendingTransition(R.layout.push_right_out ,R.layout.push_right_in);
			}			
		});
		
		
	}
	
	//---------------------------------------------------------------------------------------------------//
	
	//create "Debug" button on menu
	 @Override
	    public boolean onPrepareOptionsMenu(Menu menu) {
	        menu.findItem(R.id.debug_menu).setVisible(true);
	        return super.onPrepareOptionsMenu(menu);
	    }
	@Override
   public boolean onCreateOptionsMenu(Menu menu) {
       // Inflate the menu; this adds items to the action bar if it is present.
       getMenuInflater().inflate(R.menu.debug_menu, menu);
       return true;
   }
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		finish();
		Intent intent = new Intent(Authentication.this, Debug.class);
		Authentication.this.startActivity(intent);
		return true;
	}
	//---------------------------------------------------------------------------------------------------//

	
}

