package com.kh.hsfs.dao;

import java.util.List;

import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.util.PageUtil;

public interface OrgDao {
	
	public int saveOrg(HsfsOrgBaseInfo orgBase);
	public List getByJdbcSQL(String sql);
	public PageUtil findBySqlPage(int currPage, int rows, String sql);
	public void removeById(String id);
	public HsfsOrgBaseInfo findOrgById(String id);
	public void updateOrg(HsfsOrgBaseInfo t);
	public int checkOrgCode(String orgCode);
	
}
