package com.kh.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.kh.hsfs.impl.AreaImpl;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.opensymphony.xwork2.ActionSupport;

public class AreaUtil extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {
	private HttpServletResponse response;
	private HttpServletRequest request;
//	private String data;// json 返回数据集
	private String areacode;// 区域编号
	private String localcode;// 乡编号

	public AreaUtil() {

	}

	public String getInitSystem() throws Exception {
		response.setCharacterEncoding("utf-8");
		StringBuffer results = new StringBuffer();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		// 县市
		List larea = (List) context.getAttribute("Areacodes");
		// 乡村组
		List ltowns = (List) context.getAttribute("Towncodes");
		// 医疗机构
		HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo)session.getAttribute("org");
		String organarea = organ.getOrgAreaId();// 机构所在区域
		String organgrade = organ.getOrgLevel(); //;// 机构级别
		// 4 是地市级的医疗机构
		if ("4".equals(organgrade)) {
			results.append("{\"name\":\"grade\"");
			results.append(",\"v\":\"4\"}\n");
			if (larea != null && larea.size() > 0) {
				// 获得市下面的县
				List temp = null;
				for (int i = 0; i < larea.size(); i++) {
					temp = (List) larea.get(i);
					results.append(",{\"name\":\"" + temp.get(0).toString()
							+ "\"");
					results.append(",\"value\":\"" + temp.get(1).toString()
							+ "\"}\n");
				}
			}
		} else if ("3".equals(organgrade)) {
			// 县级的
			results.append("{\"name\":\"grade\"");
			results.append(",\"value\":\"3\"}\n");
			if (larea != null && larea.size() > 0) {
				List temp = null;
				for (int i = 0; i < larea.size(); i++) {
					temp = (List) larea.get(i);
					if (temp.get(0).toString().matches(
							organarea.substring(0, 2) + "[0-9][0-9][0-9][0-9]")
							&& ("20".equals(temp.get(2).toString())
									|| "40".equals(temp.get(2).toString()) || ((organarea
									.substring(0, 6)).equals(temp.get(0)
									.toString()) && "50".equals(temp.get(2)
									.toString())))) {
						results.append(",{\"name\":\"" + temp.get(0).toString()
								+ "\"");
						results.append(",\"value\":\"" + temp.get(1).toString()
								+ "\"}\n");
					}
				}
				if (ltowns != null && ltowns.size() > 0) {
					for (int i = 0; i < ltowns.size(); i++) {
						temp = (List) ltowns.get(i);
						if (temp.size() > 3) {
							if ((organarea.substring(0, 6)).equals(temp.get(0)
									.toString())
									&& "60".equals(temp.get(3).toString())
									|| "61".equals(temp.get(3).toString())
									|| "62".equals(temp.get(3).toString())
									|| "63".equals(temp.get(3).toString())) {
								results.append(",{\"name\":\""
										+ temp.get(1).toString() + "\"");
								results.append(",\"value\":\""
										+ temp.get(2).toString() + "\"}\n");
							}
						}
					}
				}
			}
		} else if ("2".equals(organgrade)) {
			// 乡
			results.append("{\"name\":\"grade\"");
			results.append(",\"value\":\"2\"}\n");
			if (larea != null && larea.size() > 0) {
				List temp = null;
				for (int i = 0; i < larea.size(); i++) {
					temp = (List) larea.get(i);
					if (temp.get(0).toString().matches(
							organarea.substring(0, 2) + "[0-9][0-9][0-9][0-9]")
							&& ("20".equals(temp.get(2).toString())
									|| "40".equals(temp.get(2).toString()) || ((organarea
									.substring(0, 6)).equals(temp.get(0)
									.toString()) && "50".equals(temp.get(2)
									.toString())))) {
						results.append(",{\"name\":\"" + temp.get(0).toString()
								+ "\"");
						results.append(",\"value\":\"" + temp.get(1).toString()
								+ "\"}\n");
					}
				}

				if (ltowns != null && ltowns.size() > 0) {
					for (int i = 0; i < ltowns.size(); i++) {
						temp = (List) ltowns.get(i);
						if (temp.size() > 3) {
							if ((organarea.substring(0, 6)).equals(temp.get(0)
									.toString())
									&& (temp.get(1).toString().matches(
											organarea.substring(6, 8)
													+ "[0-9][0-9][0-9][0-9]") && ("60"
											.equals(temp.get(3).toString())
											|| "61".equals(temp.get(3)
													.toString())
											|| "62".equals(temp.get(3)
													.toString())
											|| "63".equals(temp.get(3)
													.toString()) || "70"
											.equals(temp.get(3).toString())))) {
								results.append(",{\"name\":\""
										+ temp.get(1).toString() + "\"");
								results.append(",\"value\":\""
										+ temp.get(2).toString() + "\"}\n");
								// mycode.setName(temp.get(1).toString());
								// mycode.setValue(temp.get(2).toString());
								//								
								// if ("60".equals(temp.get(3).toString())) {
								// results.add(mycode);
								// } else {
								// //乡镇合并问题 先放下
								// // int count =
								// cf.getCount(organ.getOrgCode());
								// // if (count >= 1) {
								// // List list = cf.getMyNewTowns1(organ
								// // .getAreaId(), organ
								// // .getOrganizeCode());
								// // for (int j = 0; j < list.size(); j++) {
								// // List s = (List) list.get(j);
								// // String ss = s.get(0).toString();
								// // String s1 = s.get(1).toString();
								// //
								// // Name_Value mytemp1 = new Name_Value();
								// // mytemp1.setName(ss);
								// // mytemp1.setValue(s1);
								// // results.add(mytemp1);
								// // }
								// // break;
								// // } else {
								// results.add(mycode);
								// // }
								// }

							}

						}
					}

				}

			}

		} else if ("1".equals(organgrade)) {
			results.append("{\"name\":\"grade\"");
			results.append(",\"value\":\"1\"}\n");
			if (larea != null && larea.size() > 0) {
				List temp = null;
				for (int i = 0; i < larea.size(); i++) {
					temp = (List) larea.get(i);
					if (temp.get(0).toString().matches(
							organarea.substring(0, 2) + "[0-9][0-9][0-9][0-9]")
							&& ("20".equals(temp.get(2).toString())
									|| "40".equals(temp.get(2).toString()) || ((organarea
									.substring(0, 6)).equals(temp.get(0)
									.toString()) && "50".equals(temp.get(2)
									.toString())))) {
						results.append(",{\"name\":\"" + temp.get(0).toString()
								+ "\"");
						results.append(",\"value\":\"" + temp.get(1).toString()
								+ "\"}\n");
					}
				}
				if (ltowns != null && ltowns.size() > 0) {
					int w=0;
					for (int i = 0; i < ltowns.size(); i++) {
						temp = (List) ltowns.get(i);
						if (temp.size() > 3) {
							if ((organarea.substring(0, 6)).equals(temp.get(0)
									.toString())
									&& (temp.get(1).toString().matches(
											organarea.substring(6, 8)
													+ "[0-9][0-9][0-9][0-9]") && ("60"
											.equals(temp.get(3).toString())
											|| "61".equals(temp.get(3)
													.toString())
											|| "62".equals(temp.get(3)
													.toString())
											|| "63".equals(temp.get(3)
													.toString()) || ("70"
											.equals(temp.get(3).toString()) && organarea
											.substring(6, 12).equals(
													temp.get(1)))))) {
								results.append(",{\"name\":\""
										+ temp.get(1).toString() + "\"");
								results.append(",\"value\":\""
										+ temp.get(2).toString() + "\"}\n");
							}
						}
					}
				}

			}

		}
		response.getWriter().write("[" + results.toString() + "]");
		return null;
	}

