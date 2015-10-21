package com.kh.hsfs.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.hsfs.model.HsfsUserPower;
import com.kh.hsfs.model.HsfsUserRole;
import com.kh.hsfs.model.HsfsUserRolePower;
import com.kh.util.PageUtil;

public interface UserService {
	public List findList(String sql);//根据sql语句返回一个集合
	public int saveUser(HsfsUserInfo user);
	public int checkLoginID(String loginID);
	public int saveUserRole(HsfsUserRole userRole);
	public int saveUserPower(HsfsUserPower power);
	public int saveOrUpdateRolePower(HsfsUserRolePower rolePower);
	public String findId(String sql);//根据一条sql语句返回一个列
	public int checkLogin(String longInname, String loginPass, String year);
	public int checkLoginx(String pda_sn, String year);
	public int removeUser(int id);
	public int removeRole(int id);
	public Object findModel(Class obj, int id);
	public int updatePower(HsfsUserPower power);
	public int updateUser(HsfsUserInfo user);
	public int removePower(int pId);
	public PageUtil findBySqlPage(int currPage, int rows, String sql);
	public void checkUserPowers();
	public int updateUserState(String state, int id);
}
