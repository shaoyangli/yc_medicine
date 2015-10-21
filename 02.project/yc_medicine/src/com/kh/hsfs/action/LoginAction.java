package com.kh.hsfs.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import com.kh.hsfs.dao.UserService;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.hsfs.model.HsfsUserPower;
import com.kh.hsfs.model.HsfsUserRole;
import com.kh.hsfs.model.HsfsUserRolePower;
import com.kh.util.BASE64;
import com.kh.util.FileterString;
import com.kh.util.PageUtil;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {
	private int isSuccess;
	private UserService userService;
	private String loginName;
	private String loginPass;
	private String msg;
	private String year;

	/**
	 * 用户登录
	 */
	public String userLogin() throws Exception {

		// HttpServletRequest request = ServletActionContext.getRequest();
		// HttpSession session = request.getSession();
		// 借助一个外部类对 对登录的特殊字符进行处理
		String u = FileterString.StringFilter(loginName);
		String p = FileterString.StringFilter(loginPass);
		isSuccess = userService.checkLogin(u, p, year);
		
		// 登录成功
		if (isSuccess == 0) {
			return "loginSuccess";

		} else {
			msg = "用户名或者密码错误，请重新登录！";
			return "error";
		}
	}
	/**
	 * 手持机用户登录
	 */
	public String userLoginx() throws Exception {
		 byte[] byteArray = BASE64.decryptBASE64(authkey);     
	        String xauthkey=new String(byteArray);   
	        SimpleDateFormat df = new SimpleDateFormat("yyMMddHHmmss");//设置日期格式
	        String xtime=df.format(new Date());
	        String qian="",hou="";
	        hou=xauthkey.substring(0, 6);
	        qian=xauthkey.substring(6, 12);
	        String time=qian+hou;
	        if(Long.parseLong(xtime)-Long.parseLong(time)<=100&&Long.parseLong(xtime)-Long.parseLong(time)>=0){
		       isSuccess = userService.checkLoginx(pda_sn, year);
	        }else{
	        	isSuccess=2;
	        }
		// 登录成功
		return "loginSuccess";
	}
	/**
	 * 用户退出登录和切换用户
	 */
	public String userExit() throws Exception {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.invalidate();
		return "userExit";
	}

	public String left() throws Exception {
        System.out.println("========jinrucaidan--------left");
        userService.checkUserPowers();
		return "left2";
	}
	

	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
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
	public String getYear() {
		return year;
	}

	public int getIsSuccess() {
		return isSuccess;
	}
	public void setIsSuccess(int isSuccess) {
		this.isSuccess = isSuccess;
	}
	public void setYear(String year) {
		this.year = year;
	}
   private String pda_sn;
   private String authkey;
public String getPda_sn() {
	return pda_sn;
}
public void setPda_sn(String pda_sn) {
	this.pda_sn = pda_sn;
}
public String getAuthkey() {
	return authkey;
}
public void setAuthkey(String authkey) {
	this.authkey = authkey;
}
   
}
