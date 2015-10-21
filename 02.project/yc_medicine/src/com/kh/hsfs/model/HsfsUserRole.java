package com.kh.hsfs.model;

import java.math.BigDecimal;

/**
 * 用户角色表
 */

public class HsfsUserRole implements java.io.Serializable {


	private int roleCode;
	private String roleName;
	public int getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(int roleCode) {
		this.roleCode = roleCode;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
}