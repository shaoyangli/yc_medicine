<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
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
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>公告发布</title>
		<link href="<%=path %>/css/grxx.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path %>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>	
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script language="javascript" type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
		<link rel="stylesheet" href="<%=path%>/kindeditors/themes/default/default.css" />
	<link rel="stylesheet" href="<%=path%>/kindeditors/plugins/code/prettify.css" />
	<script charset="utf-8" src="<%=path%>/kindeditors/kindeditor.js"></script>
	<script charset="utf-8" src="<%=path%>/kindeditors/plugins/code/prettify.js"></script>
<script type="text/javascript">
    var editor1;
	KindEditor.ready(function(K) {
			editor1 = K.create('textarea[name="content1"]', {
				cssPath : '<%=path%>/kindeditors/plugins/code/prettify.css',
				uploadJson : '<%=path%>/kindeditors/upload_json.jsp',
				fileManagerJson : '<%=path%>/kindeditors/file_manager_json.jsp',
				allowFileManager : true,
				items			: [
						'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code',
		'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
		'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
		'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
		'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
		'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|',
		'table', 'hr', 'emoticons','pagebreak'
					],
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
				}
			});
			prettyPrint();
		});
	
	//验证上传文件大小
function resets()
{
	document.location.reload(true);
}
function init() {
	 $("#person").val("<%=userName%>");
}
		
function saveNotice(){
	editor1.sync();
	var person = $("#person").val();
	var sendDate = $("#sendDate").val();
	var title = $.trim($("#title").val());
	var content = document.getElementsByName("content1")[0].value;
	var t = editor1.text();
	if(person.length == 0) {
		alert("请填写发布人！");
		return false;
	}
	if(sendDate.length == 0) {
		alert("请选择发布时间！");
		return false;
	}
	if(title.length == 0) {
		alert("公告标题不能为空！");
		return false;
	}
	if(title.length > 40) {
		alert("标题过长！请检查...");
		return false;
	}
	if(t.length == 0) {
		alert("公告内容不能为空！");
		return false;
	}
	
	if(content.length > 3500) {
		alert("公告内容过长！");
		return false;
	}
	confirm("确定发布此公告么？",function(){
		data = 
		{
			"notice.title" : title,
			"notice.content" : content,
			"notice.date"	: sendDate,
			"notice.sendPerson" : person
		};
		$.post("notices!saveNotice.action",data,
		function(json){
				var result = json.isSuccess;
				if(result == 0) {
					alertReset("发布成功！");
				}
				else {
					alert("遗憾,发布失败！请联系管理员！")
				}
		})
	})
	
	
}
</script>
		
		<style type="text/css">
.search {
	font-family: "宋体";
	font-size: 12px;
	behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
	cursor: hand;
}
</style>
</head>
	<body onload="init();">
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：<%=orgName %>>><% String loct = request.getParameter("loct");
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="公告添加 ";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div style=" background:none; " class="mainmt">
					<table style=" margin-left:22px; width:97%; " id="aa">
						<tr>
							<td class="tstd">
								发布人：
							</td>
							<td>
								<input type="text" id="person"/><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								发布时间：
							</td>
							<td>
								<input type="text" id="sendDate" onclick="WdatePicker({minDate:'1890-01-01',maxDate:'<%=temp_str %>'})" value="<%=temp_str %>"/>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								主题：	
							</td>
							<td>
								<input type="text" size="60" id="title"/>
								<font color="red">*建议40字以内</font>
							</td>
						</tr>
						<tr >
							<td class="tstd">
								正文：
							</td>
							<td >
							<textarea id="editor_id" name="content1" style="width:666px;height:250px;"></textarea>
							</td>
						</tr>
						</table>
						<div class="buut" style="float: clear">
							<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
								onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="return saveNotice();"> <img
									name="java" src="<%=path %>/images/abc.jpg" border="0"/>
							</a>
							<a href="javascript:void(0)" onmouseover="document.jav.src='<%=path%>/images/qk.jpg'"
								onmouseout="document.jav.src='<%=path %>/images/aqk.jpg'" onclick="return resets();"> <img
									name="jav" src="<%=path %>/images/aqk.jpg" border="0"/>
							</a>
						</div>
						
				</div>
				
				<!---nr end------------------------->
			</div>
			<div class="mainb">
				<div class="mainbl"></div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>
		</div>
	</body>
</html>