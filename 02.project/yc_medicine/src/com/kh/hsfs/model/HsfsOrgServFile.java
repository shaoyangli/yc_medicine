package com.kh.hsfs.model;

/**
 * HsfsOrgServFile entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class HsfsOrgServFile implements java.io.Serializable {

	// Fields

	private int id;
	private int servId;
	private String fileName;
	private String fileType;
	private String filePath;

	// Constructors

	/** default constructor */
	public HsfsOrgServFile() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getServId() {
		return servId;
	}

	public void setServId(int servId) {
		this.servId = servId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	

	// Property accessors


}