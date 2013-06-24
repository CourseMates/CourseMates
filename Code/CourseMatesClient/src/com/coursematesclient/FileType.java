package com.coursematesclient;

public class FileType {
	private int ID ;
	private String Description ;
	private String ImageUrl ;
	private String Extension ;
	public FileType() {
		ID =-1 ;
		Description ="" ;
		ImageUrl ="";
		Extension ="";
	}
	public FileType( int ID ,String Description ,String ImageUrl , String Extension) {
		this.ID =ID ;
		this.Description = Description ;
		this.ImageUrl = ImageUrl;
		this.Extension = Extension;
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public String getImageUrl() {
		return ImageUrl;
	}
	public void setImageUrl(String imageUrl) {
		ImageUrl = imageUrl;
	}
	public String getExtension() {
		return Extension;
	}
	public void setExtension(String extension) {
		Extension = extension;
	}

}
