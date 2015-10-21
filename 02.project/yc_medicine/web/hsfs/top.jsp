<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat" pageEncoding="gbk"%>
<%@page import="com.kh.hsfs.model.HsfsUserInfo"%>
<%
	String path = request.getContextPath();
	HsfsUserInfo  user=(HsfsUserInfo)session.getAttribute("user");
	SimpleDateFormat df = new SimpleDateFormat("yyyy年MM月dd日");// 设置日期格式
	String nowTime = df.format(new Date());// 构造成当前时间
	String loginid = user.getUserLoginId();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>无标题文档</title>
		<link href="../css/common .css" rel="stylesheet" type="text/css" />
		<link href="../css/windows.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="../js/zzdc.js"></script>
				<script src="<%=path%>/js/jquery-1.4.4.js" type="text/javascript"></script>
       	<script src="<%=path%>/js/weather.js" type="text/javascript"></script>
       <script type="text/javascript">
        setInterval("Clock()",1000);
function syssrc(str) {
	window.parent.frames["mainFrame"][0][2].location.href = str;
}

function sx(){
	//history.go(-0);
	window.parent.frames["mainFrame"][0][2].location.reload();
}
function setTime() {
	
	document.getElementById("timenow").innerHTML = new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());
}
function Clock() {  
    var date = new Date(<%=new java.util.Date().getTime()%>);  
    this.year = date.getFullYear();  
    this.month = date.getMonth() + 1;  
    this.date = date.getDate();  
    this.day = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六")[date.getDay()];  
    this.hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();  
    this.minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();  
    this.second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();  
        document.getElementById("timenow").innerHTML=  this.year + "年" + this.month + "月" + this.date + "日 " + this.hour + ":" + this.minute + ":" + this.second + " " + this.day;   

    }

function notice() {
	window.parent.frames["mainFrame"][0][2].location = "<%=path%>/hsfs/notice/noticeList.jsp"
}
function emails() {
	window.parent.frames["mainFrame"][0][2].location = "<%=path%>/hsfs/email/emailManage.jsp"
}
function init() {
	$.post("notices!checkNewNotice.action?loginid=<%=loginid%>",
	function(json) {
			var count = json.isSuccess;
			var t = '<a href="javascript:void(0)" onclick="notice()" class="aa"><img src="../images/ggk.gif"/><font color="#272727" >公告'+count+'</font></a>';
			$("#ne").append(t);
		$.post("emailAction!checkNewEmail.action",
					function(json) {
						var c = json.isSuccess;
							var em = "&nbsp;<a href='javascript:void(0)' onclick='emails()' class='aa')><img src='../images/yjk.png'/><font color='#272727'>邮件" +c +"</font></a>";
							$("#ne").append(em);
					})
	});

	
}
</script>
<style type="text/css">
.menu{ background:url(../images/menbg.jpg) left top repeat-x; height:29px; line-height:29px; font-size:12px; color:#e4e9f3;}
.menul{ float:left; width:250px; }
.menuc{ float:left; width:250px; }
.menul img{ vertical-align:middle; margin-left:6px; margin-right:3px;}
.menul a{ text-decoration:none;}
.menul2{ float:none; width:100px; }
.menur{ float:right; width:200px; }
.menur img{ vertical-align:middle; }
.menun11{ float:left; width:110px; }
.aa {text-decoration:none;}
</style>
	</head>
	<body >
		<!---top begin------------------------->
		<div class="top">
			<div class="topt">
				<div class="toptl"></div>
				<div class="toptr">
					<ul>
						<li>
							<a class="MouseOver" href="javascript:syssrc('list.jsp')" ><img
									style="margin-bottom: 4px;" src="../images/hom.png" />
								<br />首页</a>
						</li>
						<li><a href="javascript:window.parent.frames['mainFrame'][0][2].location.reload();" >
							<img style="margin-bottom: 4px;"
									src="../images/sx.png" />
								<br />刷新</a>
						</li>
						
						<!--  
						<li>
							<a href="javascript:void(0)" onclick="return loginOut(1);"><img style="margin-bottom: 4px;"
									src="../images/gl.png" />
								<br />切换用户</a>
						</li>
						
						
						<li><a href="<%=path %>/hsfs/word/hsfs 2.html" target="_blank" >
							<img style="margin-bottom: 4px;"
									src="../images/czsm.gif" />
								<br />操作说明</a>
						</li>
						-->
						<li>
							<a href="javascript:void(0)" onclick="javascript:parent.frames['mainFrame'].loginOut(0);"><img style="margin-bottom: 4px;"
									src="../images/sz.png" />
								<br />退出</a>
						</li>
						
					</ul>
				</div>
			</div>
			<div class="menu">
			    <div class="menul">
			    <img src="../images/hgt.gif" />
					${user.userName }&nbsp;欢迎登陆系统&nbsp;&nbsp;
			    </div>
			    <div id="ne" class="menun11">
			    </div>
				<div class="menuc" id="weather">
				
				  <script type="text/javascript">
         //getWeather();
        </script>
					
				</div>
				<div class="menur" id="timenow" >
				</div>	<%--<img src="../images/sj.gif" /><jsp:include page="time.html" flush="true"/>
				--%>
			</div>
			 </div>			 
	</body>
</html>