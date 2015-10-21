function editor(url) {// 编辑
	var merList = $("input[name='count']:checked");// 获取checkbox
	// 定义一个数组
	var count="";
	var j = 0;
	merList.each(function(i) {
		count = $(this).val();
		j++;
	});
	if (j > 1) {
		alert("你只能选择一条编辑");

	} else if (j < 1) {
		alert("请选择你要编辑的一条记录");
	} else {
		location.href = url+count;
	}
}
function deletes(url, currPage, totalPages) {//删除
		var merList = $("input[name='count']:checked");
		// 定义一个数组
		var list = {};
		var j = 0;
		merList.each(function(i) {
			list[i] = $(this).val();
			j++;
		});
		if (j < 1) {
			alert("请选择你要删除的一条记录");
		} else {
			if (confirm("确定要删除数据吗？")) {
			var data = {
				"deleteList" : list
			};
			var url = url;
			// 提交
			$.post(url, data, function() {
				alert("删除成功");
				findList(currPage, totalPages);
			});
		}
	}
}
function allCheck(check) {//全选
   　var checkbox=document.getElementsByName("count");
        if(check.checked){
for(var i=0;i<checkbox.length;i++){
　checkbox[i].checked="checked";
        addCount(check,checkbox[i].value)
         }
}else{
               for(var i=0;i<checkbox.length;i++){
　checkbox[i].checked="";
         addCount(check,checkbox[i].value)
} 
}  
}
 function sel(totalPages){
    if(document.getElementById("currPage").value==""){
    	alert("请输入数字页码");
    	document.getElementById("currPage").focus();
    	return false;
    }
 	var currPage = document.getElementById("currPage").value;
    findList(currPage,totalPages);
 }
  function checkCurrPage(str){
				  if(/\D/.test(str)){ // 用正则判断 如果为false ps: /\D/ 是正则表达
		      	 	   alert("必须输入数字！");
		      	 	    document.getElementById("currPage").value="";
		      	 	 document.getElementById("currPage").focus();
		      	 	     return false;
		    		 }
			}
      $.fn.clearForm = function() {//from清空
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
    //百分比
    function percentNum(num, num2) {
		     if(num2!=0){
		     	if( num>=num2 ){
		     		return "100.00%";
		     	}else{
		     		return (Math.round(num / num2 * 100) / 100.00 + "%"); //小数点后两位百分比
		     	}
		     }else{
		     	return "0%"
		     }
		}
    
function reset(){//清空
	$('form').clearForm()
	}
//验证必须为数字,字母组合
function checkObj(obj) {
	if(!/^[0-9a-z]*$/i.test(obj.value)) {
		alert("只能输入字母,数字组合！");
	     obj.value = '';
	     obj.focus();
	     return false;
	}
}
// 验证必须输入数字
function checkIsNum(obj) {
	if(/\D/.test(obj.value))
	  { // 用正则判断 如果为false ps: /\D/ 是正则表达
	 	alert("必须输入数字！");
		obj.value = "";
	 	obj.focus();
	 	return false;
	  }
}
function clearNoNum(obj){  
  obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
  obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 
  obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   
  obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}
// 验证长度
function checkLength(obj,number){
	if(obj.value.length > number){
		alert("最多输入"+number+"个字！");
		obj.value="";
		obj.focus();
		return false;
	}
}
 //function clearNoNum(obj){
	//   obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
	  // obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
 	  // obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
 //}
 //获取当前日期
function currentDate(){
	var now = new Date();
    var year = now.getFullYear();       //年
    var month = now.getMonth() + 1;     //月
    var day = now.getDate();            //日
    var hh = now.getHours();            //时
    var mm = now.getMinutes();          //分
    var clock = year + "-";
    if (month < 10)
        clock += "0";
     clock += month + "-";
     if (day < 10)
         clock += "0";
     clock += day;
     return clock;
}
function alert(msg){
	art.dialog({ 
		lock: true,
		width: '20em',
	    height: 55,
		 background: '#999999', // 背景色
		 content: msg ,
		ok: function (){
	        return true;
   		 }
	});
}
//执行力完弹窗再执行一次加载页面
function alertReset(msg)
{
	art.dialog({
		lock: true,
		width: '20em',
	    height: 55,
	    background: '#999999',
	    content: msg,
	    ok: function () {
	        resets();
	        return true;
	    },
	    cancel :function() {
	    	resets();
	        return true;
	    },
	    cancelVal : "确定"
	});
}
//执行力完弹窗再执行一次加载页面
function alertJiaZhai(msg)
{
	art.dialog({
		lock: true,
		width: '20em',
	    height: 55,
	    background: '#999999',
	    content: msg,
	    ok: function () {
	        findList();
	        return true;
	    },
	    cancel :function() {
	    	findList();
	        return true;
	    },
	    cancelVal : "确定"
	});
}
//弹出成功 之后 跳到其他页面 13.4.22 gcl
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
	    cancel :function() {
	    	window.location.href=url;
	        return true;
	    },
	    cancelVal : "确定"
	});
}
  function confirm(content, yes, no) {
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
}

