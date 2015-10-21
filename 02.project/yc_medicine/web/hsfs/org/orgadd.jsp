<%@ page language="java" import="com.kh.hsfs.model.*,com.kh.util.*" pageEncoding="gbk" %>
<%
	String path = request.getContextPath();
	HsfsOrgBaseInfo orgBaseInfo = (HsfsOrgBaseInfo)session.getAttribute("org");
	String areaid = orgBaseInfo.getOrgAreaId();
	String orgLevel = orgBaseInfo.getOrgLevel();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; gbk" />
		<title>医疗机构添加</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/area.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<style type="text/css">
.search {
	font-family: "宋体";
	font-size: 12px;
	behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
	cursor: hand;
}
</style>
		<script type="text/javascript">
		function init(){
				  systeminit("<%=path%>");
				  selectUpOrg(0);//第一次加载页面的时候需要根据登录用户的级别来添加上级机构的下拉项 传 0
		}
           function add()
           {
               		//check();
                    var orgCode = $("#orgCode").val();
                    var orgName = $("#orgName").val();
                    var orgLevel = $("#orgLevel").val();

                     var orgTypexs1 = $("#orgTypexs1").val();
                    var orgTypexs2 = $("#orgTypexs2").val();
                    var orgTypexs3 = $("#orgTypexs3").val();

					var orgTypex = "";

					var orgFatCode = $("#orgFatCode").val();
					var appropriationOrg = $("#appropriationOrg").val();
                    var orgLeader = $("#orgLeader").val();
                    var orgPhone = $("#orgPhone").val();
                    var orgNccmcode = $("#orgNccmcode").val();
                    var orgId = $("#orgId").val();
                    var bzbz = $("#bzbz").val();
						
					if(orgCode.length == 0)
					{
						alert("医疗机构编号不能为空！");
						$("#orgCode").focus();
						return false;
					}
					if(orgCode.length > 20)
					{
						alert("医疗机构编号过长,小于20字符！");
						$("#orgCode").val('');
						$("#orgCode").focus();
						
						return false;
					}
					
					if(orgName.length == 0)
					{
						alert("医疗机构名字不能为空！");
						
						$("#orgName").focus();
						return false;
					}
					if(orgName.length > 40)
					{
						alert("医疗机构名字不能为大于40字符！");
						$("#orgName").val('');
						$("#orgName").focus();
						return false;
					}
					if(orgLevel == 0)
					{
						alert("必须选择医疗机构级别！");
						$("#orgLevel").focus();
						return false;
					}

					if(orgTypexs1 == 0)
					{
						alert("医疗机构类型不能为空！");
						$("#orgTypexs1").focus();
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
					else 
						orgTypex = orgTypexs1;
                    

                    var xian = $("#xian").val();
                    var xiang = $("#xiang").val();
                    var cun = $("#cun").val();
                    var orgAddress = $("#orgAddress").val();
					var orgAreaId;
					
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
                		 "hobi.bzbzjb"		: bzbz,
                		 "_input_encode" 	: 'utf-8'
                 };
             
                 $.post("<%=path%>/org_orgSave.action",
                         data,
                         function(json)
                         {
							var result = json.result;
							if(result == 1)
							{
								alertReset("保存成功！")
							}
							else
								alert("失败！")
                         }
                 );
           }
           //重置
           function resets() {
        	   	$("#orgCode").val("");
				$("#orgName").val("");
				//$("#orgLevel").val(0);
				$("#orgFatCode").val("");
				$("#orgLeader").val("");
				$("#orgPhone").val("");
				$("#orgNccmcode").val("");
				$("#orgAddress").val("");
        	   
           }
			//选择2级下拉
           function selectOrg2()
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
				    		}
					)
				}		
           }
           //选择三级下拉
           function selectOrg3()
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
				    		}
					)
        	   }
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
							$("#orgLevel").append(optionss);
							$("#orgTypexs1").append(options);
							$("#bzbz").append(optionsss);
						},'json'
					)
				}
            )
            function xiangselect1() {
				xiangselect();
				$("#orgFatCode").empty();//清空上级机构中下拉
				$("#appropriationOrg").empty();//清空拨款机构中的下拉
				$("#orgFatCode").append("<option value='0'>--请选择--</option>");
				$("#appropriationOrg").append("<option value='0'>--请选择--</option>");
				selectUpOrg(1,"xiang");//给上级机构下拉赋值
				//让医疗机构的级别下拉默选中
				var xiang = $("#xiang").val();
				if(xiang == '') {
					levelSelected(3);
				}
				else {
					levelSelected(2)
				}
				
            }
           
           function cunselect1() {
        	   $("#orgFatCode").empty();//清空上级机构中下拉
        	   $("#appropriationOrg").empty();//清空拨款机构中的下拉
				$("#orgFatCode").append("<option value='0'>--请选择--</option>");
				$("#appropriationOrg").append("<option value='0'>--请选择--</option>");
				selectUpOrg(1,"cun");
				var cun = $("#cun").val();
				if(cun == '') {
					levelSelected(2);
				}
				else {
					levelSelected(1);
				}
           }
           //机构根据区域的选择默认选中一个值
           function levelSelected(t)
           {
        	   var orgLevel = $("#orgLevel").get(0);
				var count=$("#orgLevel option").length;
				for(var i=0;i<count;i++)  
			     {           
				     if(orgLevel.options[i].value == t)  
			        {  
				    	 orgLevel.options[i].selected = true;  
			            break;  
			        }  
			    }
           }
           //查询医疗机构的上级机构
           function selectUpOrg(t,l) {
				var param;
				var level;
				var xian;
				var xiang;
				var cun;
				//t=1说明此时选择了区域信息
				if(t == 1)
				{
					//乡按钮发生改变的时候无需关心村 只需要查询出县就好
					if(l == "xiang")
					{
						xian = $("#xian").val();
						xiang = $("#xiang").val();
						param = xian;
						level = 3;
					}
					//村按钮发生改变只需要查询出上级乡即可
					if(l == "cun")
					{
						var xian = $("#xian").val();
						xiang = $("#xiang").val();
						var cun = $("#cun").val();
						if(cun == "") {
							param = xian;
							level = 3;
						}
						else {
							param = xian + cun.substring(0,2);
							//alert(param)
							level = 2;
						}
						
					}
					
				}
				if(t == 0)
				{
					level = <%=orgLevel%>;
					param = "<%=areaid%>";
					
					if(level == 2 || level == 3)
					{
						param = param.substring(0,6);
					}
					if(level == 1)
					{
						param = param.substring(0,8);
					}
					level = level +1;
					
				}
				
				
			//	var param = xian + xiang;
				var data = {"param" : param,"level" : level};
					$.post("<%=path%>/org_findUpOrg.action",data,
						function(json)
						{
							var uporgs = json.list;
							var result = json.list4;
							var options = "";
							var op="";
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
						},'json'
					)
				
           }
           
      function checkOrgCode(obj) {
    	  checkIsNum(obj);
    	  var orgCode = obj.value;
    	  $.post("org_checkOrgCode.action?orgCode="+orgCode,
    	   function(json){
    		  var count = json.level;
    		  if(count == 1) {
    			  alert("机构编码重复,请重新填写！");
    			  obj.focus();
    			  obj.value = '';
    			  return false;
    		  }
    	   })
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
					当前位置：医疗机构添加
				</div>
				<div class="maintr"></div>
			</div>

			<div class="mianm">
				<!---nr begin------------------------->
				<div class="mainmt">
					<form action=""  name="form1" method="post">
						<table>
							<tr>
								<td class="tstd">
									机构所在地区：
								</td>
								<td colspan="3">
									<select id="sheng" name="sheng" style="display: none;"></select>
									<select id="shi" name="shi" style="display: none;"></select>
									<select name="xian" id="xian" style="width:132px" onchange="xianselect1()" ></select>
									县(区)
									<select name="xiang" id="xiang" style="width:120px" onchange="xiangselect1()"></select>
									乡(镇、街道)
									<select name="cun" id="cun" style="width:120px" onchange="cunselect1()"></select>
									村(居委会)
								</td>
							</tr>
							<tr>
								<td class="tstd">
									机构类型：
								</td>
								<td>
									<select name="orgTypexs1" id="orgTypexs1" style="width:132px" onchange="selectOrg2()">
										<option value="0">--请选择--</option>
									</select>
									<select name="orgTypexs2" id="orgTypexs2" style="width:132px" onchange="selectOrg3()">
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
									<select name="orgLevel" id="orgLevel" style="width:132px">
										<option value="0">--请选择--</option>
									</select><font color="red">*</font>
								</td>
							</tr>	
							<tr>
								<td class="tstd">
									机构编码：
								</td>
								<td>
									<input name="orgCode" type="text" id="orgCode" onblur='checkOrgCode(this)'/><font color="red">*</font>
								</td>
								<td class="tstd">
									机构名称：
								</td>
								<td>
									<input name="orgName" type="text" id="orgName" /><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									补助标准级别：
								</td>
								<td>
									<select name = "bzbz" id="bzbz" style="width: 132px">
										<option value="0">--请选择--</option>
									</select><font color="red">*</font>
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
								<td class="tstd">
									农合机构编码：
								</td>
								<td>
									<input name="orgNccmcode" type="text" id="orgNccmcode" onblur='checkIsNum(this)'/>
								</td>
								<td class="tstd">
									法人代表：
								</td>
								<td>
									<input name="orgLeader" type="text" id="orgLeader"/>
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
									<input name="orgPhone" type="text" id="orgPhone" onblur='checkIsNum(this)'/>
								</td>
								
							</tr>
							<tr>
								<td class="tstd">
									对应机构编码：
								</td>
								<td>
									<input type="text" id="orgId" onblur='checkIsNum(this)'/>
								</td>
								<td	class="tstd">
									机构详细地址：
								</td>
								<td>
									<textarea  id="orgAddress" name="orgAddress" style="width: 200px; height: 80px;" onblur="checkLength(this,40)"></textarea>
								</td>
							</tr>
						</table>
						<div class="buut" style="padding-right: 10px;">
							
							<a href="#"  onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
								onclick="return add();"
								onmouseout="document.java.src='<%=path%>/images/abc.jpg'">
								<img name="java" src="<%=path%>/images/abc.jpg" border="0"/>
							</a>
							<a href="<%=path%>/hsfs/org/orgadd.jsp"  onmouseover="document.java1.src='<%=path%>/images/xz1.jpg'"
								onmouseout="document.java1.src='<%=path%>/images/axz1.jpg'">
								<img name="java1" src="<%=path%>/images/axz1.jpg" border="0"/>
							</a>
							 
							<a href="javascript:void(0)" onmouseover="document.jav.src='<%=path%>/images/qk.jpg'"
								onmouseout="document.jav.src='<%=path%>/images/aqk.jpg'" onclick="resets();"> <img
									name="jav" src="<%=path%>/images/aqk.jpg" border="0"/> 
							</a>
							
							<a href="orglist.jsp?currPage=1&totalPages=0&flags=0"  onmouseover="document.java12.src='<%=path%>/images/fh.jpg'"
								onmouseout="document.java12.src='<%=path%>/images/afh.jpg'">
								<img name="java12" src="<%=path%>/images/afh.jpg" border="0"/>
							</a>
						</div>
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