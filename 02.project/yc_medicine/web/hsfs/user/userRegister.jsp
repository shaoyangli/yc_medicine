<%@ page language="java" import="com.kh.hsfs.model.*,com.kh.util.*" pageEncoding="gbk" %>
<%
	String path = request.getContextPath();
	String area = (String)application.getAttribute("Address");
	//String year = (String)session.getAttribute("year");
	//System.out.println(year);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; gbk" />
		<title>�û����</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/area.js"></script>
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
		
function init(){
	var area = "<%=area%>";
	systeminit("<%=path%>");
	findOrg(area,3);
	findUserRole();
}
function emptySelect(){
	$("#org").empty();
	$("#org").append("<option value='0'>--��ѡ��--</option>");
}          
		
function xiangselect1() {
		xiangselect();
		emptySelect();
		var xiang = $("#xiang").val();
		var area = '<%=area%>';//��ѯ������ʱ����Ҫ���ݵĲ���
		var param;
		if(xiang.length > 0){
			param = area + xiang.substring(0,2);
			findOrg(param,2);
		}
		else {
			findOrg(area,3);
		}
}
           
function cunselect1() {
	emptySelect();
	var area = '<%=area%>';//��ѯ������ʱ����Ҫ���ݵĲ���
	var xiang = $("#xiang").val();
	var cun = $("#cun").val();
	var param;
	if(cun.length > 0) {
		param = area + cun.substring(0,4);
		findOrg(param,1);
	}
	else {
		param = area + xiang.substring(0,2);
		findOrg(param,2);
	}
}
//����������Ϣ��ѯ����
function findOrg(area,level)
{
	var data = {"area" : area,"orgLevel" : level};
	$.post("<%=path%>/orgUser!findOrgs.action",data,
		function(json)
		{
			var result = json.list;
			var options = "";
			for(var i = 0;i<result.length;i++){
				options += "<option value='" + result[i][0] + "'>" + result[i][1] + "</option>"
			}
			$("#org").append(options);
		});
}
//��ʼ����ɫѡ��
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
			
		})
	}