// 弹窗以后可以,可以执行查询
// 参数: msg: 弹出信息 c: 当前页码 t: 总页数 总要用来删除 以后执行的查询
function alertFind(msg,c,t)
{
	art.dialog({
		lock: true,
		width: '20em',
	    height: 55,
	    background: '#999999',
	    content: msg,
	    ok: function () {
	    	// this.title('3秒后自动关闭').time(3);
	        findList(c,t);
	        return true;
	    },
	     cancel :function () {
	    	findList(c,t);
	        return true;
	    },
	    cancelVal : "确定"
	});
}
function confirm1(url,currPage,totalPages)
{
	var merList=$("input[name='count']:checked");		
	if(merList.length < 1)
	{
		alert("请先选择你要删除的记录");
		return false;
	}
	else
	{
		art.dialog({
			lock: true,
			width: '20em',
		    height: 55,
		    background: '#999999',
		    content: '确定删除么？',
		    ok: function () {
					var list = {};
					merList.each(function(i)
					{
						list[i] = $(this).val();
					});	
					var data ={"deleteList":list};		  		
				   //	var url="orgExtend_removeOrgExtend.action";
				// 提交
				   $.post(url,data,
						function()
						{
							alertFind("删除成功",currPage,totalPages); 
						}
					);
			return true;
		    },
		    cancelVal: '取消',
		    cancel: true // 为true等价于function(){}
	   
		})
	}
}
function addCount(e, thisvalue) {//添加checkbox值
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
		alert("请选择你要删除的一条记录");
	} else {
		art.dialog({
			lock: true,
			width: '20em',
		    height: 55,
		    background: '#999999',
		    content: '确定删除么？',
		    ok: function () {
			var data = {
				"count" : info
			};
			$.post(url, data, function() {
				alertFind("删除成功",currPage,totalPages);
				$("#arrayid").val("");
			});
			return true;
		    },
		    cancelVal: '取消',
		    cancel: true // 为true等价于function(){}
		})
	}
}
function formatNum(strNum) {  //用逗号每3位分割数字JS代码 ，也就是人们常说的科学计算法
    if(strNum.length <= 3)  {  
        return strNum;  
    }  

    if(!/^(\+|-)?(\d+)(\.\d+)?$/.test(strNum)){  
        return strNum;  
    }  
    var a = RegExp.$1, b = RegExp.$2, c = RegExp.$3;  
    var re = new RegExp();  
    re.compile("(\\d)(\\d{3})(,|$)");  

    while(re.test(b)) {  

        b = b.replace(re, "$1,$2$3");  
    }    
    return a +""+ b +""+ c;  

}


function clearNum(strNum) {       //从格式化了的数字中删除逗号函数：

    return strNum.replace(/,/g,""); 

 } 
