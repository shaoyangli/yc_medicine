<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*,com.kh.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
HsfsOrgBaseInfo org = (HsfsOrgBaseInfo)session.getAttribute("org");
String areaid = RetrunAreaId.callAreaid(org);
String year = session.getAttribute("year").toString();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>服务记录管理</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet" type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/area_org.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>	
		<script type="text/javascript" src="<%=path%>/js/orgServ.js"></script>
		<script type="text/javascript">
			
			function init()
		     {
				systeminit("<%=path%>");
				//initYear();
				initServiceType();
				checkIndexs();
				findList(1,0);
			 }
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
			 //初始化服务类型
			 function initServerType()
			 {
				$("#serverType").empty();
				$("#serverType").append("<option value='0'>&nbsp;--请选择--</option>")
				var year = $("#buryear").val();
				$.post("orgServer_findServerType.action?year="+year,
						
						function(json)
						{
							var resultList = json.serverType;
							options = "";
							for(var i = 0; i<resultList.length;i++)
							{
								options += "<option value='"+ resultList[i][0] + "'>" + resultList[i][1]+"</option>";
							}
							$("#serverType").append(options);
						}

				)
			 }

			//根据条件 查询 机构 
				function findList(currPage,totalPages)
				{
					
					var xian = $("#xian").val();
					var xiang = $("#xiang").val();
					var cun = $("#cun").val();
					var year = $("#buryear").val();//年度
					var param = "";
					var serviceType = $("#serviceType").val();
					var checkIndex	= $("#checkIndex").val();
					//xian为空说明第一次加载页面
					if(xian == null || xian == "")
					{
						xian = "<%=areaid%>";
						param += xian;
					}
					else
					{
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
					var jigou = $("#jigou").val();
					
					var data = {"param" : param,"year" : year,"serviceType" : serviceType,"checkIndex" : checkIndex,"orgCode" : jigou};
					plan.show();
					$.post("orgServer_findOrgService.action?currPage="+currPage+"&totalPages="+totalPages,data,
							function(json)
							{
								var page = json.pages
								var list = page.list;
								//var forms  ="";//翻页
								//定义一个table 放入数据内容的
								var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>"
								//此处tables拼上两个hidden  保存当前也和总页码 为了删除的时候获得
								tables +="<th><input type='checkbox' onclick='allCheck(this)'/></th><th width='30px'>序号</th><th>服务指标</th><th>机构名称</th><th>服务类型</th><th>服务说明</th><th>服务时间<input type='hidden' id='currPage1' value='"+ page.currPage +"'/><input type='hidden' id='totalPages1' value='"+ page.totalPages +"'/></th></tr>";
								var trs = "";
								 $.each(list,function(i, obj) //对从action获取一个json进行遍历操作
								{
									if(i%2==0){
										trs+="<tr class='tstr' >";
									}else{
										trs+="<tr >";
									}
									if(obj[6]!=""&&obj[6]==1){
										trs += "<td><input name='count' type='checkbox' value='"+ obj[0]+"'/></td><td style='color:green'>"+(i+1)+"</td><td style='color:green'><a href='orgServer_findSingleOrgServce.action?id=" + obj[0] + "' target='_blank' style='color:green'>"+obj[3]+"</a></td><td style='color:green'>"+obj[1]+"</td><td style='color:green'>"+obj[2]+"</td><td style='color:green'>"+obj[4]+"</td><td style='color:green'>"+obj[5]+"</td></tr>";
									}else{
										trs += "<td><input name='count' type='checkbox' value='"+ obj[0]+"'/></td><td>"+(i+1)+"</td><td><a href='orgServer_findSingleOrgServce.action?id=" + obj[0] + "' target='_blank'>"+obj[3]+"</a></td><td>"+obj[1]+"</td><td>"+obj[2]+"</td><td>"+obj[4]+"</td><td >"+obj[5]+"</td></tr>";
									}
		                     		
		                        });
			                        if(trs == "")
			                        {
			                        	trs+="<tr ><td colspan='10' align='center' >暂无数据</td></tr>";
				                    }
			                    tables +=trs+"</table>";
			                   plan.hidden(page,tables);
						}
					)
				}

				function deletes()//处理记录的删除
				{	

					var currPage = $("#currPage1").val();
					var totalPages = $("#totalPages1").val();
					var merList=$("input[name='count']:checked");		
					if(merList.length < 1)
					{
						alert("请先选择你要删除的记录！");
						//return false;
					}else{
					    var list = "";
						merList.each(function(i)
						{
							list += $(this).val()+",";
						});	
						var da ={"delids":list.substring(0,list.length-1)};	
						$.post("orgServer_beforedel.action",da,function(json) {
	      					var result=json.serInfo;
	      					var before = json.param; 
	      					if(result!=""){
	      						 alert("指标为\n\n "+result+" 的记录\n\n 已做过申请，不能删除！");
	      						 return false;
	      					}
	      					if(before !="") {
	      						alert("指标为:\n\n" + before + "的记录\n\n非本机构上传,没有删除权限！")
	      						return false;
	      					}
	      					
	      					confirm1("orgServer_removeOrgService.action",currPage,totalPages);
	      					
	   					}, 'json');
	   				}
				}
		</script>	

	</head>
	<body onload="init();">
	<div class="main">
		<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：
					<% String loct = request.getParameter("loct");
					System.out.print(loct);
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="公共服务记录管理 ";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
		</div>
		<div class="mianm">
			<div class="mainmt">
			<table>
						<tr >
							<td class="tstd">
								&nbsp;&nbsp;县(区)：
							</td>
							<td><select id="sheng" name="sheng" style="display: none;"></select>
							<select id="shi" name="shi" style="display: none;"></select>
								<select name="" id="xian" onchange="xianselect()"
									style="width: 120px"></select>
							</td>
							<td class="tstd" >
								乡(镇、街道)：
							</td>
							<td>
								<select name="" id="xiang" onchange="xiangselect()"
									style="width: 120px"></select>
							</td>
							<td class="tstd">
								村(居委会)：
							</td>
							<td >
								<select name="" id="cun" style="width: 120px" onchange="selectjigou()"></select>
							</td>
							<td   rowspan="2">
							<a href="javascript:void(0)" onclick="findList(1,0)"> <img
										style="vertical-align: middle;" src="<%=path%>/images/cx2.gif"
										border="0" /> </a>
							</td>
						</tr>
						<tr>
							<td class="tstd">
								服务机构：
							</td>
							<td>
							<input type="hidden" value="<%=year%>" id="buryear" name="buryear"/>
							<select id="jigou" name="jigou" style="width: 120px">
							</select>
							</td>
							<td class="tstd">
								服务类型：
							</td>
							<td>
								<select name="" id="serviceType" style="width: 120px;" onchange="checkIndexs()"></select>
							</td>
							<td class="tstd">
								考核指标：
							</td>
							<td>
								<select name="checkIndex" id="checkIndex" style="width: 120px;"></select>
							</td>
							
						</tr>
					</table>
			</div>
			
			<div class="mianmm">
						<table id="mytable">
							<tr>
								<td colspan="5"
									style="border: none; text-align: left; color: #324269;">
									<img src="<%=path%>/images/lbt.gif" />
									查询列表
								</td>
								<td colspan="5"
									style="border: none; text-align: right; padding-right: 8px;">
									<img src="<%=path%>/images/sc.gif" />
									<a href="javascript:deletes()">删除</a>
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
			<input id="arrayid" name="arrayid"  type="hidden" />
		</div>
	</div>
	</body>
</html>