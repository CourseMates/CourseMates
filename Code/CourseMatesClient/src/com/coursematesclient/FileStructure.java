package com.coursematesclient;



public class FileStructure {

	
	private FileItem RootFolder ;
	
	public FileStructure() {
		setRootFolder(new FileItem());
	}

	public FileStructure(FileItem RootFolder) {
		 this.setRootFolder(RootFolder);
	}

	public FileItem getRootFolder() {
		return RootFolder;
	}

	public void setRootFolder(FileItem rootFolder) {
		RootFolder = rootFolder;
	}

}
