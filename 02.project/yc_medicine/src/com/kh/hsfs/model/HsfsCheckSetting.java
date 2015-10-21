package com.kh.hsfs.model;

/**
 * HsfsServcheckSetting entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class HsfsCheckSetting implements java.io.Serializable {

	// Fields

	private Integer checkCode;//补助指标编码
	private String checkIndex;
	private String itemCode;
	private String itemTypex;
	private String checkInfo;
	private String checkLevel;
	private String checkWay;
	private String grantNumber;
	private String amount;
    private String buryear;
    private String sql;
    private String remark;
    private String flag;
    private String standard;
    private Integer  num;
    private String updateSql;
    private String selectSql;
    private Integer unum;
    private Integer snum;
    private  String wanSql;
    private Integer  wnum;
    private String mobileId;
    
    

	public String getMobileId() {
		return mobileId;
	}

	public void setMobileId(String mobileId) {
		this.mobileId = mobileId;
	}

	public String getWanSql() {
		return wanSql;
	}

	public void setWanSql(String wanSql) {
		this.wanSql = wanSql;
	}

	public Integer getWnum() {
		return wnum;
	}

	public void setWnum(Integer wnum) {
		this.wnum = wnum;
	}

	public Integer getUnum() {
		return unum;
	}

	public void setUnum(Integer unum) {
		this.unum = unum;
	}

	public Integer getSnum() {
		return snum;
	}

	public void setSnum(Integer snum) {
		this.snum = snum;
	}


	public String getUpdateSql() {
		return updateSql;
	}

	public void setUpdateSql(String updateSql) {
		this.updateSql = updateSql;
	}

	public String getSelectSql() {
		return selectSql;
	}

	public void setSelectSql(String selectSql) {
		this.selectSql = selectSql;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	// default constructor */
	public HsfsCheckSetting() {
	}

	public String getBuryear() {
		return buryear;
	}

	public void setBuryear(String buryear) {
		this.buryear = buryear;
	}

	public int getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(int checkCode) {
		this.checkCode = checkCode;
	}

	public String getCheckIndex() {
		return checkIndex;
	}

	public void setCheckIndex(String checkIndex) {
		this.checkIndex = checkIndex;
	}

	

	public String getCheckInfo() {
		return checkInfo;
	}

	public void setCheckInfo(String checkInfo) {
		this.checkInfo = checkInfo;
	}


 
	public String getCheckWay() {
		return checkWay;
	}

	public void setCheckWay(String checkWay) {
		this.checkWay = checkWay;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getItemTypex() {
		return itemTypex;
	}

	public void setItemTypex(String itemTypex) {
		this.itemTypex = itemTypex;
	}

	public String getCheckLevel() {
		return checkLevel;
	}

	public void setCheckLevel(String checkLevel) {
		this.checkLevel = checkLevel;
	}

	

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
   
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((buryear == null) ? 0 : buryear.hashCode());
		result = prime * result + checkCode;
		result = prime * result
				+ ((itemCode == null) ? 0 : itemCode.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		HsfsCheckSetting other = (HsfsCheckSetting) obj;
		if (buryear == null) {
			if (other.buryear != null)
				return false;
		} else if (!buryear.equals(other.buryear))
			return false;
		if (checkCode != other.checkCode)
			return false;
		if (itemCode == null) {
			if (other.itemCode != null)
				return false;
		} else if (!itemCode.equals(other.itemCode))
			return false;
		return true;
	}

	

	public String getGrantNumber() {
		return grantNumber;
	}

	public void setGrantNumber(String grantNumber) {
		this.grantNumber = grantNumber;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public void setCheckCode(Integer checkCode) {
		this.checkCode = checkCode;
	}

	

	

}