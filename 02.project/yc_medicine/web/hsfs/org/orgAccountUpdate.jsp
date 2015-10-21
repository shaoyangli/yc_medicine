<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
HsfsOrgBaseInfo orgBaseInfo = (HsfsOrgBaseInfo)session.getAttribute("org");
String orgName = orgBaseInfo.getOrgName();
String orgCode = orgBaseInfo.getOrgCode();


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>医疗机构账户修改</title>
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
function updateOrgAccount(){
	var account = $("#account").val();
	var orgCode = $("#jigou").val();
	var year = $("#buryear").val();
	var id = ${orgExt.id};
	var oldAccountNUmber = ${orgExt.accountNumber};
	//帐号不能为空
	if(account.length == 0)
	{
		alert("请输入帐号！")
		return false;
	}
	//帐号只能输入数字
	data={	
			"orgExt.id"		 : 	id,
			"orgExt.orgCode" : orgCode,
		  	"orgExt.burYear" : year,
			"orgExt.accountNumber" : account,
			"oldAccountNUmber" : oldAccountNUmber
		 };
	$.post("orgExtend_orgAccountUpdate.action",data,
			function(json){
		var isSuccess = json.isSuccess;
		if(isSuccess == 0)
		{
			alert("修改成功");
			alertOpage("修改成功！","<%=path%>/hsfs/org/orgExtendList.jsp")
			return false;
		}
		if(isSuccess == 2) {
			alert("该帐号别的机构已经使用,请重新填写！");
			$("#account").val(oldAccountNUmber);
			return false;
		}
		if(isSuccess == 1)
		{
			alert("帐号已经使用禁止修改！");
			$("#account").val(oldAccountNUmber);
			return false;
		}
		if(isSuccess == 3) {
			alert("未知错误,请联系管理员！");
			$("#account").val(oldAccountNUmber);
		}

	})
}
function goback(){
	url = "<%=path%>/hsfs/org/orgExtendList.jsp?orgCode=<%=orgCode%>" ;
	location.href = url;
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
					当前位置：医疗机构账户修改 >> <%=orgName %>
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div style=" background:none; " class="mainmt">
					<table style="width: 50%;" id="aa" align="center">
						<tr>
							<td class="tstd">
								机构：
							</td>
							<td>
								<input type="text" value="<%=orgName %>" readonly="readonly" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								年  度：
							</td>
							<td>
								<input type="text" value="${orgExt.burYear }" readonly="readonly" id="buryear" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								帐号：	
							</td>
							<td>
								<input type="text" id="account" onblur="checkAccount(this)" value="${orgExt.accountNumber}"/>
								<!-- 完成用户登录以后修改 -->
								<input type="hidden" name="jigou" id="jigou" value="${orgExt.orgCode}"/>
							</td>
						</tr>
						</table>
						<div class="buut">
							<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/axg.jpg'"
								onmouseout="document.java.src='<%=path %>/images/xg.jpg'" onclick="return updateOrgAccount();"> <img
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