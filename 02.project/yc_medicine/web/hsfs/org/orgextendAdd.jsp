<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	HsfsOrgBaseInfo org = (HsfsOrgBaseInfo)session.getAttribute("org");
	String orgCode = org.getOrgCode();
	String year = (String)session.getAttribute("year");
	float perMoney = 0;
	if(null != session.getAttribute("perMoney")){
		perMoney = (Float)session.getAttribute("perMoney");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>ҽ�ƻ�����չ</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/area_org.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/My97DatePicker/WdatePicker.js">
		</script>
		<style type="text/css">
.search {
	font-family: "����";
	font-size: 12px;
	behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
	cursor: hand;
}
</style>
		<script type="text/javascript">
function add() 
{
		var cun = $("#cun").val();
		if(cun == "")
		{
			alert("��ѡ��һ���������ӣ�");
			return false;
		}
		var perMoney = '<%=perMoney%>';
		if(perMoney == 0.0) {
			alert("������Ӹ���ȱ�׼,Ȼ�����µ�¼��");
			return false;
		}
		var xian = $("#xian").val();
		var areaId = xian + cun;//������������Ϣ
		var burYear = $("#buryear").val();
		var pouNum 	= $("#pouNum").val();
		if(pouNum.length == 0) {
			alert("���˿ڱ�����ӣ�");
			return false;
		}
		if(pouNum<= 0) {
			alert("���˿ڱ������0��");
			return false;
		}
		var manNum 	= $("#manNum").val();
		var womanNum = $("#womanNum").val();
		var childNum = $("#childNum").val();
		var oldNum = $("#oldNum").val();
		var swNum = $("#swNum").val();
		var ycfNum = $("#ycfNum").val();
		var gxyNum = $("#gxyNum").val();
		var tnbNum = $("#tnbNum").val();
		var jsbNum = $("#jsbNum").val();
		//var state=$('input:radio[name="state"]:checked').val(); 
		var orgCode = '<%=orgCode%>';
		var EXPECT_MONEY = $("#EXPECT_MONEY").val();
		
		var data = {
			"orgExtend.orgCode" 	: orgCode,
			"orgExtend.burYear"		: burYear,
			"orgExtend.pouNum"		: pouNum,
			"orgExtend.manNum"		: manNum,
			"orgExtend.womanNum"	: womanNum,
			"orgExtend.childNum"	: childNum,
			"orgExtend.oldNum"		: oldNum,
			"orgExtend.swNum"		: swNum,
			"orgExtend.ycfNum" 		: ycfNum,
			"orgExtend.gxyNum"		: gxyNum,
			"orgExtend.tnbNum"		: tnbNum,
			"orgExtend.jsbNum"		: jsbNum,
			//"orgExtend.state"		: state,
			"orgExtend.orgAreaId"	: areaId,
			"orgExtend.PERCAPITAL"	: '<%=perMoney%>',
			"orgExtend.EXPECT_MONEY": EXPECT_MONEY
		};
		//var id = $("#key").val();
		var url = "orgExtend_saveOrgExtendInfo.action";
		//if(id.length > 0) {
		//	url = "orgExtend_saveOrgExtendInfo.action?id="+id;
		//}
		
		$.post(url,data, 
				 function(json)
				  {
					if(json.isSuccess == 0)
					{
						alert("��Ϣ�Ǽǳɹ���");
					}
					if(json.isSuccess == 3)
					{
						alertReset("��Ϣ���ύ,��ֹ�޸ģ�");
					}
					if(json.isSuccess == 1)
					{
						alert("δ֪����,����ϵ����Ա��");
					}
		});
		
};
function init()
{
	systeminit("<%=path%>");
	var year = '<%=year%>';
	var orgCode = '<%=orgCode%>';
	var data = {"year" : year,"orgCode" : orgCode};
	$.post("orgExtend_findOrgExtendInfo.action",data,
		function(json){
			var list = json.list;
			if(list == null || list == 'null' || list.length == 0) {
				return false;
			}
			
			else if(list.length > 0) {
				//$.each(list,function(i,obj){
					//$("#pouNum").val()
				//	alert(obj);
				//})
				for (var i=0;i<list.length;i++){
					$("#pouNum").val(list[3]);
					$("#manNum").val(list[4]);
					$("#womanNum").val(list[5]);
					$("#childNum").val(list[6]);
					$("#oldNum").val(list[7]);
					$("#swNum").val(list[8]);
					$("#ycfNum").val(list[9]);
					$("#gxyNum").val(list[10]);
					$("#tnbNum").val(list[11]);
					$("#jsbNum").val(list[12]);
					$("#perMoney").val(list[16]);
					$("#EXPECT_MONEY").val(list[17]);
					
					//$("#key").val(list[0]);
				}
			}
			
			
		})
	
}
<%-- 
//����ϵͳʱ���ʼ�����
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
//����
function reset()
{
		$("#pouNum").val("");
		$("#manNum").val("");
		$("#womanNum").val("");
		$("#sixNum").val("");
		$("#sixtyNum").val("");
		$("#thtyNum").val("");
		$("#fivetyNum").val("");
		$("#orgAddress").val("");
}
function resets()
{
	document.location.reload(true);
}
function esMoneyCheck() {
	var pouNum = $("#pouNum").val();
	if(pouNum.length == 0 || pouNum == 0) {
		$("#EXPECT_MONEY").val('');
	}
	else {
		var perMoney  = $("#perMoney").val();
		$("#EXPECT_MONEY").val(pouNum*perMoney);
	}
	
	
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
					��ǰλ�ã�Ͻ��������Ϣ�Ǽ�
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div class="mainmt" style="height:35px;">
						<p>
							<select id="sheng" name="sheng" style="display: none;"></select>
							<select id="shi" name="shi" style="display: none;"></select>
							��(��)��
							<select name="xian" id="xian" style="width:95px;" onchange="xianselect()"></select>
							��(�򡢽ֵ�)��
							<select name="xiang" id="xiang" style="width:95px;" onchange="xiangselect()"></select>
							��(��ί��)��
							<select name="cun" id="cun" style="width:95px;"></select>
							<select name="jigou" id="jigou" style="display: none;"></select>
						</p>
						</div>
					<div class="mainmt" style="background:none; border-bottom:0; ">
						<table>
							<tr>
							<td class="tstd">
									��ȣ�
									<input type="hidden" id="key"/><!-- ����ס������ֵ -->
								</td>
								<td>
								<!-- 
									<select id="buryear" style="width: 132px;">
										<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-4 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-4 %>��</option>
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-3 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-3 %>��</option>
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-2 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-2 %>��</option>
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-1 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-1 %>��</option>		
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR) %>"><%=Calendar.getInstance().get(Calendar.YEAR) %>��</option>
									</select>
								 
								 <input type="text" name="buryear" id="buryear" value="<%=Calendar.getInstance().get(Calendar.YEAR)%>" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate"/>	
									<font color="red">*</font>
									-->
									<input type="text" name="buryear" id="buryear" readonly="readonly" value="<%= year%>"/>
								</td>
								<td class="tstd">
									�˿�������
								</td>
								<td>
									<input name="pouNum" id="pouNum" type="text" onblur="checkIsNum(this)" onchange="esMoneyCheck();"/>
								</td>
								
							</tr>
							<tr>
							<td class="tstd">
									����������
								</td>
								<td>
									<input name="manNum" id="manNum"  type="text" onblur="checkIsNum(this)"/>
								</td>
								<td class="tstd">
									Ů��������
								</td>
								<td>
									<input name="womanNum"  id="womanNum" type="text" onblur="checkIsNum(this)"/>
								</td>
								
							</tr>
							<tr>
                               <td class="tstd">
									0-6���ͯ��
								</td>
								<td>
									<input name="childNum" id="childNum" type="text" onblur="checkIsNum(this)"/>
								</td>
								<td class="tstd">
									����������
								</td>
								<td>
									<input name="oldNum" id="oldNum"  type="text" onblur="checkIsNum(this)"/>
								</td>
								
							</tr>
                            <tr>
                            <td class="tstd">
									35�������˿ڣ�
								</td>
								<td>
									<input name="swNum" id="swNum" type="text" onblur="checkIsNum(this)"/>
								</td>
								<td class="tstd">
									�в���������
								</td>
								<td>
									<input name="ycfNum" id="ycfNum" type="text" onblur="checkIsNum(this)"/>
								</td>
								</tr>
								<tr>
								<td class="tstd" >
									��Ѫѹ������
								</td>
								<td>
									<input name="gxyNum" id="gxyNum" type="text"" onblur="checkIsNum(this)"/>
								</td>
								<td class="tstd">
									����������
								</td>
								<td>
									<input name="tnbNum" id="tnbNum" type="text" onblur="checkIsNum(this)"/>
								</td>
								
                            </tr>
                            <tr>
                            	<td class="tstd">
                            		����������
                            	</td>
                            	<td>
                            		<input type="text" id="jsbNum" onblur="checkIsNum(this)"/>
                            	</td>
                            	<!--  
                            	<td class="tstd" >
									�Ƿ���ˣ�
								</td>
								<td >
									<input name="state" id="state" type="radio" value="0"
										checked="checked" />
									��
									<input name="isChecked" id="isChecked" type="radio" value="1" />
									��
								</td>
								-->
                            </tr>
                            <tr >
                            	<td class="tstd">
                            		������׼��
                            	</td>
                            	<td>
                            		<input type="text" value="<%=perMoney %>" id="perMoney" readonly="readonly"/>��Ԫ/�ˣ�
                            	</td>
                            	<td class="tstd">
                            		Ԥ�Ʋ�����
                            	</td>
                            	<td>
                            		<input type="text" id="EXPECT_MONEY" readonly="readonly"/>��Ԫ��
                            	</td>
								
							</tr>
						</table>
						<br/>
						<div class="buut" align="right">
							<a HREF="#" onMouseOver="document.java.src='<%=path%>/images/bc.jpg'"
								onclick="return add();"
								onMouseOut="document.java.src='<%=path%>/images/abc.jpg'"> <img
									name="java" SRC="<%=path%>/images/abc.jpg" BORDER="0"/> </a>
							<a HREF="#" onMouseOver="document.jav.src='<%=path%>/images/qk.jpg'"
								onMouseOut="document.jav.src='<%=path%>/images/aqk.jpg'" onclick="return resets();"> <img
									name="jav" SRC="<%=path%>/images/aqk.jpg" BORDER="0"> </a>
							<!--  		
							<a href="orgextendAdd.jsp"  onmouseover="document.java1.src='<%=path%>/images/xz1.jpg'"
								onmouseout="document.java1.src='<%=path%>/images/axz1.jpg'">
								<img name="java1" src="<%=path%>/images/axz1.jpg" border="0"/>
							</a>
							-->
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