package com.coursematesclient;

import java.util.Date;

import android.app.DialogFragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.TextView;

public class DetailsAndActionDialogFragment extends DialogFragment {


	public DetailsAndActionDialogFragment() {
	}

	public DetailsAndActionDialogFragment newInstance (String fname, String ownerName, int size, String fileType, Date date ,int rate) {
		DetailsAndActionDialogFragment frag = new DetailsAndActionDialogFragment();
	        Bundle args = new Bundle();
	        args.putString("fname", fname);
	        args.putString("ownerName", ownerName);
	        args.putString("fileType", fileType);
	        args.putInt("size", size);
	        args.putInt("rate", rate);
	        args.putString("date", date.toString());
	        frag.setArguments(args);
	        return frag;
		
	}
	 @Override
	    public View onCreateView(LayoutInflater inflater, ViewGroup container,
	            Bundle savedInstanceState) {
		 	getDialog().getWindow().requestFeature(Window.FEATURE_NO_TITLE);
		 	
	        View v = inflater.inflate(R.layout.details_and_action_dialog, container, false);
	        
	        View edtFileName = v.findViewById(R.id.textView_filename);
	        ((TextView)edtFileName).setText(getArguments().getString("fname"));
	        
	        View edtOwnerName = v.findViewById(R.id.textView_owner);
	        ((TextView)edtOwnerName).setText(getArguments().getString("ownerName"));
	        
	        View edtSize = v.findViewById(R.id.textView_filesize);
	        ((TextView)edtSize).setText(Integer.toString(getArguments().getInt("size"))+" kb");
	        
	        View edtType = v.findViewById(R.id.textView_filetype);
	        ((TextView)edtType).setText(getArguments().getString("fileType")); 
	        
	        View edtRate = v.findViewById( R.id.textView_rate);
	        ((TextView)edtRate).setText(Integer.toString(getArguments().getInt("rate"))); 
	        
	        View edtDate = v.findViewById(R.id.textView_modified);
	        ((TextView)edtDate).setText(getArguments().getString("date")); 
	        
	        
	        
	        
	        return v;
	    }

	
}
