function editor(url) {// �༭
	var merList = $("input[name='count']:checked");// ��ȡcheckbox
	// ����һ������
	var count="";
	var j = 0;
	merList.each(function(i) {
		count = $(this).val();
		j++;
	});
	if (j > 1) {
		alert("��ֻ��ѡ��һ���༭");

	} else if (j < 1) {
		alert("��ѡ����Ҫ�༭��һ����¼");
	} else {
		location.href = url+count;
	}
}
function deletes(url, currPage, totalPages) {
		var merList = $("input[name='count']:checked");
		// ����һ������
		var list = {};
		var j = 0;
		merList.each(function(i) {
			list[i] = $(this).val();
			j++;
		});
		if (j < 1) {
			alert("��ѡ����Ҫɾ����һ����¼");
		} else {
			if (confirm("ȷ��Ҫɾ��������")) {
			var data = {
				"deleteList" : list
			};
			var url = url;
			// �ύ
			$.post(url, data, function() {
				alert("ɾ���ɹ�");
				findList(currPage, totalPages);
			});
		}
	}
}
function allCheck(check) {
   ��var checkbox=document.getElementsByName("count");
        if(check.checked){
for(var i=0;i<checkbox.length;i++){
��checkbox[i].checked="checked";
        addCount(check,checkbox[i].value)
         }
}else{
               for(var i=0;i<checkbox.length;i++){
��checkbox[i].checked="";
         addCount(check,checkbox[i].value)
} 
}  
}
 function sel(totalPages){
    if(document.getElementById("currPage").value==""){
    	alert("����������ҳ��");
    	document.getElementById("currPage").focus();
    	return false;
    }
 	var currPage = document.getElementById("currPage").value;
    findList(currPage,totalPages);
 }
  function checkCurrPage(str){
				  if(/\D/.test(str)){ // �������ж� ���Ϊfalse ps: /\D/ ��������
		      	 	   alert("�����������֣�");
		      	 	    document.getElementById("currPage").value="";
		      	 	 document.getElementById("currPage").focus();
		      	 	     return false;
		    		 }
			}
      $.fn.clearForm = function() {
      return this.each(function() {
        var type = this.type, tag = this.tagName.toLowerCase();
        if (tag == 'form')
          return $(':input',this).clearForm();
        if (type == 'text' || type == 'password' || tag == 'textarea')
          this.value = '';
        else if (type == 'checkbox' || type == 'radio')
          this.checked = false;
        else if (tag == 'select')
          this.selectedIndex = 0;
      });
    }; 
    //�ٷֱ�
    function percentNum(num, num2) {
		     if(num2!=0){
		     	if( num>=num2 ){
		     		return "100.00%";
		     	}else{
		     		return (Math.round(num / num2 * 100) / 100.00 + "%"); //С�������λ�ٷֱ�
		     	}
		     }else{
		     	return "0%"
		     }
		}
    
function reset(){
	$('form').clearForm()
	}
var confirm = function (content, yes, no) {
    return artDialog({
        id: 'Confirm',
        icon: 'question',
        fixed: true,
        lock: true,
        opacity: .1,
        content: content,
        ok: function (here) {
            return yes.call(this, here);
        },
        cancel: function (here) {
            return no && no.call(this, here);
        }
    });
};

// ��֤������������
function checkIsNum(obj) {
	if(/\D/.test(obj.value))
	  { // �������ж� ���Ϊfalse ps: /\D/ ��������
	 	alert("�����������֣�");
		obj.value = "";
	 	obj.focus();
	  }
}
function clearNoNum(obj){  
	obj.value = obj.value.replace(/[^\d.]/g,"");  //��������֡��͡�.��������ַ�  

 obj.value = obj.value.replace(/^\./g,"");  //��֤��һ���ַ������ֶ�����. 

  obj.value = obj.value.replace(/\.{2,}/g,"."); //ֻ������һ��. ��������.   

obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}
// ��֤����
function checkLength(obj,number){
	if(obj.value.length > number){
		alert("�������"+number+"���֣�");
		obj.value="";
		obj.focus();
		return false;
	}
}
 function clearNoNum(obj){
	   obj.value = obj.value.replace(/[^\d.]/g,"");  //��������֡��͡�.��������ַ�
	   obj.value = obj.value.replace(/\.{2,}/g,"."); //ֻ������һ��. ��������
 	   obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
 }
 //��ȡ��ǰ����
