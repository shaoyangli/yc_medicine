<%@ page language="java" pageEncoding="gbk" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; gbk"/>
<title>fk给药信息</title>
<link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css"/>
<script language="javascript" type="text/javascript"
        src="<%=path%>/js/zdc.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
<script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
<script language="javascript" type="text/javascript"
        src="<%=path%>/js/My97DatePicker/WdatePicker.js"/>
<script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
<style type="text/css">
    .search {
        font-family: "宋体";
        font-size: 12px;
        behavior BEHAVIOR : url ( ' <%=path%> /css/selectBox.htc' );
        cursor: hand;
    }
</style>
<script type="text/javascript">

//保存fk给药信息数据
function saveMedFk() {
    var hid = $.trim($("#hid").val());
    if (hid.length == 0) {
        alert("基本信息id不能为空！");
        return false;
    }

    var id = $.trim($("#id").val());

    var date = $.trim($("#date").val());  //给药日期
    var time = $.trim($("#time").val());  //给药时间
    var amt = $.trim($("#amt").val());  //给药剂量
    var time2 = $.trim($("#time2").val());  //给药时间2
    var amt2 = $.trim($("#amt2").val());  //给药剂量2
    var cmt = $.trim($("#cmt").val()); //给药方式
    var rate = $.trim($("#rate").val());   //给药频率
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度
    var hgb = $.trim($("#hgb").val());
    var inhi = $.trim($("#inhi").val());
    var pod = $.trim($("#pod").val());
    var rbc = $.trim($("#rbc").val());  //红细胞计数
    var htc = $.trim($("#htc").val()); //红细胞比积
    var tbil = $.trim($("#tbil").val());  //总胆红素积
    var alt = $.trim($("#alt").val());  //谷丙转氨酶
    var ast = $.trim($("#ast").val());  //谷草转氨酶

    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var xyxx = $.trim($("#xyxx").val());//期望血液浓度下限
    var xysx = $.trim($("#xysx").val()); //期望血液浓度上限
    var cxrq = $.trim($("#cxrq").val());//抽血日期
    var cxsj = $.trim($("#cxsj").val());//抽血时间
    var zxyl = $.trim($("#zxyl").val());//最小用药量
    var zdyl = $.trim($("#zdyl").val());//最大用药量
    var jyyl = $.trim($("#jyyl").val());//医生建议药量
    var ycxy = $.trim($("#ycxy").val());//预测血药浓度
    var data;
    if (id == null) {    //新增
        data = {
            "medicineFk.hid": hid,
            "medicineFk.date": date,
            "medicineFk.time": time,
            "medicineFk.amt": amt,
            "medicineFk.time2": time2,
            "medicineFk.amt2": amt2,
            "medicineFk.cmt": cmt,
            "medicineFk.rate": rate,
            "medicineFk.dv": dv,
            "medicineFk.hgb": hgb,
            "medicineFk.inhi": inhi,
            "medicineFk.pod": pod,
            "medicineFk.rbc": rbc,
            "medicineFk.htc": htc,
            "medicineFk.tbil": tbil,
            "medicineFk.alt": alt,
            "medicineFk.ast": ast,
            "medicineFk.jg": jg,
            "medicineFk.cxrq": cxrq,
            "medicineFk.cxsj": cxsj,
            "medicineFk.xyxx": xyxx,
            "medicineFk.xysx": xysx,
            "medicineFk.zxyl": zxyl,
            "medicineFk.zdyl": zdyl,
            "medicineFk.jyyl": jyyl,
            "medicineFk.ycxy": ycxy
        };
    } else {  //修改
        data = {
            "medicineFk.id": id,
            "medicineFk.hid": hid,
            "medicineFk.date": date,
            "medicineFk.time": time,
            "medicineFk.amt": amt,
            "medicineFk.time2": time2,
            "medicineFk.amt2": amt2,
            "medicineFk.cmt": cmt,
            "medicineFk.rate": rate,
            "medicineFk.dv": dv,
            "medicineFk.hgb": hgb,
            "medicineFk.inhi": inhi,
            "medicineFk.pod": pod,
            "medicineFk.rbc": rbc,
            "medicineFk.htc": htc,
            "medicineFk.tbil": tbil,
            "medicineFk.alt": alt,
            "medicineFk.ast": ast,
            "medicineFk.jg": jg,
            "medicineFk.cxrq": cxrq,
            "medicineFk.cxsj": cxsj,
            "medicineFk.xyxx": xyxx,
            "medicineFk.xysx": xysx,
            "medicineFk.zxyl": zxyl,
            "medicineFk.zdyl": zdyl,
            "medicineFk.jyyl": jyyl,
            "medicineFk.ycxy": ycxy
        };
    }

    //帐号只能输入数字
    $.post("fk!saveMedFk.action", data,
            function (json) {
                if (json.isSuccess == 1) {
                    $("#id").val(json.id);//给药信息id
                    alert(json.id);
                    alert("保存成功！");
                    return false;
                }
                if (json.isSuccess == 0) {
                    alert("未知错误,保存失败！");
                }
            }
    )
}

