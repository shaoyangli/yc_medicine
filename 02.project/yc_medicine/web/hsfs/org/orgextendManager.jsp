<%@ page language="java" import="com.kh.util.*,com.kh.hsfs.model.*,java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	HsfsOrgBaseInfo org = (HsfsOrgBaseInfo)session.getAttribute("org");
	String year = (String)session.getAttribute("year");
	String areaid = RetrunAreaId.callAreaid(org);
	
	String currPage = request.getParameter("currPage");
	String totalPagesq = request.getParameter("totalPages");
	String xianoldValue = request.getParameter("xianoldValue");
	String xiangoldValue = request.getParameter("xiangoldValue");
	String cunoldValue = request.getParameter("cunoldValue");
	String flags = request.getParameter("flags");
	String oldYear =request.getParameter("year");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>辖区服务信息查询</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet" type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/area.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script type="text/javascript">
		var xianoldValue =  "<%=xianoldValue%>";
		var xiangoldValue = "<%=xiangoldValue%>";
		var cunoldValue ="<%=cunoldValue%>";
		var currPage = "<%=currPage%>";
		var totalPagesq ="<%=totalPagesq%>";
		var flags = "<%=flags%>";
	  function deletes()//处理记录的删除
      {	
		  	var currPage = $("#currPage1").val();
			var totalPages = $("#totalPages1").val();
			confirm1("orgExtend_removeOrgExtend.action",currPage,totalPages);
		<%--
  	     if(confirm("确定要删除数据吗？"))
        	 {   		 
				var merList=$("input[name='count']:checked");		
				if(merList.length < 1)
				{
					alert("请选择你要删除的记录...");
				}
				else
				{
					var list = {};
					merList.each(function(i)
					{
						list[i] = $(this).val();
					});	
					var currPage = $("#currPage1").val();
					var totalPages = $("#totalPages1").val();
					var data ={"deleteList":list};				
				   	var url="orgExtend_removeOrgExtend.action";
				//提交
				   $.post(url,data,
						function()
						{
							alertFind("删除成功",currPage,totalPages); 
						}
					);
				}
		   	}
		   	 --%>
    	  }
      function editorOrgExtend()
      {
    	var currPage = $("#currPage1").val();
  		var totalPages = $("#totalPages1").val(); 
  		var xian = $("#xianOldValue").val();
  		var xiang = $("#xiangOldValue").val();
  		var cun = $("#cunOldValue").val();
  		var year = $("#yearOldValue").val();
  		var url = "orgExtend_findOneOrgExtend.action?currPage=" + currPage + "&totalPages=" + totalPages +"&year=" +year; 
  		if(xian != "")
		{
			url += "&xianoldValue ="+xian;
		}
		if(xiang != "")
		{
			url += "&xiangoldValue ="+xiang;
		}
		if(cun != ""){
			url += "&cunoldValue ="+cun;
		}
		//if(year )
		url += "&id=";
		editor(url);     
   	}
     function allCheck(check)
     {
　　　       　var checkbox=document.getElementsByName("count");
　　　　           if(check.checked){
　　　　　　for(var i=0;i<checkbox.length;i++){
　　　　　　　　checkbox[i].checked="checked";
                }
　　　　　　}else{
　　　　　　                for(var i=0;i<checkbox.length;i++){
　　　　　　　　checkbox[i].checked="";
　　　　　　} 
　　　　}  
 	}
   //根据系统时间初始化年度
	 function initYear()
	 {
		 var year=<%=Calendar.getInstance().get(Calendar.YEAR) %>;
		 var oldYear="<%=oldYear%>";//获得从返回页面过来的值
		if(oldYear != "null" &&oldYear != "" && oldYear != null)
		{
			year = oldYear;
		}	
		 var count=$("#year option").length;
			var yearValue = $("#year ").get(0);
			for(var i=0;i<count;i++)  
		     {           
			     if(yearValue.options[i].value == year)  
		        {  
		    	 yearValue.options[i].selected = true;  
		            break;  
		        }  
		     }
	 }	

     function init()
     {
    	 if(xianoldValue != "0"&&xianoldValue!=""&&xianoldValue!='null')
 		{
 			$("#xianOldValue").val(xianoldValue);
 		}
 		if(xiangoldValue != "0"&&xiangoldValue!=""&&xiangoldValue!='null')
 		{
 			$("#xiangOldValue").val(xiangoldValue);
 		}
 		if(cunoldValue != "0"&&cunoldValue!=""&&cunoldValue!='null')
 		{
 			$("#cunOldValue").val(cunoldValue);
 		}
 		if(flags == "0" || flags == 'null' || flags == null)
		{
			$("#flags").val('0');//给隐藏元素赋值0
			currPage = 0;
			totalPagesq = 1;
			
		}
 		systeminit("<%=path%>");
		initYear();
		findList(currPage,totalPagesq);
		
	 }

		//根据条件 查询 机构 
		function findList(currPage,totalPages)
		{
			var flags = $("#flags").val();//得到标志
			var xian = $("#xian").val();
			var xiang = $("#xiang").val();
			var cun = $("#cun").val();
			var year = '<%=year%>'
			//var currentYear=<%=Calendar.getInstance().get(Calendar.YEAR) %>
			//var oldYear = $("#yearOldValue").val();
			var param = "";
			//xian为空说明第一次加载页面
			//if(xian == "null"||xian == null || xian == "")
			if(flags == "0")
			{
				
				//此时从左菜单过来的数据
				if(xianoldValue == 'null' || xianoldValue == null || xianoldValue == "")
				{
					xian = "<%=areaid%>";
					param += xian;
					$("#flags").val('');
				}
				//此时为返回到情况
				else
				{
					//县
					if(xiangoldValue.length == 0 && cunoldValue.length == 0)
					{
						param += xianoldValue
					}
					//县乡
					if(cunoldValue.length == 0 && xiangoldValue.length > 0)
					{
						param = xianoldValue + xiangoldValue.substring(0,2);
					}
					//县乡村全有
					if(cunoldValue.length > 0)
					{
						param = xianoldValue + cunoldValue.substring(0,4);
					}
					$("#flags").val('');
				}
					
			}
			//处理查询条件的情况
			else
			{
				
				//给隐藏的元素赋值,为以后更新最返回到时候保存查询条件
				if(xian != ""&&xian != "null"&&xian != null)
				{
					$("#xianOldValue").val(xian);
				}
				if(xiang != ""&&xiang != "null"&&xiang != null)
				{ 
					$("#xiangOldValue").val(xiang);
				}
				if(cun != ""&&cun != "null"&&cun != null)
				{
					$("#cunOldValue").val(cun);
				}
				$("#yearOldValue").val(year);//保存年度值
				//根据县乡村信息传递查询条件
				if(xiang.length == 0 && cun.length == 0)
				{
					param += xian
				}
				if(cun.length == 0 && xiang.length > 0)
				{
					param = xian + xiang.substring(0,2);
				}
				if(cun.length > 0)
				{
					param = xian + cun.substring(0,4);
				}
			}
			plan.show();
			var data = {"param" : param,"year" : year};
			$.post("orgExtend_findOrgInfo.action?currPage="+currPage+"&totalPages="+totalPages,data,
					function(json)
					{
						var page = json.findOrgExtendResult
						var list = page.list;
						$("#orgList").empty();//清空div
						//var forms  ="";//翻页
						//定义一个table 放入数据内容的
						var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>"
						//此处tables拼上两个hidden  保存当前也和总页码 为了删除的时候获得
						tables +="<th>辖区</th><th>年度</th><th>人口总数</th><th>男性人口</th><th>女性人口</th><th>0-6岁儿童</th><th>65岁以上人口</th><th>35岁以上人口<input type='hidden' id='currPage1' value='"+ page.currPage +"'/><input type='hidden' id='totalPages1' value='"+ page.totalPages +"'</th><th>孕产妇人数</th><th>高血压人数</th><th>糖尿病</th><th>精神病</th><th>预计申请金额（元）</th><th>登记日期</th><th>登记机构</th><th>登记人姓名</th><th>是否汇总</th></tr>";
						var trs = "";
						$.each(list,function(i, obj) //对从action获取一个json进行遍历操作
						{
							if(i%2==0){
								trs+="<tr class='tstr'>";
							}else{
								trs+="<tr >";
							}
							if(obj[16] == 0) {
								obj[16] = '未汇总';
							}
							if(obj[16] == 1) {
								obj[16] = '已汇总';
							}
							if(obj[16] == 2) {
								obj[16] = '已拨付';
							}
                     		trs += "<td>"+obj[0]+"</td><td>"+obj[1]+"</td><td>"+obj[2]+"</td><td>"+obj[3]+"</td><td>"+obj[4]+"</td><td>"+obj[5]+"</td><td>"+obj[6]+"</td><td>"+obj[7]+"</td><td>"+obj[8]+"</td><td>"+ obj[9] + "</td><td>"+obj[10]+"</td><td>"+obj[11]+"</td><td>"+obj[12]+"</td><td>"+obj[13]+"</td><td>"+obj[14]+"</td><td>"+obj[15]+"</td><td>"+obj[16]+"</td></tr>";
                        });

                        if(trs == "")
                        {
                        	trs+="<tr ><td colspan='14' align='center'>暂无数据</td></tr>";
                        }
	                    tables +=trs+"</table>";
	                    plan.hidden(page,tables);
					}
			)
			
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
					当前位置：辖区服务信息登记查询
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mainmt" style="height:45px;">						
						<p>
							<select id="sheng" name="sheng" style="display: none;"></select>
							<select id="shi" name="shi" style="display: none;"></select>
							县(区)：
							<select name="xian" id="xian" style="width:100px;" onchange="xianselect()"></select>
							乡(镇、街道)：
							<select name="xiang" id="xiang" style="width:100px;" onchange="xiangselect()"></select>
							村(居委会)：
							<select name="cun" id="cun" style="width:100px;"></select>
							<!--  
							年 度：
							<select name="year" id="year" style="width:100px;">
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-4 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-4 %>年</option>
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-3 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-3 %>年</option>
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-2 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-2 %>年</option>
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR)-1 %>"><%=Calendar.getInstance().get(Calendar.YEAR)-1 %>年</option>		
								<option value="<%=Calendar.getInstance().get(Calendar.YEAR) %>"><%=Calendar.getInstance().get(Calendar.YEAR) %>年</option>
							</select>
							-->
							<input name="" type="button" class="an" onclick="return findList(1,0);"/>
						</p>
					</div>
				<div class="mianmm">
					<div class="tab"></div>
				<input type="hidden" id="xianOldValue"/>
				<input type="hidden" id="xiangOldValue"  />
				<input type="hidden" id="cunOldValue"/>
				<input type="hidden" id="yearOldValue"/>
				<input id="arrayid" name="arrayid"  type="hidden" />
				<input id ="flags"  type="hidden"/>
						<table id="mytable">
							<tr>
								<td colspan="5"
									style="border: none; text-align: left; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									查询列表
								</td>
								<td colspan="5">
									
								</td>
							</tr>
							</table>
							<!-- 隐藏部分 开始 -->
							<div id="pagelist" style="margin:0 auto;" class="fakeContainer">
          					</div>
							<div id="pagelist1">
							</div>
							<!-- 隐藏部分结束 -->
				</div>
			</div>
			<div class="mainb">
				<div class="mainbl"></div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>
		</div>
	</body>
</html>
