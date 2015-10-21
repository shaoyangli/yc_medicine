<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="gbk"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>权限管理</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/My97DatePicker/WdatePicker.js">
		</script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/jquery-1.4.4.js">
		</script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script type="text/javascript" src="<%=path%>/js/area_org.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<style type="text/css">
	a{ color:#5d7bc7; text-decoration:none;}
</style>
<script type="text/javascript">
	function init(){
		findUserPower();
		initFatherMenu();
	}
	function findUserPower(){
		
		$.post("orgUser!findAllUserPower.action",
		function(json){
			var result = json.list;
			var tables = "<table align='center' style='width: 98%; margin-top:0;  border-top:0;'>";
			tables += "<tr><th>序号</th><th>菜单名称</th><th>菜单链接</th><th>父菜单名称</th><th>修改</th><th>删除</th></tr>";
			$.each(result,function(i, obj){
				if(obj[2] == null) {
					obj[2] = "";
				}
				if(obj[3] == null) {
					obj[3] = "";
				}
				if(i%2==0){
			 		tables+="<tr class='tstr'>";
				}else{
					tables+="<tr >";
				}
				tables += "<td>"+ obj[0] +"</td><td>"+ obj[1] + " </td><td>"+ obj[2]+ 
				"</td><td>"+ obj[3]+"<td><a href='orgUser!findOnePower.action?powerID="+obj[4]+"'>修改</a></td><td><a href='javascript:void(0)' onclick='removePower("+obj[4]+");'>删除</a></td>" ;
			});
			tables += "</table>";
			//alert(tables);
			$("#powers").empty();
			$("#powers").append(tables);
			
		})

	}

	//验证表单中的数据
	function saveUserPower(){
		var powerName = $("#powerName").val();
		var powerUrl = $("#powerUrl").val();
		var fatherid = $("#fatherMenu").val();
		var orderId  = $("#orderId").val();
		//帐号不能为空
		if(powerName.length == 0)
		{
			alert("权限名不能为空,请重新输入");
			$("#powerName").focus();
			return false;
		}
		
		data = {"power.powerName"	: powerName,"power.powerUrl" : powerUrl ,"power.fatherId" : fatherid,"power.orderId" : orderId};
		//帐号只能输入数字
		$.post("orgUser!saveUserPower.action",data,
				function(json){
			if(json.isSuccess == 0) {
				alert("菜单添加成功！");
				$("#powerName").val('');
				$("#powerUrl").val('');
				$("#fatherMenu").val('0');
				$("#orderId").val('');
				findUserPower();//查询出所有的菜单
				if(fatherid == 0) {
					initFatherMenu();//重新给一级菜单下拉赋值
				}
			}
			else {
				alert("添加失败！");
			}
				
		})
	}
	
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
			}
		)
	}
	
	function removePower(pId) {
		confirm("确定删除此菜单么？",function() {
			$.post("orgUser!removePower.action?powerID="+pId,
		 	function(json) {
			var result =json.isSuccess;
			if(result == 0) {
				alert("菜单删除成功！");
				init();
				return false;
			}
			if(result == 1) {
				alert("删除失败！");
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
							loct="菜单管理";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
			<div class="mainmt">
				<div class="mianmm" >
				<div>
				<table align="center" width="94%">
							<tr>
								<td colspan="5" class="tstd" style="text-align: center;">
									用户权限管理
								</td>
							</tr>
							<tr>
								<td class="tstd" >
									菜单名称：
								</td>
								<td>
									<input type="text"  id="powerName" onblur="value=value.replace(/[^\u4E00-\u9FA5]/g,'')"/>
								</td>
								<td class="tstd">
									菜单链接：
								</td>
								<td>
									<input type="text" id="powerUrl" size="25"/>
								</td>
								<td rowspan="2">
									<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
										onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="return saveUserPower();"> 
										<img name="java" src="<%=path %>/images/abc.jpg" border="0"/>
									</a>
								</td>
							</tr>
							<tr>	
								
								<td class="tstd">
									序号：
								</td>
								<td>
									<input type="text" id="orderId"/>
								</td>
								<td class="tstd">
									父菜单名称：
								</td>
								<td>
									<select id="fatherMenu" style="width: 160px;">
										
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="5" 
									style="border: none; text-align: left; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									菜单列表
								</td>
							</tr>
				</table>
				</div>
				<div id="powers" >
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
