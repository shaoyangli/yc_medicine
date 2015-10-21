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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>发件箱</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js">
</script>
<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet" type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript"
		src="<%=path%>/js/My97DatePicker/WdatePicker.js">
</script>
<script language="javascript" type="text/javascript"
		src="<%=path%>/js/jquery-1.4.4.js">
</script>
<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script type="text/javascript" src="<%=path%>/js/area_org.js">
</script>
<style type="text/css">
	a{ color:#5d7bc7; text-decoration:none;}
</style>
<script type="text/javascript">
var currPage = '<%=currPage%>';
var totalPages = '<%=totalPages%>';
	function init(){
		findList(currPage,totalPages);
	}
	function checkEmail(id) {
		var currPage = $("#currPage1").val();
		var totalPages = $("#totalPages1").val();
		var url = "emailAction!findOneEmail.action?id="+ id + "&currPage="+currPage + "&totalPages=" + totalPages;
		location.href = url;
	}
	
	function deleteEmail() {
		var currPage = $("#currPage1").val();
		var totalPages = $("#totalPages1").val();
		var url = "emailAction!removeFromSended.action";
		delete_(url,currPage,totalPages);
	}
	function findList(currPage,totalPages){
		
		data =  {
					"currPage" : currPage,
					"totalPages" : totalPages
				};
		plan.show();
		$.post("emailAction!findSendedEmails.action",data,
		function(json){
			var page = json.result;
			var list = page.list;
			var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>";
			tables += "<th><input type='checkbox' onclick='allCheck(this)'/></th><th >标题</th><th>接收人</th><th>发送日期</th><th>查看邮件内容</th><input type='hidden' id='currPage1' value='"+ page.currPage +"'/><input type='hidden' id='totalPages1' value='"+ page.totalPages +"'/></tr>";
			var trs = "";
			$.each(list,function(i, obj){
				if(i%2==0){
			 		trs+="<tr class='tstr'>";
				}else{
					trs+="<tr >";
				}
				if(obj[1].length > 12) {
					obj[1] = obj[1].substr(0,12);
				}
				if(obj[3].length > 40) {
					obj[3] = obj[3].substr(0,40) + "..."
				}
				trs += "<td><input name='count' id='count' type='checkbox' value='"+ obj[0]+"' onchange='addCount(this,this.value)'/></td><td ><a  href='javascript:void(0)' onclick='checkEmail(" + obj[0] + ")'><img src='<%=path%>/images/yjf.png' />&nbsp"+ obj[1] + "</a></td><td>"+obj[3]+"</td><td>"+obj[2]+ "</td><td><a href='javascript:void(0)' onclick='checkEmail("+obj[0]+")'>查看邮件</a></td></tr>";
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
							loct="发件箱";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mianmm">
				
				<table id="mytable">
							<tr>
								<td
									style="border: none; text-align: left; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									发送邮件列表
								</td>
									<td colspan="5" style="text-align: right;">
									<img src="<%=path%>/images/sc.gif" />
									<a href="javascript:deleteEmail()">删除&nbsp;</a>
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
					<input id="arrayid" name="arrayid"  type="hidden" />
				</div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>

		</div>

	</body>
</html>
