<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>����ҳ��</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div align="center" style="font-size: 15px;">���½......<a href="#" onclick="javascript:window.close()">�ر�</a></div>
    <div align="center" style="font-size: 12px;margin-top: 50px"><table align="center" >
    <tr><td style="font-size: 12px;color: #0000ff">������ʾ��</td></tr>
    <tr><td style="font-size: 12px;color: #0000ff" align="left">1.����������������session����Ϊ�ա�</td></tr>
    <tr><td style="font-size: 12px;color: #0000ff" align="left">2.����ʱ��������������޷���Ӧ��</td></tr>
    <tr><td style="font-size: 12px;color: #0000ff" align="left">3.�ͻ���IE�������⣬�����Լ��ĵ��ԡ�</td></tr>
    </table></div>
  </body>
</html>
