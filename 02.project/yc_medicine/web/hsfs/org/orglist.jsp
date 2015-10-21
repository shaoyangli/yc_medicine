<%@ page language="java"  pageEncoding="gbk" import="com.kh.hsfs.model.*,com.kh.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	HsfsOrgBaseInfo org = (HsfsOrgBaseInfo)session.getAttribute("org");
	String areaid = RetrunAreaId.callAreaid(org);
	String currPage = request.getParameter("currPage");
	String totalPagesq = request.getParameter("totalPages");
	String xianoldValue = request.getParameter("xianoldValue");
	String xiangoldValue = request.getParameter("xiangoldValue");
	String cunoldValue = request.getParameter("cunoldValue");
	String flags = request.getParameter("flags");
	//System.out.println(flags+"---");
	String name = request.getParameter("orgName");
	if(name != null) {
		name = new String(name.getBytes("ISO-8859-1"),"gbk");
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>ҽ�ƻ�������</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet" type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/area.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/jquery.window.js"></script>
		<script type="text/javascript">
			
		var xianoldValue =  "<%=xianoldValue%>";
		var xiangoldValue = "<%=xiangoldValue%>";
		var cunoldValue ="<%=cunoldValue%>";
		var currPage = "<%=currPage%>";
		var totalPagesq ="<%=totalPagesq%>";
		var flags = "<%= flags%>";
		var name = "<%=name%>";
		plan.hidebreak();
	  function deleteOrg()//�����¼��ɾ��
      {	
		  	var currPage = $("#currPage1").val();
			var totalPages = $("#totalPages1").val();
			var url="org_removeOrg.action";
			delete_(url,currPage,totalPages);
      }
      function editorOrg()
      {
        var currPage = $("#currPage1").val();
		var totalPages = $("#totalPages1").val(); 
		var xian = $("#xianOldValue").val();
		var xiang = $("#xiangOldValue").val();
		var cun = $("#cunOldValue").val();
		var url = "org_findOneOrg.action?currPage=" + currPage + "&totalPages=" + totalPages ; 
		var n = $("#u").val();
		if(xian != "")
		{
			url += "&xianoldValue ="+xian;
		}
		if(xiang != "")
		{
			url += "&xiangoldValue ="+xiang;
		}
		if(cun != ""){
			url += "&cunoldValue ="+cun;
		}
		if(n.length > 0) {
			url += "&orgName="+n;
		}
		url += "&orgCode=";
		editor(url);
      }
     function init()
     {
 		//�����ص�Ԫ�ظ�ֵ,Ϊ��ѯ������Ĭ��ѡ��׼������
		if(xianoldValue != "0"&&xianoldValue!=""&&xianoldValue!='null')
		{
			$("#xianOldValue").val(xianoldValue);
		}
		if(xiangoldValue != "0"&&xiangoldValue!=""&&xiangoldValue!='null')
		{
			$("#xiangOldValue").val(xiangoldValue);
		}
		if(cunoldValue != "0"&&cunoldValue!=""&&cunoldValue!='null')
		{
			$("#cunOldValue").val(cunoldValue);
		}
		if(flags == "0")
		{
			$("#flags").val('0');//������Ԫ�ظ�ֵ0
		}
		systeminit("<%=path%>");
		findList(currPage,totalPagesq);
	 }

		//�������� ��ѯ ���� 
		function findList(currPage,totalPages)
		{
			
			//alert($("#flags").val());
			var flags = $("#flags").val();//�õ���־
			var xian = $("#xian").val();
			var xiang = $("#xiang").val();
			var cun = $("#cun").val();
			var param = "";
			//xianΪ��˵����һ�μ���ҳ��
			//if(xian == "null"||xian == null || xian == "")
			if(flags == "0")//��ʱΪ��һ�μ���ҳ��
			{
				//��ʱ����˵�����������
				if(xianoldValue == 'null' || xianoldValue == null || xianoldValue == "")
				{
					param += "<%=areaid%>";
					$("#flags").val('');
				}
				//��ʱ������Ƿ��ظ�ҳ������
				else
				{
					$("#orgName").val(name);
					//��
					if(xiangoldValue.length == 0 && cunoldValue.length == 0)
					{
						param += xianoldValue
					}
					//��,��
					if(cunoldValue.length == 0 && xiangoldValue.length > 0)
					{
						param = xianoldValue + xiangoldValue.substring(0,2);
					}
					//��,��,��ȫ��
					if(cunoldValue.length > 0)
					{
						param = xianoldValue + cunoldValue.substring(0,4);
					}
					$("#flags").val('');
				}
					
			}
			//�����ѯ���������
			else
			{
				//�����ص�Ԫ�ظ�ֵ,Ϊ�Ժ������ص�ʱ�򱣴��ѯ����
				<%-- 
				if(xian != ""&&xian != "null"&&xian != null)
				{
					$("#xianOldValue").val(xian);
				}
				if(xiang != ""&&xiang != "null"&&xiang != null)
				{ 
					$("#xiangOldValue").val(xiang);
				}
				if(cun != ""&&cun != "null"&&cun != null)
				{
					$("#cunOldValue").val(cun);
				}
				--%>
				$("#xianOldValue").val(xian);
				$("#xiangOldValue").val(xiang);
				$("#cunOldValue").val(cun);
				//�����������Ϣ���ݲ�ѯ����
				if(xiang.length == 0 && cun.length == 0)
				{
					param += xian
				}
				if(cun.length == 0 && xiang.length > 0)
				{
					param = xian + xiang.substring(0,2);
				}
				if(cun.length > 0)
				{
					param = xian + cun.substring(0,4);
				}
			}
			
			var data;
			var orgName = $.trim($("#orgName").val());//ȥ���ո�
			if(orgName.length > 0)
			{
				data = {"param" : param,"orgName" : orgName};
				
			}
			else 
			{
				data = {"param" : param};
			}
			$("#u").val(orgName);
			plan.show();
			
			$.post("<%=path%>/org_findOrg.action?currPage="+currPage+"&totalPages="+totalPages,data,
					function(json)
					{
						
						var page = json.findOrgResult;
						var list = page.list;
						//var forms  ="";//��ҳ��
						//����һ��table �����������ݵ�
						var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>"
						//�˴�tablesƴ������hidden  ���浱ǰҲ����ҳ�� Ϊ��ɾ����ʱ����
						tables +="<th><input type='checkbox' onclick='allCheck(this)'/></th><th>��������</th><th>��������</th><th>������ַ</th><th>��������</th><th>��������</th><th>��������</th><th>ũ�ϻ�������</th><th>�ϼ�����</th><th>�������</th><th>���˴���</th><th>��ϵ�绰<input type='hidden' id='currPage1' value='"+ page.currPage +"'/><input type='hidden' id='totalPages1' value='"+ page.totalPages +"'/></th><th>��Ӧ��������</th></tr>";
                        var trs="";
						 $.each(list,function(i, obj) //�Դ�action��ȡһ��json���б�������
						{
						 	if(i%2==0){
						 		trs+="<tr class='tstr'>";
							}else{
								trs+="<tr >";
							}
						 	if(obj[2] == null) {
						 		obj[2] = "";
						 	}
						 	if(obj[3] == null) {
						 		obj[3] = "";
						 	}
						 	if(obj[4] == null) {
						 		obj[4] = "";
						 	}
						 	if(obj[5] == null) {
						 		obj[5] = "";
						 	}
						 	if(obj[6] == null) {
						 		obj[6] = "";
						 	}
						 	if(obj[7] == null) {
						 		obj[7] = "";
						 	}
						 	if(obj[8] == null) {
						 		obj[8] = "";
						 	}
						 	if(obj[9] == null) {
						 		obj[9] = "";
						 	}
						 	if(obj[10] == null) {
						 		obj[10] = "";
						 	}if(obj[11] == null) {
						 		obj[11] = "";
						 	}
						 	trs += "<td><input name='count' id='count' type='checkbox' value='"+ obj[1]+"' onchange='addCount(this,this.value)'/></td><td>"+obj[0]+"</td><td>"+obj[1]+"</td><td>"+obj[2]+"</td><td>"+obj[3]+"</td><td>"+ obj[11] +"</td><td>"+obj[4]+"</td><td>"+obj[5]+"</td><td>"+obj[6]+"</td><td>"+obj[7]+"</td><td>"+obj[8]+"</td><td>"+obj[9]+"</td><td>"+obj[10]+"</td></tr>";
                        });
	                    if(trs==""){
	                    	trs+="<tr ><td colspan='13' align='center'>��������</td></tr>";
		                }
	                    tables +=trs+"</table>";
						plan.hidden(page,tables);
				}

			)
		}

		function checkOrgName(t)
		{   //5.9 gcl  ��֤����ȥ��
			//if (t.value != t.value.replace(/[^\u4E00-\u9FA5]/g,'')){
			//	   alert("��������");
			//	   t.value = "";
			//	   t.focus();
			//	}
			t.value=trim(t.value);		//ȥ���ո�		
		}
		//$(document).ready(function() {
	//	});
</script>
	</head>
	<body onload="init();">
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					��ǰλ�ã�ҽ�ƻ�������
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mainmt" style="height:35px;">						
						<p>
							<select id="sheng" name="sheng" style="display: none;"></select>
							<select id="shi" name="shi" style="display: none;"></select>
							��(��)��
							<select name="xian" id="xian" style="width:100px;" onchange="xianselect()"></select>
							��(�򡢽ֵ�)��
							<select name="xiang" id="xiang" style="width:100px;" onchange="xiangselect()"></select>
							��(��ί��)��
							<select name="cun" id="cun" style="width:100px;"></select>
							�������ƣ�
							<input type="text" name="orgName" id="orgName" style="width: 100px;" onblur="checkOrgName(this)"/>
							<a href="javascript:void(0)" onclick="findList(1,0)"> <img
										style="vertical-align: middle;" src="<%=path%>/images/cx.jpg"
										border="0" /> </a>
						</p>
					</div>
				<div class="mianmm">
				<input type="hidden" id="xianOldValue"/>
				<input type="hidden" id="xiangOldValue"  />
				<input type="hidden" id="cunOldValue"/>
				<input id="arrayid" name="arrayid"  type="hidden" />
				<input id="u" type="hidden"/>
				<input id ="flags"  type="hidden"/> 
						<table id="mytable">
							<tr>
								<td colspan="5"
									style="border: none; text-align: left; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									��ѯ�б�
								</td>
								<td colspan="5"
									style="border: none; text-align: right; padding-right: 8px;">
									<img src="<%=path%>/images/tj.gif" />
									<a href="<%=path%>/hsfs/org/orgadd.jsp">����</a>
									<img src="<%=path%>/images/xg.gif" />
									<a href="javascript:editorOrg()">�༭</a>
									<img src="<%=path%>/images/sc.gif" />
									<a href="javascript:deleteOrg()">ɾ��</a>
									
								</td>
							</tr>
							</table>
							<!-- ���ز��� ��ʼ -->
							<div id="pagelist" style="margin:0 auto;" class="fakeContainer">
          					</div>
							<div id="pagelist1">
							</div>
							<!-- ���ز��ֽ��� -->
				</div>
			</div>
			<div class="mainb">
				<div class="mainbl"></div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>
		</div>
	
	</body>
</html>
