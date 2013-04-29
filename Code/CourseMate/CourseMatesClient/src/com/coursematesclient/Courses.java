package com.coursematesclient;

import android.app.Activity;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.Toast;

public class Courses extends Activity {
	
	IPadressHelper IPadress = new IPadressHelper();
//	ArrayAdapter<String> adapter ;
	
	//---------------------------------------------------------------------------------------------------//
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.my_courses_screen);
		
		Context ctx = getApplicationContext();
	    Resources res = ctx.getResources();
	    String[] course_names = {"Linear Algebra","Physics-2","Algorithmics-2","Software Engineering","Databases","Formular Languages","Cryptography",
	    		"Hedva","Networking","Discrete Mathematics","Economics","Internet Intro"};//res.getStringArray(R.array.country_names);
	 //   TypedArray icons = res.obtainTypedArray(R.drawable.course_enitity_icon);   
	    
	    
	//	UserData ud = new UserData();
		GridView gridview = (GridView) findViewById(R.id.gridView1);
	//	ImageAdapter  ia = new ImageAdapter(this);
		final ImageAndTextAdapter ia = new ImageAndTextAdapter(ctx, R.layout.course_item,course_names);
	    gridview.setAdapter(ia);
	    
	    gridview.setOnItemClickListener(new  AdapterView.OnItemClickListener() {
		
	    	@Override
			public void onItemClick(AdapterView<?> parent, View v, int position,
					long id) {
				Toast.makeText(Courses.this, "" + position +" - " +ia.getItem(position), Toast.LENGTH_SHORT).show();
				
			}
	    });
	}
	//---------------------------------------------------------------------------------------------------//

}
