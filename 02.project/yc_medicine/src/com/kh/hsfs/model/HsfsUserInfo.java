package com.kh.hsfs.model;

/**
 * 用户实体
 */

public class HsfsUserInfo implements java.io.Serializable {

	private int userCode;// 编号
	private String userName;// 用户名
	private String orgCode;// 所属机构编码
	private String userPwd;// 登录密码
	private String userLoginId;//登录工号
	private int powerRole;// 所属角色
	private String isStop;// 是否停用
	private String handId;//用户对应的手持机id
	private String docId;

	public int getUserCode() {
		return userCode;
	}

	public void setUserCode(int userCode) {
		this.userCode = userCode;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public int getPowerRole() {
		return powerRole;
	}

	public void setPowerRole(int powerRole) {
		this.powerRole = powerRole;
	}

	public String getIsStop() {
		return isStop;
	}

	public void setIsStop(String isStop) {
		this.isStop = isStop;
	}

	public String getUserLoginId() {
		return userLoginId;
	}

	public void setUserLoginId(String userLoginId) {
		this.userLoginId = userLoginId;
	}

	public String getHandId() {
		return handId;
	}

	public void setHandId(String handId) {
		this.handId = handId;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}
	
}