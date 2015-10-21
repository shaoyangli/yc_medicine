<%@ page language="java" pageEncoding="gbk"%>
<%@page import="com.kh.hsfs.model.HsfsOrgBaseInfo"%>
<%@page import="com.kh.util.RetrunAreaId"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
String userId=request.getParameter("userId");
System.out.print(userId+"KKKK");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>服务对象管理</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet"
			type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js"
			type="text/javascript">
		</script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js">
		</script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js">
		</script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js">
		</script>
		<script type="text/javascript"
			src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue">
		</script>
		<script type="text/javascript">
function doEditor(str) {
	var url = "<%=path%>/guestAction!findByReply.action?gbook.id="+str;
	location.href=url;
}
function findList(currPage, totalPages) {
	plan.show();
	var url = "<%=path%>/guestAction!findByGuest.action?timestamp="
			+ new Date().getTime();
	var data = {
		"currPage" : currPage,
		"totalPages" : totalPages,
		"userId":'<%=userId%>'
	};
	$
			.post(url,
					data,
					function(json) {
						var page = json.page;//从action获取一个json
						var list=json.list;
					;//定义一个tr 放入数据内容的				
					var tables = "",trs="",tables2="",trs2="";
					trs="<table><tr >";
					trs2="<table><tr >";
					$
							.each(
									page.list,
									function(i, obj) {//对从action获取一个json进行遍历操作
										
										if (obj[1] == null) {
											obj[1] = "";
										}
										if (obj[2] == null) {
											obj[2] = "";
										}
										if (obj[3] == null) {
											obj[3] = "";
										}
										if (obj[1].length > 40) {
											obj[1] = obj[1].substring(0, 39)
													+ "......";
										}
										if (i % 2 == 0) {
											trs += "<tr class='tstr'>";
										} else {
											trs += "<tr >";
										}
										trs += "<td width='15%;'><span class='re_bbs'>&nbsp;&nbsp;&nbsp;</span><font>"
										        +obj[2]
										        +"</td><td width='13%;'><font color='#888888;'>"
										        +"&nbsp;发表了帖子："
										        +"</font></td><td width='57%;'><a href=\"javascript:doEditor('"
												+ obj[0]
												+ "');\">"
										        +obj[1]
										        +"</a></td><td width='15%;'>"
										        +obj[3]
												+ "</td></tr>";
									});
				
			     $
							.each(
									list,
									function(i, obj) {//对从action获取一个json进行遍历操作
										
										if (obj[1] == null) {
											obj[1] = "";
										}
										if (obj[2] == null) {
											obj[2] = "";
										}
										if (obj[3] == null) {
											obj[3] = "";
										}
										if (obj[1].length > 40) {
											obj[1] = obj[1].substring(0, 39)
													+ "......";
										}
										if (i % 2 == 0) {
											trs += "<tr class='tstr'>";
										} else {
											trs += "<tr >";
										}
										trs += "<td width='15%;'><span class='re_bbs'>&nbsp;&nbsp;&nbsp;</span><font>"
										        +obj[2]
										        +"</td><td width='13%;'><font color='#888888;'>"
										        +"&nbsp;回复了帖子："
										        +"</font></td><td width='57%;'><a href=\"javascript:doEditor('"
												+ obj[4]
												+ "');\">"
										        +obj[1]
										        +"</a></td><td width='15%;'>"
										        +obj[3]
												+ "</td></tr>";
									});
					//tables2 += trs2 + "</table>";
						tables += trs + "</table>";
				progress.complete(function(){
				art.dialog.list['jsLoadingDialog']&&art.dialog.list['jsLoadingDialog'].close();
			     	    $("#pagelist").append(tables); 
						//$("#pagelist1").append(tables2); 
						new superTable("demoTable", {
							cssSkin : "sDefault",
							fixedCols : 0
						});					
			});		
				}, 'json');

}
$(document).ready(function() {
	plan.hidebreak();
	findList(1, 0);
});
</script>
		<style type="text/css">
.mianmm table tr td {
	height: 25px;
	border-bottom: 1px solid #d2d2d2;
	text-align: left;
	padding-left: 6px;
	vertical-align: middle;
	font-size: 12px;
	color: #666;
	border-right: 1px solid #d2d2d2;
	line-height:25px;
}
.re_bbs {
    background: url("<%=path%>/images/ico_rev_bbs.gif") no-repeat scroll left center transparent;
}
.fakeContainer
  {
    margin:0 auto;
    border: none;  
    width:98%;
    height: auto; /* Required to set */
    margin-left:20px;
  }
</style>
	</head>
	<body>
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：个人动态
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mianmm">
					
					<div id="pagelist" style="margin: 0 auto;" class="fakeContainer">
					</div>
					<div id="pagelist1">
					</div>
				</div>

			</div>
			<div class="mainb">
				<div class="mainbl"></div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
				<div>
					<input id="arrayid" name="arrayid" type="hidden" />
					<input id="xianOldValue" type="hidden" />
					<input id="xiangOldValue" type="hidden" />
					<input id="cunOldValue" type="hidden" />

				</div>
			</div>
		</div>
		
	</body>
</html>