//预测血药浓度
function ycxynd() {
    var id = $.trim($("#id").val());  //给药信息id
    if(id==null){
        id=0;
    }
    var hid = $.trim($("#hid").val());  //住院信息id
    if(hid==null){
       hid=0;
    }

    var date = $.trim($("#date").val());  //给药日期
    var time = $.trim($("#time").val());  //给药时间
    var amt = $.trim($("#amt").val());  //给药剂量
    var time2 = $.trim($("#time2").val());  //给药时间2
    var amt2 = $.trim($("#amt2").val());  //给药剂量2
    var cmt = $.trim($("#cmt").val()); //给药方式
    var rate = $.trim($("#rate").val());   //给药频率
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度
    var hgb = $.trim($("#hgb").val());
    var inhi = $.trim($("#inhi").val());
    var pod = $.trim($("#pod").val());
    var rbc = $.trim($("#rbc").val());  //红细胞计数
    var htc = $.trim($("#htc").val()); //红细胞比积
    var tbil = $.trim($("#tbil").val());  //总胆红素积
    var alt = $.trim($("#alt").val());  //谷丙转氨酶
    var ast = $.trim($("#ast").val());  //谷草转氨酶

    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var xyxx = $.trim($("#xyxx").val());//期望血液浓度下限
    var xysx = $.trim($("#xysx").val()); //期望血液浓度上限
    var cxrq = $.trim($("#cxrq").val());//抽血日期
    var cxsj = $.trim($("#cxsj").val());//抽血时间

    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineFk.date": date,
        "medicineFk.time": time,
        "medicineFk.amt": amt,
        "medicineFk.time2": time2,
        "medicineFk.amt2": amt2,
        "medicineFk.cmt": cmt,
        "medicineFk.rate": rate,
        "medicineFk.dv": dv,
        "medicineFk.hgb": hgb,
        "medicineFk.inhi": inhi,
        "medicineFk.pod": pod,
        "medicineFk.rbc": rbc,
        "medicineFk.htc": htc,
        "medicineFk.tbil": tbil,
        "medicineFk.alt": alt,
        "medicineFk.ast": ast,
        "medicineFk.jg": jg,
        "medicineFk.cxrq": cxrq,
        "medicineFk.cxsj": cxsj,
        "medicineFk.xyxx": xyxx,
        "medicineFk.xysx": xysx
    };
    $.post("fk!ycxynd.action", data,
            function (json) {
                if (json.isSuccess == 1) {
                    $("#ycxy").val(json.param);
                    alert("预测成功！");
                    return false;
                }
                if (json.isSuccess == 0) {
                    alert("预测异常！");
                }
            }
    )

}
//预测给药剂量范围
function ycgyjlfw() {
    var id = $.trim($("#id").val());  //给药信息id
    if(id==null){
        id=0;
    }
    var hid = $.trim($("#hid").val());  //住院信息id
    if(hid==null){
        hid=0;
    }

    var date = $.trim($("#date").val());  //给药日期
    var time = $.trim($("#time").val());  //给药时间
    var amt = $.trim($("#amt").val());  //给药剂量
    var time2 = $.trim($("#time2").val());  //给药时间2
    var amt2 = $.trim($("#amt2").val());  //给药剂量2
    var cmt = $.trim($("#cmt").val()); //给药方式
    var rate = $.trim($("#rate").val());   //给药频率
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度
    var hgb = $.trim($("#hgb").val());
    var inhi = $.trim($("#inhi").val());
    var pod = $.trim($("#pod").val());
    var rbc = $.trim($("#rbc").val());  //红细胞计数
    var htc = $.trim($("#htc").val()); //红细胞比积
    var tbil = $.trim($("#tbil").val());  //总胆红素积
    var alt = $.trim($("#alt").val());  //谷丙转氨酶
    var ast = $.trim($("#ast").val());  //谷草转氨酶

    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var xyxx = $.trim($("#xyxx").val());//期望血液浓度下限
    var xysx = $.trim($("#xysx").val()); //期望血液浓度上限
    var cxrq = $.trim($("#cxrq").val());//抽血日期
    var cxsj = $.trim($("#cxsj").val());//抽血时间
    var zxyl = $.trim($("#zxyl").val());//最小用药量
    var zdyl = $.trim($("#zdyl").val());//最大用药量
    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineFk.date": date,
        "medicineFk.time": time,
        "medicineFk.amt": amt,
        "medicineFk.time2": time2,
        "medicineFk.amt2": amt2,
        "medicineFk.cmt": cmt,
        "medicineFk.rate": rate,
        "medicineFk.dv": dv,
        "medicineFk.hgb": hgb,
        "medicineFk.inhi": inhi,
        "medicineFk.pod": pod,
        "medicineFk.rbc": rbc,
        "medicineFk.htc": htc,
        "medicineFk.tbil": tbil,
        "medicineFk.alt": alt,
        "medicineFk.ast": ast,
        "medicineFk.jg": jg,
        "medicineFk.cxrq": cxrq,
        "medicineFk.cxsj": cxsj,
        "medicineFk.xyxx": xyxx,
        "medicineFk.xysx": xysx,
        "medicineFk.zxyl": zxyl,
        "medicineFk.zdyl": zdyl
    };
    $.post("fk!ycgyjlfw.action", data,
            function (json) {
                if (json.isSuccess == 1) {
                    var str = new Array();
                    var param = json.param;
                    str = param.split(",");
                    $("#ycxy").val(str[0]);     //预测值
                    $("#zdyl").val(str[2]);     // 最大给药量
                    $("#zxyl").val(str[3]);     // 最小给药量
                    alert("预测成功！");
                    return false;
                }
                if (json.isSuccess == 0) {
                    if(json.param=='error'){
                        alert("预测失败，请填写正确的给药剂量和剂量调整间隔(amt-jg小于0)");
                    }else{
                        alert("预测异常！");
                    }
                }
            }
    )

}

