<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="gbk"%>

<%
	String path = request.getContextPath();
	HsfsOrgBaseInfo org = (HsfsOrgBaseInfo)session.getAttribute("org");
	String orgName = org.getOrgName();
	String orgCode = org.getOrgCode();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>医疗机构账户</title>
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
<script type="text/javascript">
	function init(){
		findList();
	}
	function findList(){
		
		var orgCode = "<%=orgCode%>";
		var data = {"orgCode" : orgCode};
		$.post("orgExtend_findOrgAccounts.action",data,
		function(json){
			var result = json.list;
			var tables = "<table align='center' style='width: 90%; margin-top:0; table-layout:fixed; border-top:0;'>";
			tables += "<tr><th>机构名称</th><th>年度</th><th>帐号</th><th>操作</th></tr>";
			$.each(result,function(i, obj){
				if(i%2==0){
			 		tables+="<tr class='tstr'>";
				}else{
					tables+="<tr >";
				}
				tables += "<td>";
				tables +='<%=orgName%>';
				tables +="</td><td>"+obj[0];
				tables +="</td><td>"+obj[1];
				tables +="</td><td><a href='<%=path%>/orgExtend_FindAccount.action?id=" + obj[2] + "&orgCode="+orgCode+"' style='color:#5d7bc7; text-decoration:none;'>修改</a></td></tr>";
			});
			tables += "</table>";
			//alert(tables);
			$("#accounts").empty();
			$("#accounts").append(tables);
			
		})

	}

	function checkAccount(obj) {
		if(/\D/.test(obj.value))
		  { // 用正则判断 如果为false ps: /\D/ 是正则表达
		 	alert("必须输入数字！");
		 	obj.value="";
		 	obj.focus();
		 	return false;
		  }
	}
	//验证表单中的数据
	function saveOrgExtend(){
		var account = $("#account").val();
		var orgCode = $("#jigou").val();
		var year = $("#buryear").val();
		//帐号不能为空
		if(account.length == 0)
		{
			alert("请输入帐号！")
			return false;
		}
		//帐号只能输入数字
		

		data={	"orgExt.orgCode" : orgCode,
			  	"orgExt.burYear" : year,
				"orgExt.accountNumber" : account
			 };
		$.post("orgExtend_saveOrgExtends.action",data,
				function(json){
			if(json.result == 0)
			{
				alert("添加成功");
				//document.location.reload(true);
				$("#account").val("");
				findList();
			}
			if(json.result == 2)
			{
				alert("该机构本年度账户信息已添加！");
			}
			if(json.result == 1)
			{
				alert("失败");
			}
			if(json.result == 3)
			{
				alert("该帐号别的机构已经使用请重新填写");
				$("#account").val("");
				$("#account").focus();
			}

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
							loct="医疗机构账户设置";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
			<div class="mainmt">
				<div class="mianmm">
				
				<table align="center" style="width: 90%; border-bottom:0; margin-top:12px; table-layout: fixed;">
							<tr>
								<td class="tstd" >
									年度：
								</td>
								<td>
									<input type="text" name="buryear" id="buryear" value="<%=Calendar.getInstance().get(Calendar.YEAR)%>" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate"/>
								</td>
								<td  class="tstd" >
									帐号：
								</td>
								<td>
									<input type="text" id="account" onblur="checkAccount(this)"/>
									<input type="hidden" name="jigou" id="jigou" value="<%=orgCode %>"/>
								</td>
								<td>
									<a href="#" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
										onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="return saveOrgExtend();"> 
										<img name="java" src="<%=path %>/images/abc.jpg" border="0"/>
									</a>
								</td>
							</tr>
							<tr>
								<td colspan="5" 
									style="border: none; text-align: left; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									账户列表
								</td>
							</tr>
				</table>
				
				<div id="accounts">
				
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
