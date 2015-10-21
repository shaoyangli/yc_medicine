<!-- area_org.js 文件处理 根据乡村组信息获得 每个级别的机构信息 -->
//用户初始化函数；
var sys="";
function systeminit(str) {
    sys=str;
	$.post(sys + "/area!getInitSystem.action", null, initcallback, "json");
}

//用户级别回调函数；
function initcallback(json) {
	var data = eval(json);
	//市级用户
	if (data.length > 0 && data[0].name == "grade" && data[0].value == "4") {
		$$("sheng").options.add(new Option(data[1].value, data[1].name));
		$$("shi").options.add(new Option(data[2].value, data[2].name));
		$$("xian").options.add(new Option("--请选择--",""));
		for (var i = 3; i < data.length; i++) {
			$$("xian").options.add(new Option(data[i].value, data[i].name));
		}
	}
	//县级用户
	if (data.length > 0 && data[0].name == "grade" && data[0].value == "3") {
		$$("sheng").options.add(new Option(data[1].value, data[1].name));
		$$("shi").options.add(new Option(data[2].value, data[2].name));
		$$("xian").options.add(new Option(data[3].value, data[3].name));
		$$("xiang").options.add(new Option("--请选择--", ""));
		for (var i = 4; i < data.length; i++) {
			$$("xiang").options.add(new Option(data[i].value, data[i].name));
		}
		$$("cun").options.add(new Option("--请选择--", ""));
	}
	//乡级用户
	if (data.length > 0 && data[0].name == "grade" && data[0].value == "2") {
		$$("sheng").options.add(new Option(data[1].value, data[1].name));
		$$("shi").options.add(new Option(data[2].value, data[2].name));
		$$("xian").options.add(new Option(data[3].value, data[3].name));
		$$("xiang").options.add(new Option(data[4].value, data[4].name));
		$$("cun").options.add(new Option("--请选择--", ""));
		for (var i = 5; i < data.length; i++) {
			$$("cun").options.add(new Option(data[i].value, data[i].name));
		}
	}
	//村级用户
	if (data.length > 0 && data[0].name == "grade" && data[0].value == "1") {
		$$("sheng").options.add(new Option(data[1].value, data[1].name));
		$$("shi").options.add(new Option(data[2].value, data[2].name));
		$$("xian").options.add(new Option(data[3].value, data[3].name));
		$$("xiang").options.add(new Option(data[4].value, data[4].name));
		$$("cun").options.add(new Option(data[5].value, data[5].name));
	}
	selectjigou(sys);
}
function xianselect() {
	var xiancode = $$("xian").value;
	$.post(sys + "/area!selectXian.action?areacode=" + xiancode, null, xiancallback, "json");
}
function xiancallback(json) {
	var data = eval(json);
	$$("xiang").options.length = 0;
	$$("xiang").options.add(new Option("--请选择--", ""));
	for (var i = 0; i < data.length; i++) {
		$$("xiang").options.add(new Option(data[i].value, data[i].name));
	}
	selectjigou(sys);
}
function xiangselect() {
	var xiancode = $$("xian").value;
	var xiangcode = $$("xiang").value;
	$.post(sys + "/hsfs/area!selectXiang.action?areacode=" + xiancode + "&localcode=" + xiangcode, null, xiangcallback, "json");
}
function xiangcallback(json) {
	var data = eval(json);
	$$("cun").options.length = 0;
	$$("cun").options.add(new Option("--请选择--", ""));
	for (var i = 0; i < data.length; i++) {
		$$("cun").options.add(new Option(data[i].value, data[i].name));
	}
	selectjigou(sys);
}
function selectjigou() {
	var shen = $$("sheng").value;
	var shi = $$("shi").value;
	var xian = $$("xian").value;
	var xiang = $$("xiang").value;
	var cun = $$("cun").value;
	var areacode = shen.substring(0, 2) + shi.substring(2, 4) + xian.substring(4, 6) + xiang.substring(0, 2) + cun.substring(2, 6);
    
	//cd.getHisbtal(trim(areacode),orgacallback);
	$.post(sys + "/area!selectjigou.action?areacode=" + trim(areacode), null, jigoucallback, "json");
}
function jigoucallback(json) {
	var data = eval(json);
	$$("jigou").options.length = 0;
	$$("jigou").options.add(new Option("--请选择--", ""));
	for (var i = 0; i < data.length; i++) {
		$$("jigou").options.add(new Option(data[i].value, data[i].name));
	}
}
var $$ = function (id) {
	return "string" == typeof id ? document.getElementById(id) : id;
};
function lTrim(str) {
	if (str.charAt(0) == " ") {
		str = str.slice(1);
		str = lTrim(str);
	}
	return str;
}
function rTrim(str) {
	var iLength;
	iLength = str.length;
	if (str.charAt(iLength - 1) == " ") {
		str = str.slice(0, iLength - 1);
		str = rTrim(str);
	}
	return str;
}
function trim(str) {
	return lTrim(rTrim(str));
}

