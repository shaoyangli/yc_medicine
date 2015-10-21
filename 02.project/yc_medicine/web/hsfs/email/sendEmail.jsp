<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String temp = sdf.format(new Date());
String orgCode = "";
String orgName = "";
String userName = "";
String logid = "";
String year = (String)request.getSession().getAttribute("year");
if(session != null) {
	HsfsOrgBaseInfo orginfo=(HsfsOrgBaseInfo)session.getAttribute("org");
	HsfsUserInfo user = (HsfsUserInfo)session.getAttribute("user");
	orgCode=orginfo.getOrgCode();
	orgName=orginfo.getOrgName();
	userName = user.getUserName();
	logid = user.getUserLoginId();
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>发送邮件</title>
		
		<script language="javascript" type="text/javascript"
			src="<%=path %>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>	
		<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script type="text/javascript" src="<%=path%>/js/uploadFile.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/My97DatePicker/WdatePicker.js">
		</script>
		<link rel="stylesheet" href="<%=path%>/kindeditors/themes/default/default.css" />
	<link rel="stylesheet" href="<%=path%>/kindeditors/plugins/code/prettify.css" />
	<script charset="utf-8" src="<%=path%>/kindeditors/kindeditor.js"></script>
	<script charset="utf-8" src="<%=path%>/kindeditors/plugins/code/prettify.js"></script>
	
		<link rel="stylesheet" href="<%=path%>/js/ztree/css/demo.css" type="text/css"/>
		<link rel="stylesheet" href="<%=path%>/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
		<script type="text/javascript" src="<%=path%>/js/ztree/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="<%=path%>/js/ztree/jquery.ztree.excheck-3.5.js"></script>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
			a{ color:#5d7bc7; text-decoration:none;}
	</style>
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
		'table', 'hr', 'emoticons', 'pagebreak'
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
function empytUsers() {
	//$("#person").val('');
	showMenus();
}
function sendEmail(){
	editor1.sync();
	//收件人的问题
	var isSub = $("#isSub").val();
	if(isSub == 1) {
		alert("邮件发送中。。。请稍后！");
		return false;
	}
	
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
    var nodes = treeObj.getCheckedNodes(true);
    var  v = "";
    var names = "";
    for (var i=0; i< nodes.length;  i++) {
          v += nodes[i].id + ",";//获取选中节点的id值
          names += nodes[i].name + ";";
     }
   if(v == "") {
	   alert("请选择收件人！");
	   return false;
   }
  	v= ',' + v;
    names = names.substr(0,names.length-1);//截去最后一个分号;
	var title = $.trim($("#title").val());
	var content = document.getElementsByName("content1")[0].value;
 	var t = editor1.text();
	if(title.length == 0) {
		alert("邮件主题不能为空！");
		return false;
	}
	if(title.length > 40) {
		alert("主题过长！请检查...");
		return false;
	}
	if(t.length == 0) {
		alert("邮件内容不能为空！");
		return false;
	}
	
	if(content.length > 2000) {
		alert("邮件内容过长！,2000字以内");
		return false;
	}
	var fid = $("#fid").val();
	confirm("确定发送此邮件么？",function(){
		var data;
	if(fid.length > 0) {
		fid = fid.substr(0,fid.length-1);
		data = 
		{
			"email.title" : title,
			"email.content" : content,
			"email.senddate"	: '<%=temp%>',
			"email.sendperson" : '<%=userName%>',
			"email.sendid"  : '<%=logid%>',
			"email.sendOrgName" : '<%=orgName%>',
			"email.receiveid" : v,
			"email.receivename" : names,
			"count"				: fid
		}
	}
	else {
		data = 
		{
			"email.title" : title,
			"email.content" : content,
			"email.senddate"	: '<%=temp%>',
			"email.sendperson" : '<%=userName%>',
			"email.sendid"  : '<%=logid%>',
			"email.sendOrgName" : '<%=orgName%>',
			"email.receiveid" : v,
			"email.receivename" : names
		};
	}
		
		$("#isSub").val(1);//控制多次提交
		$.post("emailAction!sendEmail.action",data,
		function(json){
				var result = json.isSuccess;
				if(result == 0) {
					alertReset("邮件已发送！");
					return false;
				}
				else {
					alert("遗憾,发送失败！请联系管理员！");
					$("#isSub").val('');
				}
		})
	})
}

$(document).ready(function(){
	loadUsers(0);
});
var setting = {
			check: {
				enable: true,
				chkboxType: {"Y":"", "N":""}
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onCheck: onCheck
			}
		};
		function beforeClick(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		}
		
		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getCheckedNodes(true),
			v = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var cityObj = $("#citySel");
			cityObj.attr("value", v);
		}

function showMenus() {
			var cityObj = $("#citySel");
			var cityOffset = $("#citySel").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "citySel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
	}
}

