package com.coursematesclient;


public class CourseEntity {

	private int id;
	private String name;
	private String admin;
	
	public CourseEntity()
	{
		this.setId(-1);
		this.setName("No name");
		this.setAdmin("Not defined");
	}

	public CourseEntity(int id,String name,String admin)
	{
		this.setId(id);
		this.setName(name);
		this.setAdmin(admin);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("id: "+Integer.toString(getId())+ ", Name: " + getName() +", Admin: " +getAdmin());
		return sb.toString();
	}


}
