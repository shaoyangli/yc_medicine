<%@ page language="java" import="com.kh.hsfs.model.*,com.kh.util.*" pageEncoding="gbk" %>
<%
	String path = request.getContextPath();
	HsfsUserInfo user = (HsfsUserInfo) session.getAttribute("user");
	int userCode = user.getUserCode();
	String userName = user.getUserName();
	String orgCode = user.getOrgCode();
	String userPwd = user.getUserPwd();
	String userLoginId = user.getUserLoginId();
	int role = user.getPowerRole();
	String handId = user.getHandId();
	String docId = user.getDocId();
	if(handId == null) {
		handId = "";
	}
	if(docId == null) {
		docId = "";
	}
	 String loct = request.getParameter("loct");
	 if(loct!=null){
		 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
		}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; gbk" />
		<title>�û������޸�</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<style type="text/css">
.search {
	font-family: "����";
	font-size: 12px;
	behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
	cursor: hand;
}
</style>
		<script type="text/javascript">

//����ҳ��			
function reset()
{
	document.location.reload(true);
}

function updateUser(){
	var org = "${user.orgCode}";
	var username = $("#userName").val();
	var loginId = $("#loginId").val();//ֱ��ȥ����¼���ŵ�id
	var password = $.trim($("#pwd").val());
	var repassword = $.trim($("#repwd").val());
	var role = $("#role").val();
	var userCode = '<%=userCode%>'
	//var handId = $("#hand_id").val();
	//var docId  = $("#doc_id").val();
	if($.trim(username).length == 0) {
		alert("�û�������Ϊ�գ�");
		$("#userName").val("");
		$("#userName").focus();
		return false;
	}
	if(password.length == 0) {
		alert("���벻��Ϊ�գ�");
		$("#pwd").val('');
		$("#pwd").focus();
		return false;
	}
	if(repassword.length == 0) {
		alert("�ظ����벻��Ϊ�գ�");
		$("#repwd").val('');
		$("#repwd").focus();
		return false;
	}
	if(password != repassword) {
		alert("�����������벻һ�£�")
		$("#pwd").val('');
		$("#repwd").val('');
		return false;
	}
	if(role == 0) {
		alert("��ɫ����Ϊ�գ�");
		return false;
	}
	data = {
		"user.userCode" : userCode,
		"user.userName" : username,
		"user.orgCode"	: org,
		"user.userPwd" 	: password,
		"user.userLoginId" : loginId,
		"user.powerRole" : role,
		//"user.handId"   : handId,
		//"user.docId"    :  docId,
		"user.isStop"   :  '0'
	};
	$.post("<%=path%>/orgUser!userUpdate.action",data,
		function(json) {
			var result = json.isSuccess;
			if(result == 0)
				{
					alert("�û��޸ĳɹ���");
					return false;
				}
			else {
				alert("�޸�ʧ��,���Ժ�....");
			}
		
		},'json');
	
}
function init() {
	findUserRole();

}
	//��ʼ����ɫѡ��,��ѡ��Ĭ��ֵ
function findUserRole(){
		$("#role").empty();
		$("#role").append("<option value = 0> --��ѡ��--</option>");
		$.post("orgUser!findAllUserRole.action",
		function(json){
			var result = json.list;
			var op;
			$.each(result,function(i, obj){
				op += "<option value='"+ obj[0]+"'>"+ obj[1]+ "</option>";
			});
			$("#role").append(op);
			var role = '<%=role%>';
			$("#role").val(role);
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
					��ǰλ�ã�<%=loct %>
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div class="mainmt">
						<table style="width: 50%;" id="aa" align="center">
							<tr>
								<td class="tstd">
									�û�����
								</td>
								<td>
									<input name="userName" type="text" id="userName" style="width:132px" value="<%=userName %>"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									��¼���ţ�
								</td>
								<td>
									<input name="loginId" type="text"  id="loginId" style="width:132px" value="<%=userLoginId%>" readonly="readonly" disabled="disabled" />
									<font color="red">*</font>
								</td>
							</tr>
							<tr>	
								<td class="tstd">
									���룺
								</td>
								<td>
									<input name="pwd" type="password" id="pwd" style="width:132px" value="<%=userPwd%>" onblur="checkObj(this)"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									ȷ�����룺
								</td>
								<td>
									<input type="password" id="repwd" name="repwd" style="width:132px" value="<%=userPwd%>" onblur="checkObj(this)"/> 
									
									<font color="red">*</font>
								</td>
								
							</tr>
							<tr>
								<td class="tstd">
									������ɫ��
								</td>
								<td>
									<select id="role" style="width: 135px;" disabled="disabled">
										
									</select>
									<font color="red">*</font>
								</td>
							</tr>
							
						</table>
						<div class="buut" style="padding-right: 200px;">
							<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/axg.jpg'"
								onmouseout="document.java.src='<%=path%>/images/xg.jpg'" onclick="updateUser()"> <img
									name="java" src="<%=path%>/images/xg.jpg" border="0"/>
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