//	// 级联县级信息；
	public String selectXian() throws Exception {
		response.setCharacterEncoding("utf-8");
		StringBuffer results = new StringBuffer();
		if (areacode != null && !"".equals(areacode)) {
			ServletContext context = request.getSession().getServletContext();
			List ltowns = (List) context.getAttribute("Towncodes");
			if (ltowns != null && ltowns.size() > 0) {
				int w=0;
				for (int i = 0; i < ltowns.size(); i++) {
					List temp = (List) ltowns.get(i);
					if (temp.size() > 3) {
						if ((areacode.substring(0, 6)).equals(temp.get(0)
								.toString())
								&& "60".equals(temp.get(3).toString())
								|| "61".equals(temp.get(3).toString())
								|| "62".equals(temp.get(3).toString())
								|| "63".equals(temp.get(3).toString())) {
							w++;
							if(w>1){
								results.append(",");
							}
							results.append("{\"name\":\""
									+ temp.get(1).toString() + "\"");
							results.append(",\"value\":\""
									+ temp.get(2).toString() + "\"}\n");
						}
					}
				}
			}
		}
		response.getWriter().write("[" + results.toString() + "]");
		return null;
	}
//
	public String selectXiang() throws Exception {
		response.setCharacterEncoding("utf-8");
		StringBuffer results = new StringBuffer();
		if (areacode != null && localcode != null && !"".equals(localcode)
				&& !"".equals(areacode)) {
			String tempparam = areacode.trim() + localcode.trim();
			ServletContext context = request.getSession().getServletContext();
			List ltowns = (List) context.getAttribute("Towncodes");
			if (ltowns != null && ltowns.size() > 0) {
				int w=0;
				for (int i = 0; i < ltowns.size(); i++) {
					List temp = (List) ltowns.get(i);
					if (temp.size() > 3) {
						if ((tempparam.substring(0, 6)).equals(temp.get(0)
								.toString())
								&& (temp.get(1).toString().matches(
										tempparam.substring(6, 8)
												+ "[0-9][0-9][0-9][0-9]") && "70"
										.equals(temp.get(3).toString()))) {
							w++;
							if(w>1){
								results.append(",");
							}
							results.append("{\"name\":\""
									+ temp.get(1).toString() + "\"");
							results.append(",\"value\":\""
									+ temp.get(2).toString() + "\"}\n");
						}
					}
				}
			}
		}
		response.getWriter().write("[" + results.toString() + "]");
		return null;
	}
