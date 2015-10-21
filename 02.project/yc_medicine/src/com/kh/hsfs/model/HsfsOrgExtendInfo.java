package com.kh.hsfs.model;

/**
 * HsfsOrgExtendInfo entity.
 * 
 * @author MyEclipse Persistence Tools 辖区人员信息登记
 */

public class HsfsOrgExtendInfo implements java.io.Serializable {

	// Fields

	private int id;
	private String orgCode;
	private String burYear;
	private int pouNum;
	private int manNum;
	private int womanNum;
	private int childNum;
	private int oldNum;
	private int swNum;// 35岁以上人口数
	private int ycfNum;
	private int gxyNum;
	private int tnbNum;
	private int jsbNum;
	private int state;// 是否审核
	private String orgAreaId;
	private String addDate;
	private float PERCAPITAL;// 人均补偿金额
	private float EXPECT_MONEY;// 预计补偿金额
	private String addPerson;

	// Constructors

	/** default constructor */
	public HsfsOrgExtendInfo() {
	}

	// Property accessors
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

	public int getPouNum() {
		return pouNum;
	}

	public void setPouNum(int pouNum) {
		this.pouNum = pouNum;
	}

	public int getManNum() {
		return manNum;
	}

	public void setManNum(int manNum) {
		this.manNum = manNum;
	}

	public int getWomanNum() {
		return womanNum;
	}

	public void setWomanNum(int womanNum) {
		this.womanNum = womanNum;
	}

	public int getChildNum() {
		return childNum;
	}

	public void setChildNum(int childNum) {
		this.childNum = childNum;
	}

	public int getOldNum() {
		return oldNum;
	}

	public void setOldNum(int oldNum) {
		this.oldNum = oldNum;
	}

	public int getSwNum() {
		return swNum;
	}

	public void setSwNum(int swNum) {
		this.swNum = swNum;
	}

	public int getYcfNum() {
		return ycfNum;
	}

	public void setYcfNum(int ycfNum) {
		this.ycfNum = ycfNum;
	}

	public int getGxyNum() {
		return gxyNum;
	}

	public void setGxyNum(int gxyNum) {
		this.gxyNum = gxyNum;
	}

	public int getTnbNum() {
		return tnbNum;
	}

	public void setTnbNum(int tnbNum) {
		this.tnbNum = tnbNum;
	}

	public int getJsbNum() {
		return jsbNum;
	}

	public void setJsbNum(int jsbNum) {
		this.jsbNum = jsbNum;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getAddDate() {
		return addDate;
	}

	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}

	public String getOrgAreaId() {
		return orgAreaId;
	}

	public void setOrgAreaId(String orgAreaId) {
		this.orgAreaId = orgAreaId;
	}

	public float getPERCAPITAL() {
		return PERCAPITAL;
	}

	public void setPERCAPITAL(float pERCAPITAL) {
		PERCAPITAL = pERCAPITAL;
	}

	public float getEXPECT_MONEY() {
		return EXPECT_MONEY;
	}

	public void setEXPECT_MONEY(float eXPECTMONEY) {
		EXPECT_MONEY = eXPECTMONEY;
	}

	public String getAddPerson() {
		return addPerson;
	}

	public void setAddPerson(String addPerson) {
		this.addPerson = addPerson;
	}
	

}