package com.kh.hsfs.model;

import java.util.ArrayList;
import java.util.List;

public class MyChart {
	
	private Integer id;
	private String title;//统计图标题
	private String subTitle;//统计图副标题
	private String [] xTitle;//x轴标题
	private String [] yTitle;//主轴标题
	private  String typedb;//服务器端的数据源
	private String typechart;//统计图类类型
	//private String typetime = 0;//统计的时间类型
	private List emtoys = new ArrayList();//需要统计的参数
	private List smtoys	= new ArrayList();//需要统计的参数,当统计图是内嵌饼图的时候用到
	private List categoriesLocal = new ArrayList();//本地轴分段名称


	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public String[] getxTitle() {
		return xTitle;
	}
	public void setxTitle(String[] xTitle) {
		this.xTitle = xTitle;
	}
	public String[] getyTitle() {
		return yTitle;
	}
	public void setyTitle(String[] yTitle) {
		this.yTitle = yTitle;
	}
	public String getTypedb() {
		return typedb;
	}
	public void setTypedb(String typedb) {
		this.typedb = typedb;
	}
	public String getTypechart() {
		return typechart;
	}
	public void setTypechart(String typechart) {
		this.typechart = typechart;
	}
	public List getEmtoys() {
		return emtoys;
	}
	public void setEmtoys(List emtoys) {
		this.emtoys = emtoys;
	}
	public List getSmtoys() {
		return smtoys;
	}
	public void setSmtoys(List smtoys) {
		this.smtoys = smtoys;
	}
	
	public List getCategoriesLocal() {
		return categoriesLocal;
	}
	public void setCategoriesLocal(List categoriesLocal) {
		this.categoriesLocal = categoriesLocal;
	}
	
	
	

}
