package com.kh.hsfs.dao;

import com.kh.hsfs.model.Notice;
import com.kh.util.PageUtil;

public interface NoticeService {
	public int saveNotice(Notice notice);
	public PageUtil findBySqlPage(int currPage, int rows, String sql);
	public Notice findNotice(int id);
	public int deleteNotice(int id);
	public int updateNotice(Notice notice);
	public int markNotice(int id);
	public int checkNewNotice(String loginid);
}
