<%@ page language="java" import="com.kh.hsfs.model.*,com.kh.util.*" pageEncoding="gbk" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; gbk" />
		<title>用户更新</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		
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

//重载页面			
function reset()
{
	document.location.reload(true);
}

function updateUser(){
	var org = "${user.orgCode}";
	var username = $("#userName").val();
	var loginId = $("#loginId").val();//直接去掉登录工号的id
	var password = $.trim($("#pwd").val());
	var repassword = $.trim($("#repwd").val());
	var role = $("#role").val();
	var userCode = ${user.userCode};
	//var handId = $("#hand_id").val();
	//var docId  = $("#doc_id").val();
	if($.trim(username).length == 0) {
		alert("用户名不能为空！");
		$("#userName").val("");
		$("#userName").focus();
		return false;
	}
	if(password.length == 0) {
		alert("密码不能为空！");
		$("#pwd").val('');
		$("#pwd").focus();
		return false;
	}
	if(repassword.length == 0) {
		alert("重复密码不能为空！");
		$("#repwd").val('');
		$("#repwd").focus();
		return false;
	}
	if(password != repassword) {
		alert("两次输入密码不一致！")
		$("#pwd").val('');
		$("#repwd").val('');
		return false;
	}
	if(role == 0) {
		alert("角色不能为空！");
		return false;
	}
	data = {
		"user.userCode" : userCode,
		"user.userName" : username,
		"user.orgCode"	: org,
		"user.userPwd" 	: password,
		"user.userLoginId" : loginId,
		"user.powerRole" : role,
	//	"user.handId"   : handId,
	//	"user.docId"    :  docId,
		"user.isStop"   :  '0'
	};
	$.post("<%=path%>/orgUser!userUpdate.action",data,
		function(json) {
			var result = json.isSuccess;
			if(result == 0)
				{
					alert("用户修改成功！");
					return false;
				}
			else {
				alert("修改失败,请稍后....");
			}
		
		},'json');
	
}
//初始化角色选项,并选中默认值
function findUserRole(){
		$("#role").empty();
		$("#role").append("<option value = 0> --请选择--</option>");
		$.post("orgUser!findAllUserRole.action",null,
		function(json){
			var result = json.list;
			var op;
			$.each(result,function(i, obj){
				op += "<option value='"+ obj[0]+"'>"+ obj[1]+ "</option>";
			});
			$("#role").append(op);
			var role = ${user.powerRole};
			$("#role").val(role);
		});
		
	}
function init() {
	findUserRole();

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
					当前位置：用户信息修改
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div class="mainmt">
						<table style="width: 50%;" id="aa" align="center">
							<tr>
								<td class="tstd">
									用户名：
								</td>
								<td>
									<input name="userName" type="text" id="userName" style="width:132px" value="${user.userName}"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									登录工号：
								</td>
								<td>
									<input name="loginId" type="text"  id="loginId" style="width:132px" value="${user.userLoginId}" readonly="readonly" disabled="disabled" />
									<font color="red">*</font>
								</td>
							</tr>
							<tr>	
								<td class="tstd">
									密码：
								</td>
								<td>
									<input name="pwd" type="password" id="pwd" style="width:132px" value="${user.userPwd}" onblur="checkObj(this)"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									确认密码：
								</td>
								<td>
									<input type="password" id="repwd" name="repwd" style="width:132px" value="${user.userPwd}" onblur="checkObj(this)"/> 
									
									<font color="red">*</font>
								</td>
								
							</tr>
							<tr>
								<td class="tstd">
									所属角色：
								</td>
								<td>
									<select id="role" style="width: 135px;" disabled="disabled">
										
									</select>
									<font color="red">*</font>
								</td>
							</tr>
							<%-- <tr>
								<td class="tstd">
									手持机SN号：
								</td>
								<td>
									<input type="text" style="width: 135px;" readonly disabled="disabled" id="hand_id" value="${user.handId}"/>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									医生工号：
								</td>
								<td>
									<input type="text" style="width: 135px;" id="doc_id" value="${user.docId}"/>
								</td>
							</tr> --%>
							
						</table>
						<div class="buut">
							<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/axg.jpg'"
								onmouseout="document.java.src='<%=path %>/images/xg.jpg'" onclick="updateUser()"> <img
									name="java" src="<%=path %>/images/xg.jpg" border="0"/>
							</a>
							<a href="<%=path%>/hsfs/user/userList.jsp?currPage=<s:property value='currPage'/>&totalPages=<s:property value='totalPages'/>&xianoldValue=<s:property value='xianoldValue'/>&xiangoldValue=<s:property value='xiangoldValue'/>&cunoldValue=<s:property value='cunoldValue'/>&username=<s:property value="username"/>&flags=0"  onmouseover="document.java12.src='<%=path%>/images/fh.jpg'"
								onmouseout="document.java12.src='<%=path%>/images/afh.jpg'">
								<img name="java12" src="<%=path%>/images/afh.jpg" border="0"/>
							</a>
						</div>
				</div>
				<!---nr end------------------------->
			</div>
			<div class="mainb">
				<div class="mainbl"></div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>
		</div>
	</body>
</html>