function emptyUsers() {
	loadUsers(0);
	$("#checkSelect").val(0);
	$("#citySel").val('');
}
function beforeLoad() {
	$("#citySel").val('');
	var t = $("#checkSelect").val();
	loadUsers(t);
}
function loadUsers(t) {
	$("#checkSelect").attr("disabled",true);
	$.post("emailAction!findAllNodes.action?checkType=" + t,
		function(json) {
			var zNodess = json.menuNodes
			$.fn.zTree.init($("#treeDemo"), setting, zNodess);
			$("#checkSelect").attr("disabled",false);
		})
}
//附件上传成功后返回文件名字和ID
function addFileNames(id,name) {
	var td = document.getElementById("more");
	var br = document.createElement("br");
	var span = document.createElement("span");
	var button = document.createElement("input");
	button.type = "button";
    button.value = "删除";
    span.innerHTML   = name;
    var  a="<tr id='" 
    +"more"+id
    +"'><td style='border:none;'>&nbsp;&nbsp;<span>"+name+"</span>&nbsp;&nbsp;<img src='<%=path%>/images/sc.gif\' /><a style=\"text-decoration:none;\" href='javascript:void(0)' onclick=\"delfile("
    +id+")\" id='delfile'>删除</a></td><tr>";
    //绑定删除按钮删除附件的时候,要删掉文件表和硬盘上的文件
   button.onclick = function() {
    	$.post("emailAction!removeFujian.action?id="+id,function(json) {
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
    $("#mytable").append(a);
}
  function delfile(id) {
    	$.post("emailAction!removeFujian.action?id="+id,function(json) {
    		var r = json.isSuccess;
    		if(r == 0) {
    $("#more"+id).empty();
	        	manageFileId(id,1);  //解除对id的记录
    		}
    	
		})
    	
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
				url:'emailAction!uploadFile.action',//用于文件上传的服务器端请求地址
				secureuri:false,//一般设置为false
				fileElementId:'file',//文件上传空间的id属性  <input type="file" id="file" name="file" />
				dataType: 'json',//返回值类型 一般设置为json
				success: function (data, status)  //服务器成功响应处理函数
				{
					afterAjax();
					del();//隐藏并清空上传组件
					//alert(data.message);//从服务器返回的json中取出message中的数据,其中message为在struts2中定义的成员变量
					if(data.isSuccess == 1) {
						alert(data.message);
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
	<body>
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：<%=orgName %> >> 
					<% String loct = request.getParameter("loct");
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="发送邮件 ";
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
								收件人：
							</td>
							<td >
								<select style="width:90px;" id="checkSelect" onchange="beforeLoad();">
									<option value="0">用户查询</option>
									<option value="1">区域查询</option>
									<option value="2">机构查询</option>
								</select>
								<br/>
								<input id="citySel" type="text" readonly="readonly"  style="width:250px;" onclick="showMenus();"/>
								<input type="button"" value="清 空" onclick="emptyUsers()" style="background: #ECF5FF"/>
								<input type="hidden" id="isSub"/>
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
								<br/>
								
							</td>
						</tr>
						<tr>
								<td class="tstd">
									邮件附件：
								</td>
								
								<td>
								<!--  
								<input type="button" value="添加附件" onclick='show();' style="background: #ECF5FF"/>*上传文件不超过50M<br/>
								-->
								<a href="javascript:void(0)" onclick="show()" style=" color:#5d7bc7; text-decoration:none;" ><img src="<%=path%>/images/fj.gif"/> 添加附件</a>
								
								<div style="display: none;" id="fu">
									<input type="file" name="file" id="file" onchange="return ajaxFileUpload();"/>
									<!-- 
									<a href="javascript:void(0)" style=" color:#5d7bc7; text-decoration:none;" onclick="del()">取消</a>
									 -->
									<input type="button" value="取消" id="re" onclick="del()" style="background: #ECF5FF"/>
								</div>
								<br/>
								<img src="<%=path %>/images/loading1.gif" id="loading" style="display: none;"/>
								<!-- 隐藏元素来存储上传附件的id -->
								<input type="hidden"  id="fid"/>
								<table id='mytable' style="border:none; width:100%; border-collapse:collapse;">
								</table>
								</td>
							</tr>
						</table>
						<div class="buut" style="float: clear">
							<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
								onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="return sendEmail();"> <img
									name="java" src="<%=path %>/images/abc.jpg" border="0"/>
							</a>
							<a href="javascript:void(0)" onmouseover="document.jav.src='<%=path%>/images/qk.jpg'"
								onmouseout="document.jav.src='<%=path %>/images/aqk.jpg'" onclick="return resets();"> <img
									name="jav" src="<%=path %>/images/aqk.jpg" border="0"/>
							</a>
						</div>
				</div>
					
				</div>
				
				<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
						<ul id="treeDemo" class="ztree" style="margin-top:0; width:180px; height: 300px;"></ul>	
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