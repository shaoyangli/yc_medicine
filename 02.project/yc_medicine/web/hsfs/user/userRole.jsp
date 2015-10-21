<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="gbk"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>用户角色管理</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js">
</script>
		<script language="javascript" type="text/javascript"
		src="<%=path%>/js/My97DatePicker/WdatePicker.js">
</script>
<script language="javascript" type="text/javascript"
		src="<%=path%>/js/jquery-1.4.4.js">
</script>
<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
<script type="text/javascript" src="<%=path%>/js/area_org.js"></script>
<style type="text/css">
	a{ color:#5d7bc7; text-decoration:none;}
</style>
<script type="text/javascript">
	function init(){
		findUserRole();
	}
	function findUserRole(){
		
		$.post("orgUser!findAllUserRole.action",
		function(json){
			var result = json.list;
			var tables = "<table align='center' style='width: 60%; margin-top:0; table-layout:fixed; border-top:0;'>";
			tables += "<tr><th>角色名称</th><th>修改</th><th>删除</th></tr>";
			$.each(result,function(i, obj){
				if(i%2==0){
			 		tables+="<tr class='tstr'>";
				}else{
					tables+="<tr >";
				}
				tables += "<td>"+ obj[1] + "</td><input type='hidden' id='"+obj[0]+"' value='"+obj[1]+"'><td><a href='javascript:void(0)' onclick='updateRole(\""+obj[0]+"\")'>修改</a></td><td><a href='javascript:void(0)' onclick='removeRole("+obj[0]+")'>删除</a></td>" ;
			});
			tables += "</table>";
			//alert(tables);
			$("#roles").empty();
			$("#roles").append(tables);
			
		})

	}

	//验证表单中的数据
	function saveUserRole(){
		var roleName = $.trim($("#userRole").val());
		var roleId = $("#rid").val();
		//帐号不能为空
		if(roleName.length == 0)
		{
			alert("角色名不能为空！");
			$("#userRole").focus();
			return false;
		}
		var data;
		if(roleId == 0) {
			data = {"userRole.roleName"	: roleName};
		}
		if(roleId > 0) {
			data = {"userRole.roleName"	: roleName,"userRole.roleCode" : roleId};
		}
		
		//帐号只能输入数字
		$.post("orgUser!saveUserRole.action",data,
				function(json){
			if(json.isSuccess == 0) {
				alert("操作成功！");
				$("#userRole").val('');
				$("#rid").val(0);
				findUserRole();
				return false;
			}
			if(json.isSuccess == 2){
				alert("角色名已经使用！");
				$("#userRole").val('');
				return false;
				
			}
			if(json.isSuccess == 1) {
				alert("未知错误,保存失败！");
				$("#rid").val(0);
			}
			
				
		})
	}
	function updateRole(roleId) {
		var roleName = $("#"+roleId).val();
		$("#rid").val(roleId);
		$("#userRole").val(roleName);
	}
	function removeRole(roleId) {
		confirm("确定删除该角色么？",function(){
			$.post("orgUser!removeRole.action?roleId="+roleId,
			function(json){
				var result = json.isSuccess;
				if(result == 0) {
					alert("该角色成功删除！");
					findUserRole();
					return false;
				}
				if(result == 2) {
					alert("角色已经分配权限不能删除！");
					return false;
				}
				if(result == 1) {
					alert("未知错误,请联系管理员！");
				}
		})
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
					当前位置：
					<% String loct = request.getParameter("loct");
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="用户角色管理";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
			<div class="mainmt">
				<div class="mianmm">
				
				<table align="center" style="width: 60%; border-bottom:0; margin-top:12px;table-layout: fixed">
							<tr>
								<td colspan="3" class="tstd" style="text-align: center;">
									用户角色管理
								</td>
							</tr>
							<tr>
								<td class="tstd" style="text-align: left;">
									角色名称：
								</td>
								<td>
									<input type="text"  id="userRole"/><!--  onblur="value=value.replace(/[^\u4E00-\u9FA5]/g,'')" -->
								</td>
								<td >
									<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
										onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="saveUserRole()"> 
										<img name="java" src="<%=path %>/images/abc.jpg" border="0"/>
									</a>
								</td>
							</tr>
							<tr>
								<td colspan="3"
									style="border: none; text-align: left; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									角色列表
									<input type="hidden" id="rid" value="0"/>
								</td>
								
							</tr>
				</table>
				
					<div id="roles">
				
					</div>
				</div>
					
				</div>
			</div>
			<div class="mainb">
				<div class="mainbl">
				</div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>

		</div>

	</body>
</html>
