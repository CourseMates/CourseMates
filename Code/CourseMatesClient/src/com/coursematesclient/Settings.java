package com.coursematesclient;

import android.app.DialogFragment;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.Button;
import android.widget.CheckBox;

public class Settings extends DialogFragment {

	private static Context context;

	public Settings() {
	}
	
	public  Settings newInstance (Context activityContext) {
		Settings frag = new Settings();
		context = activityContext;
	        return frag;
	}

	
		@Override
	    public View onCreateView(LayoutInflater inflater, ViewGroup container,
	            Bundle savedInstanceState) {
		 	getDialog().getWindow().requestFeature(Window.FEATURE_NO_TITLE);
	        View v = inflater.inflate(R.layout.settings_screen, null, false);
	      //create object that operate with user's data ,stored locally.
			final UserData ud = new UserData();
	        //Getting checkboxes
	        final CheckBox autologinCheckBox = (CheckBox) v.findViewById(R.id.checkBox_settings_autologin);
	        final CheckBox pushCheckBox = (CheckBox) v.findViewById(R.id.checkBox_settings_push);
	        
	        //Update the views according to user saved data
	        autologinCheckBox.setChecked(ud.getAutologin(context));
	        pushCheckBox.setChecked(ud.getPushnotification(context));
	        
	        
	        
	        //Button listeners
	        Button saveBtn = (Button) v.findViewById(R.id.button_settings_save);
	        Button cancelBtn = (Button) v.findViewById(R.id.button_settings_cancel);
	        
	        //save button click 
	        saveBtn.setOnClickListener(new OnClickListener() {
				@Override
				public void onClick(View v) {
					ud.setAutologin(context, autologinCheckBox.isChecked());
					ud.setPushnotification(context, pushCheckBox.isChecked());
					if(!pushCheckBox.isChecked() && Utils.isGCMRegistered(context)) {
						Utils.GCMUnregister(context);
					} else
						if(pushCheckBox.isChecked() && !Utils.isGCMRegistered(context)) {
							Utils.GCMregisterIfNotRegistered(context);
						}	
					dismiss();
				}
			});
	        
	        
	        //cancel button click
	        cancelBtn.setOnClickListener(new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					dismiss();
					
				}
			});
	        return v;
	    }


}
