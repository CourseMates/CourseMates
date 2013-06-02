package com.coursematesclient;

import java.io.IOException;
import java.util.ArrayList;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;


//Override Async task to call web service it paralell thread

class RequestTask extends AsyncTask<String,Void,String> {
	
	Context app_context; 
//---------------------------------------------------------------------------------------------------//	
//override constructor 
//Need to pass App Context for getting access to shared preferences 
	public RequestTask (Context context){
		this.app_context = context;
	}
//---------------------------------------------------------------------------------------------------//
//runs in background 
    @Override
    protected String doInBackground(String... uri) {
    	
        HttpClient httpclient = new DefaultHttpClient();
//        ((AbstractHttpClient) httpclient).getCredentialsProvider().setCredentials( new AuthScope(null, -1),new UsernamePasswordCredentials("joeuser", "mypassword"));
        HttpContext  localContext = new BasicHttpContext();
        
        
        HttpResponse response;
        String responseString = "";
        UserData ud = new UserData();
        HttpGet do_get = new HttpGet(uri[0]+"/" +ud.getUserName(app_context) +"/" +ud.getUserPassword(app_context));
        //Log.i("SharedParams test :",ud.GetUserName(this.app_context));
        
        do_get.addHeader("accept", "application/json");

        try {
            response = httpclient.execute(do_get,localContext);
         // Get the response entity
            HttpEntity entity = response.getEntity();
            // If response entity is not null
           
            if (entity != null) {
                // get entity contents and convert it to string
            	responseString = EntityUtils.toString(response.getEntity());
               
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return responseString;
    }
//---------------------------------------------------------------------------------------------------//	
    @Override
    protected void onPostExecute(String result) {
        super.onPostExecute(result);
     //   Log.i("onPost",result );
        if(!result.equals(""))
        try {
        	JSONObject jsonResponse = new JSONObject(new String(result));
			JSONArray respJSON = jsonResponse.getJSONArray("courseEntity");
			ArrayList<String> courses = new ArrayList<String>();
			for (int i=0 ; i <respJSON.length() ; i++) {
				JSONObject json = respJSON.optJSONObject(i);
				Gson gson =  new Gson();
				CourseEntity ce = gson.fromJson(json.toString(),CourseEntity.class);
				courses.add(ce.toString());
				//Log.i(ce.getName(), ce.toString());
			}
			 Intent intent = new Intent(app_context, Home.class);
			 intent.putStringArrayListExtra("mylist",courses);
			 app_context.startActivity(intent);
		
		} catch (JSONException e) {
			e.printStackTrace();
		}
        
        
    }
 //---------------------------------------------------------------------------------------------------//	
}