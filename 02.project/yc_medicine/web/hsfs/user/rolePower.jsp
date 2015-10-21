<%@ page language="java"  pageEncoding="gbk"%>

<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>角色分配权限</title>
		<link rel="stylesheet" href="<%=path%>/js/ztree/css/demo.css" type="text/css"/>
		<link rel="stylesheet" href="<%=path%>/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
		
		
		<script language="javascript" type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
		<script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
		<script language="javascript" type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
		
        <script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
		 <script type="text/javascript" src="<%=path%>/js/ztree/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="<%=path%>/js/ztree/jquery.ztree.excheck-3.5.js"></script>
		<script type="text/javascript">
var clearFlag = false;
		function onCheck(e, treeId, treeNode) {
			if (clearFlag) {
				clearCheckedOldNodes();
			}
		}
		function getPrivilege(role){
		   if(role==""){
		      return;
		   }
		   select1();
		}
		function clearCheckedOldNodes() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getChangeCheckedNodes();
			for (var i=0, l=nodes.length; i<l; i++) {
				nodes[i].checkedOld = nodes[i].checked;
			}
		}
		function checkAllNode(){//默认全部勾选
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes =treeObj.getCheckedNodes(true);
            if(nodes!=null&&nodes!=""){
            	treeObj.checkAllNodes(false);
            }else{
            	treeObj.checkAllNodes(true);
            }
		}
		function checkAllNodef(){//默认全部不勾选
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            treeObj.checkAllNodes(false);
		}
		function expandAll(){//展开			
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
               treeObj.expandAll(true);
		}
		function expandAllf(){//折叠		
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
               treeObj.expandAll(false);
		}
		function createTree() {	
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			clearFlag = $("#last").attr("checked");
		}
 var zNodes;
		<%--
		var setting = {
			view: {
				selectedMulti: false
			},
			check: {
				enable: true,
				chkStyle: "checkbox",
		       chkboxType: { "Y": "p", "N": "s" }
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onCheck: onCheck
			},
			data : {
                keep : {
                 leaf : false,
       			 parent : true
       			 
    			},
   				 key : {
      			 checked : "checked",
        		 children : "children",
        		 name : "name",
        		 title : ""
    			},
    		   simpleData : {
      		   enable : true,
        	   idKey : "id",
               pIdKey : "parentid",
               rootPId : -1
              }

           }
		};
