/**
 This class is expansion of basic adapter (List array of components displayed in ListView or GridView) that
 contains text and image 
 */

package com.coursematesclient;

import java.util.ArrayList;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class ImageAndTextAdapter extends ArrayAdapter<String> {

	private LayoutInflater mInflater;
	
	private  ArrayList<String> mStrings;
	//private TypedArray mIcons;
	
	private int mViewResourceId;
	//---------------------------------------------------------------------------------------------------//
	//constructor 
	public ImageAndTextAdapter(Context ctx, int viewResourceId,	 ArrayList<String> strings ) {
		super(ctx, viewResourceId, strings);
		
		mInflater = (LayoutInflater)ctx.getSystemService(
				Context.LAYOUT_INFLATER_SERVICE);
		
		mStrings = strings;
		mViewResourceId = viewResourceId;
	}
	//---------------------------------------------------------------------------------------------------//
	//return count of elements
	@Override
	public int getCount() {
		return mStrings.size();
	}
	//---------------------------------------------------------------------------------------------------//
	//return text by id
	@Override
	public String getItem(int position) {
		return mStrings.get(position);//  [position];
	}
	//---------------------------------------------------------------------------------------------------//
	@Override
	public long getItemId(int position) {
		return 0;
	}
	//---------------------------------------------------------------------------------------------------//
	//creation of view of single element
	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		convertView = mInflater.inflate(mViewResourceId, null);
		
		ImageView iv = (ImageView)convertView.findViewById(R.id.imageView_course_icon);
		iv.setImageResource(R.drawable.course_enitity_icon);
		TextView tv = (TextView)convertView.findViewById(R.id.textView_course_name);
		tv.setText(mStrings.get(position));
		
		return convertView;
	}
	//---------------------------------------------------------------------------------------------------//
}
