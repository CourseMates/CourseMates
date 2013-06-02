package com.coursematesclient;

import java.util.ArrayList;
import java.util.List;


public class CourseEntity {

	
	private int CourseAdminID;
	private String CourseName;
	private ArrayList<String> Files;
	private ArrayList<String> FourmItems;
	private int ID;
	private String IconClass;
	private boolean IsAdmin;
	private ArrayList<String> Participants;
	
	public CourseEntity() {
		this.setCourseAdminID(-1);
		this.setCourseName("test");
		this.Files = new ArrayList<String>();
		this.setFourmItems(null);
		this.setIconClass(null);
		this.setID(-1);
		this.setIsAdmin(false);
		this.setParticipants(null);
	}
	
	public CourseEntity(int CourseAdminID,String CourseName, ArrayList<String> Files, ArrayList<String> FourmItems ,int ID,String IconClass , 
			boolean IsAdmin , ArrayList<String> Participants	)
	{
		this.CourseAdminID =CourseAdminID ;
		this.CourseName = CourseName ;
		this.Files = new ArrayList<String>(Files);
		this.FourmItems = new ArrayList<String>(FourmItems);
		this.ID = ID;
		this.IconClass = IconClass;
		this.IsAdmin = IsAdmin;
		this.Participants =  new ArrayList<String>(Participants);
	}

	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("CourseID: "+Integer.toString(getID())+"CourseName: " + getCourseName() );
		return sb.toString();
	}


	public int getCourseAdminID() {
		return CourseAdminID;
	}


	public void setCourseAdminID(int courseAdminID) {
		CourseAdminID = courseAdminID;
	}


	public String getCourseName() {
		return CourseName;
	}


	public void setCourseName(String courseName) {
		CourseName = courseName;
	}


	public List<String> getFiles() {
		if(Files.isEmpty()) return null;
		return Files;
	}


	public void setFiles(ArrayList<String> files) {
		Files = files;
	}


	public ArrayList<String> getFourmItems() {
		return FourmItems;
	}


	public void setFourmItems(ArrayList<String> sfourmItems) {
		FourmItems = sfourmItems;
	}


	public int getID() {
		return ID;
	}


	public void setID(int iD) {
		ID = iD;
	}


	public String getIconClass() {
		return IconClass;
	}


	public void setIconClass(String iconClass) {
		IconClass = iconClass;
	}


	public boolean isIsAdmin() {
		return IsAdmin;
	}


	public void setIsAdmin(boolean isAdmin) {
		IsAdmin = isAdmin;
	}


	public ArrayList<String> getParticipants() {
		return Participants;
	}


	public void setParticipants(ArrayList<String> participants) {
		Participants = participants;
	}


}
