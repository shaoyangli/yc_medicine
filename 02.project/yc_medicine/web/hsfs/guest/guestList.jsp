<%@ page language="java" pageEncoding="gbk"%>
<%@page import="com.kh.hsfs.model.HsfsOrgBaseInfo"%>
<%@page import="com.kh.util.RetrunAreaId"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
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
function doEditor2(str) {
	var url = "<%=path%>/guestAction!findByUser.action?userId="+str;
	location.href=url;
}
function findList(currPage, totalPages) {
	plan.show();
	var title=$("#title").val();
	var url = "<%=path%>/guestAction!findAll.action?timestamp="
			+ new Date().getTime();
	var data = {
		"result":$.trim(title),
		"currPage" : currPage,
		"totalPages" : totalPages
	};
	$
			.post(url,
					data,
					function(json) {
						var page = json.page;//从action获取一个json
					var trs = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>"
							+ "<th width='40%'>标题</th>"
							+ "<th width='20%'>发言人</th>"
							+ "<th width='20%'>回复数/点击数</th>" 
							+ "<th width='20%'>最后更新时间</th>";
					;//定义一个tr 放入数据内容的				
					var tables = "";
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
										if (obj[4] == null) {
											obj[4] = "";
										}
										if (obj[5] == null) {
											obj[5] = "";
										}
										if (obj[6] == null) {
											obj[6] = "";
										}
										if (obj[7] == null) {
											obj[7] = "";
										}
										if (obj[1].length > 40) {
											obj[1] = obj[1].substring(0, 39)
													+ "......";
										}
										if(obj[9]==null){
											obj[9]=0;
										}
										if(obj[8]==null){
											obj[8]=0;
										}
										if (i % 2 == 0) {
											trs += "<tr class='tstr'>";
										} else {
											trs += "<tr >";
										}
										trs += "<td><a href=\"javascript:doEditor('"
												+ obj[0]
												+ "');\">"
												+ obj[1]
												+ "</a></td><td><a href=\"javascript:doEditor2('"
												+ obj[8]
												+ "');\">"
												+ obj[2]
												+ "</a><br>"
												+ obj[3]
												+ "</td><td>&nbsp;&nbsp;"
												+ obj[4]
												+ "&nbsp;&nbsp;/&nbsp;&nbsp;"
												+ obj[5]
												+ "</td><td ><a href=\"javascript:doEditor2('"
												+ obj[9]
												+ "');\">"
												+ obj[6]
												+ "</a><br>"
												+ obj[7]
												+ "</td></tr>";
									});
					tables += trs + "</table>";
					plan.hidden(page, tables);

				}, 'json');

}
$(document).ready(function() {
	plan.hidebreak();
	findList(1, 0);
});
</script>
		<style type="text/css">
.btn_2 {
	background: url("../../images/btn_1.png") no-repeat scroll 0 -24px
		transparent;
	color: #FFFFFF !important;
	display: inline-block;
	height: 24px;
	overflow: hidden;
	padding: 0 0 0 18px;
	text-align: center;
	text-decoration: none;
	vertical-align: middle;
	width: auto;
	vertical-align: middle;
}

.btn_1 {
	background: url("../../images/btn_1.png") no-repeat scroll 0 0
		transparent;
	color: #FFFFFF !important;
	display: inline-block;
	height: 24px;
	overflow: hidden;
	padding: 0 0 0 18px;
	text-align: center;
	text-decoration: none;
	vertical-align: middle;
	width: auto;
	vertical-align: middle;
}

.btn_1 span {
	background: url("../../images/btn_1.png") no-repeat scroll right 0
		transparent;
	display: inline-block;
	height: 24px;
	overflow: hidden;
	padding: 0 18px 0 0;
	line-height: 24px;
}

.btn_2 span {
	background: url("../../images/btn_1.png") no-repeat scroll right -24px
		transparent;
	display: inline-block;
	height: 24px;
	overflow: hidden;
	padding: 0 18px 0 0;
	line-height: 24px;
}

.mianmm table tr td {
	height: 15px;
	border-bottom: 1px solid #d2d2d2;
	text-align: left;
	padding-left: 6px;
	vertical-align: middle;
	font-size: 12px;
	color: #666;
	border-right: 1px solid #d2d2d2;
	line-height:15px;
}
.btn_b {
    background-color: #1276BF;
    background-image: -moz-linear-gradient(center top , #1276BF, #006699);
    border: 1px solid #3C7BC4;
    border-radius: 2px 2px 2px 2px;
    color: white !important;
    cursor: pointer;
    padding: 4px 15px;
}
.mainmt{ background:url(../../images/cxbg.jpg) left top repeat-x;padding-top:8px; height:35px; margin:0; border-bottom:1px solid #dcdcdc;}
</style>
	</head>
	<body>
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm" >
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：
					<% String loct = request.getParameter("loct");
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="留言列表";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mainmt" >
					
						<p>请输入关键词	：<input name="" type="text"  size="30" id="title"/>	
							
						<a href="#" onclick="findList(1,0)"> <img
										style="vertical-align: middle;" src="<%=path%>/images/cx.gif"
										border="0" /> </a></p>
						<%--<input  type="button" class="btn_b" onclick="findList()" value="帖子查询"/>	
						--%>
						
							
				</div>
				<div class="mianmm">
					<table style="height: auto; border-bottom: none; margin-top: 6px">
						<tr style="height:25px;">
							<td colspan="5" 
								style="border: none; text-align: left; color: #324269;">
								<img src="<%=path%>/images/lbt.gif" />
								查询列表
								
							</td>
							<td colspan="2"
								style="border: none; text-align: right; padding-right: 8px;">
								<%--<a class="btn_1" href="<%=path%>/hsfs/guest/addGuest.jsp"> <span>发帖</span>
								</a>
								<a class="btn_2" onclick="window.location.reload()"
									href="javascript:void(0)"> <span>刷新</span> </a>
									
							--%>

								<img src="<%=path%>/images/tj.gif" />
								<a
									href="<%=path%>/hsfs/guest/addGuest.jsp">发帖</a>
								
							</td>
						</tr>
					</table>
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
		<%--
 	<span id="thinking"  style="display:none"></span>  
		<script type="text/javascript">
		setInterval("windows()",10000);
		</script>
		
	--%>
	</body>
</html>