(function(w){//进度条
		var _html='<div style="line-height: 30px;text-align: center;">请稍候,正在准备数据。。。</div><div id="jsLoadOuter" style="width:250px;height:8px;border:#6BAAC9 solid 1px; background:#C0EBFF; margin:0 auto;box-shadow: 0 0 3px #2E94BB;padding:1px"><div id="jsLoadInner" style="background:#54AEE0;height:100%;width:0"></div></div>';
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
				$("#pagelist").empty();// 清空div
				$("#pagelist").append(tables); // 把数据table放入div中
				new superTable("demoTable", {
						cssSkin : "sDefault",
						fixedCols : 0
				});  
			});
      },
      hidebreak :function(){// 项目出错时中断进度条
    	  $(document).ajaxError(function() {
		progress.complete(function(){
				art.dialog.list['jsLoadingDialog']&&art.dialog.list['jsLoadingDialog'].close();	
			});
	   });	 
      },
       hidden :function(page,tables){
    	   var  tables2="";trs2 ="";
    	  	$("#pagelist").empty();// 清空div
			$("#pagelist1").empty();// 清空div
    	  trs2 += "<table style='margin-top: 0; border-top: 0;'><tr class='ts'><td style='border: 0; text-align: left; padding-left: 6px;'>&nbsp;&nbsp;共有&nbsp;"
								+ page.totalRows
								+ "&nbsp;条记录,当前第&nbsp;"
								+ page.currPage
								+ "&nbsp;页/共"
								+ page.totalPages
								+ "&nbsp;页&nbsp;&nbsp;每页&nbsp;"
								+ page.rows
								+ "&nbsp;条记录</td><td style='text-align: right; padding-right: 8px;'>"
								+ page.url
								+ "转到第<input name='currPage' type='text' size='4' style='height: 12px; width: 20px; border: 1px solid #999999;'id='currPage' onblur='checkCurrPage(this.value)' /><input type='hidden' name='totalPages' value='"
								+ page.totalPages
								+ "' />页<input type='hidden' name='docurrPages' id='docurrPages' value='"
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
								 
								if ($.trim(info[i]) == $.trim($(this).val())) { // 这里是你要选的值
									$(this).attr("checked", true);
									break;
								}
							}
						});
			});		
				 
      },
       hidden2 :function(page,tables){
    	   var  tables2="";trs2 ="";
    	  	$("#pagelist").empty();// 清空div
			$("#pagelist1").empty();// 清空div
    	  trs2 += "<table style='margin-top: 0; border-top: 0;'><tr class='ts'><td style='border: 0; text-align: left; padding-left: 6px;'>&nbsp;&nbsp;共有&nbsp;"
								+ page.totalRows
								+ "&nbsp;条记录,当前第&nbsp;"
								+ page.currPage
								+ "&nbsp;页/共"
								+ page.totalPages
								+ "&nbsp;页&nbsp;&nbsp;每页&nbsp;"
								+ page.rows
								+ "&nbsp;条记录</td><td style='text-align: right; padding-right: 8px;'>"
								+ page.url
								+ "转到第<input name='currPage' type='text' size='4' style='height: 12px; width: 20px; border: 1px solid #999999;'id='currPage' onblur='checkCurrPage(this.value)' /><input type='hidden' name='totalPages' value='"
								+ page.totalPages
								+ "' />页<input type='hidden' name='docurrPages' id='docurrPages' value='"
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
       hidden3 :function(page,tables){
    	   var  tables2="";trs2 ="";
    	  	$("#pagelist").empty();// 清空div
			$("#pagelist1").empty();// 清空div
    	  trs2 += "<table id='tstab' style='margin-top: 0;  border-top: 0;'><tr class='ts'><td style='border: 0; text-align: left; padding-left: 6px;'>&nbsp;&nbsp;共有&nbsp;"
								+ page.totalRows
								+ "&nbsp;条记录,当前第&nbsp;"
								+ page.currPage
								+ "&nbsp;页/共"
								+ page.totalPages
								+ "&nbsp;页&nbsp;&nbsp;每页&nbsp;"
								+ page.rows
								+ "&nbsp;条记录</td><td style='text-align: right; padding-right: 8px;'>"
								+ page.url
								+ "转到第<input name='currPage' type='text' size='4' style='height: 12px; width: 20px; border: 1px solid #999999;'id='currPage' onblur='checkCurrPage(this.value)' /><input type='hidden' name='totalPages' value='"
								+ page.totalPages
								+ "' />页<input type='hidden' name='docurrPages' id='docurrPages' value='"
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
			});		
				 
      }
	 }
//获取窗口的高度 
var windowHeight; 
//获取窗口的宽度 
var windowWidth; 
//获取弹窗的宽度 
var popWidth; 
//获取弹窗高度 
var popHeight; 
var popupStatus;
function init(){ 
   windowHeight=$(window).height(); 
   windowWidth=$(window).width(); 
   popHeight=$(".window").height(); 
   popWidth=$(".window").width(); 
} 
//关闭窗口的方法 
function closeWindow(){ 
    $(".title span").click(function(){ 
        $(this).parent().parent().hide("slow"); 
        }); 
    }
    //定义弹出居中窗口的方法 
    function popCenterWindow(){ 
    	//showYear()
    	popupStatus=1;
        init(); 
        //计算弹出窗口的左上角Y的偏移量 
    var popY=(windowHeight-popHeight)/2; 
    var popX=(windowWidth-popWidth)/2; 
    //alert(popY); 
    //设定窗口的位置 
    $("#center").css("top",popY).css("left",popX).slideToggle("slow");  
    closeWindow(); 
    }   
//键盘按下ESC时关闭窗口!
$(document).keyup(function(e){   
if(e.keyCode==27 && popupStatus==1){   
 $("#center").hide();
}   
});  



