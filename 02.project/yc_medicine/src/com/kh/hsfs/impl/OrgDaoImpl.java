package com.kh.hsfs.impl;

import java.util.List;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.OrgDao;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.util.DicUtil;
import com.kh.util.PageUtil;

public class OrgDaoImpl implements OrgDao {

	private BaseDaoImpl bdi;
		
	
	public int checkOrgCode(String orgCode) {
		System.out.println(orgCode .equals(""));
		if(!"".equals(orgCode)) {
			String sql = "select count(1) from hsfs_org_base_info where org_code = "+ orgCode;
			int count = bdi.getCounts(sql);
			if(count > 0) {
				return 1;
			}
			else {
				return 0;
			}
		}
		return 3;
		
	}
	
	public int saveOrg(HsfsOrgBaseInfo orgBase) {
		int id;	
		try
			{
				bdi.saveorUpdate(orgBase);
				id =1;
			}
			catch (Exception e)
			{
				id = 0;
				e.printStackTrace();
			}
			return id;
	}
	
	public List getByJdbcSQL(String sql)
	{
		return bdi.getByJdbcSQL(sql);
	}
	
	public PageUtil findBySqlPage(int currPage, int rows, String sql)
	{
		//默认显示第一页
		if(currPage == 0)
		{
			currPage = 1;
		}
		return bdi.findBySqlPage(currPage, rows, sql);
	}
	
	public BaseDaoImpl getBdi() {
		return bdi;
	}

	public void setBdi(BaseDaoImpl bdi) {
		this.bdi = bdi;
	}

	public void removeById(String id) {
		try {
			HsfsOrgBaseInfo hsbi = (HsfsOrgBaseInfo)bdi.getObject(HsfsOrgBaseInfo.class, id);
			bdi.remove(hsbi);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public HsfsOrgBaseInfo findOrgById(String id) 
	{
		HsfsOrgBaseInfo hobi = null;
		
		try {
				hobi =(HsfsOrgBaseInfo) bdi.getObject(HsfsOrgBaseInfo.class, id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return hobi;
	}

	public void updateOrg(HsfsOrgBaseInfo t) {
		try {
			bdi.update(t);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	

}