function currentDate(){
	var now = new Date();
    var year = now.getFullYear();       //��
    var month = now.getMonth() + 1;     //��
    var day = now.getDate();            //��
    var hh = now.getHours();            //ʱ
    var mm = now.getMinutes();          //��
    var clock = year + "-";
    if (month < 10)
        clock += "0";
     clock += month + "-";
     if (day < 10)
         clock += "0";
     clock += day;
     return clock;
}
//function alert(msg){
//	art.dialog({ 
//		lock: true,
//		width: '20em',
//	    height: 55,
//		 background: '#999999', // ����ɫ
//		 content: msg ,
//		ok: function (){
//	        return true;
//   		 },
//		canel : function() {
//   			 return false;
//		}
//	});
//}
//function alert(msg){
//	art.dialog({ 
//		lock: true,
//		width: '20em',
//	    height: 55,
//		 background: '#999999', // ����ɫ
//		 content: msg ,
//		ok: function (){
//	        return true;
//	        $("#archCode").focus();
//   		 }
//	});
//}
//�����ɹ� ֮�� ��������ҳ�� 13.4.22 gcl
function alertOpage(msg,url)
{
	art.dialog({
		lock: true,
		width: '20em',
	    height: 55,
	    background: '#999999',
	    content: msg,
	    ok: function () {
	        window.location.href=url;
	        return true;
	    },
	    cancel :function () {
	    	 window.location.href=url;
	        return true;
	    },
	    cancelVal : "ȷ��"
	    
	});
}

