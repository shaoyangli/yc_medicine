package com.kh.hsfs.dao;

import java.util.List;

import com.kh.hsfs.model.HsfsCheckSetting;
import com.kh.util.PageUtil;




public interface CheckService {
	public int selIsexists(HsfsCheckSetting sercheck);
	public int add(HsfsCheckSetting sercheck);
    public void delete(int id, String str1, String str2) throws Exception;
    public void deleteStr(String id) throws Exception;
    public int modify(HsfsCheckSetting sercheck);
   // public PageUtil<HsfsPopuBaseInfo> findByPage(int currPage, int rows);
    public List<HsfsCheckSetting> findAll();
	public List getByJdbcSQL(String sql);
	public HsfsCheckSetting  findById(String id);
	public HsfsCheckSetting  findById(int code, String year, String typeCode);
	public PageUtil getlist(int curpage, int count, String hql);
}
