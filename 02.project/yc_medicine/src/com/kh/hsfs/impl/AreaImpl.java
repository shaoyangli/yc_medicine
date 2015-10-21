package com.kh.hsfs.impl;
import java.util.List;

import com.kh.base.impl.BaseDaoImpl;


public class AreaImpl{
	private BaseDaoImpl bdi;

	
	public BaseDaoImpl getBdi() {
		return bdi;
	}

	public void setBdi(BaseDaoImpl bdi) {
		this.bdi = bdi;
	}

	public List getMyNewDiqu(String areas) { 
		String sql="select * from dic_gb_area dic where dic.area_Id like '"+areas.substring(0, 2)+"0000' or dic.area_Id like '"+areas.substring(0, 4)+"%'  order by dic.area_Id,dic.grade ";
		try {
			return bdi.getByJdbcSQL(sql);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public List getMyNewTowns(String area) {
		String sql="select * from dic_hr_area_local where COUNTY_ID like '"+area.substring(0, 4)+"%' order by county_id,local_id,local_grade ";
		return bdi.getByJdbcSQL(sql)  ;

	}
	
	public List gethospitals(String sql) {
		return bdi.getByJdbcSQL(sql)  ;
	}
   
	

}