// �����Ժ����,����ִ�в�ѯ
// ����: msg: ������Ϣ c: ��ǰҳ�� t: ��ҳ�� ��Ҫ����ɾ�� �Ժ�ִ�еĲ�ѯ
function alertFind(msg,c,t)
{
	art.dialog({
		lock: true,
		width: '20em',
	    height: 55,
	    background: '#999999',
	    content: msg,
	    ok: function () {
	    	// this.title('3����Զ��ر�').time(3);
	        findList(c,t);
	        return true;
	    },
	     cancel :function () {
	    	 findList(c,t);
	        return true;
	    },
	    cancelVal : "ȷ��"
	});
}
function confirm1(url,currPage,totalPages)
{
	var merList=$("input[name='count']:checked");		
	if(merList.length < 1)
	{
		alert("����ѡ����Ҫɾ���ļ�¼");
		return false;
	}
	else
	{
		art.dialog({
			lock: true,
			width: '20em',
		    height: 55,
		    background: '#999999',
		    content: 'ȷ��ɾ��ô��',
		    ok: function () {
					var list = {};
					merList.each(function(i)
					{
						list[i] = $(this).val();
					});	
					var data ={"deleteList":list};		  		
				   //	var url="orgExtend_removeOrgExtend.action";
				// �ύ
				   $.post(url,data,
						function()
						{
							alertFind("ɾ���ɹ�",currPage,totalPages); 
						}
					);
			return true;
		    },
		    cancelVal: 'ȡ��',
		    cancel: true // Ϊtrue�ȼ���function(){}
	   
		})
	}
}
function addCount(e, thisvalue) {
	tem = document.getElementById("arrayid").value;
	var bb = document.getElementById('arrayid');
	if (e.checked == true) {
		tem += thisvalue + ",";
	} else {
		tem = tem.replace(thisvalue + ",", "");
	}
	bb.value = tem;
}
function delete_(url, currPage, totalPages) {
	var info = $("#arrayid").val();
	if (info.length < 1) {
		alert("��ѡ����Ҫɾ����һ����¼");
	} else {
		art.dialog({
			lock: true,
			width: '20em',
		    height: 55,
		    background: '#999999',
		    content: 'ȷ��ɾ��ô��',
		    ok: function () {
			var data = {
				"count" : info
			};
			$.post(url, data, function() {
				alertFind("ɾ���ɹ�",currPage,totalPages);
				$("#arrayid").val("");
			});
			return true;
		    },
		    cancelVal: 'ȡ��',
		    cancel: true // Ϊtrue�ȼ���function(){}
		})
	}
}
(function(w){
		var _html='<div style="line-height: 30px;text-align: center;">���Ժ�,����׼�����ݡ�����</div><div id="jsLoadOuter" style="width:250px;height:8px;border:#6BAAC9 solid 1px; background:#C0EBFF; margin:0 auto;box-shadow: 0 0 3px #2E94BB;padding:1px"><div id="jsLoadInner" style="background:#54AEE0;height:100%;width:0"></div></div>';
		var __g;
		var _maxWidth=100;
		var _nowWidth=0;
		var _speed=30;
		var _step=2;
		var __time;
		progress={
			render:function(fn){
				fn&&fn(_html);
				_nowWidth=0;
				__g=document.getElementById('jsLoadInner');
				this.fx();
			},
			complete:function(fn){
				clearTimeout(__time);
				progress.completeFn=fn;
				this.setOver();
			},			
			setOver:function(){
				var _stepa=_step*1.5;
				if(_nowWidth<_maxWidth){
					_nowWidth=_nowWidth-0+_stepa;
					parseInt(_nowWidth)>parseInt(_maxWidth)?_nowWidth=_maxWidth:'';
					__g.style.width=''+_nowWidth+'%';
					_speed=(_maxWidth-_nowWidth)/1000;
					__time=setTimeout('progress.setOver()',_speed)	;
				}else{
					clearTimeout(__time);
					progress.completeFn&&progress.completeFn();
				};
			},
			fx:function(){
				var _stepa=_step;
				if(_nowWidth<_maxWidth-5){
					_stepa=_nowWidth>_maxWidth*0.6?(_stepa*0.02):_stepa;
					_nowWidth=_nowWidth-0+_stepa;
					parseInt(_nowWidth)>parseInt(_maxWidth)?_nowWidth=_maxWidth:'';
					__g.style.width=''+_nowWidth+'%';
					__time=setTimeout('progress.fx()',_speed);
				}else{
					clearTimeout(__time);
				};
			}
		}
		w.progress=progress;
	})(window)
	plan={
	  show :function (){
	   progress.render(function(html){
				art.dialog({id:"jsLoadingDialog",title:"\u6b63\u5728\u52a0\u8f7d\u4e2d\u2026\u2026",cancel:!1,lock:!0,background:"#999999",fixed:!0,content:html});
				
		 });	
	  },
	  hide2 :function(){
		 progress.complete(function(){
				art.dialog.list['jsLoadingDialog']&&art.dialog.list['jsLoadingDialog'].close();
			});
      },
      hide :function(tables){
		 progress.complete(function(){
				art.dialog.list['jsLoadingDialog']&&art.dialog.list['jsLoadingDialog'].close();
				$("#pagelist").empty();// ���div
				$("#pagelist").append(tables); // ������table����div��
				new superTable("demoTable", {
						cssSkin : "sDefault",
						fixedCols : 0
				});  
			});
      },
      hidebreak :function(){// ��Ŀ����ʱ�жϽ�����
    	  $(document).ajaxError(function() {
		progress.complete(function(){
				art.dialog.list['jsLoadingDialog']&&art.dialog.list['jsLoadingDialog'].close();	
			});
	   });	 
      },
       hidden :function(page,tables){
    	   var  tables2="";trs2 ="";
    	  	$("#pagelist").empty();// ���div
			$("#pagelist1").empty();// ���div
    	  trs2 += "<table style='margin-top: 0; border-top: 0;'><tr class='ts'><td style='border: 0; text-align: left; padding-left: 6px;'>&nbsp;&nbsp;����&nbsp;"
								+ page.totalRows
								+ "&nbsp;����¼,��ǰ��&nbsp;"
								+ page.currPage
								+ "&nbsp;ҳ/��"
								+ page.totalPages
								+ "&nbsp;ҳ&nbsp;&nbsp;ÿҳ&nbsp;"
								+ page.rows
								+ "&nbsp;����¼</td><td style='text-align: right; padding-right: 8px;'>"
								+ page.url
								+ "ת����<input name='currPage' type='text' size='4' style='height: 12px; width: 20px; border: 1px solid #999999;'id='currPage' onblur='checkCurrPage(this.value)' /><input type='hidden' name='totalPages' value='"
								+ page.totalPages
								+ "' />ҳ<input type='hidden' name='docurrPages' id='docurrPages' value='"
								+ page.currPage
								+ "' /><input type='hidden' name='dototalPages' id='dototalPages' value='"
								+ page.totalPages
								+ "' /><input name='' class='ann' type='button' onclick='sel("
								+ page.totalPages + ")' /></td></tr></table>";
						tables2 += trs2;
				progress.complete(function(){
				art.dialog.list['jsLoadingDialog']&&art.dialog.list['jsLoadingDialog'].close();
			     	    $("#pagelist").append(tables); 
						$("#pagelist1").append(tables2); 
						new superTable("demoTable", {
							cssSkin : "sDefault",
							fixedCols : 0
						});
						var info = $("#arrayid").val();
					   info =info.split(",");
						var merList = $("input[name='count']");
						merList.each(function() {
							for ( var i = 0; i < info.length; i++) {
								 
								if ($.trim(info[i]) == $.trim($(this).val())) { // ��������Ҫѡ��ֵ
									$(this).attr("checked", true);
									break;
								}
							}
						});
			});		
				 
      },
       hidden2 :function(page,tables){
    	   var  tables2="";trs2 ="";
    	  	$("#pagelist").empty();// ���div
			$("#pagelist1").empty();// ���div
    	  trs2 += "<table style='margin-top: 0; border-top: 0;'><tr class='ts'><td style='border: 0; text-align: left; padding-left: 6px;'>&nbsp;&nbsp;����&nbsp;"
								+ page.totalRows
								+ "&nbsp;����¼,��ǰ��&nbsp;"
								+ page.currPage
								+ "&nbsp;ҳ/��"
								+ page.totalPages
								+ "&nbsp;ҳ&nbsp;&nbsp;ÿҳ&nbsp;"
								+ page.rows
								+ "&nbsp;����¼</td><td style='text-align: right; padding-right: 8px;'>"
								+ page.url
								+ "ת����<input name='currPage' type='text' size='4' style='height: 12px; width: 20px; border: 1px solid #999999;'id='currPage' onblur='checkCurrPage(this.value)' /><input type='hidden' name='totalPages' value='"
								+ page.totalPages
								+ "' />ҳ<input type='hidden' name='docurrPages' id='docurrPages' value='"
								+ page.currPage
								+ "' /><input type='hidden' name='dototalPages' id='dototalPages' value='"
								+ page.totalPages
								+ "' /><input name='' class='ann' type='button' onclick='sel("
								+ page.totalPages + ")' /></td></tr></table>";
						tables2 += trs2;
				progress.complete(function(){
				art.dialog.list['jsLoadingDialog']&&art.dialog.list['jsLoadingDialog'].close();
			     	    $("#pagelist").append(tables); 
						$("#pagelist1").append(tables2); 
						new superTable("demoTable", {
							cssSkin : "sDefault",
							fixedCols : 0
						});					
			});		
				 
      },
      hide2 :function(tables){
 		 progress.complete(function(tables){
 				art.dialog.list['jsLoadingDialog']&&art.dialog.list['jsLoadingDialog'].close();
 				$("#pagelist").append(tables); // ������table����div��
 			});
       }
	 }
