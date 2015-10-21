package com.kh.util;

import java.util.List;

public class PageUtil<User> {

	private int totalRows;// 定义总记录数

	private int totalPages;// 定义总页数

	private int rows; // 定义每页显示数据的最大行数

	private int currPage;// 定义当前页数

	private int prePage;// 定义上一页

	private int nextPage;// 定义下一页

	private String url; // 定义处理分页的url

	private List<User> list;// 定义保存数据的集合

	private boolean hasPre;// 是否有上一页，用作首页和尾页的链接判断使用

	private boolean hasNext;// 是否有下一页

	public PageUtil(int totalRows, int rows, int currPage) {// 提供一个构造函数，传递三个参数，总记录数，每页显示的最大记录数，当前页数
		this.totalRows = totalRows;// 赋值总记录数
		this.rows = rows;// 赋值每页显示的最大记录数

		setTotalPages(totalRows);// 调用设置总页数的方法
		if (currPage > totalPages) {
			this.currPage = totalPages;
		} else {
			this.currPage = currPage;// 赋值当前页
		}
		setCurrPage(currPage);// 调用设置当前页的方法
		setPrePage(currPage);// 调用设置上一页的方法
		setNextPage(currPage);// 调用设置下一页的方法
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalRows) {// 设置总页数的方法，传递一个参数，总记录数，通过计算得出总页数
		totalPages = (totalRows + rows - 1) / rows;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		if (currPage < 1) {
			currPage = 1;
		} else if (currPage > totalPages) {
			currPage = totalPages;
		}
	}

	public int getPrePage() {
		return prePage;
	}

	public void setPrePage(int currPage) {// 设置上一页的页码数，传递一个参数，当夜页码数，通过计算来得出上一页的页码数
		if (currPage <= 1) {// 当前页如果为第一页，上一页的页码为1
			this.prePage = 1;
			hasPre = false;// 没上一页，false
		} else {// 否则为当前页-1
			this.prePage = currPage - 1;
			hasPre = true;// 有上一页，true
		}

	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int currPage) {// 设置上一页的页码数，传递一个参数，当夜页码数，通过计算来得出下一页的页码数
		if (currPage >= totalPages) {// 当前页如果为最后一页，下一页的页码为最后一页
			this.nextPage = totalPages;
			hasNext = false;// 没下一页，fals
		} else {// 否则为当前页+1
			this.nextPage = currPage + 1;
			hasNext = true;// 有下一页，true
		}
	}

	public String getUrl() {
		StringBuffer buffer = new StringBuffer();// StringBuffer节省内存空间，效率高
		if (hasPre == true) {// 对当前页为第一页或者最后一页时进行判断
			buffer.append("<a href='#' onclick='findList(1,0)'><img src='../../images/first.gif'  /></a>");
			buffer.append("<a href='#' onclick='findList("+prePage+","+totalPages+")'><img src='../../images/back.gif'  /></a>");
		} else {
			buffer
					.append("<img src='../../images/first.gif'  />");
			buffer
					.append("<img src='../../images/back.gif'  />");
		}

		if (hasNext == true) {
			buffer.append("<a href='#' onclick='findList("+nextPage+","+totalPages+")'><img src='../../images/next.gif'  /></a>");
			buffer.append("<a href='#' onclick='findList("+totalPages+","+totalPages+")'><img src='../../images/last.gif'  /></a>");
		} else {
			buffer
					.append("<img src='../../images/next.gif'  />");
			buffer
					.append("<img src='../../images/last.gif' />");
		}
		return buffer.toString();
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<User> getList() {
		return list;
	}

	public void setList(List<User> list) {
		this.list = list;
	}
}