//保存给药明细
function SaveFkDetail() {

    var id = $.trim($("#id").val());  //给药信息id
    var hid = $.trim($("#hid").val());  //住院信息id

    var date = $.trim($("#date").val());  //给药日期
    var time = $.trim($("#time").val());  //给药时间

//    $("#amt").val($("#jyyl").val());
    var amt = $.trim($("#amt").val());  //给药剂量
    var time2 = $.trim($("#time2").val());  //给药时间2
    var amt2 = $.trim($("#amt2").val());  //给药剂量2

    var cmt = $.trim($("#cmt").val()); //给药方式
    var rate = $.trim($("#rate").val());   //给药频率
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度
    var hgb = $.trim($("#hgb").val());
    var inhi = $.trim($("#inhi").val());
    var pod = $.trim($("#pod").val());
    var rbc = $.trim($("#rbc").val());  //红细胞计数
    var htc = $.trim($("#htc").val()); //红细胞比积
    var tbil = $.trim($("#tbil").val());  //总胆红素积
    var alt = $.trim($("#alt").val());  //谷丙转氨酶
    var ast = $.trim($("#ast").val());  //谷草转氨酶
    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var cxrq = $.trim($("#cxrq").val());//抽血日期
    var cxsj = $.trim($("#cxsj").val());//抽血时间


    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineFk.hid": Number(hid),
        "medicineFk.date": date,
        "medicineFk.time": time,
        "medicineFk.amt": amt,
        "medicineFk.time2": time2,
        "medicineFk.amt2": amt2,
        "medicineFk.cxrq": cxrq,
        "medicineFk.cxsj": cxsj,
        "medicineFk.cmt": cmt,
        "medicineFk.rate": rate,
        "medicineFk.dv": dv,
        "medicineFk.hgb": hgb,
        "medicineFk.inhi": inhi,
        "medicineFk.pod": pod,
        "medicineFk.rbc": rbc,
        "medicineFk.htc": htc,
        "medicineFk.tbil": tbil,
        "medicineFk.alt": alt,
        "medicineFk.ast": ast,
        "medicineFk.jg": jg
    };
    $.post("fk!SaveFkDetail.action", data,
            function (json) {
                if (json.isSuccess == 1) {
                    $("#ycxy").val(json.param);
                    alert("保存给药明细成功！");
                    return false;
                }
                if (json.isSuccess == 0) {
                    alert("保存异常！");
                }
                if (json.isSuccess == 3) {
                    alert("请先保存给药信息！");
                }
            }
    )
}

