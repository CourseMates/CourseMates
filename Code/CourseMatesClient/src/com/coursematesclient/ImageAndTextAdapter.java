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

public class ImageAndTextAdapter extends ArrayAdapter<ImageAndTextAdoptable> {

	private LayoutInflater mInflater;
	
	private  ArrayList<ImageAndTextAdoptable> objs;
	//private TypedArray mIcons;
	
	private int mViewResourceId;
	
	static Context context;
	//---------------------------------------------------------------------------------------------------//
	//constructor 
	public ImageAndTextAdapter(Context ctx, int viewResourceId,	 ArrayList<ImageAndTextAdoptable> objlist ) {
		super(ctx, viewResourceId, objlist);
		
		mInflater = (LayoutInflater)ctx.getSystemService(
				Context.LAYOUT_INFLATER_SERVICE);
		context = ctx;
		objs = objlist;
		mViewResourceId = viewResourceId;
	}
	//---------------------------------------------------------------------------------------------------//
	//return count of elements
	@Override
	public int getCount() {
		return objs.size();
	}
	//---------------------------------------------------------------------------------------------------//
	//return text by id
	@Override
	public ImageAndTextAdoptable getItem(int position) {
		return objs.get(position);//  [position];
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
		
		iv.setImageResource(objs.get(position).GetResourceID());
		TextView tv = (TextView)convertView.findViewById(R.id.textView_course_name);
		tv.setText(objs.get(position).GetText());
		
		return convertView;
	}
	//---------------------------------------------------------------------------------------------------//
//	public static int getImageId(String imageName) {
//	    return ctx.getResources().getIdentifier("R.drawable." + imageName, null, ctx.getPackageName());
//	}
}
