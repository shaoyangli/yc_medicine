<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();

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
	var checkCode = $("#checkIndex").val();
	var serverDate = $("#serverDate").val();
	var serInfo = $("#serInfo").val();
	var file = $("input[name='file']");
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
	//验证上传组件的文件是否选择了文件
	for(var i = 0; i<file.length; i++) {
		var t = file[i].value.length
		if(t == 0)
		{
			alert("请选择要上传的文件！");
			return false;
		}
	}
	//如果文件过大,提示用户,停止表单提交
  	//if(!checkFileSize()){
	//  return false;
	//}
	$("#isSub").val(1);//控制多次提交
	$("#myform").submit();
	
}
//上传文件总大小验证
function checkFileSize() {
	var filesize = 0;
	var f = 0;
	var files = document.getElementsByName("file");
	for(var i = 0;i< files.length;i++ ) {
		var obj = files[i];
		
		if(Sys.firefox)   
		{   
			if(obj.files[0].fileSize == undefined)
			{
				filesize = obj.files[0].size;
			}
			else {
				filesize = obj.files[0].fileSize;
			}
		}
		else if(Sys.ie)   
		{   
		    var fileobject = new ActiveXObject ("Scripting.FileSystemObject");//获取上传文件的对象   
		   	var file = fileobject.GetFile (obj.value);//获取上传的文件   
		   	var filesize = file.Size;//文件大小   
		}
		f+= filesize;
	}
	if(f > 52428800){
		alert("上传文件过大，不能超过50M，请检查！")
		return false;
	}
	return true;
}
//上传文件格式验证
function checkFile(td,br,obj,button) {
	
	var extend = obj.value.substring(obj.value.lastIndexOf(".")+1).toLowerCase();    
	if(extend==""){    
	}
	else
	{ 
		 //doc docx,ppt pptx,xls,xlsx,wps,et,dps,pdf,txt,jpg,jpeg,gif,png   
		if(!(extend=="doc"||extend=="docx"||extend=="ppt"||extend=="pptx"||extend=="xls"||extend=="xlsx"||extend=="wps"||extend=="et"|| extend=="dps"|| extend=="pdf"|| extend=="txt"|| extend=="jpg"|| extend=="jpeg"|| extend=="gif"|| extend=="png"))
		{    
			alert("请上传正确类型的文件!");    
			<%--
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
			--%>
			//自动删除不合法的input
			td.removeChild(br);
    		td.removeChild(obj);
        	td.removeChild(button);
		} 
		 return false;
	}
}
//添加多个动态file
function addMore() {
    var td = document.getElementById("more");
    var br = document.createElement("br");
    var input = document.createElement("input");
    var button = document.createElement("input");
    input.type = "file";
    input.name = "file";
    input.onchange= function(){
    	checkFile(td,br,this,button);
    };
    button.type = "button";
    button.value = "删除";
    button.onclick = function() {
    	td.removeChild(br);
    	td.removeChild(input);
        td.removeChild(button);
    }
    td.appendChild(br);
    td.appendChild(input);
    td.appendChild(button);
}

var  Sys = {};   
if(navigator.userAgent.indexOf("MSIE")>0)   
{   
	Sys.ie=true;   
}   
if(isFirefox=navigator.userAgent.indexOf("Firefox")>0)   
{   
	Sys.firefox=true;   
}   
	var size=0; 
	
	//验证上传文件大小
function reset()
{
	document.location.reload(true);
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
					当前位置：<%=orgName %>>>医疗机构服务登记 
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
								<input type="text" id="serverDate" name="serverDate" onclick="WdatePicker({minDate:'1890-01-01',maxDate:CurentTime()})"/>
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
								<table id='mytable' style="border:none; width:100%; border-collapse:collapse;">
									<tr >
										<td style="border:none;" id ="more">
											<input type="file" name="file" id="file" onchange="checkFiles(this)"/>
											<input type="button" value="添加" onclick='addMore();'/> <font color="red">*可以点击进行多个文件的上传，上传文件不超过50M</font>
											<input type="hidden" value="<%=userName%>" name="userName"/>
										</td> 
									</tr>
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
								onmouseout="document.jav.src='<%=path %>/images/aqk.jpg'" onclick="return reset();"> <img
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