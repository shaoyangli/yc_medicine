<%@ page language="java" pageEncoding="gbk"%>
<%@page import="java.util.Calendar"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<frameset id="aattachucp" framespacing="0" border="0" frameborder="no" cols="218,8,*">
 
<frame scrolling="no" noresize="" frameborder="no" name="leftFrame" src="<%=path %>/user!left.action">
<frame  scrolling="no" noresize="" name="switchFrame" src="<%=path %>/hsfs/swich.html">

<frame id="leftbar" scrolling="auto" noresize="" name="listFrame" src="<%=path %>/hsfs/list.jsp">

</frameset>
  <noframes></noframes>

</html>