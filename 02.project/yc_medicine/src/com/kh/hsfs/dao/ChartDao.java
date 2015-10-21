package com.kh.hsfs.dao;

import java.util.List;

import com.kh.util.PageUtil;

public interface ChartDao {
	
	public List yszl(String proname, String insql);
	public List getJzym();
	public List selfwjl(String sql);
	public PageUtil getlist(int curpage, int count, String sql);
	
	public List account(String orgcode, String buryear);
	public List account_services(String orgareaid, String buryear);
	public List account_servicesuser(String orgareaid, String buryear);
	public List account_use(String sql);
	public List account_obj(String sql);
}
