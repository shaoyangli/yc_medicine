<%@ page language="java"  pageEncoding="gbk" import="com.kh.hsfs.model.*,com.kh.util.*"%>
<%
	String path = request.getContextPath();

	String currPage = request.getParameter("currPage");
	String totalPagesq = request.getParameter("totalPages");
	String flags = request.getParameter("flags");
	String name = request.getParameter("username");
	if(name != null) {
		name = new String(name.getBytes("ISO-8859-1"),"gbk");
	}
	if(currPage==null||currPage.equals("null")){
		currPage="1";
	}
	if(totalPagesq==null||totalPagesq.equals("null")){
		totalPagesq="1";
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>�û�����</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet" type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
<script type="text/javascript">
var currPage = "<%=currPage%>";
var totalPagesq ="<%=totalPagesq%>";
var flags = "<%= flags%>";
var names="<%=name%>"
		plan.hidebreak();
 function deleteUser(userid)//�����¼��ɾ��
 {	
	 var currPage = $("#currPage1").val();
		var totalPages = $("#totalPages1").val();
	 confirm('��ȷ��Ҫɾ����', 
	function () {
	  	$.post("<%=path%>/orgUser!removeUser.action?roleId=" +userid,
		   function(json){
			  if(json.isSuccess == 0) {
				  //alert("�û�ɾ���ɹ�...");
				 // findList(2);
				  alertFind("�û�ɾ���ɹ���",currPage,totalPages)
			  }
			  else {
				  alert("ɾ��ʧ�ܣ�");
			  }
		   })
	});
}
   function updateUser(id) {
	   var url = 'orgUser!findUser.action?roleId='+ id ;
	    var currPage = $("#currPage1").val();
		var totalPages = $("#totalPages1").val(); 
		
		var username = $("#u").val();
		url += "&currPage="+currPage + "&totalPages=" + totalPages;
		
		if(username.length > 0) {
			url +="&username=" + username;
		}
		location.href = url;
   }
function init(){
	
		if(flags == "0")
		{
			$("#flags").val('0');//������Ԫ�ظ�ֵ0
		}
		findList(currPage,totalPagesq);
}
          
		//�������� ��ѯ ���� 
		function findList(currPage,totalPages)
		{
			var flags = $("#flags").val();//�õ���־
			var param = "";
			var username = $.trim($("#username").val());//�ж�ģ����ѯ����
			var data =
				{
					"param" : param,
					"currPage" : currPage,
					"totalPages" : totalPages,
					"username"	: username
				};
			
			$("#u").val(username);
			plan.show();
			$.post("<%=path%>/orgUser!findUserList.action",data,
					function(json)
					{
						var page = json.findOrgResult;
						var list = page.list;
						//var forms  ="";//��ҳ��
						//����һ��table �����������ݵ�
						var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>";
						//�˴�tablesƴ������hidden  ���浱ǰҲ����ҳ�� Ϊ��ɾ����ʱ����
						tables +="<th>�û���</th><th>��¼����</th><th>��¼����</th><th>��ɫ��Ϣ</th><th>��Ͻ����</th><th>�޸�</th><th>ɾ��<input type='hidden' id='currPage1' value='"+ page.currPage +"'/><input type='hidden' id='totalPages1' value='"+ page.totalPages +"'/></th><th>�˻�ͣ��</th>";
                        var trs="";
						 $.each(list,function(i, obj) //�Դ�action��ȡһ��json���б�������
						{
						 	var c = "";
							 if(i%2==0){
						 		trs+="<tr class='tstr'>";
							}else{
								trs+="<tr >";
							}
						 	
						 	if(obj[8] == 0) {
						 		c+= "<td id='id" 
						 		+(i+1)
						 		+"'>����/<a href='javascript:void(0)' onclick='kt("+obj[0]+","+(i+1)+","+obj[8]+")'>ͣ��</a></td>";
						 	}
						 	if(obj[8] == 1) {
						 		c+= "<td id='id"
						 		 +(i+1)+"'><a href='javascript:void(0)' onclick='kt("+obj[0]+","+(i+1)+","+obj[8]+")'>����</a>/ͣ��</td>";
						 	}
						 	trs += "<td>"+obj[1]+"</td><td>"+obj[2]+"</td><td>"+obj[3]+"</td><td>"+obj[4]+"<td> " +obj[5]+"</td><td><a href='javascript:void(0)' onclick='updateUser("+obj[0]+")' >�޸�<a></td><td><a href='javascript:void(0)' onclick='return deleteUser("+ obj[0] +")'>ɾ��</a></td>"+c+"</tr>";
						});
	                    if(trs==""){
	                    	trs+="<tr ><td colspan='10' align='center'>��������</td></tr>";
		                }
	                    tables +=trs+"</table>";
	                    
	                    plan.hidden2(page,tables);
				}

			)
		}
		//�����˻�ͣ������
        function kt(id,rows,state){
        	var ca="";
        	var st = "";
        	var message = "";
        	if(state == 1) {
        	st = '0';
        	message += "ȷ�������˻�ô?";
			ca+= "<td border=0 id='id" 
			+rows
			+"'>����/<a href='javascript:void(0)' onclick='kt("+id+","+rows+","+0+")'>ͣ��</a></td>";
			}
			if(state == 0) {
			st = '1';
			message += "ȷ��ͣ���˻�ô?";
			ca+= "<td border=0 id='id"
			+rows+"'><a href='javascript:void(0)' onclick='kt("+id+","+rows+","+1+")'>����</a>/ͣ��</td>";
			}
			confirm(message,function(){
				$.post("<%=path%>/orgUser!updateState.action?msg="+st+"&id="+id,
        		function(json){
        			var r = json.isSuccess;
        			if(r > 0) {
        				alert("�û�״̬�޸ĳɹ���")
        				document.getElementById("id"+rows).innerHTML = ca;
        			}
        			else {
        				alert("״̬�޸�ʧ�ܣ�");
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
							loct="�û�����";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mainmt" style="height:35px;">						
						 <p>
							
							�û�����
							<input name="username" id="username" style="width: 100px;"/>
							<a href="javascript:void(0)" onclick="findList(1,0)" > <img
										style="vertical-align: middle;" src="<%=path%>/images/cx2.gif"
										border="0" /> </a>
						</p>
					</div>
				<div class="mianmm">
						<table id="mytable">
							<tr>
								<td
									style="border: none; text-align: left; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									��ѯ�б�
								</td>
							</tr>
							</table>
							
							<input id ="flags"  type="hidden"/>
							<input id="u" type="hidden"/>
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
