package com.kh.hsfs.model;

/**
 * HsfsOrgExtend entity. @author MyEclipse Persistence Tools
 */
public class HsfsOrgExtend  implements java.io.Serializable {

	// Constructors
	private int id;
	private String orgCode;
	private String burYear;
	private String accountNumber;
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
	public String getBurYear() {
		return burYear;
	}
	public void setBurYear(String burYear) {
		this.burYear = burYear;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
}
