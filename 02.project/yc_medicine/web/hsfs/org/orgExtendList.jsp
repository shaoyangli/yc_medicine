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
		<title>ҽ�ƻ����˻�</title>
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
			tables += "<tr><th>��������</th><th>���</th><th>�ʺ�</th><th>����</th></tr>";
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
				tables +="</td><td><a href='<%=path%>/orgExtend_FindAccount.action?id=" + obj[2] + "&orgCode="+orgCode+"' style='color:#5d7bc7; text-decoration:none;'>�޸�</a></td></tr>";
			});
			tables += "</table>";
			//alert(tables);
			$("#accounts").empty();
			$("#accounts").append(tables);
			
		})

	}

	function checkAccount(obj) {
		if(/\D/.test(obj.value))
		  { // �������ж� ���Ϊfalse ps: /\D/ ��������
		 	alert("�����������֣�");
		 	obj.value="";
		 	obj.focus();
		 	return false;
		  }
	}
	//��֤���е�����
	function saveOrgExtend(){
		var account = $("#account").val();
		var orgCode = $("#jigou").val();
		var year = $("#buryear").val();
		//�ʺŲ���Ϊ��
		if(account.length == 0)
		{
			alert("�������ʺţ�")
			return false;
		}
		//�ʺ�ֻ����������
		

		data={	"orgExt.orgCode" : orgCode,
			  	"orgExt.burYear" : year,
				"orgExt.accountNumber" : account
			 };
		$.post("orgExtend_saveOrgExtends.action",data,
				function(json){
			if(json.result == 0)
			{
				alert("��ӳɹ�");
				//document.location.reload(true);
				$("#account").val("");
				findList();
			}
			if(json.result == 2)
			{
				alert("�û���������˻���Ϣ����ӣ�");
			}
			if(json.result == 1)
			{
				alert("ʧ��");
			}
			if(json.result == 3)
			{
				alert("���ʺű�Ļ����Ѿ�ʹ����������д");
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
					��ǰλ�ã�
					<% String loct = request.getParameter("loct");
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="ҽ�ƻ����˻�����";
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
									��ȣ�
								</td>
								<td>
									<input type="text" name="buryear" id="buryear" value="<%=Calendar.getInstance().get(Calendar.YEAR)%>" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate"/>
								</td>
								<td  class="tstd" >
									�ʺţ�
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
									�˻��б�
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
