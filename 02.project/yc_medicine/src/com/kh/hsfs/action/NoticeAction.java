package com.kh.hsfs.action;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.kh.hsfs.dao.NoticeService;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.hsfs.model.Notice;
import com.kh.util.PageUtil;
import com.opensymphony.xwork2.ActionSupport;

public class NoticeAction extends ActionSupport {
	private NoticeService noticeService;
	private Notice notice;
	private int isSuccess;
	private int flag;
	private int currPage;
	private int totalPages;
	private PageUtil result;
	private int id;
	private String loginid;
	private HttpSession session = ServletActionContext.getRequest()
			.getSession();
	private String [] info;//
	private String count;//
	/*
	 * 公告发布
	 */
	public String saveNotice() throws Exception {
		isSuccess = noticeService.saveNotice(notice);
		return "r";
	}

	/*
	 * 查看所有公告列表
	 */

	public String findAllNotice() throws Exception {
		HsfsUserInfo user = (HsfsUserInfo) session.getAttribute("user");
		String loginid = user.getUserLoginId();
		String sql = "select id,title,content,notice_date,send_person,(case when login_id like '%,"
				+ loginid + ",%' then 1 else 0 end ) s from hsfs_notice order by  notice_date desc,id desc";
		int row = 10;// 每页记录数
		if (currPage > totalPages) {
			currPage = totalPages;
		}
		result = noticeService.findBySqlPage(currPage, row, sql);
		return "r";
	}

	/*
	 * 查看一个公告
	 */
	public String findOneNotice() throws Exception {
		notice = noticeService.findNotice(id);
		if (flag == 1) {
			return "updateNotice";
		}
		return "findOneNotice";
	}

	/*
	 * 公告删除
	 */
	public String deleteNotice() throws Exception {
//		isSuccess = noticeService.deleteNotice(id);
		info=count.split(",");
		for ( int i = 0; i < info.length; i++) {
			noticeService.deleteNotice(Integer.parseInt(info[i]));
		}
		
		return "r";
	}

	/*
	 * 公告更新
	 */
	public String updateNotice() throws Exception {
		isSuccess = noticeService.updateNotice(notice);
		return "r";
	}

	/*
	 * 给某个公告标识已读
	 */
	public String markReaded() throws Exception {
		isSuccess = noticeService.markNotice(id);
		return "r";
	}
	/*
	 * 查看某个登录用户是否有新的公告
	 */
	public String checkNewNotice() throws Exception {
		isSuccess = noticeService.checkNewNotice(loginid);
		return "r";
	}
	public NoticeService getNoticeService() {
		return noticeService;
	}

	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}

	public Notice getNotice() {
		return notice;
	}

	public void setNotice(Notice notice) {
		this.notice = notice;
	}

	public int getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(int isSuccess) {
		this.isSuccess = isSuccess;
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

	public PageUtil getResult() {
		return result;
	}

	public void setResult(PageUtil result) {
		this.result = result;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getLoginid() {
		return loginid;
	}

	public void setLoginid(String loginid) {
		this.loginid = loginid;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}
	
	
}
