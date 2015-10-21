<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>

<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>中国中心组个体化药物治疗组网络平台</title>
		<script src="<%=path%>/js/jquery-1.4.4.js" type="text/javascript"></script>
			<script language="javascript" type="text/javascript"
			src="<%=path%>/js/doUtil.js"></script>

</head>

	<frameset id="attachucp" framespacing="0" border="0" frameborder="no"  rows="100,*,20">
<frame 	scrolling="no" noresize="" frameborder="no" name="topFrame" src="<%=path %>/hsfs/top.jsp">
<frame   marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" noresize scrolling="no" name="mainFrame" src="<%=path %>/hsfs/cont.jsp">
  <frame scrolling="no" noresize="" border="0" name="footFrame" src="<%=path %>/hsfs/foot.jsp">
</frameset>


  
  
  <noframes>

  </noframes>
</html>
