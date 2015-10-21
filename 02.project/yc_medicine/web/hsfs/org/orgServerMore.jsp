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
		<title>�����¼�ļ���Ϣ</title>
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
	font-family: "����";
	font-size: 12px;
	behavior BEHAVIOR: url('../css/selectBox.htc');
	cursor: hand;
}
</style>
<script type="text/javascript" language="javascript"> 
 setInterval("timenow.innerHTML=new Date().toLocaleString()+' ����'+'��һ����������'.charAt(new Date().getDay());",1000);
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
					alert("���ص��ļ������ڣ�")
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
								<br />�ر�</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="menu">
				<div class="menul">
					<img src="<%=path%>/images/hgt.gif" />
					${user.userName}��ӭ��½�����������񾭷Ѽ��ϵͳ
				</div>
				<div class="menur" id="timenow">
				<!-- 	<img src="<%=path%>/images/sj.gif" />
					������2012��2��16��&nbsp; ����һ &nbsp; 17:23:16 -->
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
				����ĵ��Ƽ�
				
			</h3>

			<h4>
				�ļ��б�:
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

			�ƺ�������޹�˾,��ַwww.hn-kehong.com,�������ߣ�0371-66291551
		</div>
		------------------------->
	</body>
</html>












