<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="gbk"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Ȩ�޹���</title>
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
			tables += "<tr><th>���</th><th>�˵�����</th><th>�˵�����</th><th>���˵�����</th><th>�޸�</th><th>ɾ��</th></tr>";
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
				"</td><td>"+ obj[3]+"<td><a href='orgUser!findOnePower.action?powerID="+obj[4]+"'>�޸�</a></td><td><a href='javascript:void(0)' onclick='removePower("+obj[4]+");'>ɾ��</a></td>" ;
			});
			tables += "</table>";
			//alert(tables);
			$("#powers").empty();
			$("#powers").append(tables);
			
		})

	}

	//��֤���е�����
	function saveUserPower(){
		var powerName = $("#powerName").val();
		var powerUrl = $("#powerUrl").val();
		var fatherid = $("#fatherMenu").val();
		var orderId  = $("#orderId").val();
		//�ʺŲ���Ϊ��
		if(powerName.length == 0)
		{
			alert("Ȩ��������Ϊ��,����������");
			$("#powerName").focus();
			return false;
		}
		
		data = {"power.powerName"	: powerName,"power.powerUrl" : powerUrl ,"power.fatherId" : fatherid,"power.orderId" : orderId};
		//�ʺ�ֻ����������
		$.post("orgUser!saveUserPower.action",data,
				function(json){
			if(json.isSuccess == 0) {
				alert("�˵���ӳɹ���");
				$("#powerName").val('');
				$("#powerUrl").val('');
				$("#fatherMenu").val('0');
				$("#orderId").val('');
				findUserPower();//��ѯ�����еĲ˵�
				if(fatherid == 0) {
					initFatherMenu();//���¸�һ���˵�������ֵ
				}
			}
			else {
				alert("���ʧ�ܣ�");
			}
				
		})
	}
	
	//���˵�������ʼ��
	function initFatherMenu() {
		$("#fatherMenu").empty();
		$("#fatherMenu").append("<option value = '0'>--��ѡ��--</option>")
		
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
		confirm("ȷ��ɾ���˲˵�ô��",function() {
			$.post("orgUser!removePower.action?powerID="+pId,
		 	function(json) {
			var result =json.isSuccess;
			if(result == 0) {
				alert("�˵�ɾ���ɹ���");
				init();
				return false;
			}
			if(result == 1) {
				alert("ɾ��ʧ�ܣ�");
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
					��ǰλ�ã�
					<% String loct = request.getParameter("loct");
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="�˵�����";
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
									�û�Ȩ�޹���
								</td>
							</tr>
							<tr>
								<td class="tstd" >
									�˵����ƣ�
								</td>
								<td>
									<input type="text"  id="powerName" onblur="value=value.replace(/[^\u4E00-\u9FA5]/g,'')"/>
								</td>
								<td class="tstd">
									�˵����ӣ�
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
									��ţ�
								</td>
								<td>
									<input type="text" id="orderId"/>
								</td>
								<td class="tstd">
									���˵����ƣ�
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
									�˵��б�
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
