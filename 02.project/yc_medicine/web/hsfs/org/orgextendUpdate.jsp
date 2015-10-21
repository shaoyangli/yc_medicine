<%@ page language="java"  pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>医疗机构扩展信息修改</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script type="text/javascript" src="<%=path%>/js/area_org.js"></script>
		<style type="text/css">
.search {
	font-family: "宋体";
	font-size: 12px;
	behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
	cursor: hand;
}
</style>
		<script type="text/javascript">

		//判断输入是否为数字
		function checkIsNum(object)
		{
			  if(/\D/.test(object.value))
			  { //用正则判断 如果为false    ps:  /\D/  是正则表达 
	      	 	alert("必须输入数字！");
				object.value = "";
	      	 	object.focus();
				//object.select();
	    	  }
		}



function add() 
{
		var burYear = $("#burYear").val();
		var pouNum 	= $("#pouNum").val();
		var manNum 	= $("#manNum").val();
		var womanNum = $("#womanNum").val();
		var sixNum 	= $("#sixNum").val();
		var sixtyNum = $("#sixtyNum").val();
		var thtyNum = $("#thtyNum").val(); 	
		var fivetyNum = $("#fivetyNum").val(); 
		var eighteenNum = $("#eighteenNum").val();
		//alert(eighteenNum+"");
		var isChecked=$('input:radio[name="isChecked"]:checked').val(); 
		var id = "<s:property value='orgExtend.id'/>";
		var orgAreaid = "<s:property value='orgExtend.orgAreaId'/>";
		var orgCode = "<s:property value='orgExtend.orgCode'/>";
		var data = {
			"orgExtend.id" 			: id,
			"orgExtend.orgCode"		: orgCode,
			"orgExtend.burYear"		: burYear,
			"orgExtend.pouNum"		: pouNum,
			"orgExtend.manNum"		: manNum,
			"orgExtend.womanNum"	: womanNum,
			"orgExtend.sixNum"		: sixNum,
			"orgExtend.sixtyNum"	: sixtyNum,
			"orgExtend.thtyNum"		: thtyNum,
			"orgExtend.fivetyNum" 	: fivetyNum,
			"orgExtend.eighteenNum"	: eighteenNum,
			"orgExtend.isChecked"	: isChecked,
			"orgExtend.orgAreaId"	: orgAreaid
		};
	
		$.post("orgExtend_updateOrgExtend.action",
				 data, 
				 function(json)
				  {
					alert("更新成功!")
		})
};
//重置
function reset()
{
		location.reload(true);
}
function init ()
{
	var year = "<s:property value='orgExtend.burYear'/>";
	var count=$("#burYear option").length;
	var yearValue = $("#burYear ").get(0);
	for(var i=0;i<count;i++)  
     {           
	     if(yearValue.options[i].value == year)  
        {  
    	 yearValue.options[i].selected = true;  
            break;  
        }  
    }
}
</script>
	</head>
	<body onload="init()">
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：${ areaName} 信息修改
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
					<div class="mainmt" style="background:none; border-bottom:0; ">
						<table>
							<tr>
							<td class="tstd">
									年度：
								</td>
								<td>
									<select id="burYear" style="width:132px">
										<option value="2012">
											2012 年
										</option>
										<option  value="2013">
											2013 年
										</option>
										<option value="2014">
											2014 年
										</option>
										<option value="2015">
											2015 年
										</option>
										<option value="2016">
											2016 年
										</option>
									</select>
									<font color="red">*</font>
								</td>
								<td class="tstd">
									人口总数：
								</td>
								<td>
									<input name="pouNum" id="pouNum" type="text" onblur="checkIsNum(this)" value="${orgExtend.pouNum}"/>
								</td>
								
							</tr>
							<tr>
							<td class="tstd">
									男性人数：
								</td>
								<td>
									<input name="manNum" id="manNum"  type="text" onblur="checkIsNum(this)" value="${orgExtend.manNum}"/>
								</td>
								<td class="tstd">
									女性人数：
								</td>
								<td>
									<input name="womanNum"  id="womanNum" type="text" onblur="checkIsNum(this)" value="${orgExtend.womanNum}"/>
								</td>
								
							</tr>
							<tr>
                               <td class="tstd">
									0-6岁儿童：
								</td>
								<td>
									<input name="sixNum" id="sixNum" type="text" onblur="checkIsNum(this)" value="${orgExtend.sixNum}"/>
								</td>
								<td class="tstd">
									老人人数：
								</td>
								<td>
									<input name="sixtyNum" id="sixtyNum"  type="text" onblur="checkIsNum(this)" value="${orgExtend.sixtyNum}"/>
								</td>
								
							</tr>
                            <tr>
                            	<td class="tstd">
									35岁以上人口：
								</td>
								<td>
									<input name="thtyNum" id="thtyNum" type="text" onblur="checkIsNum(this)" value="${orgExtend.thtyNum}"/>
								</td>
								<td class="tstd">
									15岁以上人口：
								</td>
								<td>
									<input name="fivetyNum" id="fivetyNum" type="text" onblur="checkIsNum(this)" value="${orgExtend.fivetyNum}"/>
								</td>
							</tr>
							<tr>
								<td class="tstd" >
									18岁以上人口：
								</td>
								<td>
									<input name="eighteenNum" id="eighteenNum" type="text" onblur="checkIsNum(this)" value="${orgExtend.eighteenNum}"/>
								</td>
								<td class="tstd" >
									是否审核：
								</td>
								
								<td colspan="3">
									<s:if test="orgExtend.isChecked == 0">
										<input name="isChecked" id="isChecked" type="radio" value="0"
										checked="checked" />
									是
									<input name="isChecked" id="isChecked" type="radio" value="1" />
									否
									</s:if>
									<s:else>
										<input name="isChecked" id="isChecked" type="radio" value="0"
										 />
									是
									<input name="isChecked" id="isChecked" type="radio" value="1" checked="checked"/>
									否
									</s:else>
									
								</td>
                            </tr>
						</table>
						<br/>
						<div class="buut" align="right">
							<a HREF="#" onMouseOver="document.java.src='<%=path%>/images/axg.jpg'"
								onclick="return add();"
								onMouseOut="document.java.src='<%=path%>/images/xg.jpg'"> <img
									name="java" SRC="<%=path%>/images/xg.jpg" BORDER="0"> </a>
							<a HREF="#" onMouseOver="document.jav.src='<%=path%>/images/cz.jpg'"
								onMouseOut="document.jav.src='<%=path%>/images/acz.jpg'" onclick="return reset();"> <img
									name="jav" SRC="<%=path%>/images/acz.jpg" BORDER="0"> </a>
							<a HREF='orgextendManager.jsp?currPage=<s:property value="currPage"/>&totalPages=<s:property value="totalPages"/>&xianoldValue=<s:property value="xianoldValue"/>&xiangoldValue=<s:property value="xiangoldValue"/>&cunoldValue=<s:property value="cunoldValue"/>&flags=0&year=<s:property value="year"/>'  onMouseOver="document.java1.src='<%=path%>/images/fh.jpg'"
								onMouseOut="document.java1.src='<%=path%>/images/afh.jpg'">
								<img name="java1" SRC="<%=path%>/images/afh.jpg" BORDER="0"/>
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