//
//	// 获取地区的组织机构；
	public String selectjigou() throws Exception{
		response.setCharacterEncoding("utf-8");
		StringBuffer results = new StringBuffer();
		ServletContext context = request.getSession().getServletContext();
		ApplicationContext context1 = WebApplicationContextUtils
				.getWebApplicationContext(context);
		AreaImpl cf = (AreaImpl) context1.getBean("areaimpl");
		int isql = areacode.trim().length();
		String grsql = "";
//		HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo)request.getSession().getAttribute("org");
//		String organize_code = organ.getOrgCode();// 当前登录的医疗机构代码
//		String sql1 = "select count(1) from HRX01_01A_01 where organize_manage = "
//				+ organize_code;// 查出乡镇合并的信息
//
//		List records = modeladds.getBasedao().getByJdbcSQL(sql1);// 查出合并信息

//		List perhbxz = (List) records.get(0);// 得到单行记录

//		int record = Integer.parseInt(perhbxz.get(0).toString());// 当前登录的医疗机构在表hrx01_01a_01
		// 中是否有记录,如果有记录代表是属于乡镇合并的情况
		// System.out.println("记录数 为: " + record);

		if (isql == 2) {
			grsql = " and ORG_LEVEL='5' ";
		}
		if (isql == 4) {
			grsql = " and ORG_LEVEL='4' ";
		}
		if (isql == 6) {
			grsql = " and ORG_LEVEL='3' ";
		}
		// 当传递过来的code是8 说明此时乡级编号传递过来
		if (isql == 8) {
//			if (record > 0)
//				grsql = " and grade='2' and organize_code =  " + organize_code;
//			else
				grsql = " and ORG_LEVEL='2'";
		}
		if (isql == 12) {
			grsql = " and ORG_LEVEL='1' ";
		}
		String sql = "select org_code,org_name from HSFS_ORG_BASE_INFO where ORG_AREAID like '" + areacode + "%' " + grsql + " ";
//		System.out.println(sql);
		List list=cf.gethospitals(sql);
		if(list!=null&&list.size()>0){
			List temp=null;
			int w=0;
			for(int i=0;i<list.size();i++){
				temp=(List)list.get(i);
				w++;
				if(w>1){
					results.append(",");
				}
				results.append("{\"name\":\""
						+ temp.get(0).toString() + "\"");
				results.append(",\"value\":\""
						+ temp.get(1).toString() + "\"}\n");
			}
		}
		response.getWriter().write("[" + results.toString() + "]");
		return null;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

//	public String getData() {
//		return data;
//	}
//
//	public void setData(String data) {
//		this.data = data;
//	}

	public String getAreacode() {
		return areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	public String getLocalcode() {
		return localcode;
	}

	public void setLocalcode(String localcode) {
		this.localcode = localcode;
	}

}
