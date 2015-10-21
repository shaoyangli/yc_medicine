package com.kh.util;

import java.util.ArrayList;
import java.util.List;

import com.kh.hsfs.model.HsfsOrgBaseInfo;
/*
 * 此类根据机构返回第一次根据区域信息查询的区域
 */
public class RetrunAreaId {
	public static String callAreaid(HsfsOrgBaseInfo org) {
		String checkAreaId = "";
		String orgAreaid = org.getOrgAreaId();//机构的区域信息
		String orgLevel = org.getOrgLevel();//机构的级别
		if(orgLevel != null)
		{
			//县级用户
			if(orgLevel.equals("3") ) {
				checkAreaId = orgAreaid.substring(0,6);//取得6位的省市县编号411521
			}
			//乡级用户
			if(orgLevel.equals("2")) {
				checkAreaId = orgAreaid.substring(0,8);//取得8位省市县乡编号41152101
			}
			//村级用户
			if(orgLevel.equals("1")) {
				checkAreaId = orgAreaid.substring(0,10);//取得8位省市县乡编号41152101
			}
		}
		return checkAreaId;
	}
	//根据机构返回按地区查询邮件接收人的时候 应该查询的区域id
	public static List<String> returnAreaid(HsfsOrgBaseInfo org) {
		ArrayList<String> areaids = new ArrayList<String>();
		String orgAreaid = org.getOrgAreaId();//机构的区域信息
		String orgLevel = org.getOrgLevel();//机构的级别
		String xian = orgAreaid.substring(0,6) + "000000";
		String xiang = orgAreaid.substring(0, 8) + "0000";
		String cun = orgAreaid.substring(0, 10) + "00";
		if(orgLevel.equals("3")) {
			areaids.add(xian);
		}
		if(orgLevel.equals("2")) {
			areaids.add(xian);
			areaids.add(xiang);
		}
		if(orgLevel.equals("1")) {
			areaids.add(xian);
			areaids.add(xiang);
			areaids.add(cun);
		}
		return areaids;
		
	}
	public static void main(String[] args) {
		HsfsOrgBaseInfo org = new HsfsOrgBaseInfo();
		org.setOrgAreaId("4115210203");
		org.setOrgLevel("1");
		List<String> areaids = RetrunAreaId.returnAreaid(org);
		String temp = "";
		for(String area : areaids) {
			temp += " or receiveid like '%," + area + ",%' ";
		}
		//System.out.println(temp);
	}
	
	
}
