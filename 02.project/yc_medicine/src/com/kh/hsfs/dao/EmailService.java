package com.kh.hsfs.dao;

import java.util.List;

import com.kh.hsfs.model.HsfsEmail;
import com.kh.hsfs.model.HsfsEmailFile;
import com.kh.util.PageUtil;

public interface EmailService {
	public List<String[]> FindNodes(String proname, int type, String address);
	public int sendEmail(HsfsEmail email, String fileIDs);
	public int saveFile(HsfsEmailFile f);
	public PageUtil findBySqlPage(int currPage, int rows, String sql) ;
	public HsfsEmail findOneEmail(int id);
	public HsfsEmailFile findOneFile(int id);
	public List<HsfsEmailFile> findFiles(int id);
	public int markEmail(int id);
	public int removeEmail(int id, String logid);
	public int checkNewEmail();
	public int removeFujian(int id);
	public int removeFromSendBOx(int id);
}
