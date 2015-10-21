package com.kh.hsfs.model;

/**
 * 角色权限关系
 */

public class HsfsUserRolePower implements java.io.Serializable {

	private int id;
	private int roleId;
	private String powerId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public String getPowerId() {
		return powerId;
	}
	public void setPowerId(String powerId) {
		this.powerId = powerId;
	}
	
}