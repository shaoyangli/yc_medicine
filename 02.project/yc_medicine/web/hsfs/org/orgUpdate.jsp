<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; utf-8" />
		<title>医疗机构更新</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/js/area.js"></script>
			<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
	
		
		<script type="text/javascript">
			function init(){
				selectUpOrg(0);
				  systeminit("<%=path%>");
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
		<script type="text/javascript">
		//重置
        function reset()
        {
				document.location.reload(true);
        }
			//选择2级下拉
			//参数说明: t 表示着是哪种调用.如果是三级联动的效果t=0, 如果t=1是为了给编辑页面赋值
        function selectOrg2(t,k)
        {
				var orgTypexs1 = $("#orgTypexs1").val();
				$("#orgTypexs2").empty();
				$("#orgTypexs2").append("<option value='0'>--请选择--</option>");
				$("#orgTypexs3").empty();
				$("#orgTypexs3").append("<option value='0'>--请选择--</option>");
				if(orgTypexs1 == 0)
				{
					return false;
				}
				else
				{
					data = {"orgTypexs1" : orgTypexs1};
			    	$.post("<%=path%>/org_selectOrg2.action",
					    	data,
			    			function(result)
			    			{
			    				var	orgTypexs2s = result.list2;
			    				var options = "";
			    				for(var i = 0;i < orgTypexs2s.length; i++)
			    				{
									options += "<option value='" + orgTypexs2s[i][0] + "'>" + orgTypexs2s[i][1] + "</option>"
				    			}
			    				$("#orgTypexs2").append(options);
			    				//给二级菜单选初值
			    				if(k == 1)
			    				{
			    					var orgTypex;
									if(t == 1)
									{
										orgTypex = "<s:property value='hobi.orgTypex'/>".substring(0,2);
									}
									else
									{
										orgTypex = "<s:property value='hobi.orgTypex'/>";
									}
									
									var orgLevelValue2 = $("#orgTypexs2 ").get(0);
									var count1=$("#orgTypexs2 option").length;
									for(var i=0;i<count1;i++)  
								     {           
									     if(orgLevelValue2.options[i].value == orgTypex)  
								        {  
								    	 orgLevelValue2.options[i].selected = true;  
								            break;  
								        }  
								    }
									selectOrg3(1);
					    		}
								
				    		}
					)
				}		
        }
        //选择三级下拉
        function selectOrg3(t)
        {
     	   var orgTypexs2 = $("#orgTypexs2").val();
     	   $("#orgTypexs3").empty();
			   $("#orgTypexs3").append("<option value='0'>--请选择--</option>");
     	   if(orgTypexs2 == 0)
     	   {
					return false;
            }
     	   else
     	   {
				   data = {"orgTypexs2" : orgTypexs2};
				   $.post("<%=path%>/org_selectOrg3.action",
					    	data,
			    			function(json1)
			    			{
			    				var	orgTypexs3s = json1.list3;
			    				var options = "";
			    				
			    				for(var i = 0;i < orgTypexs3s.length; i++)
			    				{
									options += "<option value='" + orgTypexs3s[i][0] + "'>" + orgTypexs3s[i][1] + "</option>"
				    			}
			    				$("#orgTypexs3").append(options);

			    				if(t == 1)
			    				{
			    					var orgTypex = "<s:property value='hobi.orgTypex'/>";
										var count=$("#orgTypexs3 option").length;
										var orgLevelValue = $("#orgTypexs3 ").get(0);
										for(var i=0;i<count;i++)  
									     {           
										     if(orgLevelValue.options[i].value == orgTypex)  
									        {  
									    	 orgLevelValue.options[i].selected = true;  
									            break;  
									        }  
									    }
									
				    			}
				    		}
					)
     	   }
        }
			//处理医疗机构级别的初始值
        function orgLevelInit()
        {
     	 //要对级别和医疗机构类型进行初始选择
				var orgOldLevel = "<s:property value='hobi.orgLevel'/>"
				var count=$("#orgLevel option").length;
				var orgLevelValue = $("#orgLevel ").get(0);
				  for(var i=0;i<count;i++)  
				     {           
					     if(orgLevelValue.options[i].value == orgOldLevel)  
				        {  
				    	 orgLevelValue.options[i].selected = true;  
				            break;  
				        }  
				    }
        }
		//给补偿级别初始化
		function orgBzbzInit() {
			var oldBzbz = "<s:property value='hobi.bzbzjb'/>";
			$("#bzbz").val(oldBzbz);
		}
		
        //给医疗机构类型赋初值
        
        function orgTypeInit()
        {
				var orgType = "<s:property value='hobi.orgTypex'/>";
				var data = {"orgType" : orgType};
				$.post("<%=path%>/org_findSorts.action",data,
						function(json)
						{
							var sorts =  json.sorts;//获得数据库中机构类型的sorts
							var orgTypex = "<s:property value='hobi.orgTypex'/>";

							if(sorts == 1)
							{
								var count=$("#orgTypexs1 option").length;
								var orgLevelValue = $("#orgTypexs1 ").get(0);
								for(var i=0;i<count;i++)  
							     {           
								     if(orgLevelValue.options[i].value == orgTypex)  
							        {  
							    	 orgLevelValue.options[i].selected = true;  
							            break;  
							        }  
							    }
							}

							if(sorts == 2)
							{
								var count=$("#orgTypexs1 option").length;
								var orgLevelValue = $("#orgTypexs1 ").get(0);
								var orgTypex1 = orgTypex.substring(0,1);
								for(var i=0;i<count;i++)  
							     {           
								     if(orgLevelValue.options[i].value == orgTypex1)  
							        {  
							    	 orgLevelValue.options[i].selected = true;  
							            break;  
							        }  
							    }
								selectOrg2(2,1);//加载好二级菜单的值 
							}
							if(sorts == 3)
							{
								var count=$("#orgTypexs1 option").length;
								var orgLevelValue = $("#orgTypexs1 ").get(0);
								var orgTypex1 = orgTypex.substring(0,1);
								for(var i=0;i<count;i++)  
							     {           
								     if(orgLevelValue.options[i].value == orgTypex1)  
							        {  
							    	 orgLevelValue.options[i].selected = true;  
							            break;  
							        }  
							    }
								selectOrg2(1,1);//加载好二级菜单的值 
							}
								
						}
				)
        }

		
           function updateOrg()
           {
     				//check();
                    var orgCode = $("#orgCode").val();
                    var orgName = $.trim($("#orgName").val());
                    var orgLevel = $("#orgLevel").val();
                    var orgId = $("#orgId").val();
                    var orgTypexs1 = $("#orgTypexs1").val();
                    var orgTypexs2 = $("#orgTypexs2").val();
                    var orgTypexs3 = $("#orgTypexs3").val();
                    var bzbz = $("#bzbz").val();
					var orgTypex = "";
					if(orgName.length == 0) {
						alert("机构名字不为空！");
						return false;
						
					}
					if(bzbz == 0) {
						alert("补助标准级别不能为空！");
						$("#bzbz").focus();
						return false;
					}
					if(orgTypexs3 != 0)
					{
						orgTypex =  orgTypexs3
					}
					else if(orgTypexs2 != 0 && orgTypexs3 == 0 )
					{
						orgTypex = orgTypexs2;
					}
					else{
						orgTypex = orgTypexs1;
					} 
					
					
					if(orgTypexs1 == 0)
					{
						alert("医疗机构类型不能为空！");
						$("#orgTypexs1").focus();
						return false;
					}
					if(orgLevel == 0) {
						alert("机构级别不能为空！");
						return false;
					}
					
                    var orgFatCode = $("#orgFatCode").val();
                    var appropriationOrg = $("#appropriationOrg").val();
                    var orgLeader = $("#orgLeader").val();
                    var orgPhone = $("#orgPhone").val();
                    var orgNccmcode = $("#orgNccmcode").val();

                    var xian = $("#xian").val();
                    var xiang = $("#xiang").val();
                    var cun = $("#cun").val();
                    var orgAddress = $("#orgAddress").val();
                    var superFlag = '${hobi.superFlag}';
					var orgAreaId;//orgAreaId
                   if(xiang.length == 0)
                   {
                	   orgAreaId = xian + "000000";
                   }
                   else if(cun.length == 0)
                   {
						orgAreaId = xian +	xiang.substring(0,2) + "0000";
                   }
                   else 
                   {
						orgAreaId = xian + xiang.substring(0,2) + cun.substring(2,4) + "00";
                   }
                 var data={
                		 "hobi.orgCode" : orgCode,
                		 "hobi.orgName" : orgName,
                		 "hobi.orgLevel" : orgLevel,
                		 "hobi.orgTypex" :  orgTypex,
                		 "hobi.orgFatCode" : orgFatCode,
                		 "hobi.appropriationOrg" : appropriationOrg,
                		 "hobi.orgLeader" : orgLeader,
                		 "hobi.orgPhone" : orgPhone,
                		 "hobi.orgNccmcode" : orgNccmcode,
                		"hobi.orgAreaId"	: orgAreaId,
                		 "hobi.orgAddress"	: orgAddress,
                		 "hobi.orgId"		: orgId,
                		 "hobi.superFlag"	: superFlag,
                		 "hobi.bzbzjb"		: bzbz,
                		 "_input_encode" 	: 'utf-8'
                 };
             
                 $.post("<%=path%>/org_updateOrg.action",
                         data,
                         function(json)
                         {
							alert("编辑成功！")
                         }
                 );
           }

         //查询医疗机构的上级机构
           function selectUpOrg(r) {
				
				var orgAreaId = '${hobi.orgAreaId }';
				var orgLevel = ${hobi.orgLevel};
				var param = "";//查询上级的区域id信息
				var level = "";//查询机构的级别

				if(r == 0)//加载页面的情况
				{
					if(orgLevel == "3")
					{
						param = orgAreaId.substring(0,6);
						level = 4;
						//return false;
					}
					if(orgLevel == "2")//乡级机构 ,需要查询的县级机构
					{
						param = orgAreaId.substring(0,6);
						level = 3;
					}
					if(orgLevel == "1")//编辑的是村级机构,查询一个乡级机构出来
					{
						param = orgAreaId.substring(0,8);
						level = 2;
					}
				}
				if(r == 1)//机构级别发生了改变
				{
					var lev = $("#orgLevel").val();
					//alert(lev);
					$("#orgFatCode").empty();
					$("#orgFatCode").append("<option value='0'>--请选择--</option>");
					
					$("#appropriationOrg").empty();
					$("#appropriationOrg").append("<option value='0'>--请选择--</option>");
					if(lev == "2" || lev == "3")
					{
						param = orgAreaId.substring(0,6);
						level = 3;
					}
					if(lev == "1")
					{
						param = orgAreaId.substring(0,8);
						level = 2;
					}
					if(lev == 0) {
						return false;
					}
				}
				
				var data = {"param" : param,"level" : level};
					$.post("<%=path%>/org_findUpOrg.action",data,
						function(json)
						{
							var uporgs = json.list;
							var result = json.list4;
							var options = "";
							var op = "";
							for(var i=0;i< uporgs.length;i++ )
							{
								options += "<option value='" + uporgs[i][0] + "'>" + uporgs[i][1] + "</option>"
							}
							for(var i=0;i< result.length;i++ )
							{
								op += "<option value='" + result[i][0] + "'>" + result[i][1] + "</option>"
							}
							$("#orgFatCode").append(options);
							$("#appropriationOrg").append(op);
							var fatCode = '${hobi.orgFatCode}';
							var orgbc = '${hobi.appropriationOrg}';
							if(fatCode.length > 0)
							{
								var orgFatCode = $("#orgFatCode").get(0);
								var count=$("#orgFatCode option").length;
								for(var i=0;i<count;i++)  
				    		 	{           
					     			if(orgFatCode.options[i].value == fatCode)  
				        			{  
					     				orgFatCode.options[i].selected = true;  
				            			break;  
				        			}  
				    			}
							}
							if(orgbc.length > 0)
							{
								var appropriationOrg = $("#appropriationOrg").get(0);
								var count=$("#appropriationOrg option").length;
								for(var i=0;i<count;i++)  
				    		 	{           
					     			if(appropriationOrg.options[i].value == orgbc)  
				        			{  
					     				appropriationOrg.options[i].selected = true;  
				            			break;  
				        			}  
				    			}
							}
							//让上级下拉默认选中
							
						},'json'
					)
				
           }
           
           
			//初始化医疗机构级别和类型
           $(document).ready(
				function()
				{
					$.post("<%=path%>/org_findDic.action",
						function(json)
						{
							var orglevels = json.list;	
							var orgTypes = json.list1;
							var orgBzBz = json.list2;
							var options="";
							var optionss= "";
							var optionsss= "";
							for(var i=0;i< orglevels.length;i++ )
							{
								optionss += "<option value='" + orglevels[i][0] + "'>" + orglevels[i][1] + "</option>"
							}
							for(var j= 0; j < orgTypes.length;j++)
							{ 
								options+="<option value='" + orgTypes[j][0] + "'>" + orgTypes[j][1] + "</option>";
							}
							for(var j= 0; j < orgBzBz.length;j++)
							{ 
								optionsss+="<option value='" + orgBzBz[j][0] + "'>" + orgBzBz[j][1] + "</option>";
							}
							$("#bzbz").append(optionsss);
							$("#orgLevel").append(optionss);
							$("#orgTypexs1").append(options);
							

							orgLevelInit();//给医疗机构赋初值
							orgTypeInit();
							orgBzbzInit();
															
							
						}
					)
				}
            )
           
</script>
	</head>
	<body onload="init();">
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintl"></div>
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：医疗机构更新
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div class="mainmt">
						<table>
							<tr>
								<td class="tstd">
									机构所在地区：
									
									<input type="hidden" id="areaid" value="${hobi.orgAreaId }" />
									
									<s:if test="hobi.orgAreaId.substring(6,8) != 00">
										<input type="hidden" id="xiangOldValue" value="<s:property value="hobi.orgAreaId.substring(6,8)"/>0000"/>
									</s:if>
									<s:if test="hobi.orgAreaId.substring(4,6) != 00">
										<input type="hidden" id="xianOldValue" value="<s:property value="hobi.orgAreaId.substring(0,6)"/>"/>
									</s:if>
									<s:if test="hobi.orgAreaId.substring(8,10) != 00">
										<input type="hidden" id="cunOldValue" value="<s:property value="hobi.orgAreaId.substring(6,10)"/>00"/>
									</s:if>
								</td>
								<td colspan="3">
									<select id="sheng" name="sheng" style="display: none;"></select>
									<select id="shi" name="shi" style="display: none;"></select>
									<select name="xian" id="xian" onchange="xianselect()" style="width:132px" disabled="disabled"></select>
									县(区)
									<select name="xiang" id="xiang" onchange="xiangselect()" disabled="disabled" style="width:132px"></select>
									乡(镇、街道)
									<select name="cun" id="cun" disabled="disabled" style="width:132px"></select>
									村(居委会)
								</td>
							</tr>
							<tr>
								<td class="tstd">
									机构类型：
								</td>
								<td>
									<select name="orgTypexs1" id="orgTypexs1" onchange="selectOrg2(0,0)" style="width:132px">
										<option value="0">--请选择--</option>
									</select>
									<select name="orgTypexs2" id="orgTypexs2" onchange="selectOrg3(0)" style="width:132px">
										<option value="0">--请选择--</option>
									</select>
									<select name="orgTypexs3" id="orgTypexs3" style="width:132px">
										<option value="0">--请选择--</option>
									</select><font color="red">*</font>
								</td>
								<td class="tstd">
									机构级别：
								</td>
								<td>
									<select name="orgLevel" id="orgLevel" onchange="selectUpOrg(1)" style="width:132px">
										<option value="0">--请选择--</option>
									</select><font color="red">*</font>
								</td>
							</tr>	

							<tr>
								<td class="tstd">
									机构编码：
								</td>
								<td>
									<input name="orgCode" type="text" id="orgCode" value="${hobi.orgCode }" readonly="readonly" disabled="disabled"/><font color="red">*</font>
								</td>
								<td class="tstd">
									机构名称：
								</td>
								<td>
									<input name="orgName" type="text" id="orgName" value="${hobi.orgName }"/><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									补助级别：
								</td>
								<td>
									<select name="bzbz" id ="bzbz" style="width:132px">
										<option value="0">--请选择--</option>
									</select>
								</td>
								
								<td class="tstd">
									上级机构：
								</td>
								<td>
									<select name="orgFatCode" id="orgFatCode" style="width:132px">
										<option value="0">--请选择--</option>
									</select>
								</td>
								
								
							</tr>
							<tr>
							</tr>
							<tr>
								<td class="tstd">
									农合机构编码：
								</td>
								<td>
									<input name="orgNccmcode" type="text" id="orgNccmcode" value="${hobi.orgNccmcode }"/>
								</td>
								<td class="tstd">
									法人代表：
								</td>
								<td>
									<input name="orgLeader" type="text" id="orgLeader" value="${hobi.orgLeader }"/>
								</td>
								
								
							</tr>
							<tr>
								
								<td class="tstd">
									拨款机构：
								</td>
								<td>
									<select name="appropriationOrg" id="appropriationOrg" style="width:132px">
										<option value="0">--请选择--</option>
									</select>
								</td>
								
								<td class="tstd">
									联系电话：
								</td>
								<td>
									<input name="orgPhone" type="text" id="orgPhone" value="${hobi.orgPhone }"/>
								</td>
								</tr>
								<tr>
								<td class="tstd">
									对应机构编码：
								</td>
								<td>
									<input type="text" id="orgId" onblur='checkIsNum(this)' value="${hobi.orgId}"/>
								</td>
								<td	class="tstd">
									机构详细地址：
								</td>
								<td colspan="3">
									<textarea  id="orgAddress" name="orgAddress" style="width: 200px; height: 80px;" >${hobi.orgAddress }</textarea>
								</td>
								
							</tr>
						</table>
						<div class="buut">
							
							<a HREF="#"  onMouseOver="document.java.src='<%=path%>/images/axg.jpg'"
								onclick="return updateOrg();"
								onMouseOut="document.java.src='<%=path%>/images/xg.jpg'">
								<img name="java" SRC="<%=path%>/images/xg.jpg" BORDER="0">
							</a>
							<a HREF="#" onMouseOver="document.jav.src='<%=path%>/images/cz.jpg'"
								onMouseOut="document.jav.src='<%=path%>/images/acz.jpg'" onclick="return reset();"> <img
									name="jav" SRC="<%=path%>/images/acz.jpg" BORDER="0"> 
							</a>
							<a HREF='orglist.jsp?currPage=<s:property value="currPage"/>&totalPages=<s:property value="totalPages"/>&xianoldValue=<s:property value="xianoldValue"/>&xiangoldValue=<s:property value="xiangoldValue"/>&cunoldValue=<s:property value="cunoldValue"/>&flags=0&orgName=<s:property value="orgName"/>'  onMouseOver="document.java1.src='<%=path%>/images/fh.jpg'"
								onMouseOut="document.java1.src='<%=path%>/images/afh.jpg'">
								<img name="java1" SRC="<%=path%>/images/afh.jpg" BORDER="0">
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