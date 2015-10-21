<%@ page language="java" pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>邮件接收</title>
		<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet"
			type="text/css" />
		<script src="<%=path%>/js/superTables_compressed.js"
			type="text/javascript">
		</script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js">
		</script>
		<script type="text/javascript" src="<%=path%>/js/area.js">
		</script>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js">
		</script>
		<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
		<script type="text/javascript" src="<%=path%>/js/doUtil.js">
		</script>
		<link rel="stylesheet" href="<%=path%>/js/ztree/css/demo.css" type="text/css"/>
		<link rel="stylesheet" href="<%=path%>/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
		<script type="text/javascript" src="<%=path%>/js/ztree/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="<%=path%>/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	emptyUser();
	loadUsers(0);
});
var setting = {
			check: {
				enable: true,
				chkboxType: {"Y":"", "N":""}
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onCheck: onCheck
			}
		};
		function beforeClick(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		}
		
		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getCheckedNodes(true),
			v = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var cityObj = $("#citySel");
			cityObj.attr("value", v);
		}

function showMenus() {
			var cityObj = $("#citySel");
			var cityOffset = $("#citySel").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "citySel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
	}
}
function saveid() {
    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
    var nodes = treeObj.getCheckedNodes(true);
    var  v = "";
    for (var i=0; i< nodes.length;  i++) {
          v += nodes[i].id + ",";//获取选中节点的id值
     }
    alert(v);
    v=v.substring(0, v.length - 1);
	// var role=$('#role option:selected').val();
}
function selectUser(){    
    var users = $("#citySel").val(); 
    alert(users);
	window.returnValue = users;
    window.opener = null;
    window.close();
      }
function emptyUser() {
	$("#citySel").val('');
}
function beforeLoad() {
	var t = $("#checkSelect").val();
	//alert(t);
	loadUsers(t);
}
function loadUsers(t) {
	$.post("emailAction!findAllNodes.action?checkType=" + t,
		function(json) {
			var zNodess = json.menuNodes
			$.fn.zTree.init($("#treeDemo"), setting, zNodess);
		})
}

</script>
<style>
.sDefault {
	text-align: left;
}

;
.sDefault tr {
	
}

.sDefault tr td {
	text-align: left;
}
</style>
	</head>
<body>
		<!---main begin------------------------->
		<div class="main">
			<div class="maint">
				<div class="maintm">
					<img src="<%=path%>/images/tb1.jpg" />
					当前位置：选择邮件接收人
				</div>
				<div class="maintr"></div>
			</div>
			<div class="mianm">
			<div class="mainmt">
					<table align="center" style="width: 80%; border-bottom:0; margin-top:12px;">
			<tr>
				<td>
					<select style="width:90px;" id="checkSelect" onchange="beforeLoad();">
						<option value="0">用户查询</option>
						<option value="1" >区域查询</option>
						<option value="2">机构查询</option>
					</select>
					<input id="citySel" type="text" readonly="readonly"  style="width:120px;" onclick="showMenus();" />
					<a id="menuBtn" href="javascript:void(0)" onclick="showMenus();">选择</a>
					<input type="button" value="确定" onclick="saveid()" />
					<input type="button" value="清空" onclick="emptyUser()" />
					&nbsp;&nbsp;
					
				</td>
			</tr>
		</table>  
         <table align="center" style="width: 60%; border-bottom:0;">
			<tr>
				<td>
					<!--  
					<div style="height: 35px; padding-top: 5px;">
						<img src="<%=path %>/images/open.gif"/>
						<a href= "javascript:void(0)"
							onclick='javascript:expandAll()'>全部展开</a>
						<img src="<%=path %>/images/close.gif"/>
						<a href= "javascript:void(0)" onclick='javascript:expandAllf()'/>全部折叠</a>
						<img src="<%=path %>/images/open.gif"/>
						<a href= "javascript:void(0)"
							onclick='javascript:checkAllNode()'/>选中/取消</a>
						
					</div>
					-->
					<!--  
					<div id="treeboxbox_tree2"
						style="width: 100%; height: 640px; border: 1px solid Silver; overflow: auto;">				
						<ul id="treeDemo" class="ztree" style="margin-left: 20px;"></ul>
					</div>
					-->
					<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:180px; height: 300px;"></ul>
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










