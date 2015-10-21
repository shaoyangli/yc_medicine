
//显示file组件
function show() {
		$("#fu").show();
		if (!window.addEventListener)
			{       
				//IE 关键代码在这里！！！ 
				//obj.select();   
				//document.execCommand('Delete'); 
				//obj.blur();   
				obj.outerHTML+=''; 
				return false;   
			}
			 else 
			{   
				//非IE   
				obj.value = "";   
				return false;   
			} 
}
function del() {
	$("#fu").hide();
	$("#loading").hide();
	var obj = document.getElementById("file");
	if (!window.addEventListener)
			{       
				//IE 关键代码在这里！！！ 
				//obj.select();   
				//document.execCommand('Delete'); 
				//obj.blur();   
				obj.outerHTML+=''; 
				return false;   
			}
			 else 
			{   
				//非IE   
				obj.value = "";   
				return false;   
			} 
}
//完成对邮件已经上传附件的记录 flag = 0 增加id,flag = 1删除id
function manageFileId(id,flag) {
	tem = document.getElementById("fid").value;
	var bb = document.getElementById('fid');
	if(flag == 0) {
		tem += id + ",";
	}
	 if(flag == 1) {
		tem = tem.replace(id + ",", "");
	}
	bb.value = tem;
}
//提交之前
function beforeAjax() {
	$("#sa").attr({"disabled":"disabled"});
	$("#re").attr({"disabled":"disabled"});
}
function afterAjax() {
	$("#sa").removeAttr("disabled");//将按钮可用
	$("#re").removeAttr("disabled");
}