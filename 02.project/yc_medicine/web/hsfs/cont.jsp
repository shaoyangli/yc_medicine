<%@ page language="java" pageEncoding="gbk"%>
<%@page import="java.util.Calendar"%>
<%
String path = request.getContextPath();
String year=(String)session.getAttribute("year");
%>
<!DOCTYPE HTML >
<html>
<head>
<link href="../css/windows.css" rel="stylesheet" type="text/css" />
<script src="<%=path%>/js/jquery-1.4.4.js" type="text/javascript"></script>
			<script language="javascript" type="text/javascript"
			src="<%=path%>/js/doUtil.js"></script>
				<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
<script type="text/javascript">
 function checkYear(){
	var year=$("#year option:selected").val();
	if(year=='<%=year%>'){
		alert("本年度不可切换!");
		return false;
	}
	$.getJSON("<%=path%>/offerAction!checkSession.action?year="+year,
					function (json){
					   var result =json.result;
					   if(result==1){
						   //alert("年度切换成功");
						  // history.go(-0); 
						 // $("#center").hide();
						// window.parent.frames["mainFrame"][0][2].location.href="list.jsp";
						  window.parent.frames["topFrame"].location.href="top.jsp";
						  window.parent.frames["mainFrame"].location.href="cont.jsp";
						   }
					},'json')
   
}
 function loginOut(msg){
        if(msg==1){
        	msg="确定要切换用户吗？";
        }else{
        	msg="确定要退出系统吗？";
        }
        confirm(msg,function(){
        	window.parent.location='<%=path %>/user!userExit.action'; 
        	
        })
			
}
</script>
<style type="text/css">
body, html {
height:100%;
 font-size: 12px;
}
</style>
</head>
 <body >
 <div style="height: 100%;width: 100%">
		 <iframe name="mainmain" id="mainmain" src="<%=path %>/hsfs/cont_main.jsp" width="100%" height=100%  marginheight="0" marginwidth="0" frameborder="0" ></iframe>
		</div>
  	 <div class="window" id="center" > 
<div id="title" class="title">年度切换<span id="close"  style="margin-left: 165px;line-height:auto;color:red;font-size:14px;font-weight:bold;text-align:center;cursor:pointer;overflow:hidden;">×</span></div> 
<div class="content" >
<select style="margin: 5px;" id="year" name="year">
											<option
												value="<%=Calendar.getInstance().get(Calendar.YEAR) - 3%>">
												&nbsp;&nbsp;&nbsp;<%=Calendar.getInstance().get(Calendar.YEAR) - 3%>年
											</option>
											<option
												value="<%=Calendar.getInstance().get(Calendar.YEAR) - 2%>">
												&nbsp;&nbsp;&nbsp;<%=Calendar.getInstance().get(Calendar.YEAR) - 2%>年
											</option>
											<option
												value="<%=Calendar.getInstance().get(Calendar.YEAR) - 1%>">
												&nbsp;&nbsp;&nbsp;<%=Calendar.getInstance().get(Calendar.YEAR) - 1%>年
											</option>
											<option
												value="<%=Calendar.getInstance().get(Calendar.YEAR)%>"
												selected="selected">
												&nbsp;&nbsp;&nbsp;<%=Calendar.getInstance().get(Calendar.YEAR)%>年
											</option>
											<option
												value="<%=Calendar.getInstance().get(Calendar.YEAR) + 1%>">
												&nbsp;&nbsp;&nbsp;<%=Calendar.getInstance().get(Calendar.YEAR) + 1%>年
											</option>
										</select>
										<input type="button" value="切换" style="width: 45px;height: 25px;" onclick="checkYear()"/>

</div> 
		</div>
		
		 </body>
</html>