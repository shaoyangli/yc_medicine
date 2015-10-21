<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.kh.hsfs.model.HsfsUserInfo"%>
<%
	String path = request.getContextPath();
String year=session.getAttribute("year").toString();
HsfsUserInfo user=(HsfsUserInfo)session.getAttribute("user");
String userName=user.getUserName();
int userId=user.getUserCode();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>留言添加</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
			<script language="javascript" type="text/javascript"
			src="<%=path%>/js/jquery-1.4.4.js">
		</script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/limitLength.js"></script>
			<script type="text/javascript" src="<%=path%>/js/doUtil.js">
</script>
	<link rel="stylesheet" href="<%=path%>/kindeditors/themes/default/default.css" />
			<script charset="utf-8" src="<%=path%>/kindeditors/kindeditor.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<style type="text/css">
.search {
	font-family: "宋体";
	font-size: 12px;
	behavior BEHAVIOR: url('../css/selectBox.htc');
	cursor: hand;
}
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
.mainmt table tr th.tstd{  background: none repeat scroll 0 0 #EFF4FB; text-align:right; padding-right:4px; color:#324269; width:100px;}
</style>
<script type="text/javascript">
 	var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					resizeType : 1,
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
	var title = $("#title").val();
	if(title.length<1){alert("文章标题不能为空");return false;}
	var content = editor.text();
	if(content.length>1000){
		alert("文章内容超过1000个字符!");
		return false;
	}
	if(content.length<1){
		alert("文章内容不能为空!");
		return false;
	}
	var content = editor.html();
	var url = "<%=path%>/guestAction!add.action";
	var data = {		
		"gbook.lytitle" : title,
		"gbook.lycontent": content,
		"gbook.userId" :'<%=userId%>',
		"gbook.lyauthor": '<%=userName%>'
	}
	$.post(url, data, function(json) {
		var d = json.result;
		if (d == 1) {
		alertJiaZhai("保存成功！");
			
		} else {
			alert("保存失败！");
		}
	}, 'json')
} 	
 function findList(){
   location.href="<%=path%>/hsfs/guest/guestList.jsp";
}
//基于jQuery版本 
            function yzlength(obj){ 
              	 var _area=$("#"+obj); 
            	 var _info=_area.next(); 
           	 	var _submit=_info.find(':hidden'); 
  				var _max=_area.attr('maxlength'); 
				var _val,_cur,_count,_warn; 
				_submit.attr('disabled',true); 
				_area.bind('keyup change',function(){ //绑定keyup和change事件 
				_submit.attr('disabled',false); 
				if(_info.find('span').size()<1){//避免每次弹起都会插入一条提示信息 
				_info.append('<span>你还可以输入<em>'+ _max +'</em>个字符<font>[不区分中英文字符数]</font></span>'); 
					} 
				_val=$(this).val(); 
				_cur=_val.length; 
				_count=_info.find('em'); 
				_warn=_info.find('font'); 

				if(_cur==0){//当默认值长度为0时,可输入数为默认maxlength值,此时不可提交 
				_count.text(_max); 
				_submit.attr('disabled',true); 
				}else if(_cur<_max){//当默认值小于限制数时,可输入数为max-cur 
				_count.text(_max-_cur); 
				_warn.text('[不区分中英文字符数]'); 
				}else{//当默认值大于等于限制数时,插入一条提示信息并截取限制数内的值 
				_count.text(0); 
				_warn.text('不可再输入!'); 
				$(this).val(_val.substring(0,_max)); 
				} 
				}); 
			}; 
			function back(){
	location.href="<%=path%>/hsfs/guest/guestList.jsp";
}
</script>
	</head>
	<body>
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path %>/images/tb1.jpg" />
					当前位置：留言板发帖
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div class="mainmt">
					<form >
						<table>
							<tr>
								<td class="tstd">
									文章标题：
								</td>
								<td>									
								<input type="text"   name="title" id="title" size="60"  maxlength="120" onkeyup="yzlength('title')"/>
								<font color="red">*</font>
								<p>
								<input type="hidden" value="呵呵" />
							</p>
								</td>
								
							</tr>
							<tr>
								<th class="tstd" valign="top" >
									文章内容：
								</th>
								<td>
										<textarea name="content" style="width:700px;height:300px;visibility:hidden;"></textarea>
								</td>
							</tr>
						
						</table>
						<div class="buut">
						
						
						<a HREF="#" 
							onMouseOver="document.java.src='<%=path%>/images/bc.jpg'"
							onclick="javascript:save();"
							onMouseOut="document.java.src='<%=path%>/images/abc.jpg'"> <img
								name="java" SRC="<%=path%>/images/abc.jpg" BORDER="0" /> </a>				
						<a HREF="javascript:back();" id="clickButton"
							onMouseOver="document.jav.src='<%=path%>/images/fh.jpg'"
							onMouseOut="document.jav.src='<%=path%>/images/afh.jpg'"> <img
								name="jav" SRC="<%=path%>/images/afh.jpg" BORDER="0" /> </a><%--
						<input class="btn_b"  type="button" onclick="save()" value="发表帖子" name="commit"/>
						<input class="btn_t" type="button" onclick="back()" value="返回列表" name="commit"/>
						--%></div>
					</form>


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












