package com.kh.hsfs.model;

/**
 * HsfsOrgBaseInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class HsfsOrgBaseInfo implements java.io.Serializable {

	// Fields

	private String orgCode;
	private String orgName;
	private String orgFatCode;
	private String orgLevel;
	private String orgTypex;
	private String orgLeader;
	private String orgAddress;
	private String orgNccmcode;
	private String orgPhone;
	private String orgAreaId;
	private String appropriationOrg;//拨款机构
	private int superFlag;//标识是否财政用户
	private String orgId;
	private String bzbzjb;//机构补助标准级别

	// Constructors

	/** default constructor */
	public HsfsOrgBaseInfo() {
	}

	/** minimal constructor */
	public HsfsOrgBaseInfo(String orgName, String orgFatCode, String orgLevel,
			String orgTypex) {
		this.orgName = orgName;
		this.orgFatCode = orgFatCode;
		this.orgLevel = orgLevel;
		this.orgTypex = orgTypex;
	}

	/** full constructor */
	public HsfsOrgBaseInfo(String orgName, String orgFatCode, String orgLevel,
			String orgTypex, String orgLeader, String orgAddress,
			String orgNccmcode, String orgPhone) {
		this.orgName = orgName;
		this.orgFatCode = orgFatCode;
		this.orgLevel = orgLevel;
		this.orgTypex = orgTypex;
		this.orgLeader = orgLeader;
		this.orgAddress = orgAddress;
		this.orgNccmcode = orgNccmcode;
		this.orgPhone = orgPhone;
	}

	// Property accessors

	public String getOrgCode() {
		return this.orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgAreaId() {
		return orgAreaId;
	}

	public void setOrgAreaId(String orgAreaId) {
		this.orgAreaId = orgAreaId;
	}

	public String getOrgName() {
		return this.orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getOrgFatCode() {
		return this.orgFatCode;
	}

	public void setOrgFatCode(String orgFatCode) {
		this.orgFatCode = orgFatCode;
	}

	public String getOrgLevel() {
		return this.orgLevel;
	}

	public void setOrgLevel(String orgLevel) {
		this.orgLevel = orgLevel;
	}

	public String getOrgTypex() {
		return this.orgTypex;
	}

	public void setOrgTypex(String orgTypex) {
		this.orgTypex = orgTypex;
	}

	public String getOrgLeader() {
		return this.orgLeader;
	}

	public void setOrgLeader(String orgLeader) {
		this.orgLeader = orgLeader;
	}

	public String getOrgAddress() {
		return this.orgAddress;
	}

	public void setOrgAddress(String orgAddress) {
		this.orgAddress = orgAddress;
	}

	public String getOrgNccmcode() {
		return this.orgNccmcode;
	}

	public void setOrgNccmcode(String orgNccmcode) {
		this.orgNccmcode = orgNccmcode;
	}

	public String getOrgPhone() {
		return this.orgPhone;
	}

	public void setOrgPhone(String orgPhone) {
		this.orgPhone = orgPhone;
	}

	public String getAppropriationOrg() {
		return appropriationOrg;
	}

	public void setAppropriationOrg(String appropriationOrg) {
		this.appropriationOrg = appropriationOrg;
	}

	public int getSuperFlag() {
		return superFlag;
	}

	public void setSuperFlag(int superFlag) {
		this.superFlag = superFlag;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getBzbzjb() {
		return bzbzjb;
	}

	public void setBzbzjb(String bzbzjb) {
		this.bzbzjb = bzbzjb;
	}
	
	
}