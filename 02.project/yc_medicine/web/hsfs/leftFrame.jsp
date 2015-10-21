<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<script>
var flag=2;
function shift_status(){
if(flag==2)
{
flag=1;
window.parent.frameset.cols="218,8,*";
frameshow2.src="../images/p_3.jpg";
frameshow2.alt="隐藏图片管理"
}
else
{
flag=2;
frameshow2.src="../images/p_4.jpg";
frameshow2.alt="显示图片管理"
window.parent.frameset.cols="0,8,*";
}
}

</script>
	</head>
	<body onclick="shift_status()" text="#000000" leftmargin="0"
		topmargin="0" bgcolor="#a5bee6">
		<table border=0 height="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="middle" bgcolor="#a5bee6" id=menuSwitch
					style="cursor: hand">
					<img src="../images/p_3.jpg" width="8" height="38" id=frameshow2>
				</td>
			</tr>
		</table>

	</body>
</html>