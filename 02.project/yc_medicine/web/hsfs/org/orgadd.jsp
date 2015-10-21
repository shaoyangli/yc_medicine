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
		<title>ҽ�ƻ������</title>
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/area.js"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		<style type="text/css">
.search {
	font-family: "����";
	font-size: 12px;
	behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
	cursor: hand;
}
</style>
		<script type="text/javascript">
		function init(){
				  systeminit("<%=path%>");
				  selectUpOrg(0);//��һ�μ���ҳ���ʱ����Ҫ���ݵ�¼�û��ļ���������ϼ������������� �� 0
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
						alert("ҽ�ƻ�����Ų���Ϊ�գ�");
						$("#orgCode").focus();
						return false;
					}
					if(orgCode.length > 20)
					{
						alert("ҽ�ƻ�����Ź���,С��20�ַ���");
						$("#orgCode").val('');
						$("#orgCode").focus();
						
						return false;
					}
					
					if(orgName.length == 0)
					{
						alert("ҽ�ƻ������ֲ���Ϊ�գ�");
						
						$("#orgName").focus();
						return false;
					}
					if(orgName.length > 40)
					{
						alert("ҽ�ƻ������ֲ���Ϊ����40�ַ���");
						$("#orgName").val('');
						$("#orgName").focus();
						return false;
					}
					if(orgLevel == 0)
					{
						alert("����ѡ��ҽ�ƻ�������");
						$("#orgLevel").focus();
						return false;
					}

					if(orgTypexs1 == 0)
					{
						alert("ҽ�ƻ������Ͳ���Ϊ�գ�");
						$("#orgTypexs1").focus();
						return false;
					}	
					if(bzbz == 0) {
						alert("������׼������Ϊ�գ�");
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
								alertReset("����ɹ���")
							}
							else
								alert("ʧ�ܣ�")
                         }
                 );
           }
           //����
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
			//ѡ��2������
           function selectOrg2()
           {
				var orgTypexs1 = $("#orgTypexs1").val();
				$("#orgTypexs2").empty();
				$("#orgTypexs2").append("<option value='0'>--��ѡ��--</option>");
				$("#orgTypexs3").empty();
				$("#orgTypexs3").append("<option value='0'>--��ѡ��--</option>");
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
           //ѡ����������
           function selectOrg3()
           {
        	   var orgTypexs2 = $("#orgTypexs2").val();
        	   $("#orgTypexs3").empty();
			   $("#orgTypexs3").append("<option value='0'>--��ѡ��--</option>");
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
			//��ʼ��ҽ�ƻ������������
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
				$("#orgFatCode").empty();//����ϼ�����������
				$("#appropriationOrg").empty();//��ղ�������е�����
				$("#orgFatCode").append("<option value='0'>--��ѡ��--</option>");
				$("#appropriationOrg").append("<option value='0'>--��ѡ��--</option>");
				selectUpOrg(1,"xiang");//���ϼ�����������ֵ
				//��ҽ�ƻ����ļ�������Ĭѡ��
				var xiang = $("#xiang").val();
				if(xiang == '') {
					levelSelected(3);
				}
				else {
					levelSelected(2)
				}
				
            }
           
           function cunselect1() {
        	   $("#orgFatCode").empty();//����ϼ�����������
        	   $("#appropriationOrg").empty();//��ղ�������е�����
				$("#orgFatCode").append("<option value='0'>--��ѡ��--</option>");
				$("#appropriationOrg").append("<option value='0'>--��ѡ��--</option>");
				selectUpOrg(1,"cun");
				var cun = $("#cun").val();
				if(cun == '') {
					levelSelected(2);
				}
				else {
					levelSelected(1);
				}
           }
           //�������������ѡ��Ĭ��ѡ��һ��ֵ
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
           //��ѯҽ�ƻ������ϼ�����
           function selectUpOrg(t,l) {
				var param;
				var level;
				var xian;
				var xiang;
				var cun;
				//t=1˵����ʱѡ����������Ϣ
				if(t == 1)
				{
					//�簴ť�����ı��ʱ��������Ĵ� ֻ��Ҫ��ѯ���ؾͺ�
					if(l == "xiang")
					{
						xian = $("#xian").val();
						xiang = $("#xiang").val();
						param = xian;
						level = 3;
					}
					//�尴ť�����ı�ֻ��Ҫ��ѯ���ϼ��缴��
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
    			  alert("���������ظ�,��������д��");
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
					��ǰλ�ã�ҽ�ƻ������
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
									�������ڵ�����
								</td>
								<td colspan="3">
									<select id="sheng" name="sheng" style="display: none;"></select>
									<select id="shi" name="shi" style="display: none;"></select>
									<select name="xian" id="xian" style="width:132px" onchange="xianselect1()" ></select>
									��(��)
									<select name="xiang" id="xiang" style="width:120px" onchange="xiangselect1()"></select>
									��(�򡢽ֵ�)
									<select name="cun" id="cun" style="width:120px" onchange="cunselect1()"></select>
									��(��ί��)
								</td>
							</tr>
							<tr>
								<td class="tstd">
									�������ͣ�
								</td>
								<td>
									<select name="orgTypexs1" id="orgTypexs1" style="width:132px" onchange="selectOrg2()">
										<option value="0">--��ѡ��--</option>
									</select>
									<select name="orgTypexs2" id="orgTypexs2" style="width:132px" onchange="selectOrg3()">
										<option value="0">--��ѡ��--</option>
									</select>
									<select name="orgTypexs3" id="orgTypexs3" style="width:132px">
										<option value="0">--��ѡ��--</option>
									</select><font color="red">*</font>
								</td>
								<td class="tstd">
									��������
								</td>
								<td>
									<select name="orgLevel" id="orgLevel" style="width:132px">
										<option value="0">--��ѡ��--</option>
									</select><font color="red">*</font>
								</td>
							</tr>	
							<tr>
								<td class="tstd">
									�������룺
								</td>
								<td>
									<input name="orgCode" type="text" id="orgCode" onblur='checkOrgCode(this)'/><font color="red">*</font>
								</td>
								<td class="tstd">
									�������ƣ�
								</td>
								<td>
									<input name="orgName" type="text" id="orgName" /><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="tstd">
									������׼����
								</td>
								<td>
									<select name = "bzbz" id="bzbz" style="width: 132px">
										<option value="0">--��ѡ��--</option>
									</select><font color="red">*</font>
								</td>
								
								<td class="tstd">
									�ϼ�������
								</td>
								<td>
									<select name="orgFatCode" id="orgFatCode" style="width:132px">
										<option value="0">--��ѡ��--</option>
									</select>
								</td>
								
								
							</tr>
							<tr>
								<td class="tstd">
									ũ�ϻ������룺
								</td>
								<td>
									<input name="orgNccmcode" type="text" id="orgNccmcode" onblur='checkIsNum(this)'/>
								</td>
								<td class="tstd">
									���˴���
								</td>
								<td>
									<input name="orgLeader" type="text" id="orgLeader"/>
								</td>
							</tr>
							<tr>
							<td class="tstd">
									���������
								</td>
								<td>
									<select name="appropriationOrg" id="appropriationOrg" style="width:132px">
										<option value="0">--��ѡ��--</option>
									</select>
								</td>
									
									
								<td class="tstd">
									��ϵ�绰��
								</td>
								<td>
									<input name="orgPhone" type="text" id="orgPhone" onblur='checkIsNum(this)'/>
								</td>
								
							</tr>
							<tr>
								<td class="tstd">
									��Ӧ�������룺
								</td>
								<td>
									<input type="text" id="orgId" onblur='checkIsNum(this)'/>
								</td>
								<td	class="tstd">
									������ϸ��ַ��
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