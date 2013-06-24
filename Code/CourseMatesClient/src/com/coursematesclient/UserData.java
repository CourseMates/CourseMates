package com.coursematesclient;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

public class UserData  {
	
	public static final String PREF_NAME = "USER_DATA";
	public static final int MODE = Context.MODE_PRIVATE;
	
	final private static String username = "USERNAME";
	final private static String password = "PASSWORD";
	final private static String savepassword = "SAVE_PASSWORD";
	final private static String autologin = "AUTO_LOGIN";
	final private static String pushnotification = "PUSH_NOTIFY";
	
	//---------------------------------------------------------------------------------------------------//
	public void saveUserAuthenticationData(Context context , String user,String pass,Boolean save_password, boolean alogin) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		Editor edit = sp.edit();
		edit.putString(username, user);
		edit.putString(password, pass);
		edit.putBoolean(savepassword, save_password);
		edit.putBoolean(autologin, alogin);
		edit.commit();
	}
	//---------------------------------------------------------------------------------------------------//
	public String getUserName (Context context) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		return sp.getString(username, "");
	}
	//---------------------------------------------------------------------------------------------------//
	public String getUserPassword (Context context) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		return sp.getString(password, "");
	}
	//---------------------------------------------------------------------------------------------------//
	public Boolean isPasswordSaved (Context context) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		return sp.getBoolean(savepassword, false);
	}
	//---------------------------------------------------------------------------------------------------//
	public void logout (Context context) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		Editor edit = sp.edit();
		edit.clear();
		edit.commit();
		Utils.GCMUnregister(context);
	}
	//---------------------------------------------------------------------------------------------------//
	public  boolean getAutologin(Context context) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		return sp.getBoolean(autologin, false);
	}
	//---------------------------------------------------------------------------------------------------//
	public  void setAutologin(Context context ,boolean auto) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		Editor edit = sp.edit();
		edit.putBoolean(autologin, auto);
		edit.commit();
	}
	//---------------------------------------------------------------------------------------------------//
	public  boolean getPushnotification(Context context) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		return sp.getBoolean(pushnotification,false);
	}
	//---------------------------------------------------------------------------------------------------//
	public void setPushnotification(Context context, boolean push) {
		SharedPreferences sp = context.getSharedPreferences(PREF_NAME, MODE);
		Editor edit = sp.edit();
		edit.putBoolean(pushnotification, push);
		edit.commit();
	}
	//---------------------------------------------------------------------------------------------------//
}
