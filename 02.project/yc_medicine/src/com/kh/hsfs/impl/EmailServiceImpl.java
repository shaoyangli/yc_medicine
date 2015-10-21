package com.kh.hsfs.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.kh.base.dao.BaseDao;
import com.kh.hsfs.dao.EmailService;
import com.kh.hsfs.model.HsfsEmail;
import com.kh.hsfs.model.HsfsEmailFile;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.util.PageUtil;

public class EmailServiceImpl implements EmailService {
	private BaseDao bdi;

	public List<String[]> FindNodes(String proname, int type, String address) {
		return bdi.findResult(proname, type, address);
	}

	// 发送邮件的时候如果存在附件的话要在文件表中关联邮件的id
	public int sendEmail(HsfsEmail email, String fileIds) {
		try {
			bdi.save(email);
			if (!fileIds.equals("")) {
				int id = email.getId();
				String sql = "update hsfs_email_file t set t.email_id = " + id
						+ " where t.id in (" + fileIds + ")";
				bdi.executeBySQL(sql);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}
	}

	public int saveFile(HsfsEmailFile f) {
		String fileName = f.getFileName();
		String fileType = f.getFileType();
		String filePath = f.getFilePath();
		int id = bdi.uploadFiles1(fileName, fileType, filePath);
		System.out.println(id+"@@@@@@@");
		return id;
	}

	// 删除邮件附件
	public int removeFujian(int id) {
		try {
			HsfsEmailFile file = (HsfsEmailFile) bdi.getInt(
					HsfsEmailFile.class, id);
			HttpServletRequest request = ServletActionContext.getRequest();
			String path = request.getSession().getServletContext().getRealPath(
					"/");

			File f = new File(path + file.getFilePath());
			if (f.exists()) {
				if (f.delete()) {// 第一步删除硬盘上文件
					bdi.remove(file);
				}
			}
			return 0;

			// 删除表中记录
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}

	}

	// 从发件箱删除邮件
	public int removeFromSendBOx(int id) {
		try {
			HsfsEmail email = (HsfsEmail) bdi.getInt(HsfsEmail.class, id);
			email.setFlag(1);
			bdi.update(email);
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

	public HsfsEmail findOneEmail(int id) {
		HsfsEmail email = null;

		try {
			email = (HsfsEmail) bdi.getInt(HsfsEmail.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return email;
	}

	public HsfsEmailFile findOneFile(int id) {
		HsfsEmailFile f = null;
		try {
			f = (HsfsEmailFile) bdi.getInt(HsfsEmailFile.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// 根据邮件ID返回附件列表
	public List<HsfsEmailFile> findFiles(int id) {
		List<HsfsEmailFile> list = null;
		String hql = "from HsfsEmailFile f where f.emailId = " + id;
		try {
			list = bdi.queryList(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	};

	public int markEmail(int id) {
		try {
			HsfsUserInfo user = (HsfsUserInfo) ServletActionContext
					.getRequest().getSession().getAttribute("user");
			String userLoginID = user.getUserLoginId();
			String sql = "select count(1) from hsfs_email where readedid like '%,"
					+ userLoginID + ",%' and id =" + id;
			int count = bdi.getCounts(sql);
			if (count == 0) {
				HsfsEmail email = (HsfsEmail) bdi.getInt(HsfsEmail.class, id);
				String readedid = email.getReadedid();
				email.setReadedid(readedid + userLoginID + ",");
				bdi.update(email);
				return 0;
			} else
				return 1;

		} catch (Exception e) {
			e.printStackTrace();
			return 3;
		}
	}

	public int removeEmail(int id, String logid) {
		try {
			HsfsEmail email = (HsfsEmail) bdi.getInt(HsfsEmail.class, id);
			StringBuffer deledId = new StringBuffer(email.getDeledId());
			deledId.append(logid);
			deledId.append(",");
			email.setDeledId(deledId.toString());
			bdi.update(email);
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}
	}

	public int checkNewEmail() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		HsfsUserInfo user = (HsfsUserInfo) session.getAttribute("user");
		HsfsOrgBaseInfo org = (HsfsOrgBaseInfo) session.getAttribute("org");
		String loginid = user.getUserLoginId();// 登录工号
		String orgCode = user.getOrgCode();// 当前登录用户所属机构
		String areaid = org.getOrgAreaId();
		String xian = areaid.substring(0, 6) + "000000";
		String sql = "select count(1) from hsfs_email where ((receiveid like '%,"
				+ loginid
				+ ",%') or (receiveid like '%,"
				+ orgCode
				+ ",%') or (receiveid like '%,"
				+ areaid
				+ ",%') or (receiveid like '%,"
				+ xian
				+ ",%')) and deledid not like '%,"
				+ loginid
				+ ",%' and readedid not like '%," + loginid + ",%'";
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
