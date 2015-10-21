package com.kh.hsfs.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import com.kh.base.dao.BaseDao;
import com.kh.hsfs.dao.CheckService;
import com.kh.hsfs.model.HsfsCheckSetting;
import com.kh.util.PageUtil;

public class CheckServiceImpl implements CheckService {
	private BaseDao<HsfsCheckSetting> checkDao;

	public int selIsexists(HsfsCheckSetting sercheck) {
		int id = 0;
		try {
			 String sql="select count(1) from hsfs_check_setting where check_code="+sercheck.getCheckCode()+" and item_code='"+sercheck.getItemCode()+"' and buryear='"+sercheck.getBuryear()+"'";
//			 System.out.println(sql);
			 id=checkDao.getCounts(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	public int add(HsfsCheckSetting sercheck) {
		int id = 0;
		try {
			 checkDao.saveorUpdate(sercheck);
			 id =1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

	@Resource(name = "checkDao")
	public void setcheckDao(
			BaseDao<HsfsCheckSetting> checkDao) {
		this.checkDao = checkDao;
	}

	public void delete(int id,String year ,String typeCode) throws Exception {
		String hql="from HsfsCheckSetting where checkCode=? and buryear=? and itemCode=?";
		HsfsCheckSetting sercheck =  (HsfsCheckSetting) checkDao.getObject2(hql, id, year,typeCode);
		try {
			checkDao.remove(sercheck);
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	public void deleteStr(String id) throws Exception {
		HsfsCheckSetting sercheck = (HsfsCheckSetting) checkDao
				.getObject(HsfsCheckSetting.class, id);
		try {
			checkDao.remove(sercheck);
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	public List<HsfsCheckSetting> findAll() {
		List<HsfsCheckSetting> list = new ArrayList<HsfsCheckSetting>();
		list = checkDao.findAll(HsfsCheckSetting.class);
		return list;

	}

	public int modify(HsfsCheckSetting sercheck) {
		try {
			checkDao.update(sercheck);
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}

	}

	public List getByJdbcSQL(String sql) {
		List list = checkDao.getByJdbcSQL(sql);

		return list;
	}

	

	public PageUtil getlist(int currpage, int count,String sql) {
		PageUtil pu = checkDao.findBySqlPage(currpage, count, sql);

		return pu;
	}

	public HsfsCheckSetting findById(String id) {
		HsfsCheckSetting sercheck = null;
		try {
			sercheck = (HsfsCheckSetting) checkDao.getObject(
					HsfsCheckSetting.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sercheck;
	}
	public HsfsCheckSetting findById(int code,String year,String typeCode) {
		HsfsCheckSetting sercheck = null;
		String hql="from HsfsCheckSetting where checkCode=? and buryear=? and itemCode=?";
		try {
			sercheck =  (HsfsCheckSetting) checkDao.getObject2(hql, code, year,typeCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sercheck;
	}


}
