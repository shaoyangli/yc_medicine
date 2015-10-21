<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>公告发布</title>
		<link href="<%=path %>/css/grxx.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path %>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<style type="text/css">
.search {
	font-family: "宋体";
	font-size: 12px;
	behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
	cursor: hand;
}
</style>
	<script type="text/javascript">
		function goback() {
			var flag = '${flag}';
			var currPage = '${currPage}';
			var totalPages = '${totalPages}';
			var url;
			if(flag == '2') {
				url = "<%=path%>/hsfs/notice/noticeManage.jsp?currPage=" + currPage + "&totalPages=" + totalPages;
			}
			else {
				url = "<%=path%>/hsfs/notice/noticeList.jsp?currPage=" + currPage + "&totalPages=" + totalPages;
			}
			location.href= url;
		}
		
function init() {
	var id = $("#noticeId").val();
	$.post("notices!markReaded.action?id="+id,
	  function(json)
	  {
		var m = json.isSuccess;
		if(m == 0) {
			window.parent.frames.parent.parent[0].location.href="<%=path%>/hsfs/top.jsp";
		}
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
					当前位置：公告内容
				</div>
			</div>

			<div class="mianm">
				<div align="center">
					<h6><font style="text-align: center; font-size: 20px;"><s:property value="notice.title"/></font></h6><br/>
					<s:property value="notice.date"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<s:property value="notice.sendPerson"/><br/>
					<s:property value="notice.content" escape="false"/><br/>
					
					
				</div>
				<div style=" background:none; " class="mainmt">
					
						<div class="buut" style="float: clear">
							<a href="javascript:void(0)" onmouseover="document.jav.src='<%=path%>/images/fh.jpg'"
								onmouseout="document.jav.src='<%=path %>/images/afh.jpg'" onclick="return goback();"> <img
									name="jav" src="<%=path %>/images/afh.jpg" border="0"/>
									<input type="hidden" id="noticeId" value='<s:property value="notice.id"/>'/>
							</a>
						</div>
						
				</div>
				
			</div>
			<div class="mainb">
				<div class="mainbl"></div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>
		</div>
	</body>
</html>