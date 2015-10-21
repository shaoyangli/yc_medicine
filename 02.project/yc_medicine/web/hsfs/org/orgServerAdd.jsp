<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.kh.util.DicUtil"%>
<%@page import="com.kh.hsfs.model.HsfsOrgBaseInfo"%>
<%@page import="com.kh.hsfs.model.HsfsUserInfo"%>
<%
String path = request.getContextPath();
String temp_str=DicUtil.maxDate().toString();
String orgCode = "";
String orgName = "";
String userName = "";
String year = (String)request.getSession().getAttribute("year");
if(session != null) {
	HsfsOrgBaseInfo orginfo=(HsfsOrgBaseInfo)session.getAttribute("org");
	HsfsUserInfo user = (HsfsUserInfo)session.getAttribute("user");
	orgCode=orginfo.getOrgCode();
	orgName=orginfo.getOrgName();
	userName = user.getUserName();
}
String nowTime = temp_str;// 构造成当前时间
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>医疗机构服务记录添加</title>
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
		<script type="text/javascript" src="<%=path%>/js/uploadFile.js"></script>
		<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="<%=path%>/js/limitLength.js"></script>
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
<style type="text/css">
	a{ color:#5d7bc7; text-decoration:none;}
</style>
<script type="text/javascript">
 
function init()
{
	var saveResult = "${saveResult}";
	if(saveResult == 1)
	{
		alert("服务记录上传成功！");
	}
	initServiceType();//服务类型初始化
}
<%--
//根据系统时间初始化年度
function initYear()
{
	 var year=<%=Calendar.getInstance().get(Calendar.YEAR) %>
	 var count=$("#buryear option").length;
		var yearValue = $("#buryear ").get(0);
		for(var i=0;i<count;i++)  
	     {           
		     if(yearValue.options[i].value == year)  
	        {  
	    	 yearValue.options[i].selected = true;  
	            break;  
	        }  
	     }
}
--%>

function checkFiles(obj) {
	var extend = obj.value.substring(obj.value.lastIndexOf(".")+1).toLowerCase();    
	if(extend==""){    
	}
	else
	{ 
		 //doc docx,ppt pptx,xls,xlsx,wps,et,dps,pdf,txt,jpg,jpeg,gif,png   
		if(!(extend=="doc"||extend=="docx"||extend=="ppt"||extend=="pptx"||extend=="xls"||extend=="xlsx"||extend=="wps"||extend=="et"|| extend=="dps"|| extend=="pdf"|| extend=="txt"|| extend=="jpg"|| extend=="jpeg"|| extend=="gif"|| extend=="png"))
		{    
			alert("请上传正确类型的文件!");    
			if (!window.addEventListener)
			{       
				//IE 关键代码在这里！！！ 
				//obj.select();   
				//document.execCommand('Delete'); 
				//obj.blur();   
				obj.outerHTML+=''; 
				return false;   
			}
			 else 
			{   
				//非IE   
				obj.value = "";   
				return false;   
			} 
		
		} 
	}
}


//验证表单中的数据
function checkForm(){
	var isSub = $("#isSub").val();
	if(isSub == 1) {
		alert("提交中。。。请不要重复提交！");
		return false;
	}
	var orgCode = $("#orgCode").val();
	var orgName = $("#orgName").val();
	var servType = $("#serviceType").val();
	var checkCode = $("#checkIndex").val();
	var serverDate = $("#serverDate").val();
	var serInfo = $("#serInfo").val();
	var buryear = $("#buryear").val();
	var file = $("input[name='file']");
	var addPerson = $("#addPerson").val();
	if(checkCode == 0)
	{ 
		alert("请选择指标！")
		return false;
	}
	if(serverDate.length == 0)
	{
		alert("请选择服务时间！")
		return false;
	}
	if(serInfo.length > 100)
	{
		alert("服务说明过长,50字以内！");
		return false;
			
	}
	var fid = $("#fid").val();
	if(fid.length == 0) {
		alert("请先上传服务记录附件！");
		return false;
	}
	confirm("确定上传本次服务记录么？",function() {
			var data = 
			{
				"orgServInfo.orgCode"  : orgCode,
				"orgServInfo.servType" : servType,		
				"orgServInfo.checkCode": checkCode,
				"orgServInfo.servDate" : serverDate,
				"orgServInfo.servInfo" : serInfo,
				"orgServInfo.buryear"	 : 	buryear,
				"orgServInfo.addPerson" : addPerson,
				"orgServInfo.addDate"	 : "<%=nowTime%>"
			}
	var url;
	if(fid.length > 0) {
		fid = fid.substr(0,fid.length-1);
		url = "orgServer_saveOrgService.action?count = " + fid;
	}
	else {
		url = "orgServer_saveOrgService.action";
	}
	$("#isSub").val(1);//控制多次提交
	$.post(url,data,
		function(json){
			var r = json.isSuccess;
			if(r == 0) {
				alertReset("服务记录上传成功！");
			}
			else {
				$("#isSub").val('');
				alert("记录上传失败！");
				
			}
			
		})
		
	})
	
}

//上传文件格式验证
function checkFile(obj) {
	
	var extend = obj.value.substring(obj.value.lastIndexOf(".")+1).toLowerCase();    
	if(extend==""){    
	}
	else
	{ 
		 //doc docx,ppt pptx,xls,xlsx,wps,et,dps,pdf,txt,jpg,jpeg,gif,png   
		if(!(extend=="doc"||extend=="docx"||extend=="ppt"||extend=="pptx"||extend=="xls"||extend=="xlsx"||extend=="wps"||extend=="et"|| extend=="dps"|| extend=="pdf"|| extend=="txt"|| extend=="jpg"|| extend=="jpeg"|| extend=="gif"|| extend=="png"))
		{    
			alert("请上传正确类型的文件!");    
			if (!window.addEventListener)
			{       
				//IE 关键代码在这里！！！ 
				//obj.select();   
				//document.execCommand('Delete'); 
				//obj.blur();   
				obj.outerHTML+=''; 
				return false;   
			}
			 else 
			{   
				//非IE   
				obj.value = "";   
				return false;   
			} 
		} 
	}
	ajaxFileUpload();
}
//验证上传文件大小
function resets()
{
	document.location.reload(true);
}

	function ajaxFileUpload()
	{
		
		//var file = $("#input");
		var file = $("input[name='file']");
		var t = file[0].value.length
		if(t == 0) {
			alert("请选择要上传的文件...");
			return false;
		}
		$("#loading")
		.ajaxStart(function(){
			$(this).show();
		})//开始上传文件时显示一个图片
		.ajaxComplete(function(){
			$(this).hide();
		});//文件上传完成将图片隐藏起来
		beforeAjax();
		$.ajaxFileUpload
		(
			{
				url:'orgServer_uploadFile.action',//用于文件上传的服务器端请求地址
				secureuri:false,//一般设置为false
				fileElementId:'file',//文件上传空间的id属性  <input type="file" id="file" name="file" />
				dataType: 'json',//返回值类型 一般设置为json
				success: function (data, status)  //服务器成功响应处理函数
				{
					afterAjax();
					del();//隐藏并清空上传组件
					
					if(data.isSuccess == 1) {
						var msg = data.message;
						alert(msg);
						return false;
					}
					var fname = data.fileFileName//或得上传文件的名字
					var id = data.id;//得到上传文件的id
					addFileNames(id,fname);//显示出来文件名,与文件ID绑定到删除按钮上
					manageFileId(id,0);
					if(typeof(data.error) != 'undefined')
					{
						if(data.error != '')
						{
							alert(data.error);
						}else
						{
							alert(data.message);
						}
					}
				},
				error: function (data, status, e)//服务器响应失败处理函数
				{
					afterAjax();
					del();//隐藏并清空上传组件
					//alert(e);
					alert("文件过大,建议小于50M...")
				}
			}
		)
		return false;
	}
//附件上传成功后返回文件名字和ID
function addFileNames(id,name) {
	var td = document.getElementById("more");
	//var br = document.createElement("br");
	////var span = document.createElement("span");
	//var button = document.createElement("input");
	//button.type = "button";
    //button.value = "删除";
    //span.innerHTML   = name;
    var  a="<tr id='" 
    +"more"+id
    +"'><td style='border:none;'>&nbsp;&nbsp;<span>"+name+"</span>&nbsp;&nbsp;<img src='<%=path%>/images/sc.gif\' /><a href='javascript:void(0)' onclick=\"delfile("
    +id+")\" id='delfile'>删除</a></td><tr>";
    //绑定删除按钮删除附件的时候,要删掉文件表和硬盘上的文件
    $("#mytable").append(a);
}
  function delfile(id) {
    	$.post("orgServer_removeFujian.action?id="+id,function(json) {
    		var r = json.isSuccess;
    		if(r == 0) {
    $("#more"+id).empty();
	        	manageFileId(id,1);  //解除对id的记录
    		}
    	
		})
    	
    }
<%-- 
function addFileNames(id,name) {
	var td = document.getElementById("more");
	var br = document.createElement("br");
	var span = document.createElement("span");
	var button = document.createElement("input");
	button.type = "button";
    button.value = "删除";
    span.innerHTML   = name;
    //绑定删除按钮删除附件的时候,要删掉文件表和硬盘上的文件
    button.onclick = function() {
    	$.post("orgServer_removeFujian.action?id="+id,function(json) {
    		var r = json.isSuccess;
    		if(r == 0) {
	    		td.removeChild(br);
	    		td.removeChild(span);
	        	td.removeChild(button);
	        	//解除对id的记录
	        	manageFileId(id,1);
    		}
    	
		})
    	
    }
     td.appendChild(br);
   	 td.appendChild(span);
   	 td.appendChild(button);
}
--%>
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
							loct="公共服务记录添加 ";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<form action="orgServer_saveOrgService.action" method="post" id="myform" enctype="multipart/form-data">
				<div style=" background:none; " class="mainmt">
					<table style=" margin-left:25px; width:95%;" id="aa">
						<tr>
							<td class="tstd">
								年  度：
							</td>
							<td>
								<!--  
								<select name="buryear" id="buryear" style="width:132px;"  onchange="yearchange()">
									<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-4 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-4 %>年</option>
									<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-3 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-3 %>年</option>
									<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-2 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-2 %>年</option>
									<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-1 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-1 %>年</option>		
									<option value="<%=Calendar.getInstance().get(Calendar.YEAR) %>"><%=Calendar.getInstance().get(Calendar.YEAR) %>年</option>
								</select>
								-->
								<input type="text" name="buryear" id="buryear" value="<%=year%>" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								服务类型：	
							</td>
							<td>
								<select name="serviceType" id="serviceType" style="width: 132px;" onchange="checkIndexs()"></select>
								<!-- 完成用户登录以后修改 -->
								<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>"/>
								<input type="hidden" name="orgName" id="orgName" value="<%=orgName%>"/>
								<input type="hidden" value="<%=userName%>" name="userName" id="addPerson"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								服务指标：
							</td>
							<td colspan="3">
								<select name="checkIndex" id="checkIndex" style="width: 132px;">
									<option value="0">--请选择--</option>
								</select>
								<input type="hidden" id="isSub"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								服务时间：
							</td>
							<td>
								<input type="text" id="serverDate" name="serverDate" onclick="WdatePicker({minDate:'1890-01-01',maxDate:'<%=temp_str %>'})"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
									服务说明：
							</td>
							<td>
									<textarea rows="5" cols="30" id="serInfo" name="serInfo" onkeyup="checkFieldLength('serInfo', '服务说明的字段长度超过规定长度！', 190);" style="margin-left: 6px"></textarea>
							</td>
						</tr>
						<tr>
								<td class="tstd">
									材料上传：
								</td>
								<td>
								 <!--
								<input type="button" value="添加文件" onclick='show();' style="background: #ECF5FF"/>*上传文件不超过50M<br/>
								  -->
								<a href="javascript:void(0)" onclick="show()" style=" color:#5d7bc7; text-decoration:none;" ><img src="<%=path%>/images/fj.gif"/> 添加文件</a><br/>
								<div style="display: none;" id="fu">
									<input type="file" name="file" id="file" onchange="return checkFile(this);"/>
									<input type="button" value="取消" id="re" onclick="del()" style="background: #ECF5FF"/>
								</div><br/>
								<img src="<%=path %>/images/loading1.gif" id="loading" style="display: none;"/>
								<!-- 次隐藏元素来存储上传附件的id -->
								<input type="hidden"  id="fid"/>
								
								<table id='mytable' style="border:none; width:100%; border-collapse:collapse;">
								</table>
								</td>
							</tr>
							<tr>
								<td class="tstd">文档格式：
								</td>
								<td >
									<table style="border:none; width:100%; border-collapse:collapse;">
									  <tr >
									    <td style="text-align:right;width:100px;height:26px;padding:0 2px;" > MS&nbsp;Office文档</td>
									    <td style="height:26px;width:260px; vertical-align: middle;" >&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/w.jpg" /> doc,docx&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/ppt.jpg" /> ppt,pptx&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/ex.jpg" /> xls,xlsx</td>
									  	<td style="text-align:right;height:26px;width:50px; padding:0 2px;" > 纯文本</td>
									    <td style="height:20px; vertical-align: middle;" >&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/txt.jpg" /> txt </td>
									  	
									  </tr>
									  <tr >
									    <td style="text-align:right;width:100px;height:26px;padding:0 2px;" > WPS&nbsp;Office文档</td>
									    <td style="height:26px" >&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/wps.jpg" /> wps&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/dps.jpg" /> dps&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/et.jpg" /> et</td>
									  	<td style="text-align:right;height:26px; padding:0 4px;" >PDF</td>
									    <td style="height:26px" >&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/pdf.jpg" /> pdf</td>
									  </tr>
									  <tr>
									    <td style="text-align:right;height:26px; padding:0 2px;" > 图片</td>
									    <td style="height:26px" colspan="3">&nbsp;<img style="vertical-align: middle;" src="<%=path%>/images/jpg.jpg" /> jpg,jpeg,gif,png</td>
									  </tr>
									</table>
								</td>
							</tr>
						</table>
						<div class="buut">
							<a href="#" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
								onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="return checkForm();"> <img
									name="java" src="<%=path %>/images/abc.jpg" border="0"/>
							</a>
							<a href="#" onmouseover="document.jav.src='<%=path%>/images/qk.jpg'"
								onmouseout="document.jav.src='<%=path %>/images/aqk.jpg'" onclick="return resets();"> <img
									name="jav" src="<%=path %>/images/aqk.jpg" border="0"/>
							</a>
						</div>
				</div>
				<!---nr end------------------------->
				</form>
			</div>
			<div class="mainb">
				<div class="mainbl"></div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>
		</div>
	</body>
</html>