<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="gbk"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String currPage = request.getParameter("currPage");
String totalPages = request.getParameter("totalPages");
if(currPage == null) {
	currPage = 1 + "";
}
if(totalPages == null) {
	totalPages = 0 + "";
}
HsfsUserInfo  user=(HsfsUserInfo)session.getAttribute("user");
String loginid = user.getUserLoginId();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>查看公告</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js">
		</script>
		<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet" type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"> </script>
		<script language="javascript" type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"> </script>
 		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script type="text/javascript" src="<%=path%>/js/area_org.js"> </script>
		<style type="text/css">
	a{ color:#5d7bc7; text-decoration:none;}
</style>
<script type="text/javascript">
var currPage = '<%=currPage%>';
var totalPages = '<%=totalPages%>';
	function init(){
		findList(currPage,totalPages);
		$.post("notices!checkNewNotice.action?loginid=<%=loginid%>",
			function(json){
				var count = json.isSuccess;
				if(count > 0) {
					window.parent.frames.parent.parent[0].location.href="<%=path%>/hsfs/top.jsp";
				}
			})
		
	}
	function checkNotice(id) {
		var currPage = $("#currPage1").val();
		var totalPages = $("#totalPages1").val();
		var url = "notices!findOneNotice.action?id="+ id + "&flag=3&currPage="+currPage + "&totalPages=" + totalPages;
		location.href = url;
	}
	function findList(currPage,totalPages){
		
		data =  {
					"currPage" : currPage,
					"totalPages" : totalPages
				};
		plan.show();
		$.post("notices!findAllNotice.action",data,
		function(json){
			var page = json.result;
			var list = page.list;
			var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>";
			tables += "<th >标题</th><th>发布人</th><th>发布时间</th><th>查看公告内容</th><input type='hidden' id='currPage1' value='"+ page.currPage +"'/><input type='hidden' id='totalPages1' value='"+ page.totalPages +"'/></tr>";
			var trs = "";
			$.each(list,function(i, obj){
				if(i%2==0){
			 		trs+="<tr class='tstr'>";
				}else{
					trs+="<tr >";
				}
				if(obj[1].length > 16) {
					obj[1] = obj[1].substr(0,16);
				}
				trs += "<td ><a  href='javascript:void(0)' onclick='checkNotice("+ obj[0]+")'>";
				if(obj[5] == 0) {
					trs += "<img src='<%=path%>/images/ggk.gif' />&nbsp<strong>" +obj[1] + "</strong>";
				}
				if(obj[5] == 1) {
					trs += "<img src='<%=path%>/images/ggg.gif' />&nbsp" + obj[1];
				}
				trs+= "</a></td><td >"+obj[4]+ "</td><td >"+obj[3]+"</td><td><a href='javascript:void(0)' onclick='checkNotice(" + obj[0] + ")'>查看</a></td></tr>";
			});
			if(trs==""){
	        	trs+="<tr ><td colspan='10' align='center'>暂无数据</td></tr>";
		    }
			tables += trs + "</table>";
			
			plan.hidden2(page,tables);
		})
	}

	

</script>
	</head>
	<body onload="init();">
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：
					<% String loct = request.getParameter("loct");
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="公告查看 ";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mianmm">
				
						<table id="mytable">
							<tr>
								<td
									style="border: none; text-align: center; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									公告列表
								</td>
							</tr>
							</table>
					<!-- 隐藏部分 开始 -->
							<div id="pagelist" style="margin:0 auto;" class="fakeContainer">
          					</div>
          					<div id="pagelist1">
							</div>
					<!-- 隐藏部分结束 -->
				</div>
					
			</div>
			<div class="mainb">
				<div class="mainbl">
				</div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>

		</div>

	</body>
</html>
