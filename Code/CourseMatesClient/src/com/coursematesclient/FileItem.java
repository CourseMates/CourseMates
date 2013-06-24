package com.coursematesclient;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class FileItem implements Serializable ,  ImageAndTextAdoptable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int ID;
	private String FileName ;
	private FileType Type ;
	private int Rate ;
	private int OwnerId ;
	private String OwnerName ;
	private boolean IsFolder ;
	private int PerantID ;
	private ArrayList<FileItem> SubItems ;
	private Date LastModify ;
	private int Size ;
	private int iconID;
	//private static int name=1;
	
	
	
	public FileItem() {
		 this.ID = -1;
		 this.FileName = "Empty";
		 this.Type = new FileType();
		 this.Rate = 0;
		 this.OwnerId =-1;
		 this.OwnerName ="";
		 this.IsFolder = false;
		 this.PerantID = -1;
		 this.SubItems = new ArrayList<FileItem>(); 
		 this.LastModify = new Date();
		 this.Size = 0;
	}
	public FileItem(int ID , String FileName , FileType Type , int Rate , int OwnerId , String OwnerName ,  boolean IsFolder ,  int PerantID ,
			ArrayList<FileItem> SubItems ,  Date LastModify , int Size ) {
		 this.ID = ID;
		 this.FileName = FileName;
		 this.Type = Type;
		 this.Rate = Rate;
		 this.OwnerId = OwnerId;
		 this.OwnerName = OwnerName;
		 this.IsFolder = IsFolder;
		 this.PerantID = PerantID;
		 this.SubItems = new ArrayList<FileItem>(SubItems);
		 this.LastModify =LastModify;
		 this.Size = Size;
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public FileType getType() {
		return Type;
	}
	public void setType(FileType type) {
		Type = type;
	}
	public int getRate() {
		return Rate;
	}
	public void setRate(int rate) {
		Rate = rate;
	}
	public int getOwnerId() {
		return OwnerId;
	}
	public void setOwnerId(int ownerId) {
		OwnerId = ownerId;
	}
	public String getOwnerName() {
		return OwnerName;
	}
	public void setOwnerName(String ownerName) {
		OwnerName = ownerName;
	}
	public boolean isIsFolder() {
		return IsFolder;
	}
	public void setIsFolder(boolean isFolder) {
		IsFolder = isFolder;
	}
	public int getPerantID() {
		return PerantID;
	}
	public void setPerantID(int perantID) {
		PerantID = perantID;
	}
	public ArrayList<FileItem> getSubItems() {
		return SubItems;
	}
	public void setSubItems(ArrayList<FileItem> subItems) {
		SubItems = subItems;
	}
	public Date getLastModify() {
		return LastModify;
	}
	public void setLastModify(Date lastModify) {
		LastModify = lastModify;
	}
	public int getSize() {
		return Size;
	}
	public void setSize(int size) {
		Size = size;
	}
	@Override
	public String GetText() {
		return this.getFileName();
	}
	@Override
	public int GetResourceID() {
		return this.getIconID();
	}
	public int getIconID() {
		return iconID;
	}
	public void setIconID(int iconID) {
		this.iconID = iconID;
	}

}
