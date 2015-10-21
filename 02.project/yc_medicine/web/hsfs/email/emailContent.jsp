<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>邮件内容</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
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
span {
   color:#9399A7;
}
td{
padding:4px;
margin:0px;
border:0px;
} 
.tdss{
  width:100px;
}
.tdtt{
  width:950px;
}
</style>
	<script type="text/javascript">
		function goback() {
			var flag = '${flag}';
			var currPage = '${currPage}';
			var totalPages = '${totalPages}';
			var url;
			if(flag == '2') {
				url = "<%=path%>/hsfs/email/emailManage.jsp?currPage=" + currPage + "&totalPages=" + totalPages;
			}
			else {
				url = "<%=path%>/hsfs/email/emailList.jsp?currPage=" + currPage + "&totalPages=" + totalPages;
			}
			location.href= url;
		}
		
function init() {
	var id = $("#emailId").val();
	$.post("emailAction!markReaded.action?id="+id,
	  function(json)
	  {
		var m = json.isSuccess;
		if(m == 0) {
			window.parent.frames.parent.parent[0].location.href="<%=path%>/hsfs/top.jsp";
		}
	  })
}
function checkDownload(id){
    	//orgService.action?fileId=${st.id}
		$.post("emailAction!checkFileExist.action?id="+id,
			function(json){
				var result = json.isSuccess;
				if(result == 1){
					alert("下载的文件不存在,请联系管理员！")
					return false;
				}
				else {
					 window.location.href="emailAction!downFile.action?id ="+id;
				}
			}
		)
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
					当前位置：邮件内容
				</div>
			</div>

			<div class="mianm">
				<div style="width: 85%">
					<table align="left" style="margin-left: 5px;" >
						<tr >
							<td class="tdss">
								<span>邮件主题  ：</span>
							</td>
							<td class="tdtt">
								<span  ><strong><s:property value="email.title"/></strong></span>
								
							</td>
						</tr>
						<tr>
							<td class="tdss">
							  <span>发件人名 ：</span>
							</td>
							<td class="tdtt">
								<span><s:property value="email.sendperson"/></span>
							</td>
						</tr>
						<tr>
							<td class="tdss">
								<span >发送时间 ：</span>
							</td>
							<td class="tdtt">
								<span ><s:property value="email.senddate"/></span>
							</td>
						</tr>
						<tr >
							<td class="tdss">
								<span>接收人名 ：</span>
							</td>
							<td class="tdtt">
								<span><s:property value="email.receivename"/></span>
							</td>
						</tr>
						<s:if test="email.isf == 1">
						<tr>
							<td class="tdss">
								<span>所有附件 ：</span>
							</td>
							<td class="tdtt">
								<s:iterator value="files" id="st">
									<a href="javascript:checkDownload(<s:property value="#st.id"/>)"><strong><s:property value="#st.fileName"/></strong></a>;
								</s:iterator>
							</td>
						
						</tr>
						
						</s:if>

					</table>
				</div>
				
				<div style="width: 85%">
					<table align="left" style="margin-left: 5px;">
						<tr>
							<td class="tdss">
								邮件内容 ：
							</td>
							<td class="tdtt">
								<s:property value="email.content" escape="false"/>
							</td>
						</tr>
					</table>
				</div>
				<div align="right" style="margin-right: 10px;">
					<a href="javascript:void(0)" onmouseover="document.jav.src='<%=path%>/images/fh.jpg'"
								onmouseout="document.jav.src='<%=path %>/images/afh.jpg'" onclick="return goback();"> <img
									name="jav" src="<%=path %>/images/afh.jpg" border="0"/>
									<input type="hidden" id="emailId" value='<s:property value="email.id"/>'/>
					</a>
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