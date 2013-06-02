package com.coursematesclient;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class NewCourseDialog extends Dialog {
	Context c ; 
    public NewCourseDialog(Context context, int customDialog) {
	 super(context , customDialog);

     c = context ; 
 }

 @Override
 protected void onCreate(Bundle savedInstanceState) {
     super.onCreate(savedInstanceState);

     setTitle("Add a course");
	 setContentView(R.layout.new_course_dialog);
     Button b3 =(Button) findViewById(R.id.button_dismiss); 
     b3.setOnClickListener(new View.OnClickListener() {

         @Override
         public void onClick(View v) {
        	 dismiss();
//             Toast.makeText(c,"Button 3 has been clicked ",Toast.LENGTH_LONG).show();
         }
     });

 }

}
