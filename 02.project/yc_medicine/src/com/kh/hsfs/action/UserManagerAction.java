package com.kh.hsfs.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.kh.hsfs.dao.UserService;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.hsfs.model.HsfsUserPower;
import com.kh.hsfs.model.HsfsUserRole;
import com.kh.hsfs.model.HsfsUserRolePower;
import com.kh.util.PageUtil;
import com.opensymphony.xwork2.ActionSupport;

public class UserManagerAction extends ActionSupport {
	// private HttpServletRequest request;
	private UserService userService;
	private String area;// 注册用户时候所选取的区域id信息
	private int orgLevel;// 需要查询的医疗机构级别
	private List list;
	private HsfsUserInfo user;// 用户
	private HsfsUserRole userRole;// 用户角色
	private HsfsUserRolePower rolePower;
	private HsfsUserPower power;
	private int isSuccess;// 标志保存是否成功
	private String loginId;
	private int roleId;// 角色Id
	private int powerID;//菜单主键
	private String[] powerIds;// 菜单的id形式为:1,2,3,4
	private String loginName;
	private String loginPass;
	private String msg;
	private String orgCode;// 根据机构编号查询用户列表
	private HttpSession session = ServletActionContext.getRequest()
			.getSession();

	private ArrayList<Map<String, Object>> menuNodes = new ArrayList<Map<String, Object>>();
	
	private PageUtil findOrgResult;
	private int currPage;// 当前页
	private int totalPages;// 总页数
	private String param;// 接收查询条件传递过来的值
	private String xianoldValue;
	private String xiangoldValue;
	private String cunoldValue;
	private String username = "";//模糊查询根据用户名
	private int id;

	/**
	 * 查询注册用户所管辖的医疗机构
	 */
	public String findOrgs() throws Exception {
		String sql = "select org_code,org_name from HSFS_ORG_BASE_INFO where org_areaid like '"
				+ area + "%' " + "and org_level = " + orgLevel;
		list = userService.findList(sql);
		return "findOrgs";
	}

	/**
	 * 检查注册工号是否使用
	 */
	public String checkLoginId() throws Exception {
		isSuccess = userService.checkLoginID(loginId);
		return "checkLoginId";
	}

	/**
	 * 用户注册
	 */
	public String saveUser() throws Exception {

		isSuccess = userService.saveUser(user);
		return "saveUser";
	}

	/**
	 * 查询用户列表
	 */
	public String findUserList() throws Exception {
        System.out.println("======================");
		String sql = "select t.user_code,t.user_name,t.user_loginid,t.user_pwd,"
				+ "(select role_name from hsfs_user_role k where t.power_role = k.role_code) power_role,m.org_name,t.PDA_SN,t.doc_id,t.is_stop "
				+ "from hsfs_user_info t,hsfs_org_base_info m where t.org_code= m.org_code ";
		if(!"".equals(username)) {
			sql += " and user_name like '%"+ username +"%'";
		}
		sql += " order by t.power_role,t.org_code";
		int row = 10;// 每页记录数
		if (currPage > totalPages) {
			currPage = totalPages;
		}
		System.out.println(sql+"))))))))))))))))))))))");
		findOrgResult = userService.findBySqlPage(currPage, row, sql);
		return "result";
	}

	/**
	 * 删除用户
	 */
	public String removeUser() throws Exception {
		isSuccess = userService.removeUser(roleId);
		return "result";
	}
	/**
	 * 查询单个用户
	 */
	public String findUser() throws Exception {
		username = (new String(username.getBytes("ISO-8859-1"),"gbk"));
		user = (HsfsUserInfo)userService.findModel(HsfsUserInfo.class, roleId);
		return "findUser";
	}
	/**
	 * 用户修改
	 */
	public String userUpdate() throws Exception {
		isSuccess = userService.updateUser(user);
		return "result";
	}
	/*
	 * 账户停用启用控制
	 */
	public String updateState() throws Exception {
		isSuccess = userService.updateUserState(msg,id);
		return "result";
	}

	/**
	 * 角色添加
	 */

	public String saveUserRole() throws Exception {
		isSuccess = userService.saveUserRole(userRole);
		return "saveUserRole";
	}

	/**
	 * 查询所有用户角色
	 */
	public String findAllUserRole() throws Exception {
		String sql = "select * from hsfs_user_role order by role_code";
		list = userService.findList(sql);
		return "findAllUserRole";
	}
	
