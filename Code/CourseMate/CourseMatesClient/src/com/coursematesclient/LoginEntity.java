package com.coursematesclient;


public class LoginEntity {
	
	 private Boolean authorized;
	 public LoginEntity() {
		 authorized = false;
	 }
	 
	 public LoginEntity(String username ,String password) {
		 if(username.equalsIgnoreCase("Dima") && password.equalsIgnoreCase("12345") ) {
			 setAuthorized(true);
				}
		 else
			 setAuthorized(false);
	 }
	 
	public Boolean getAuthorized() {
		return authorized;
	}
	
	public void setAuthorized(Boolean authorized) {
		this.authorized = authorized;
	}
	@Override
	public String toString() {
		return this.getAuthorized().toString();
	}
}
