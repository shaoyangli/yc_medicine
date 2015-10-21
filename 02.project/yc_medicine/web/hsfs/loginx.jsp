<%@page import="java.util.Date"%>
<%@ page language="java" pageEncoding="gbk"%>
<%@page import="java.util.Calendar"%>
<%
String path = request.getContextPath();
String pda_sn=request.getParameter("pda_sn");
String year = Calendar.getInstance().get(Calendar.YEAR)+"";
String authkey=request.getParameter("authkey");
%>
<!DOCTYPE HTML >
<html>
<head>
<link href="../css/windows.css" rel="stylesheet" type="text/css" />
<script src="<%=path%>/js/jquery-1.4.4.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	var pda_sn='<%=pda_sn%>';
	var authkey='<%=authkey%>';
	if (pda_sn=='null'||authkey=='null'||authkey.length<1||pda_sn.length<1) location.href="<%=path%>/hsfs/userLogin.jsp";
	var url = "<%=path%>/user!userLoginx.action?timestamp="
		+ new Date().getTime();
var data = {
	"pda_sn" :pda_sn,
	"year":'<%=year%>',
	"authkey":authkey,
};
$.post(url, data, function(json) {   
	var result = json.isSuccess;
	if(result == 0) {
		location.href = "<%=path%>/hsfs/manage.jsp";
	}else if(result == 1){
		location.href="<%=path%>/hsfs/userLogin.jsp";
	}else if(result == 2){
		location.href="<%=path%>/hsfs/userLogin.jsp";
	}
 },'json')
});
</script>
<style type="text/css">
body,html {
	height: 100%;
	font-size: 12px;
}
</style>
</head>
<body>


</body>
</html>