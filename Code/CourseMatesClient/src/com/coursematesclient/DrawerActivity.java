package com.coursematesclient;

import android.app.Activity;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

public abstract class DrawerActivity extends Activity {

    protected LinearLayout fullLayout;
    protected FrameLayout actContent;

    @Override
    public void setContentView(final int layoutResID) {
        fullLayout= (LinearLayout) getLayoutInflater().inflate(R.layout.drawer_multi_activity, null); // Your base layout here
        actContent= (FrameLayout) fullLayout.findViewById(R.id.global_content_frame);
        getLayoutInflater().inflate(layoutResID, actContent, true); // Setting the content of layout your provided to the act_content frame
        super.setContentView(fullLayout);
        // here you can get your drawer buttons and define how they should behave and what must they do, so you won't be needing to repeat it in every activity class
    }
}