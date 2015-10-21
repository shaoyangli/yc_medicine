package com.kh.hsfs.dao;

import java.util.List;

import com.kh.hsfs.model.HsfsOrgExtend;
import com.kh.hsfs.model.HsfsOrgExtendInfo;
import com.kh.util.PageUtil;

public interface OrgExtendDao 
{
	public int saveOrgExtend(HsfsOrgExtend orgExtend);
	public int saveOrgExtendInfo(HsfsOrgExtendInfo info);
	public PageUtil findOrgExtend(int currPage, int rows, String sql);
	public void removeOrgExtend(int id);
	public HsfsOrgExtendInfo findOrgExtend(int id);
	public HsfsOrgExtend findOrgAccount(int id);
	public void updateOrgExtend(HsfsOrgExtendInfo t);
	public int updateOrgAccount(HsfsOrgExtend t, String oldNum);
	public String findAreaName(String areaid);
	public List findOrgAccount(String sql);
	public List findOrgExtendinfo(String year, String orgCode);
}
