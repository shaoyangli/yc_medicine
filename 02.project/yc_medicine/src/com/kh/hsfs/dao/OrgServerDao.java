package com.kh.hsfs.dao;

import java.util.List;

import com.kh.hsfs.model.HsfsOrgServFile;
import com.kh.hsfs.model.HsfsOrgServInfo;
import com.kh.util.PageUtil;

public interface OrgServerDao {
	public List getBysql(String sql);
	public List getBysql2(String sql);
	public int saveOrgServ(HsfsOrgServInfo orgServ, String count);//保存记录基本信息
	public int SaveOrgServFile(HsfsOrgServFile orgServFile);//保存记录文件信息
	public PageUtil findOrgServ(int currPage, int rows, String sql);
	public void removeOrgService(int id);
	public List<HsfsOrgServFile> findOrgServFiles(int id); 
	public HsfsOrgServFile findNextOrgServFile(int id);
	public int removeFujian(int id);
}
