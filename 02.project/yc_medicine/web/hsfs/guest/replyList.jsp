<%@ page language="java" pageEncoding="gbk"%>
<%@page import="com.kh.hsfs.model.HsfsOrgBaseInfo"%>
<%@page import="com.kh.util.RetrunAreaId"%>
<%@page import="com.kh.hsfs.model.HsfsUserInfo"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
HsfsUserInfo user=(HsfsUserInfo)session.getAttribute("user");
String userName=user.getUserName();
int userId=user.getUserCode();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>留言板</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet"
			type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js"
			type="text/javascript">
		</script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js">
		</script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js">
		</script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js">
		</script>
		<script type="text/javascript"
			src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue">
		</script>
		<link rel="stylesheet" href="<%=path%>/kindeditors/themes/default/default.css" />
			<script charset="utf-8" src="<%=path%>/kindeditors/kindeditor.js"></script>
		<script type="text/javascript">
 	var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					resizeType : 1,
					//newlineTag : 'br',
					//allowPreviewEmoticons : false,
					//allowImageUpload : false,
					uploadJson : '<%=path%>/kindeditors/upload_json.jsp',
				fileManagerJson : '<%=path%>/kindeditors/file_manager_json.jsp',
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'image', 'link']
				});
			});
function save() {
	var content = editor.text();
	if(content.length>1000){
		alert("回复内容超过1000个字符!");
		return false;
	}
	if(content.length<1){
		alert("回复内容不能为空!");
		return false;
	}
	var content = editor.html();
	var url = "<%=path%>/guestAction!addReply.action";
	var id='<s:property value="gbook.id"/>';
	var data = {	
		"gbook.id":id,
		"rbook.content": content,
		"rbook.userId" :'<%=userId%>',
		"rbook.replyAuthor": '<%=userName%>'
	}
	$.post(url, data, function(json) {
		var d = json.result;
		if (d == 1) {
			alertJiaZhai("回复成功！");
		} else {
			alert("回复失败！");
		}
	}, 'json')
}
function findList(){
	window.location.reload();
	}
function back(){
	location.href="<%=path%>/hsfs/guest/guestList.jsp";
}
    $(window).bind("load", function() {  
          
    // IMAGE RESIZE  
        $('#guest img').each(function() {          	 
            var maxWidth =700; 
            var maxHeight = 400;   
              //var maxWidth =$(window).height()*0.7; 
           // var maxHeight = $(window).width()*0.5;   
            var ratio = 0;  
            var width = $(this).width();  
            var height = $(this).height();  
            if(width > maxWidth){  
                ratio = maxWidth / width;  
                $(this).css("width", maxWidth);  
                $(this).css("height", height * ratio);  
                height = height * ratio;  
            }  
            var width = $(this).width();  
            var height = $(this).height();  
            if(height > maxHeight){  
                ratio = maxHeight / height;  
                $(this).css("height", maxHeight);  
                $(this).css("width", width * ratio);  
                width = width * ratio;  
            }  
        });  
          
    //$("#contentpage img").show();  
          
    // IMAGE RESIZE  
    });  
</script>
		<style type="text/css">
.btn_b {
    background-color: #1276BF;
    background-image: -moz-linear-gradient(center top , #1276BF, #006699);
    border: 1px solid #3C7BC4;
    border-radius: 2px 2px 2px 2px;
    color: white !important;
    cursor: pointer;
    padding: 4px 15px;
}
.btn_t {
    background-color: #1276BF;
    background-image: -moz-linear-gradient(center top , #ffff00, #1276BF);
    border: 1px solid #F3F781;
    border-radius: 2px 2px 2px 2px;
    color: white !important;
    cursor: pointer;
    padding: 4px 15px;
}
.mainmt table tr th.tstd{  text-align:right; padding-right:4px; color:#324269; width:100px;}
.mainmt table tr td.tstd{  text-align:right; padding-right:4px; color:#324269; width:100px;}
.mainmt{ background:url(<%=path%>/images/cxbg.jpg) left top repeat-x;padding-top:8px; height:35px; margin:0; border-bottom:1px solid #dcdcdc;}
</style>
	</head>
	<body>
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：留言板列表
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
			<div class="mainmt" >
					<table>
						<tr>
						<td>
							<font color="blue">	<s:property value="gbook.lytitle"/></font><font color="red">[推荐]</font>
						</td>
						</tr>
						</table>
							
				</div>
				<div class="mianmm">
					<table style="height: auto; border-bottom: none; margin-top: 6px">
						<tr>	
						<td rowspan=2 >
								<a href="<%=path%>/guestAction!findByUser.action?userId=<s:property value='gbook.userId'/>"><s:property value="gbook.lyauthor"/></a>
							</td>						
							
							<td  width="85%">
								发表于：<s:property value="gbook.lytime"/><strong><font style="margin-left: 400px;" color="red">楼主</font></strong>
							</td>
						</tr>
						<tr >
							<td class="tstd" >                       
							<s:property value="gbook.lycontent" escapeHtml="false"/>
							</td>						
						</tr>					
					</table>
					<table >
					  <s:iterator value="page.list" status="st" var="reply">
					<tr>	
						<td rowspan=2 >
							<a href="<%=path%>/guestAction!findByUser.action?userId=<s:property value='#reply[4]'/>">	<s:property value="#reply[3]"/></a>
							</td>						
							
							<td  width="85%">
								回复于：<s:property value="#reply[2]"/>&nbsp;<strong><font style="margin-left: 400px;" color="red">#<s:property value="#st.count"/></font></strong>
							</td>
						</tr>
						<tr>
							<td  >
								<div id="guest"><s:property value="#reply[1]" escapeHtml="false"/></div>
							</td>						
						</tr>		
					 </s:iterator>
					</table>
						<table>
							
							<tr>
								<td  valign="top" >
									<strong>回复内容：</strong>
								</td>
								<td>
										<textarea name="content" style="width:700px;height:200px;visibility:hidden;word-wrap: break-word;"></textarea>
								</td>
							</tr>
						
						</table>
						<div class="buut">
						<%--<input class="btn_b" type="button" onclick="save()" value="提交回复" name="commit"/>
						<input class="btn_t" type="button" onclick="back()" value="返回列表" name="commit"/>
						--%>
							<a HREF="#" 
							onMouseOver="document.java.src='<%=path%>/images/bc.jpg'"
							onclick="javascript:save();"
							onMouseOut="document.java.src='<%=path%>/images/abc.jpg'"> <img
								name="java" SRC="<%=path%>/images/abc.jpg" BORDER="0" /> </a>				
						<a HREF="javascript:back();" id="clickButton"
							onMouseOver="document.jav.src='<%=path%>/images/fh.jpg'"
							onMouseOut="document.jav.src='<%=path%>/images/afh.jpg'"> <img
								name="jav" SRC="<%=path%>/images/afh.jpg" BORDER="0" /> </a>
						</div>
				</div>

			</div>
			<div class="mainb">
				<div class="mainbl"></div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
				<div>
					<input id="arrayid" name="arrayid" type="hidden" />
					<input id="xianOldValue" type="hidden" />
					<input id="xiangOldValue" type="hidden" />
					<input id="cunOldValue" type="hidden" />

				</div>
			</div>
		</div>
		<%--
 	<span id="thinking"  style="display:none"></span>  
		<script type="text/javascript">
		setInterval("windows()",10000);
		</script>
		
	--%>
	</body>
</html>