//����ҳ��			
function resets()
{
	$("#loginId").val('');
	$("#userName").val('');
	$("#pwd").val('');
	$("#repwd").val('');
	$("#hand_id").val('');
	findUserRole();
}
//����¼�����Ƿ��Ѿ�ʹ��
function checkLoginId(obj) {
	var loginId = $.trim(obj.value);
	
	if(!/^[0-9a-z]*$/i.test(obj.value)) {
		alert("ֻ��������ĸ����");
	     obj.value = '';
	     obj.focus();
	     return false;
	}
	$.post("<%=path%>/orgUser!checkLoginId.action?loginId="+loginId,
		function(json){
			var result = json.isSuccess;
			if(result == 1) {
				alert("�ù����Ѿ�ʹ��,���������룡");
				obj.value = "";
	 			obj.focus();
			}
		},"json")
}
function register(){
	var org = 'D001';
	var username = $("#userName").val();
	var loginId = $.trim($("#loginId").val());//ֱ��ȥ����¼���ŵ�id
	var password = $.trim($("#pwd").val());
	var repassword = $.trim($("#repwd").val());
	var role = $("#role").val();
	var handId = $("#hand_id").val();
	var docId = $("#doc_id").val();
//	if(org == 0) {
//		alert("��ѡ���Ͻ������");
//		return false;
//	}
	if($.trim(username).length == 0) {
		alert("�û�������Ϊ�գ�");
		$("#userName").val("");
		$("#userName").focus();
		return false;
	}
	if(loginId.length == 0) {
		alert("��¼���Ų���Ϊ�գ�");
		$("#loginId").val("");
		$("#loginId").focus();
		return false;
	}
	if(loginId.length < 6) {
		alert("���������6λ��");
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
		alert("ѡ���û�������ɫ��");
		return false;
	}
	data = {
		"user.userName" : username,
		"user.orgCode"	: org,
		"user.userPwd" 	: password,
		"user.userLoginId" : loginId,
		"user.powerRole" : role,
		"user.handId"    : handId,
		"user.docId"	:  docId,
		"user.isStop"   :  '0'
	};
	$.post("<%=path%>/orgUser!saveUser.action",data,
		function(json) {
			var result = json.isSuccess;
			if(result == 0)
				{
				
					alert("�û�ע��ɹ���");
					resets();
				}
			else {
				alert("ע��ʧ��,���Ժ�....");
			}
		
		},"json"	
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
					��ǰλ�ã����û�ע��
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div class="mainmt">
						<table>
							<%--<tr>--%>
								<%--<td class="tstd">--%>
									<%--�������ڵ�����--%>
								<%--</td>--%>
								<%--<td>--%>
									<%--<select id="sheng" name="sheng" style="display: none;"></select>--%>
									<%--<select id="shi" name="shi" style="display: none;"></select>--%>
									<%--<select name="xian" id="xian" style="width:135px" onchange="xianselect1()" ></select>--%>
									<%--�أ�����--%>
									<%--<select name="xiang" id="xiang" style="width:120px" onchange="xiangselect1()"></select>--%>
									<%--�磨�򡢽ֵ���--%>
									<%--<select name="cun" id="cun" style="width:120px" onchange="cunselect1()"></select>--%>
									<%--�壨��ί�ᣩ--%>
								<%--</td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td class="tstd">--%>
									<%--��Ͻҽ�ƻ�����--%>
								<%--</td>--%>
								<%--<td>--%>
									<%--<select name="org" id="org" style="width:135px">--%>
										<%--<option value="0">--��ѡ��--</option>--%>
									<%--</select>--%>
									<%--<font color="red">*</font>--%>
								<%--</td>--%>
								<%----%>
							<%--</tr>	--%>
							<tr>
								<td class="tstd">
									�û�����
								</td>
								<td>
									<input name="userName" type="text" id="userName" style="width:132px"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									��¼���ţ�
								</td>
								<td>
									<input name="loginId" type="text"  id="loginId" style="width:132px" onblur="checkLoginId(this)"/>
									<font color="red">* ������ĸ�������</font>
								</td>
							</tr>
							<tr>	
								<td class="tstd">
									���룺
								</td>
								<td>
									<input name="pwd" type="password" id="pwd" style="width:132px" onblur="checkObj(this)"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									ȷ�����룺
								</td>
								<td>
									<input type="password" id="repwd" name="repwd" style="width:132px" onblur="checkObj(this)"/> 
									
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									������ɫ��
								</td>
								<td>
									<select id="role" style="width: 135px;">
										
									</select>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									�ֳֻ�SN�ţ�
								</td>
								<td>
									<input type="text" style="width: 132px;" id="hand_id"/>
								</td>
							</tr>
							<%--<tr>--%>
								<%--<td class="tstd">--%>
									<%--ҽ�����ţ�--%>
								<%--</td>--%>
								<%--<td>--%>
									<%--<input type="text" style="width: 132px;" id="doc_id"/>--%>
									<%--<font color="red">*��Ӧ����ƽ̨��¼����</font>--%>
								<%--</td>--%>
							<%--</tr>--%>
						</table>
						<div class="buut">
							
							<a href="javascript:void(0)"  onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
								onclick="return register();" onmouseout="document.java.src='<%=path%>/images/abc.jpg'">
								<img name="java" src="<%=path%>/images/abc.jpg" border="0"/>
							</a>
							<a href="javascript:void(0)" onmouseover="document.jav.src='<%=path%>/images/qk.jpg'"
								onmouseout="document.jav.src='<%=path%>/images/aqk.jpg'" onclick="return resets();" style="text-align: right;"> <img
									name="jav" src="<%=path%>/images/aqk.jpg" border="0"/> 
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