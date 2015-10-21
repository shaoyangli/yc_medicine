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
		<title>用户管理</title>
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
 function deleteUser(userid)//处理记录的删除
 {	
	 var currPage = $("#currPage1").val();
		var totalPages = $("#totalPages1").val();
	 confirm('你确定要删除吗？', 
	function () {
	  	$.post("<%=path%>/orgUser!removeUser.action?roleId=" +userid,
		   function(json){
			  if(json.isSuccess == 0) {
				  //alert("用户删除成功...");
				 // findList(2);
				  alertFind("用户删除成功！",currPage,totalPages)
			  }
			  else {
				  alert("删除失败！");
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
			$("#flags").val('0');//给隐藏元素赋值0
		}
		findList(currPage,totalPagesq);
}
          
		//根据条件 查询 机构 
		function findList(currPage,totalPages)
		{
			var flags = $("#flags").val();//得到标志
			var param = "";
			var username = $.trim($("#username").val());//判断模糊查询条件
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
						//var forms  ="";//翻页表单
						//定义一个table 放入数据内容的
						var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>";
						//此处tables拼上两个hidden  保存当前也和总页码 为了删除的时候获得
						tables +="<th>用户名</th><th>登录工号</th><th>登录密码</th><th>角色信息</th><th>管辖机构</th><th>修改</th><th>删除<input type='hidden' id='currPage1' value='"+ page.currPage +"'/><input type='hidden' id='totalPages1' value='"+ page.totalPages +"'/></th><th>账户停用</th>";
                        var trs="";
						 $.each(list,function(i, obj) //对从action获取一个json进行遍历操作
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
						 		+"'>启用/<a href='javascript:void(0)' onclick='kt("+obj[0]+","+(i+1)+","+obj[8]+")'>停用</a></td>";
						 	}
						 	if(obj[8] == 1) {
						 		c+= "<td id='id"
						 		 +(i+1)+"'><a href='javascript:void(0)' onclick='kt("+obj[0]+","+(i+1)+","+obj[8]+")'>启用</a>/停用</td>";
						 	}
						 	trs += "<td>"+obj[1]+"</td><td>"+obj[2]+"</td><td>"+obj[3]+"</td><td>"+obj[4]+"<td> " +obj[5]+"</td><td><a href='javascript:void(0)' onclick='updateUser("+obj[0]+")' >修改<a></td><td><a href='javascript:void(0)' onclick='return deleteUser("+ obj[0] +")'>删除</a></td>"+c+"</tr>";
						});
	                    if(trs==""){
	                    	trs+="<tr ><td colspan='10' align='center'>暂无数据</td></tr>";
		                }
	                    tables +=trs+"</table>";
	                    
	                    plan.hidden2(page,tables);
				}

			)
		}
		//控制账户停用启用
        function kt(id,rows,state){
        	var ca="";
        	var st = "";
        	var message = "";
        	if(state == 1) {
        	st = '0';
        	message += "确定启用账户么?";
			ca+= "<td border=0 id='id" 
			+rows
			+"'>启用/<a href='javascript:void(0)' onclick='kt("+id+","+rows+","+0+")'>停用</a></td>";
			}
			if(state == 0) {
			st = '1';
			message += "确定停用账户么?";
			ca+= "<td border=0 id='id"
			+rows+"'><a href='javascript:void(0)' onclick='kt("+id+","+rows+","+1+")'>启用</a>/停用</td>";
			}
			confirm(message,function(){
				$.post("<%=path%>/orgUser!updateState.action?msg="+st+"&id="+id,
        		function(json){
        			var r = json.isSuccess;
        			if(r > 0) {
        				alert("用户状态修改成功！")
        				document.getElementById("id"+rows).innerHTML = ca;
        			}
        			else {
        				alert("状态修改失败！");
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
							loct="用户管理";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mainmt" style="height:35px;">						
						 <p>
							
							用户名：
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
									查询列表
								</td>
							</tr>
							</table>
							
							<input id ="flags"  type="hidden"/>
							<input id="u" type="hidden"/>
							<!-- 隐藏部分 开始 -->
							<div id="pagelist" style="margin:0 auto;" class="fakeContainer">
          					</div>
          					<div id="pagelist1">
							</div>
							<!-- 隐藏部分结束 -->
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
