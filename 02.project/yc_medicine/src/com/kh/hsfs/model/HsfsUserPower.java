package com.kh.hsfs.model;

/**
 * 权限表
 */

public class HsfsUserPower implements java.io.Serializable {

	private int powerId;
	private String powerName;// 连接名称
	private String powerUrl;// 权限地址
	private int fatherId;// 上级菜单id
	private String orderId;//菜单排序id

	public int getPowerId() {
		return powerId;
	}

	public void setPowerId(int powerId) {
		this.powerId = powerId;
	}

	public String getPowerName() {
		return powerName;
	}

	public void setPowerName(String powerName) {
		this.powerName = powerName;
	}

	public String getPowerUrl() {
		return powerUrl;
	}

	public void setPowerUrl(String powerUrl) {
		this.powerUrl = powerUrl;
	}

	public int getFatherId() {
		return fatherId;
	}

	public void setFatherId(int fatherId) {
		this.fatherId = fatherId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

}