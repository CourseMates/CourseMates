/*
 * This class retrieves contains userID and sessionID
 * Gson uses it for easy convention from json response 
 */
package com.coursematesclient;


public class LoginEntity {
	
	 private int id;
	 private String LoginRESTResult;
	 
	 public LoginEntity() {
		 this.setId(-1);
		 this.setLoginResult("");
	 }
	 
	 public LoginEntity(int id ,String LoginResult) {
		 this.setId(id);
		 this.setLoginResult(LoginResult);
	 }
	 
	public Boolean getAuthorized() {
		if(!LoginRESTResult.equals(""))
			return true;
		else 
			return false;
	}
	
	public String getLoginResult() {
		return LoginRESTResult;
	}

	public void setLoginResult(String loginResult) {
		LoginRESTResult = loginResult;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return this.getAuthorized().toString();
	}
}