</script>
</head>
<body>
<!---main begin------------------------->
<div class="main">
<div class="maint">
    <div class="maintl"></div>
    <div class="maintm">
        <img src="<%=path%>/images/tb1.jpg"/>
        当前位置：fk给药信息
    </div>
    <div class="maintr"></div>
</div>

<div class="mianm">
<div class="mainmt">
<table align="center" style="width: 90%; border-bottom:0; margin-top:12px;table-layout: auto">
    <tr>
        <td colspan="8" style="text-align: center;">
            基本信息
        </td>
    </tr>
    <tr>
        <td>
            住院号：
        </td>
        <td>
            <input type="hidden" id="hid" value="<s:property value="#request.hobi.id"/>"/>
            <s:textfield type="text" id="hospcode" style="width: 60px;" value="%{hobi.hospcode}" disabled="true"/>
        </td>
        <td>
            姓名：
        </td>
        <td>
            <s:textfield type="text" id="name" style="width: 60px;" value="%{hobi.name}" disabled="true"/>
        </td>
        <td>
            性别：
        </td>
        <td>
            <s:select id="sex" list="#{1:'男',2:'女'}" listKey="key" listValue="value"
                      value="%{hobi.sex}" disabled="true" cssStyle="width:60px;"/>
        </td>
        <td>
            年龄：
        </td>
        <td>
            <s:textfield type="text" id="age" style="width: 60px;" value="%{hobi.age}"
                         disabled="true"/>
        </td>
    </tr>
    <tr>
        <td>
            身高：
        </td>
        <td>
            <s:textfield type="text" id="height" style="width: 60px;"
                         value="%{hobi.height}" disabled="true"/>
        </td>
        <td>
            体重：
        </td>
        <td>
            <s:textfield type="text" id="weight" style="width: 60px;"
                         value="%{hobi.weight}" disabled="true"/>
        </td>
        <td>
            体表面积：
        </td>
        <td>
            <s:textfield type="text" id="surface_area" style="width: 60px;"
                         value="%{hobi.surface_area}" disabled="true"/>
        </td>
        <td>
            手术时间：
        </td>
        <td>
            <s:textfield type="text" id="operation_time"
                         onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1890-01-01 11:30:00',maxDate:CurentTime()})"
                         value="%{hobi.operation_time}" disabled="true"/>
        </td>
    </tr>


</table>
<table align="center" style="width: 90%; border-bottom:0; margin-top:12px;table-layout: fixed">
<tr>
    <td colspan="8" style="text-align: center;">
        给药信息
         <input type="hidden" id="id" value="<s:property value="#request.medicineFk.id"/>"/>
    </td>
</tr>
<tr>
    <td>
        给药方式：
    </td>
    <td>
        <s:select id="cmt" list="#{1:'口服',2:'静脉滴注'}" listKey="key" listValue="value" value="%{medicineFk.cmt}"/>
    </td>
    <td>
        给药剂量(mg)：
    </td>
    <td>
        <s:textfield type="text" id="amt" style="width: 100px;" value="%{medicineFk.amt}"/>
    </td>
    <td>
        给药频率：
    </td>
    <td>
        <s:select id="rate" list="#{1:'QD',2:'Q12D',3:'24H滴注'}" listKey="key" listValue="value"
                  value="%{medicineFk.rate}"/>
    </td>

    <td>
        剂量调整间隔：
    </td>
    <td>
        <s:textfield type="text" id="jg" style="width: 100px;" value="%{medicineFk.jg}"/>
    </td>

</tr>
<tr>
    <td>
        给药日期：
    </td>
    <td>
        <s:textfield type="text" id="date" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:CurentTime()})"
                     value="%{medicineFk.date}"/>
    </td>
    <td>
        给药时间：
    </td>
    <td>
        <s:textfield type="text" id="time" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineFk.time}"/>
    </td>
    <td>
        给药时间2：
    </td>
    <td>
        <s:textfield type="text" id="time2" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineFk.time2}"/>
    </td>
    <td>
        给药剂量2(mg)：
    </td>
    <td>
        <s:textfield type="text" id="amt2" style="width: 100px;" value="%{medicineFk.amt2}"/>
    </td>


