package com.kh.hsfs.model;

/**
 * HsfsOrgServInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class HsfsOrgServInfo implements java.io.Serializable {

	// Fields

	private int id;
	private String orgCode;
	private String servType;
	private String checkCode;
	private String servDate;
	private String servInfo;
	private String buryear;
	private String addPerson;//上传人
	private String addDate;//上传时间

	// Constructors

	/** default constructor */
	public HsfsOrgServInfo() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	public String getServDate() {
		return servDate;
	}

	public void setServDate(String servDate) {
		this.servDate = servDate;
	}

	public String getServInfo() {
		return servInfo;
	}

	public void setServInfo(String servInfo) {
		this.servInfo = servInfo;
	}

	public String getBuryear() {
		return buryear;
	}

	public void setBuryear(String buryear) {
		this.buryear = buryear;
	}

	public String getServType() {
		return servType;
	}

	public void setServType(String servType) {
		this.servType = servType;
	}

	public String getAddPerson() {
		return addPerson;
	}

	public void setAddPerson(String addPerson) {
		this.addPerson = addPerson;
	}

	public String getAddDate() {
		return addDate;
	}

	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}

	// Property accessors

	
}