--%>
var setting = {
			check: {
				enable: true,
				chkStyle: "checkbox",
		       	chkboxType: {"Y" : "p", "N" : "ps"}
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};

function findPowers(t){
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	zTree.checkAllNodes(false);
    var roleid=$('#role option:selected').val();
    if(roleid=="0"){
		if(t == 1) {
			alert("请选择角色");
		}
    	
	return false;
	}
    var url="<%=path%>/orgUser!findPowers.action?timestamp="
				+ new Date().getTime();
    var data={"roleId":roleid}
               $.post(url,data,
                      function (json){
            	          zNodes=json.powerIds;
            	          
            	          if( zNodes==null){
            	        	 zNodes=0; 
            	          }
            	          for(var i=0;i<zNodes.length;i++){   
                            var node = zTree.getNodeByParam("id", zNodes[i]);   
                                 if(node==null){
                                	 node=0;
                                 }else{
                                node.checked=true; 
                                }
                                zTree.updateNode(node,true);   
                           }              	          
                      },'json'
                       
                    )
               };
               
function save() {
    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
    var nodes = treeObj.getCheckedNodes(true);
    var  v = "";
    for (var i=0; i< nodes.length;  i++) {
          v += nodes[i].id + ",";//获取选中节点的id值
     }
    v=v.substring(0, v.length - 1);
	// var role=$('#role option:selected').val();
	var role = $("#role").val();
	if(role== 0){
		alert("请先选择角色！");
		return false;
	};
	 var data={
           "rolePower.roleId":role,
            "rolePower.powerId":v
                   }
	var url="<%=path%>/orgUser!saveRolePower.action";
	$.post(url,data,
	     function(json){
		var result=json.isSuccess;
			if(result==0){
      		alert("权限分配成功！");
    	 }
            if(result==1){
        	alert("失败！");
  		   }
  	      },'json'
	);
}



	function findUserRole(){
		
		$.post("orgUser!findAllUserRole.action?timestamp="
				+ new Date().getTime(),
		function(json){
			var result = json.list;
			var tables = "<table align='center' style='width: 60%; margin-top:0; table-layout:fixed; border-top:0;'>";
			tables += "<tr><th>角色名称</th><th>修改</th><th>删除</th></tr>";
			$.each(result,function(i, obj){
				if(i%2==0){
			 		tables+="<tr class='tstr'>";
				}else{
					tables+="<tr >";
				}
				tables += "<td>"+ obj[1] + "</td><td><a href='#'>修改</a></td><td><a href=''>删除</a></td>" ;
			});
			tables += "</table>";
			//alert(tables);
			$("#roles").empty();
			$("#roles").append(tables);
			
		})

	}
$(document).ready(function(){
//先加载所有的菜单	
	$.getJSON("orgUser!findAllMenu.action?timestamp="
				+ new Date().getTime(),function(json){
		zNodes = json.menuNodes;
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		//createTree();	
		},'json'
		    );
	
	$.getJSON("orgUser!findAllUserRole.action?timestamp="
				+ new Date().getTime(),function(json){
		var result = json.list;
		var options = "";
		for(var i = 0;i< result.length;i++) {
			options +="<option value='"+result[i][0]+"'>" +result[i][1] + "</option>";
		}
		$("#role").append(options);
		
	}),'json';});
	
		//$("#init").bind("change", createTree);
		//$("#last").bind("change", createTree);



</script>
	</head>
	<body>
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：
					<% String loct = request.getParameter("loct");
					 if(loct!=null)
						 loct =new String (loct.getBytes("ISO-8859-1"),"utf-8"); 
						else 
							loct="角色分配权限管理";
					 %><%=loct %>
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
				<div class="mainmt">
					<table style=" align:center;width: 600px; border-bottom:0; margin-top:12px;">
						<tr>
							<td style="padding-left: 20px; ">
								角色列表：
							<select name="role" id="role" onchange="findPowers()">
								<option value="0">
									--选择角色--
								</option>
							</select>
							&nbsp;&nbsp;
							<input type="hidden" name="privilege" value="" id="privilege" />
							<!-- 
							<input type="button" value="显示权限"  onclick="findPowers(1)" />
					 
					&nbsp;&nbsp;
					<input type="button" value="保 存" onclick="save()" />
					-->
					<a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
										onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="save()"> 
										<img name="java" src="<%=path %>/images/abc.jpg" border="0"/>
									</a>
				</td>
			</tr>
		</table>  
         <table align="center" style="width: 600px; border-bottom:0;" >
			<tr>
				<td>
					<div style="height: 35px; padding-top: 5px;">
						<img src="<%=path %>/images/open.gif"/>
						<a href= "javascript:void(0)"
							onclick='javascript:expandAll()'>全部展开</a>
						<img src="<%=path %>/images/close.gif"/>
						<a href= "javascript:void(0)" onclick='javascript:expandAllf()'>全部折叠</a>
						<img src="<%=path %>/images/open.gif"/>
						<a href= "javascript:void(0)"
							onclick='javascript:checkAllNode()'>选中/取消</a>
						
					</div>
					<!--  
					<div id="treeboxbox_tree2"
						style="width: 100%; height: 640px; border: 1px solid Silver; overflow: auto;">				
						<ul id="treeDemo" class="ztree" style="margin-left: 20px;"></ul>
					</div>
					-->
					<div class="content_wrap">
			<div class="zTreeDemoBackground left">
					<ul id="treeDemo" class="ztree"></ul>
			</div>
	</div>
				</td>				
			</tr>
		</table>
				
				</div>
					
				</div>
			<div class="mainb">
				<div class="mainbl">
				</div>
				<div class="mainbm"></div>
				<div class="mainbr"></div>
			</div>

		</div>

	</body>
</html>