</tr>
<tr>
    <td>
        血红蛋白：
    </td>
    <td>
        <s:textfield type="text" id="hgb" style="width: 100px;" value="%{medicineFk.hgb}"/>
    </td>

    <td>
        抗真菌药物：
    </td>
    <td>
        <s:select id="inhi" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineFk.inhi}"/>
    </td>
    <td>
        术后天数：
    </td>
    <td>
        <s:textfield type="text" id="pod" style="width: 100px;" value="%{medicineFk.pod}"/>
    </td>
    <td>
        红细胞计数：
    </td>
    <td>
        <s:textfield type="text" id="rbc" style="width: 100px;" value="%{medicineFk.rbc}"/>
    </td>

</tr>
<tr>
    <td>
        红细胞比积：
    </td>
    <td>
        <s:textfield type="text" id="htc" style="width: 100px;" value="%{medicineFk.htc}"/>
    </td>
    <td>
        总胆红素积：
    </td>
    <td>
        <s:textfield type="text" id="tbil" style="width: 100px;" value="%{medicineFk.tbil}"/>
    </td>

    <td>
        谷丙转氨酶：
    </td>
    <td>
        <s:textfield type="text" id="alt" style="width: 100px;" value="%{medicineFk.alt}"/>
    </td>
    <td>
        谷草转氨酶：
    </td>
    <td>
        <s:textfield type="text" id="ast" style="width: 100px;" value="%{medicineFk.ast}"/>
    </td>
</tr>
<tr>
    <td>
        抽血日期：
    </td>
    <td>
        <s:textfield type="text" id="cxrq" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:'3000-01-01'})"
                     value="%{medicineFk.cxrq}"/>
    </td>
    <td>
        抽血时间：
    </td>
    <td>
        <s:textfield type="text" id="cxsj" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineFk.cxsj}"/>
    </td>
    <td>
        上次给药后血浓度：
    </td>
    <td>
        <s:textfield type="text" id="dv" style="width: 100px;" value="%{medicineFk.dv}"/>
    </td>
    <td>医生建议用量：</td>
    <td><s:textfield type="text" id="jyyl" style="width: 100px;" value="%{medicineFk.jyyl}"/></td>
</tr>
<tr>
    <td>
        期望血药浓度下限：
    </td>
    <td>
        <s:textfield type="text" id="xyxx" style="width: 100px;" value="%{medicineFk.xyxx}"/>
    </td>
    <td>
        期望血药浓度上限：
    </td>
    <td>
        <s:textfield type="text" id="xysx" style="width: 100px;" value="%{medicineFk.xysx}"/>
    </td>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="SaveFkDetail()" value="保存给药明细">
    </td>
    <td>
    </td>
    <td>
    </td>
    <td>
    </td>
</tr>
<tr>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="ycxynd()" value="预测血药浓度 ">
    </td>
    <td>
        <s:textfield type="text" id="ycxy" style="width: 100px;" value="%{medicineFk.ycxy}" />
    </td>

    <td colspan="2" align="center" style="text-align: center;">
        <input type="button" onclick="ycgyjlfw()" value="预测给药剂量范围">
    </td>
    <td>
        最小给药量：
    </td>
    <td>
        <s:textfield type="text" id="zxyl" style="width: 100px;" value="%{medicineFk.zxyl}"/>
    </td>
    <td>
        最大给药量：
    </td>
    <td>
        <s:textfield type="text" id="zdyl" style="width: 100px;" value="%{medicineFk.zdyl}"/>
    </td>
</tr>
<tr>
    <td colspan="4" align="center" style="text-align: center;">
        <a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
           onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="saveMedFk()"
           style="text-align:center;">
            <img name="java" src="<%=path %>/images/abc.jpg" border="0"/>
        </a>
    </td>
    <td colspan="4" align="center" style="text-align: center;">
        <a href="<%=path%>/medicine/hosp/fk!toMedicineFkList.action?hid=<s:property value="#request.hobi.id"/>&currPage=<s:property value='currPage'/>&totalPages=<s:property value='totalPages'/>"
           onmouseover="document.java12.src='<%=path%>/images/fh.jpg'"
           onmouseout="document.java12.src='<%=path%>/images/afh.jpg'">
            <img name="java12" src="<%=path%>/images/afh.jpg" border="0"/>
        </a>
    </td>

</tr>

</table>

</div>
</div>
<div class="mainb">
    <div class="mainbl"></div>
    <div class="mainbm"></div>
    <div class="mainbr"></div>
</div>
</div>
</body>
</html>