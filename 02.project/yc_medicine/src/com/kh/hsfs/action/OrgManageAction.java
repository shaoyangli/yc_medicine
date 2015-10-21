package com.kh.hsfs.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletResponseAware;

import com.kh.hsfs.dao.OrgDao;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.util.DicUtil;
import com.kh.util.PageUtil;
import com.opensymphony.xwork2.ActionSupport;

/*
 * 处理医疗机构基本信息
 */
public class OrgManageAction extends ActionSupport implements
		ServletResponseAware {
	private OrgDao orgDao;
	private HsfsOrgBaseInfo hobi;
	private HttpServletResponse response;
	private String result;

	private PageUtil pageUtil;
	private PageUtil findOrgResult;
	private int currPage;// 当前页
	private int totalPages;// 总页数
	private String orgTypexs1;// 医疗机构类型一级菜单的值
	private String orgTypexs2;// 医疗机构类型二级菜单的值

	private List list;// 存医疗机构级别
	private List list4;//拨款机构
	private List list1;// 存医疗机构类型 sorts 为1 select * from dic_organ_type where
	// sorts = '1'
	private List list2;// 存根据医疗机构类型的一级菜单 查询二级下拉菜单的集合
	private List list3;// 存根据医疗机构类型的二级菜单 查询三级下拉菜单的集合

	private String orgCode;// 接收要编辑的机构编号

	private String param;// 接收查询条件传递过来的值
	private String orgName;//模糊查询中医疗机构名字
	private int level;// 医疗机构级别

	private String orgType;// 接受机构类型的类型
	private String sorts;// 机构类型的sorts

	private String xianoldValue;
	private String xiangoldValue;
	private String cunoldValue;
	private String [] info;//
	private String count;//

	
	/*
	 * 添加机构之前检查机构编码是否已经使用了
	 */
	public String checkOrgCode() throws Exception {
		level = orgDao.checkOrgCode(orgCode);
		return "save";
	}
	/*
	 * 此方法处理医疗机构添加
	 */
	public String orgSave() throws Exception {
		int flag = 0;
		try {
			flag = orgDao.saveOrg(hobi);
		} catch (Exception e) {
			e.printStackTrace();
		}

		result = flag + "";
		return "save";

	}

	/*
	 * 添加医疗机构页面, 查询医疗机构的级别和类型
	 */
	public String findDic() throws Exception {
		String sql3 = DicUtil.sql3;// 获得医疗机构的级别
		String sql4 = DicUtil.sql4;// 获得医疗机构的类型(下拉的一级)
		String sql5 = DicUtil.sql_bz;//或得机构补助标准级别
		list = orgDao.getByJdbcSQL(sql3);
		list1 = orgDao.getByJdbcSQL(sql4);
		list2 = orgDao.getByJdbcSQL(sql5);
		return "getDic";
	}

	/*
	 * 选择医疗机构类型的二级菜单
	 */
	public String selectOrg2() throws Exception {
		String sql = "select code,text from dic_organ_type where sorts = '2' and code like '"
				+ orgTypexs1 + "%'";
		list2 = orgDao.getByJdbcSQL(sql);
		return "selectOrg2";
	}

	/*
	 * 选择医疗机构类型的三级菜单
	 */
	public String selectOrg3() throws Exception {
		String sql = "select code,text from dic_organ_type where sorts = '3' and code like '"
				+ orgTypexs2.substring(0, 2) + "%'";
		list3 = orgDao.getByJdbcSQL(sql);
		return "selectOrg3";
	}

	/*
	 * 医疗机构查询方法
	 */
	public String findOrg() throws Exception {
		String sql = "select a.org_name orgname,a.org_code code,a.org_address,(select CVALUE from dic_code_nh_list where code='NH201_06' and cid = a.org_level) org_level,"
				+ "(select text from dic_organ_type where code = a.org_typex )org_typex,a.ORG_NCCMCODE ORG_NCCMCODE,(select b.org_name from hsfs_org_base_info b"
				+ " where b.org_code = a.org_fat_code) org_fat_name,(select b.org_name from hsfs_org_base_info b where b.org_code = a.appropriation_org) org_bk, a.ORG_LEADER ORG_LEADER,a.org_phone org_phone,a.org_id,(select t.cvalue from dic_code_hr_list t where t.code = 'ORGL' and t.cid = a.bzbz_jb) bzbz  from hsfs_org_base_info a "
				+ "where a.org_areaid like '"
				+ param
				+ "%'" ;
		if(orgName != null)
		{
			sql += " and a.org_name like '%" + orgName +"%'";
		
		}
		sql += " order by a.org_areaid,a.org_code,a.org_level desc";
		int row = 10;// 每页记录数
		if (currPage > totalPages) {
			currPage = totalPages;
		}
		findOrgResult = orgDao.findBySqlPage(currPage, row, sql);
		return "findOrg";
	}

	/*
	 * 医疗机构删除
	 */
	public String removeOrg() throws Exception {
		
		info=count.split(",");
		for ( int i = 0; i < info.length; i++) {
			orgDao.removeById(info[i]);
		}
		return "removeOrg";
	}

	/*
	 * 单个医疗机构的查询
	 */
	public String findOneOrg() throws Exception {
		if(null != orgName) {
			
			orgName = (new String(orgName.getBytes("ISO-8859-1"),"gbk"));
		}
		
		hobi = orgDao.findOrgById(orgCode);
		return "findOneOrg";
	}

	/*
	 * 获得当前机构的类型的sorts
	 */
	public String findSorts() throws Exception {
		String sql = "select sorts from dic_organ_type where code = '"
				+ orgType + "'";
		List list = orgDao.getByJdbcSQL(sql);
		sorts = ((ArrayList<String>) list.get(0)).get(0);
		return "findSorts";
	}

	/*
	 * 医疗机构更新
	 */
	public String updateOrg() throws Exception {
		// System.out.println(hobi.getOrgCode()+"---------");
		orgDao.updateOrg(hobi);
		return "updateOrg";
	}

	/*
	 * 查询医疗机构上级医疗机构信息和拨款机构
	 */
	public String findUpOrg() throws Exception {
		//查询上级机构
		String sql = "select org_code,org_name from HSFS_ORG_BASE_INFO where org_areaid like '"
				+ param + "%' " + "and org_level = " + level;
		//查询拨款机构
		String sql1 = "select org_code,org_name from HSFS_ORG_BASE_INFO where ";
		if(level == 3 || level == 4){
			sql1 += "org_areaid like '"+ param + "%' and org_level = 3" ;
		}
		if(level == 2)	{
			
			sql1 += "(org_areaid like '"+ param + "%' and org_level = " + level + ") or (org_areaid like '" + param.substring(0, 6) + "%' and org_level = 3)";
		}
		list = orgDao.getByJdbcSQL(sql);
		list4 = orgDao.getByJdbcSQL(sql1);
		
		return "findUpOrg";
	}

	public HsfsOrgBaseInfo getHobi() {
		return hobi;
	}

	public void setHobi(HsfsOrgBaseInfo hobi) {
		this.hobi = hobi;
	}

	public void setOrgDao(OrgDao orgDao) {
		this.orgDao = orgDao;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public void setList1(List list1) {
		this.list1 = list1;
	}

	public List getList1() {
		return list1;
	}

	public List getList2() {
		return list2;
	}

	public void setList2(List list2) {
		this.list2 = list2;
	}

	public List getList3() {
		return list3;
	}

	public void setList3(List list3) {
		this.list3 = list3;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public PageUtil getPageUtil() {
		return pageUtil;
	}

	public void setPageUtil(PageUtil pageUtil) {
		this.pageUtil = pageUtil;
	}

	public PageUtil getFindOrgResult() {
		return findOrgResult;
	}

	public void setFindOrgResult(PageUtil findOrgResult) {
		this.findOrgResult = findOrgResult;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getOrgTypexs1() {
		return orgTypexs1;
	}

	public void setOrgTypexs1(String orgTypexs1) {
		this.orgTypexs1 = orgTypexs1;
	}

	public String getOrgTypexs2() {
		return orgTypexs2;
	}

	public void setOrgTypexs2(String orgTypexs2) {
		this.orgTypexs2 = orgTypexs2;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgType() {
		return orgType;
	}

	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}

	public String getSorts() {
		return sorts;
	}

	public void setSorts(String sorts) {
		this.sorts = sorts;
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

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getCurrPage() {
		return currPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String[] getInfo() {
		return info;
	}

	public void setInfo(String[] info) {
		this.info = info;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public List getList4() {
		return list4;
	}

	public void setList4(List list4) {
		this.list4 = list4;
	}
	
}
