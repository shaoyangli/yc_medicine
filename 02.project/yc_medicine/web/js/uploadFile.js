
//��ʾfile���
function show() {
		$("#fu").show();
		if (!window.addEventListener)
			{       
				//IE �ؼ�������������� 
				//obj.select();   
				//document.execCommand('Delete'); 
				//obj.blur();   
				obj.outerHTML+=''; 
				return false;   
			}
			 else 
			{   
				//��IE   
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
				//IE �ؼ�������������� 
				//obj.select();   
				//document.execCommand('Delete'); 
				//obj.blur();   
				obj.outerHTML+=''; 
				return false;   
			}
			 else 
			{   
				//��IE   
				obj.value = "";   
				return false;   
			} 
}
//��ɶ��ʼ��Ѿ��ϴ������ļ�¼ flag = 0 ����id,flag = 1ɾ��id
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
//�ύ֮ǰ
function beforeAjax() {
	$("#sa").attr({"disabled":"disabled"});
	$("#re").attr({"disabled":"disabled"});
}
function afterAjax() {
	$("#sa").removeAttr("disabled");//����ť����
	$("#re").removeAttr("disabled");
}