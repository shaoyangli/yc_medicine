package com.kh.hsfs.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.kh.base.dao.BaseDao;
import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.OrgExtendDao;
import com.kh.hsfs.model.HsfsOrgExtend;
import com.kh.hsfs.model.HsfsOrgExtendInfo;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.util.PageUtil;

public class OrgExtendDaoImpl implements OrgExtendDao {
	private BaseDaoImpl bdi;

	public List findOrgAccount(String sql) {
		return bdi.getByJdbcSQL(sql);
	}

	/**
	 * 设置医疗机构账户信息,保存成功的话要在账户表里添加一条记录
	 */
	public int saveOrgExtend(HsfsOrgExtend orgExtend) {
		int id;
		String orgCode = orgExtend.getOrgCode();
		String year = orgExtend.getBurYear();
		String accountNumber = orgExtend.getAccountNumber();
		String sql = "select count(1) from hsfs_org_extend where org_code="
				+ orgCode + " and bur_year=" + year;
		String sql2 = "select count(1) from hsfs_org_extend where org_code != "
				+ orgCode + " and account_number = " + accountNumber;
		int res = bdi.getCounts(sql2);
		if (res > 0)// 代表别的机构使用了这个帐号不能再用
		{
			id = 3;// 别的机构使用了帐号
		} else {
			int result = bdi.getCounts(sql);
			if (result > 0) {
				id = 2;// 本年已经添加了帐号
			} else {
				try {
					bdi.save(orgExtend);
					id = 0;// 保存成功
					// 在账户表里添加一条记录
					

				} catch (Exception e) {
					id = 1;
					e.printStackTrace();
				}
			}
		}
		return id;
	}

	/**
	 * 信息登记
	 */

	public int saveOrgExtendInfo(HsfsOrgExtendInfo info) {
		int isSuccess;
		// String orgCode = info.getOrgCode();
		// String buryear = info.getBurYear();
		// String sql =
		// "select count(1) from hsfs_org_extend_info t where t.org_code = '"
		// + orgCode + "' and buryear = '" + buryear + "'";
		// int t = bdi.getCounts(sql);
		// if (t > 0) {
		// isSuccess = 1;// 本机构的信息已经添加
		// } else {
		// SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 设置日期格式
		// String nowTime = df.format(new Date());// 构造成当前时间
		// info.setAddDate(nowTime);
		// try {
		// bdi.save(info);
		// isSuccess = 0;
		// } catch (Exception e) {
		// e.printStackTrace();
		// isSuccess = 2;
		// }
		// }
		try {
			String orgCode = info.getOrgCode();
			String buryear = info.getBurYear();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 设置日期格式
			String nowTime = df.format(new Date());// 构造成当前时间
			info.setAddDate(nowTime);
			HttpSession session = ServletActionContext.getRequest()
			.getSession();
			 HsfsUserInfo user = (HsfsUserInfo)session.getAttribute("user");
			 String userName = user.getUserName();
			// System.out.println(userName);
			 info.setAddPerson(userName);
			String sql = "select count(1) from hsfs_org_extend_info t where t.org_code = '"
					+ orgCode + "' and buryear = '" + buryear + "'";
			int t = bdi.getCounts(sql);
			if (t == 1) {
				String sql1 = "select id,state from hsfs_org_extend_info t where t.org_code = '"
						+ orgCode + "' and buryear = '" + buryear + "'";
				List rs = bdi.getByJdbcSQL2(sql1);
				int id = Integer.parseInt((String) rs.get(0));
				int state = Integer.parseInt((String) rs.get(1));
				if (state != 0) {
					isSuccess = 3;// 已经提交
				} else {
					info.setId(id);
					bdi.saveorUpdate(info);// 更新
					isSuccess = 0;
				}

			} else {
				bdi.saveorUpdate(info);// 新增
				isSuccess = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = 1;
		}
		return isSuccess;
	}

	public List findOrgExtendinfo(String year, String orgCode) {
		List info = null;
		String sql = "select count(1) from hsfs_org_extend_info where org_code = '"
				+ orgCode + "' and buryear = '" + year + "'";
		int t = bdi.getCounts(sql);
		if (t == 1) {
			String sql1 = "select * from hsfs_org_extend_info where org_code = '"
					+ orgCode + "' and buryear = '" + year + "'";
			info = bdi.getByJdbcSQL2(sql1);
		}
		return info;
	}

	public PageUtil findOrgExtend(int currPage, int rows, String sql) {
		// 默认显示第一页
		if (currPage == 0) {
			currPage = 1;
		}
		return bdi.findBySqlPage(currPage, rows, sql);
	}

	public void removeOrgExtend(int id) {
		HsfsOrgExtendInfo orgDaoExtend;
		try {
			orgDaoExtend = (HsfsOrgExtendInfo) bdi.getInt(
					HsfsOrgExtendInfo.class, id);
			bdi.remove(orgDaoExtend);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public HsfsOrgExtendInfo findOrgExtend(int id) {
		HsfsOrgExtendInfo orgExtend = null;
		try {
			orgExtend = (HsfsOrgExtendInfo) bdi.getInt(HsfsOrgExtendInfo.class,
					id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orgExtend;
	}

	public HsfsOrgExtend findOrgAccount(int id) {
		HsfsOrgExtend account = null;
		try {
			account = (HsfsOrgExtend) bdi.getInt(HsfsOrgExtend.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return account;
	}

	public void updateOrgExtend(HsfsOrgExtendInfo t) {

		try {
			bdi.update(t);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 此方法完成对医疗机构账户的修改功能,但是通常情况下,医疗机构 帐号只有刚设置的可以修改,一旦账户有了流转记录就不允许修改
	 * 修改账户的时候要对账户日志表中的帐号进行修改
	 */
	public int updateOrgAccount(HsfsOrgExtend t, String oldNum) {
		String year = t.getBurYear();
		String orgCode = t.getOrgCode();
		String newAccountNumber = t.getAccountNumber();
		String sql = "select count(1) from hsfs_account_log where account_number='"
				+ oldNum + "' and buryear='" + year+"'";
		String sql2 = "select count(1) from hsfs_org_extend where org_code != "
				+ orgCode + " and account_number = " + newAccountNumber;
		String sql3 = "select id from hsfs_account where org_code='" + orgCode+"'"
				+ " and buryear =" + year;
		String sql4 = "select count(1) from hsfs_account where org_code='" + orgCode+"'"
				+ " and buryear =" + year;
		int k = bdi.getCounts(sql);
		int l = bdi.getCounts(sql2);
		int j = bdi.getCounts(sql4);
		// 先判断日志表是否有记录,没记录才可以更新
		if (k > 0) {
			return 1;
		} else {
			// 判断新帐号是否别的机构使用了
			if (l > 0) {
				return 2;
			} else {
				// 更新机构账户的情况下,账户表也要随着更新
				try {
					System.out.println(sql3+"sql2");
					// 下面修改账户表中的帐号
					
					// System.out.println("要更改账户的ID为: "+id);
					
					bdi.update(t);
					
					return 0;
				} catch (Exception e) {
					e.printStackTrace();
					return 3;
				}

			}

		}

	}

	public BaseDaoImpl getBdi() {
		return bdi;
	}

	public void setBdi(BaseDaoImpl bdi) {
		this.bdi = bdi;
	}

	public String findAreaName(String areaid) {
		String sql = "select t.local_name from dic_hr_area_local t where t.county_id || t.local_id = "
				+ areaid;
		return bdi.getSingleResult(sql);
	}

}
