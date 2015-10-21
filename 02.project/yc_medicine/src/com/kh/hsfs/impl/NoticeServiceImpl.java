package com.kh.hsfs.impl;

import org.apache.struts2.ServletActionContext;

import com.kh.base.dao.BaseDao;
import com.kh.hsfs.dao.NoticeService;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.hsfs.model.Notice;
import com.kh.util.PageUtil;

public class NoticeServiceImpl implements NoticeService {
	private BaseDao bdi;

	public int saveNotice(Notice notice) {
		try {
			bdi.save(notice);
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}
	}

	public PageUtil findBySqlPage(int currPage, int rows, String sql) {
		if (currPage == 0) {
			currPage = 1;
		}
		return bdi.findBySqlPage(currPage, rows, sql);
	}

	public Notice findNotice(int id) {
		Notice notice = null;
		try {
			notice = (Notice) bdi.getInt(Notice.class, id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return notice;
	}

	public int deleteNotice(int id) {
		String sql = "delete from hsfs_notice where id = " + id;
		return bdi.executeBySQL(sql);

	}

	public int updateNotice(Notice notice) {
		try {
			bdi.update(notice);
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}
	}

	public int markNotice(int id) {
		try {
			HsfsUserInfo user = (HsfsUserInfo) ServletActionContext
					.getRequest().getSession().getAttribute("user");
			String userLoginID = user.getUserLoginId();
			String sql = "select count(1) from hsfs_notice where login_id like '%,"
					+ userLoginID + ",%' and id =" + id;
			int count = bdi.getCounts(sql);
			if (count == 0) {
				Notice notice = (Notice) bdi.getInt(Notice.class, id);
				String loginID = notice.getLoginID();
				notice.setLoginID(loginID + userLoginID + ",");
				bdi.update(notice);
				return 0;
			} else
				return 1;

		} catch (Exception e) {
			e.printStackTrace();
			return 3;
		}

	}

	public int checkNewNotice(String loginid) {
		String sql = "select count(1) from hsfs_notice where login_id not like '%,"
				+ loginid + ",%'";
		int count = bdi.getCounts(sql);
		return count;
	}

	public BaseDao getBdi() {
		return bdi;
	}

	public void setBdi(BaseDao bdi) {
		this.bdi = bdi;
	}

}