	/**
	 * 角色删除
	 */
	public String removeRole() throws Exception {
		isSuccess = userService.removeRole(roleId);
		return "result";
	}

	/**
	 * 菜单添加
	 */
	public String saveUserPower() throws Exception {
		isSuccess = userService.saveUserPower(power);
		return "saveUserPower";
	}

	/**
	 * 查询所有菜单
	 */
	public String findAllUserPower() throws Exception {
		String sql = "select m.order_id,m.power_name,m.power_url,"
				+ "(select n.power_name from hsfs_user_power n where m.father_id = n.power_id ) fathterMenu,m.power_id "
				+ "from hsfs_user_power m order by m.order_id";
		System.out.println(sql);
		list = userService.findList(sql);
		return "findAllUserPower";
	}
	/**
	 * 查询一个菜单实体,为修改做准备
	 */
	public String findOnePower() throws Exception {
		power = (HsfsUserPower)userService.findModel(HsfsUserPower.class,powerID);
		return "findOnePower";
	}
	
	/**
	 * 更新菜单信息
	 */
	public String updatePower() throws Exception {
		isSuccess = userService.updatePower(power);
		return "result";
	}
	
	/**
	 * 删除菜单
	 */
	
	public String removePower() throws Exception {
		isSuccess = userService.removePower(powerID);
		return "result";
	}

	/**
	 * 查询所有一级菜单
	 */
	public String findAllFatherMenu() throws Exception {
		String sql = "select power_id,power_name from hsfs_user_power where father_id = 0 order by power_id";
		list = userService.findList(sql);
		return "findAllFatherMenu";
	}

	/**
	 * 自动生成所有的菜单
	 */
	public String findAllMenu() throws Exception {
		String sql = "select power_id,father_id, power_name from hsfs_user_power order by order_id asc";
		list = userService.findList(sql);
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			List l = (ArrayList) list.get(i);
			map.put("id", l.get(0));
			map.put("pId", l.get(1));
			map.put("name", l.get(2));
			map.put("open", true);
			menuNodes.add(map);
		}

		return "findAllMenu";
	}

	/**
	 * 角色分配权限
	 */
	public String saveRolePower() throws Exception {

		isSuccess = userService.saveOrUpdateRolePower(rolePower);
		return "saveRolePower";
	}

	/**
	 * 查询角色的权限
	 */
	public String findPowers() throws Exception {
		String sql = "select power_id from hsfs_user_role_power where role_id = "
				+ roleId;
		String pIds = userService.findId(sql);
		powerIds = pIds.split(",");
		return "findPowers";
	}

	/**
	 * 用户退出登录和切换用户
	 */
	public String userExit() throws Exception {

		session.invalidate();
		return "userExit";
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public int getOrgLevel() {
		return orgLevel;
	}

	public void setOrgLevel(int orgLevel) {
		this.orgLevel = orgLevel;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public HsfsUserInfo getUser() {
		return user;
	}

	public void setUser(HsfsUserInfo user) {
		this.user = user;
	}

	public int getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(int isSuccess) {
		this.isSuccess = isSuccess;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public HsfsUserRole getUserRole() {
		return userRole;
	}

	public void setUserRole(HsfsUserRole userRole) {
		this.userRole = userRole;
	}

	public HsfsUserPower getPower() {
		return power;
	}

	public void setPower(HsfsUserPower power) {
		this.power = power;
	}

	public ArrayList<Map<String, Object>> getMenuNodes() {
		return menuNodes;
	}

	public void setMenuNodes(ArrayList<Map<String, Object>> menuNodes) {
		this.menuNodes = menuNodes;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String[] getPowerIds() {
		return powerIds;
	}

	public void setPowerIds(String[] powerIds) {
		this.powerIds = powerIds;
	}

	public HsfsUserRolePower getRolePower() {
		return rolePower;
	}

	public void setRolePower(HsfsUserRolePower rolePower) {
		this.rolePower = rolePower;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginPass() {
		return loginPass;
	}

	public void setLoginPass(String loginPass) {
		this.loginPass = loginPass;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public int getPowerID() {
		return powerID;
	}

	public void setPowerID(int powerID) {
		this.powerID = powerID;
	}

	public PageUtil getFindOrgResult() {
		return findOrgResult;
	}

	public void setFindOrgResult(PageUtil findOrgResult) {
		this.findOrgResult = findOrgResult;
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

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
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

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
}
