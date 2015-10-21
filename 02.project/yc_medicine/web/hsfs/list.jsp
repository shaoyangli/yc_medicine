<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*"
	pageEncoding="utf-8"%>

<%
	String path = request.getContextPath();
	String year = (String) session.getAttribute("year");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<link href="../css/main.css" rel="stylesheet" type="text/css" />
<link href="../css/windows.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="../js/zdc.js"></script>
<script src="<%=path%>/js/jquery-1.4.4.js" type="text/javascript">
		</script>
<script type="text/javascript" src="<%=path%>/js/js/line.js">
		</script>
<script src="<%=path%>/js/js/highcharts.js" type="text/javascript">
		</script>
<script type="text/javascript" src="<%=path%>/js/exporting.src.js">
		</script>
<%--<script language="javascript" type="text/javascript"
			src="<%=path%>/js/jquery.window.js">
		</script>
		--%>
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/doUtil.js">
		</script>
<script language="javascript" type="text/javascript">

</script>
</head>
<body>
	<!---main begin------------------------->
	<div class="main" id="backgroundPopup">
		<div class="maint">
			<div class="maintl"></div>
			<div class="maintm">
				<img src="../images/tb1.jpg" /> 当前位置：系统首页
			</div>
			<div class="maintr"></div>
		</div>

		<div class="mianm">
			
			
			<div id="container5"
				style="width: 95%; float: left; margin-top: 8px; margin-left: 12px;"></div>
			<br />
			

			<div id="container2"
				style="width: 95%; float: left; margin-top: 8px; margin-left: 12px;"></div>
			<%--<div id="container4"
				style="width: 95%; float: left; margin-top: 8px; margin-left: 12px;"></div>
			--%><div class="clear"></div>
		</div>
		<div class="mainb">
			<div class="mainbl"></div>
			<div class="mainbm"></div>
			<div class="mainbr"></div>
		</div>
	</div>
	<div class="window" id="center" style="display: none;">
		<div id="title" class="title">
			工作提示 <span id="close"
				style="margin-left: 165px;line-height:auto;color:red;font-size:14px;font-weight:bold;text-align:center;cursor:pointer;overflow:hidden;">×</span>
		</div>
		<div class="content" id="content"></div>
	</div>
</body>
</html>