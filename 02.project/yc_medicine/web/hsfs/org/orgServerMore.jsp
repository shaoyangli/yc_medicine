<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>服务记录文件信息</title>
		<link href="<%=path%>/css/display.css" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zdc.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=path%>/js/zzdc.js"></script>
			<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
			<script type="text/javascript" src="<%=path %>/flexpaper/js/flexpaper_flash.js"></script>
		<style type="text/css">
.search {
	font-family: "宋体";
	font-size: 12px;
	behavior BEHAVIOR: url('../css/selectBox.htc');
	cursor: hand;
}
</style>
<script type="text/javascript" language="javascript"> 
 setInterval("timenow.innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);
	function readFile(id) {
			$.post("orgServer_findOrgServiceFile.action?fileId="+id,
					function(json) {
						var url = json.orgServFile.filePath;
						var fileName = json.orgServFile.fileName;
						show(url);
						$("#titleName").empty();
						var st = "<img src='<%=path%>/images/dispic.jpg' />"+ fileName;
						$("#titleName").append(st);
				}
					)
        }

    function checkDownload(id){
    	//orgService.action?fileId=${st.id}
		$.post("orgServer_checkFileExist.action?fileId="+id,
			function(json){
				var result = json.checkFileResult;
				if(result == 1){
					alert("下载的文件不存在！")
					return false;
				}
				else {
					 window.location.href="orgService.action?fileId="+id
				}
			}
		)
     }

	function show(url)
	{
	var fp = new FlexPaperViewer(	
						 '<%=path%>/flexpaper/FlexPaperViewer',
						 'viewerPlaceHolder', { config : {
						 SwfFile : "../../"+url,
						 Scale : 1, 
						 ZoomTransition : 'easeOut',
						 ZoomTime : 0.5,
						 ZoomInterval : 0.2,
						 FitPageOnLoad : true,
						 FitWidthOnLoad : true,
						 PrintEnabled : true,
						 FullScreenAsMaxWindow : false,
						 ProgressiveLoading : false,
						 MinZoomSize : 0.2,
						 MaxZoomSize : 5,
						 SearchMatchAll : false,
						 InitViewMode : 'Portrait',
						 
						 ViewModeToolsVisible : true,
						 ZoomToolsVisible : true,
						 NavToolsVisible : true,
						 CursorToolsVisible : true,
						 SearchToolsVisible : true,
  						
  						 localeChain: 'en_US'
						 }});
	}
	
	$(document).ready(
	        function (){
			        //alert("${orgServFile.filePath}");
           //show("${orgServFile.filePath}");
	        }
	      );

	    

</script>

	</head>
	<body onload="readFile('${orgServFile.id}')">
		<div class="top">
			<div class="topt">
				<div class="toptl"></div>
				<div class="toptr">
					<ul  style="float:right;">
						<li>
							<a class="MouseOver" href="#" onclick="javascript:window.close()"><img
									style="margin-bottom: 4px;" src="<%=path%>/images/sz.png" />
								<br />关闭</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="menu">
				<div class="menul">
					<img src="<%=path%>/images/hgt.gif" />
					${user.userName}欢迎登陆财政公共服务经费监管系统
				</div>
				<div class="menur" id="timenow">
				<!-- 	<img src="<%=path%>/images/sj.gif" />
					今天是2012年2月16日&nbsp; 星期一 &nbsp; 17:23:16 -->
				</div>
			</div>
		</div>
		<!---main begin------------------------->


		<div class="dismleft">
			
			<h4 id="titleName">
					<img src="<%=path%>/images/dispic.jpg" />
					${orgServFile.fileName }
				
			</h4>
			<div class="infor" id="fileContent">
	        	<a id="viewerPlaceHolder" style="width:100%;height:100%;display:block">
	        	</a>
	        
	        
        	</div>
		</div>
		<div class="dismright">
			<h3>
				<img src="<%=path%>/images/right_pic.jpg" />
				相关文档推荐
				
			</h3>

			<h4>
				文件列表:
			</h4>
		<ul>
	        <s:iterator value="list" id="st">
		        <li >
		          <span class="sppl">
			          <a href="javascript:readFile(${st.id })">
			          	<s:if test="#st.fileType.toLowerCase() == 'doc' || #st.fileType.toLowerCase() == 'docx'  ">
							<img src="<%=path %>/images/w.jpg"/>
						</s:if>
						<s:elseif test="#st.fileType.toLowerCase() == 'wps'">
							<img src="<%=path%>/images/wps.jpg" />
						</s:elseif>
						<s:elseif test="#st.fileType.toLowerCase() == 'dps'">
							<img src="<%=path%>/images/dps.jpg" />
						</s:elseif>
						<s:elseif test="#st.fileType.toLowerCase() == 'txt'">
							<img src="<%=path%>/images/txt.jpg" />
						</s:elseif>
						<s:elseif test="#st.fileType.toLowerCase() == 'et'">
							<img src="<%=path%>/images/et.jpg" />
						</s:elseif>
						<s:elseif test="#st.fileType.toLowerCase() == 'jpg' || #st.fileType.toLowerCase() == 'jpeg' ||#st.fileType.toLowerCase() == 'gif'||#st.fileType.toLowerCase() == 'gif'||#st.fileType.toLowerCase() == 'png'">
							<img src="<%=path%>/images/jpg.jpg" />
						</s:elseif>
						<s:elseif test="#st.fileType.toLowerCase() == 'pptx' || #st.fileType.toLowerCase() == 'ppt'">
							<img src="<%=path%>/images/ppt.jpg" />
						</s:elseif>
						<s:elseif test="#st.fileType.toLowerCase() == 'pdf'">
							<img src="<%=path%>/images/pdf.jpg" />
						</s:elseif>
						<s:else>
							<img src="<%=path%>/images/ex.jpg" />
						</s:else>
			          </a> 
		          <a title="${st.fileName }"  href="javascript:readFile(${st.id })">
		          		
		          </a>
		          </span>
		          <span class="sppr">
		         <a href="javascript:checkDownload(${st.id})">
		         	<img src="<%=path %>/images/downlod.jpg" />
		         </a>
		         </span>
		        </li>
	        <div class="clear"></div>
	        </s:iterator>
     </ul>
		</div>

		

		<div class="clear"></div>


		<!---foot begin
		<div class="foot">

			科鸿电子有限公司,网址www.hn-kehong.com,服务热线：0371-66291551
		</div>
		------------------------->
	</body>
</html>












