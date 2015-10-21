
function isNumber(str){
	if('' == str){
		return false;
	}
	else if(str.search(/^[0-9]+$/) <0){
		return false;
	}
	else{
		return true;
	}
}


function isNull(str){
	if(null == str || '' ==str){
		return false;
	}else{
		return true;
	}
}


function isChn(str){ 
var reg = /^[u4E00-u9FA5]+$/; 
if(!reg.test(str)){ 
		return false; 
}else{
		return true;
	}

}

function isEmail(str){ 
	var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/; 
	return reg.test(str); 
} 


function isqq(str){ 
	var result=str.match(/[1-9][0-9]{4,}/); 
	if(result==null) return false; 
	return true; 
} 

/**============�0�5���0�0��0�8�0�5�0�7�����0�6�0�0��0�2�0�3�0�5�0�1return true�0�2�0�9�0�9�0�5�0�6���0�7�����0�6�0�0��0�2�0�3�0�0�0�9�0�8�0�5========*/
function isidcard(str){ 
	var result=str.match(/\d{15}|\d{18}/); 
	if(result==null) return false; 
	return true; 
} 
/**============�0�5���0�0��url�0�5�0�1return true�0�2�0�9�0�2�0�3�����0�8�0�2http�0�4�0�2�0�6���0�8�0�2url============*/
function isUrl(str){
	var reg = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
	var result=str.match(reg); 
	if(result==null) return false; 
	return true;
}
/**============�0�5���0�0��2���0�0���0�4�0�7�0�3�0�8�0�5���0�9�0�6�0�3�0�0�0�0�0�5�0�1return true�0�2�0�9�0�6�0�3�0�0�0�0==============*/
function isSame(str1,str2){
	if(str1 == str2){
		return true;
	}else{
		return false;
	}
}

  function checkPhone(phone)    
{    

if (phone==""){    
 alert("������绰���룡");  
return false;    
}    
if (phone != ""){     
var p1 = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;    
var me = false;    
if (p1.test(phone)) me=true;    
if (!me){       
 alert('�Բ���������ĵ绰�����д������ź͵绰����֮������-�ָ�'); 
return false;    
}    
}   
return true;    
}  

