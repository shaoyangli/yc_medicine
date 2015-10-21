package com.kh.hsfs.action;

import java.util.ArrayList;
import java.util.List;

import com.kh.hsfs.dao.OrgDao;
import com.kh.hsfs.dao.OrgExtendDao;
import com.kh.hsfs.model.HsfsOrgExtend;
import com.kh.hsfs.model.HsfsOrgExtendInfo;
import com.kh.util.PageUtil;
import com.opensymphony.xwork2.ActionSupport;

public class OrgExtendManageAction extends ActionSupport {
	private HsfsOrgExtendInfo orgExtend;
	private HsfsOrgExtend orgExt;
	private OrgExtendDao orgExtendDao;
	private OrgDao orgDao;
	private String result;// 添加机构扩展信息的返回值
	private String areaName;// 编辑扩展记录的辖区名

	private String oldAccountNUmber;
	private int isSuccess;

	private String year;// 机构扩展信息的年度
	private String orgCode;// 当前登录的机构编码
	private ArrayList list;
	private String param;// 接收查询条件传递过来的值
	private int currPage;// 当前页
	private int totalPages;// 总页数
	private int id;// 医疗机构扩展信息主键

	private List<Integer> deleteList;// 待删除的主键集合
	private PageUtil findOrgExtendResult;
	private String xianoldValue;
	private String xiangoldValue;
	private String cunoldValue;

	/*
	 * 医疗机构扩展信息保存 每个医疗机构一年只能有一条扩展信息
	 */
	public String saveOrgExtends() throws Exception {

		int flag = orgExtendDao.saveOrgExtend(orgExt);
		result = flag + "";
		return "saveOrgExtends";
	}

	public String saveOrgExtendInfo() throws Exception {
		if(id > 0) {
			orgExtend.setId(id);
		}
		isSuccess = orgExtendDao.saveOrgExtendInfo(orgExtend);
		return "saveOrgExtends";
	}

	/*
	 * 查询医疗机构账户信息
	 */
	public String findOrgAccounts() throws Exception {
		String sql = "select bur_year,account_number,id from hsfs_org_extend where org_code = "
				+ orgCode + "order by bur_year desc";
		list = (ArrayList) orgExtendDao.findOrgAccount(sql);
		return "findOrgAccounts";
	}

	/**
	 * 查询登记人口信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public String findOrgInfo() throws Exception {

		String sql = "select ((select t.local_name from dic_hr_area_local t where t.county_id || t.local_id = substr(b.areaid,1,8)|| '0000') || '  '|| a.local_name)localname,b.buryear, b.pop_num, b.man_num,b.woman_num,b.child_num,b.old_num,b.sw_num,b.ycf_num,b.gxy_num,b.tnb_num, b.jsb_num, b.expect_money, b.add_date,"
				+ " (select org_name from hsfs_org_base_info a where a.org_code = b.org_code) orgName,b.add_person,b.state "
				+ "from hsfs_org_extend_info b left join dic_hr_area_local a on a.county_id || a.local_id = b.areaid "
				+ " where b.areaid like'" + param + "%' ";
		sql += "and b.buryear = '" + year + "'";
		sql += " order by b.areaid";
		//System.out.println(sql);
		int row = 10;// 每页显示记录数
		if (currPage > totalPages) {
			currPage = totalPages;
		}
		findOrgExtendResult = orgExtendDao.findOrgExtend(currPage, row, sql);
		return "findOrgExtend";
	}

	/*
	 * 删除医疗机构扩展信息
	 */
	public String removeOrgExtend() throws Exception {
		for (int id : deleteList) {
			orgExtendDao.removeOrgExtend(id);
		}
		return "removeOrgExtend";
	}

	/*
	 * 查询一条扩展信息
	 */
	public String findOneOrgExtend() throws Exception {
		orgExtend = orgExtendDao.findOrgExtend(id);
		areaName = orgExtendDao.findAreaName(orgExtend.getOrgAreaId());

		// HsfsOrgBaseInfo hsfsOrgBaseInfo =
		// orgDao.findOrgById(orgExtend.getOrgCode());
		// System.out.println(hsfsOrgBaseInfo.getOrgName()+"------");
		return "findOneOrgExtend";
	}
	/**
	 *查询一条登记信息 
	 * @throws Exception
	 */
	public String findOrgExtendInfo() throws Exception {
		list = (ArrayList)orgExtendDao.findOrgExtendinfo(year, orgCode);
		return "findOrgExtend";
	}
	/*
	 * 查询一个医疗机构帐号
	 */
	public String FindAccount() throws Exception {
		orgExt = orgExtendDao.findOrgAccount(id);
		return "FindAccount";
	}

	/*
	 * 更新医疗机构扩展信息
	 */
	public String updateOrgExtend() throws Exception {

		orgExtendDao.updateOrgExtend(orgExtend);
		return "updateOrgExtend";
	}

	/*
	 * 更新医疗账户更新
	 */
	public String orgAccountUpdate() throws Exception {
		isSuccess = orgExtendDao.updateOrgAccount(orgExt, oldAccountNUmber);
		return "orgAccountUpdate";
	}

	public HsfsOrgExtendInfo getOrgExtend() {
		return orgExtend;
	}

	public void setOrgExtend(HsfsOrgExtendInfo orgExtend) {
		this.orgExtend = orgExtend;
	}

	public OrgExtendDao getOrgExtendDao() {
		return orgExtendDao;
	}

	public void setOrgExtendDao(OrgExtendDao orgExtendDao) {
		this.orgExtendDao = orgExtendDao;
	}

	public OrgDao getOrgDao() {
		return orgDao;
	}

	public void setOrgDao(OrgDao orgDao) {
		this.orgDao = orgDao;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public PageUtil getFindOrgExtendResult() {
		return findOrgExtendResult;
	}

	public void setFindOrgExtendResult(PageUtil findOrgExtendResult) {
		this.findOrgExtendResult = findOrgExtendResult;
	}

	public List<Integer> getDeleteList() {
		return deleteList;
	}

	public void setDeleteList(List<Integer> deleteList) {
		this.deleteList = deleteList;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getXianoldValue() {
		return xianoldValue;
	}

	public void setXianoldValue(String xianoldValue) {
		this.xianoldValue = xianoldValue;
	}

	public String getXiangoldValue() {
		return xiangoldValue;
	}

	public void setXiangoldValue(String xiangoldValue) {
		this.xiangoldValue = xiangoldValue;
	}

	public String getCunoldValue() {
		return cunoldValue;
	}

	public void setCunoldValue(String cunoldValue) {
		this.cunoldValue = cunoldValue;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public HsfsOrgExtend getOrgExt() {
		return orgExt;
	}

	public void setOrgExt(HsfsOrgExtend orgExt) {
		this.orgExt = orgExt;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public ArrayList getList() {
		return list;
	}

	public void setList(ArrayList list) {
		this.list = list;
	}

	public String getOldAccountNUmber() {
		return oldAccountNUmber;
	}

	public void setOldAccountNUmber(String oldAccountNUmber) {
		this.oldAccountNUmber = oldAccountNUmber;
	}

	public int getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(int isSuccess) {
		this.isSuccess = isSuccess;
	}

}
