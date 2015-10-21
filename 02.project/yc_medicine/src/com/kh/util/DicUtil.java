package com.kh.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DicUtil {

	//查询名族
	public static	String mingzu="select CID,CVALUE from dic_code_gb_list where CODE='GB101_03'";
	//查询职业类别
	public static	String zhiye="select CID,CVALUE from dic_code_gb_list where CODE='GB101_07'";
	//查询文化程度
	public static	String wenfa="select CID,CVALUE from dic_code_gb_list where CODE='GB4658_1984'";
   //查询 医疗机构级别
	public static	String sql3 = "select CID,CVALUE from dic_code_nh_list where code='NH201_06' order by cid";
	//医疗机构类型初始化
	public static 	String sql4 = "select code,text from dic_organ_type where sorts = '1'";
	//查询你医疗机构的类型
	public static   String sql11 = "select * from dic_organ_type";
	//查询婚姻类型
	public static String hunyin="select cid,cvalue  from dic_code_gb_list where code = 'GB101_02'";
	//查询性别类型
	public static String xingbie="select cid,cvalue from dic_code_gb_list where code = 'GB101_01'";
    //疫苗
	public static String immunity ="select cid,cvalue from dic_code_hr_list where code='CV5303_01' and isuse=1";
	//医疗机构补偿标准字典
	public static String sql_bz = "select t.cid,t.cvalue,t.notes from dic_code_hr_list t where t.code = 'ORGL' order by t.notes";
	
	public static String  maxDate(){
		Date dt = new Date();
		String d = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		d = sdf.format(dt);
		return d;
		
	}
	public static String  formatDate(){
		Date dt = new Date();
		String d = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		d = sdf.format(dt);
		return d;
		
	}
}
