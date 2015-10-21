package com.kh.hsfs.impl;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.kh.base.dao.BaseDao;
import com.kh.hsfs.dao.OrgServerDao;
import com.kh.hsfs.model.HsfsEmailFile;
import com.kh.hsfs.model.HsfsOrgServFile;
import com.kh.hsfs.model.HsfsOrgServInfo;
import com.kh.util.PageUtil;

public class OrgServerDaoImpl implements OrgServerDao {

	private BaseDao bdi;

	public BaseDao getBdi() {
		return bdi;
	}

	public void setBdi(BaseDao bdi) {
		this.bdi = bdi;
	}

	public List getBysql(String sql) {
		return bdi.getByJdbcSQL(sql);
	}

	public List getBysql2(String sql) {
		return bdi.getByJdbcSQL2(sql);
	}

	public int saveOrgServ(HsfsOrgServInfo orgServ, String count) {
		try {
			bdi.save(orgServ);
			if (!count.equals("")) {
				int fid = orgServ.getId();
				String sql = "update hsfs_org_serv_file t set t.serv_id = "
						+ fid + " where t.id in ( " + count + ")";
				bdi.executeBySQL(sql);

			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}
	}

	public int SaveOrgServFile(HsfsOrgServFile orgServFile) {
		String fileName = orgServFile.getFileName();
		String fileType = orgServFile.getFileType();
		String filePath = orgServFile.getFilePath();
		int id = bdi.uploadFiles(fileName, fileType, filePath);
		return id;
	}

	public PageUtil findOrgServ(int currPage, int rows, String sql) {
		// 默认显示第一页
		if (currPage == 0) {
			currPage = 1;
		}
		return bdi.findBySqlPage(currPage, rows, sql);
	}

	public void removeOrgService(int id) {
		HsfsOrgServInfo orgServ = null;
		try {
			// 删除硬盘上的文件,与文件表中的对象
			String hql1 = "from HsfsOrgServFile t where t.servId =" + id;
			HttpServletRequest request = ServletActionContext.getRequest();
			String path = request.getSession().getServletContext().getRealPath(
					"/");
			List<HsfsOrgServFile> orgServFiles = (List<HsfsOrgServFile>) bdi
					.queryList(hql1);
			for (HsfsOrgServFile orgServFile : orgServFiles) {
				String url = orgServFile.getFilePath();
				File file = new File(path + url);
				bdi.remove(orgServFile);
				if (file.exists()) {
					file.delete();
				}
			}
			// 删除基本表
			orgServ = (HsfsOrgServInfo) bdi.getInt(HsfsOrgServInfo.class, id);
			bdi.remove(orgServ);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public int removeFujian(int id) {
		try {
			HsfsOrgServFile file = (HsfsOrgServFile) bdi.getInt(
					HsfsOrgServFile.class, id);
			HttpServletRequest request = ServletActionContext.getRequest();
			String path = request.getSession().getServletContext().getRealPath(
					"/");

			File f = new File(path + file.getFilePath());
			if (f.exists()) {
				f.delete();
			}
			bdi.remove(file);
			return 0;

		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}
	}

	public List<HsfsOrgServFile> findOrgServFiles(int id) {
		String hql = "from HsfsOrgServFile t where t.servId = " + id;
		try {
			return bdi.queryList(hql);
		} catch (Exception e) {
			return null;
		}
	}

	public HsfsOrgServFile findNextOrgServFile(int id) {
		HsfsOrgServFile orgServfile = null;
		try {
			orgServfile = (HsfsOrgServFile) bdi.getInt(HsfsOrgServFile.class,
					id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orgServfile;
	}

}
