<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>菜单修改</title>
		<link href="<%=path %>/css/grxx.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path %>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/area_org.js"></script>
		<script type="text/javascript" src="<%=path%>/js/orgServ.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/My97DatePicker/WdatePicker.js">
		</script>
		<style type="text/css">
.search {
	font-family: "宋体";
	font-size: 12px;
	behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
	cursor: hand;
}
</style>
<script type="text/javascript">
function checkAccount(obj) {
	if(/\D/.test(obj.value))
	  { // 用正则判断 如果为false ps: /\D/ 是正则表达
	 	alert("必须输入数字！");
	 	obj.value="";
	 	obj.focus();
	 	return false;
	  }
}
//帐号修改
function updateMenu(){
	var powerId = ${power.powerId};
	var powerName = $("#powerName").val();
	var powerUrl = $("#powerUrl").val();
	var fatherid = $("#fatherMenu").val();
	var orderId = $("#orderId").val();
	
	if(powerName.length == 0)
	{
		alert("权限名不能为空,请重新输入！");
		$("#powerName").focus();
		return false;
	}
	data = 
	{
		"power.powerId"	 :	powerId,
		"power.powerName": 	powerName,
		"power.powerUrl" :	powerUrl ,
		"power.fatherId" :	fatherid,
		"power.orderId"	 : 	orderId
	};
	$.post("<%=path%>/orgUser!updatePower.action" ,data,
		function(json) {
		 var result = json.isSuccess;
		 if(result == 0) {
			 alert("菜单信息更新成功！")
			 return false;
		 }
		 if(result == 1) {
			 alert("更新失败！");
		 }
		})	
	
}
function goback(){
	url = "<%=path%>/hsfs/user/userPower.jsp" ;
	location.href = url;
}
$(document).ready(function(){
	initFatherMenu();
})

	//父菜单下拉初始化
	function initFatherMenu() {
		$("#fatherMenu").empty();
		$("#fatherMenu").append("<option value = '0'>--请选择--</option>")
		$.post("<%=path%>/orgUser!findAllFatherMenu.action",
			function(json) {
				var op = json.list;
				var options= "";
				for(var i=0;i<op.length;i++) {
					options += "<option value='" + op[i][0] + "'>" + op[i][1] + "</option>";
				}
				$("#fatherMenu").append(options);
				//然后给父菜单选中
				var fatherId = ${power.fatherId};
				var count=$("#fatherMenu option").length;
				var fatherMenu = $("#fatherMenu ").get(0);
				for(var i=0;i<count;i++)  
				{           
					if(fatherMenu.options[i].value == fatherId)  
					{  
						fatherMenu.options[i].selected = true;  
						break;  
					}  
				}
			}
		)
	}

</script>
	</head>
	<body>
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：菜单修改
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div style=" background:none; " class="mainmt">
					<table style="width: 50%;" id="aa" align="center">
						<tr>
							<td class="tstd">
								菜单名称：
							</td>
							<td>
								<input type="text" value="${power.powerName}" id="powerName"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								菜单链接：
							</td>
							<td>
								<input type="text" value="${power.powerUrl}" id="powerUrl"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								父菜单：	
							</td>
							<td>
								<select style="width:132px;" id="fatherMenu">
									<option value="0">--请选择--</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								序列号：	
							</td>
							<td>
								<input type="text" value="${power.orderId}" id="orderId"/>
							</td>
						</tr>
						</table>
						<div class="buut">
							<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/axg.jpg'"
								onmouseout="document.java.src='<%=path %>/images/xg.jpg'" onclick="return updateMenu();"> <img
									name="java" src="<%=path %>/images/xg.jpg" border="0"/>
							</a>
							<a href='javascript:void(0)' onclick="goback()" onmouseover="document.java12.src='<%=path%>/images/fh.jpg'"
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