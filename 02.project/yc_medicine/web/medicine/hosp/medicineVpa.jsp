<%@ page language="java" pageEncoding="gbk" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; gbk"/>
<title>vpa给药信息</title>
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

//保存vpa给药信息数据
function saveMedVpa() {
    var hid = $.trim($("#hid").val());
    if (hid.length == 0) {
        alert("基本信息id不能为空！");
        return false;
    }

    var id = $.trim($("#id").val());
    var date = $.trim($("#date").val());  //给药日期
    var time = $.trim($("#time").val());  //给药时间
    var time2 = $.trim($("#time2").val());  //给药时间
    var time3 = $.trim($("#time3").val());  //给药时间
    var amt = $.trim($("#amt").val());  //给药剂量
    var amt2 = $.trim($("#amt2").val());  //给药剂量
    var amt3 = $.trim($("#amt3").val());  //给药剂量
    var rate = $.trim($("#rate").val());   //给药频率QD(一天一次)，BID一天两次 TID一天三次
    var form = $.trim($("#form").val());
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度

    var lmsq = $.trim($("#lmsq").val()); //是否合用拉莫三嗪，合用输入”1”，未合用输入“0”
    var lxxp = $.trim($("#lxxp").val()); //是否合用氯硝西泮，合用输入”1”，未合用输入“0”；
    var kmxp = $.trim($("#kmxp").val()); //是否合用卡马西平，合用输入”1”，未合用输入“0”；
    var tt = $.trim($("#tt").val()); //是否合用妥泰（妥吡酯），合用输入”1”，未合用输入“0”；
    var bbbt = $.trim($("#bbbt").val());  //是否用合苯巴比妥，合用输入”1”，未合用输入“0”；
    var kpl = $.trim($("#kpl").val());  //是否合用开普兰（左乙拉西坦），合用输入”1”，未合用输入“0”
    var okxp = $.trim($("#okxp").val());  //是否合用奥卡西平，合用输入”1”，未合用输入“0”；
    var pht = $.trim($("#pht").val());  //是否合用苯妥英，合用输入”1”，未合用输入“0”；

    var xyxx = $.trim($("#xyxx").val());//期望血液浓度下限
    var xysx = $.trim($("#xysx").val()); //期望血液浓度上限
    var cxrq = $.trim($("#cxrq").val());//抽血日期
    var cxsj = $.trim($("#cxsj").val());//抽血时间
    var zxyl = $.trim($("#zxyl").val());//最小用药量
    var zdyl = $.trim($("#zdyl").val());//最大用药量
    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var jyyl = $.trim($("#jyyl").val());//医生建议药量
    var ycxy = $.trim($("#ycxy").val());//预测血药浓度
    var data;
    if (id == null) {    //新增
        data = {
            "medicineVpa.hid": hid,
            "medicineVpa.date": date,
            "medicineVpa.time": time,
            "medicineVpa.time2": time2,
            "medicineVpa.time3": time3,
            "medicineVpa.amt": amt,
            "medicineVpa.amt2": amt2,
            "medicineVpa.amt3": amt3,
            "medicineVpa.rate": rate,
            "medicineVpa.form": form,
            "medicineVpa.dv": dv,
            "medicineVpa.lmsq": lmsq,
            "medicineVpa.lxxp": lxxp,
            "medicineVpa.kmxp": kmxp,
            "medicineVpa.tt": tt,
            "medicineVpa.bbbt": bbbt,
            "medicineVpa.kpl": kpl,
            "medicineVpa.okxp": okxp,
            "medicineVpa.pht": pht,
            "medicineVpa.jg": jg,
            "medicineVpa.cxrq": cxrq,
            "medicineVpa.cxsj": cxsj,
            "medicineVpa.xyxx": xyxx,
            "medicineVpa.xysx": xysx,
            "medicineVpa.zxyl": zxyl,
            "medicineVpa.zdyl": zdyl,
            "medicineVpa.jyyl": jyyl,
            "medicineVpa.ycxy": ycxy
        };
    } else {  //修改
        data = {
            "medicineVpa.id": id,
            "medicineVpa.hid": hid,
            "medicineVpa.date": date,
            "medicineVpa.time": time,
            "medicineVpa.time2": time2,
            "medicineVpa.time3": time3,
            "medicineVpa.amt": amt,
            "medicineVpa.amt2": amt2,
            "medicineVpa.amt3": amt3,
            "medicineVpa.rate": rate,
            "medicineVpa.form": form,
            "medicineVpa.dv": dv,
            "medicineVpa.lmsq": lmsq,
            "medicineVpa.lxxp": lxxp,
            "medicineVpa.kmxp": kmxp,
            "medicineVpa.tt": tt,
            "medicineVpa.bbbt": bbbt,
            "medicineVpa.kpl": kpl,
            "medicineVpa.okxp": okxp,
            "medicineVpa.pht": pht,
            "medicineVpa.jg": jg,
            "medicineVpa.cxrq": cxrq,
            "medicineVpa.cxsj": cxsj,
            "medicineVpa.xyxx": xyxx,
            "medicineVpa.xysx": xysx,
            "medicineVpa.zxyl": zxyl,
            "medicineVpa.zdyl": zdyl,
            "medicineVpa.jyyl": jyyl,
            "medicineVpa.ycxy": ycxy
        };
    }

    //帐号只能输入数字
    $.post("vpa!saveMedVpa.action", data,
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
    var time2 = $.trim($("#time2").val());  //给药时间2
    var time3 = $.trim($("#time3").val());  //给药时间3
    var amt = $.trim($("#amt").val());  //给药剂量
    var amt2 = $.trim($("#amt2").val());  //给药剂量2
    var amt3 = $.trim($("#amt3").val());  //给药剂量3

    var rate = $.trim($("#rate").val());   //给药频率QD(一天一次)，BID一天两次 TID一天三次
    var form = $.trim($("#form").val());
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度

    var lmsq = $.trim($("#lmsq").val()); //是否合用拉莫三嗪，合用输入”1”，未合用输入“0”
    var lxxp = $.trim($("#lxxp").val()); //是否合用氯硝西泮，合用输入”1”，未合用输入“0”；
    var kmxp = $.trim($("#kmxp").val()); //是否合用卡马西平，合用输入”1”，未合用输入“0”；
    var tt = $.trim($("#tt").val()); //是否合用妥泰（妥吡酯），合用输入”1”，未合用输入“0”；
    var bbbt = $.trim($("#bbbt").val());  //是否用合苯巴比妥，合用输入”1”，未合用输入“0”；
    var kpl = $.trim($("#kpl").val());  //是否合用开普兰（左乙拉西坦），合用输入”1”，未合用输入“0”
    var okxp = $.trim($("#okxp").val());  //是否合用奥卡西平，合用输入”1”，未合用输入“0”；
    var pht = $.trim($("#pht").val());  //是否合用苯妥英，合用输入”1”，未合用输入“0”；

    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var cxrq = $.trim($("#cxrq").val());//抽血日期
    var cxsj = $.trim($("#cxsj").val());//抽血时间

    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineVpa.date": date,
        "medicineVpa.time": time,
        "medicineVpa.time2": time2,
        "medicineVpa.time3": time3,
        "medicineVpa.amt": amt,
        "medicineVpa.amt2": amt2,
        "medicineVpa.amt3": amt3,
        "medicineVpa.rate": rate,
        "medicineVpa.form": form,
        "medicineVpa.dv": dv,
        "medicineVpa.lmsq": lmsq,
        "medicineVpa.lxxp": lxxp,
        "medicineVpa.kmxp": kmxp,
        "medicineVpa.tt": tt,
        "medicineVpa.bbbt": bbbt,
        "medicineVpa.kpl": kpl,
        "medicineVpa.okxp": okxp,
        "medicineVpa.pht": pht,
        "medicineVpa.jg": jg,
        "medicineVpa.cxrq": cxrq,
        "medicineVpa.cxsj": cxsj
    };
    $.post("vpa!ycxynd.action", data,
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
    var time2 = $.trim($("#time2").val());  //给药时间2
    var time3 = $.trim($("#time3").val());  //给药时间3
    var amt = $.trim($("#amt").val());  //给药剂量
    var amt2 = $.trim($("#amt2").val());  //给药剂量2
    var amt3 = $.trim($("#amt3").val());  //给药剂量3

    var rate = $.trim($("#rate").val());   //给药频率QD(一天一次)，BID一天两次 TID一天三次
    var form = $.trim($("#form").val());
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度

    var lmsq = $.trim($("#lmsq").val()); //是否合用拉莫三嗪，合用输入”1”，未合用输入“0”
    var lxxp = $.trim($("#lxxp").val()); //是否合用氯硝西泮，合用输入”1”，未合用输入“0”；
    var kmxp = $.trim($("#kmxp").val()); //是否合用卡马西平，合用输入”1”，未合用输入“0”；
    var tt = $.trim($("#tt").val()); //是否合用妥泰（妥吡酯），合用输入”1”，未合用输入“0”；
    var bbbt = $.trim($("#bbbt").val());  //是否用合苯巴比妥，合用输入”1”，未合用输入“0”；
    var kpl = $.trim($("#kpl").val());  //是否合用开普兰（左乙拉西坦），合用输入”1”，未合用输入“0”
    var okxp = $.trim($("#okxp").val());  //是否合用奥卡西平，合用输入”1”，未合用输入“0”；
    var pht = $.trim($("#pht").val());  //是否合用苯妥英，合用输入”1”，未合用输入“0”；

    var xyxx = $.trim($("#xyxx").val());//期望血液浓度下限
    var xysx = $.trim($("#xysx").val()); //期望血液浓度上限
    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var cxrq = $.trim($("#cxrq").val());//抽血日期
    var cxsj = $.trim($("#cxsj").val());//抽血时间
    var zxyl = $.trim($("#zxyl").val());//最小用药量
    var zdyl = $.trim($("#zdyl").val());//最大用药量
    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineVpa.date": date,
        "medicineVpa.time": time,
        "medicineVpa.time2": time2,
        "medicineVpa.time3": time3,
        "medicineVpa.amt": amt,
        "medicineVpa.amt2": amt2,
        "medicineVpa.amt3": amt3,
        "medicineVpa.rate": rate,
        "medicineVpa.form": form,
        "medicineVpa.dv": dv,
        "medicineVpa.lmsq": lmsq,
        "medicineVpa.lxxp": lxxp,
        "medicineVpa.kmxp": kmxp,
        "medicineVpa.tt": tt,
        "medicineVpa.bbbt": bbbt,
        "medicineVpa.kpl": kpl,
        "medicineVpa.okxp": okxp,
        "medicineVpa.pht": pht,
        "medicineVpa.jg": jg,
        "medicineVpa.cxrq": cxrq,
        "medicineVpa.cxsj": cxsj,
        "medicineVpa.xyxx": xyxx,
        "medicineVpa.xysx": xysx,
        "medicineVpa.zxyl": zxyl,
        "medicineVpa.zdyl": zdyl
    };
    $.post("vpa!ycgyjlfw.action", data,
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
function SaveVpaDetail() {

    var id = $.trim($("#id").val());  //给药信息id
    var hid = $.trim($("#hid").val());  //住院信息id

    var date = $.trim($("#date").val());  //给药日期
    var time = $.trim($("#time").val());  //给药时间
    var time2 = $.trim($("#time2").val());  //给药时间2
    var time3 = $.trim($("#time3").val());  //给药时间3
    var amt = $.trim($("#amt").val());  //给药剂量
    var amt2 = $.trim($("#amt2").val());  //给药剂量2
    var amt3 = $.trim($("#amt3").val());  //给药剂量3

    var rate = $.trim($("#rate").val());   //给药频率QD(一天一次)，BID一天两次 TID一天三次
    var form = $.trim($("#form").val());
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度

    var lmsq = $.trim($("#lmsq").val()); //是否合用拉莫三嗪，合用输入”1”，未合用输入“0”
    var lxxp = $.trim($("#lxxp").val()); //是否合用氯硝西泮，合用输入”1”，未合用输入“0”；
    var kmxp = $.trim($("#kmxp").val()); //是否合用卡马西平，合用输入”1”，未合用输入“0”；
    var tt = $.trim($("#tt").val()); //是否合用妥泰（妥吡酯），合用输入”1”，未合用输入“0”；
    var bbbt = $.trim($("#bbbt").val());  //是否用合苯巴比妥，合用输入”1”，未合用输入“0”；
    var kpl = $.trim($("#kpl").val());  //是否合用开普兰（左乙拉西坦），合用输入”1”，未合用输入“0”
    var okxp = $.trim($("#okxp").val());  //是否合用奥卡西平，合用输入”1”，未合用输入“0”；
    var pht = $.trim($("#pht").val());  //是否合用苯妥英，合用输入”1”，未合用输入“0”；

    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var cxrq = $.trim($("#cxrq").val());//抽血日期
    var cxsj = $.trim($("#cxsj").val());//抽血时间


    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineVpa.hid": Number(hid),
        "medicineVpa.date": date,
        "medicineVpa.time": time,
        "medicineVpa.time2": time2,
        "medicineVpa.time3": time3,
        "medicineVpa.amt": amt,
        "medicineVpa.amt2": amt2,
        "medicineVpa.amt3": amt3,
        "medicineVpa.rate": rate,
        "medicineVpa.form": form,
        "medicineVpa.dv": dv,
        "medicineVpa.lmsq": lmsq,
        "medicineVpa.lxxp": lxxp,
        "medicineVpa.kmxp": kmxp,
        "medicineVpa.tt": tt,
        "medicineVpa.bbbt": bbbt,
        "medicineVpa.kpl": kpl,
        "medicineVpa.okxp": okxp,
        "medicineVpa.pht": pht,
        "medicineVpa.jg": jg,
        "medicineVpa.cxrq": cxrq,
        "medicineVpa.cxsj": cxsj
    };
    $.post("vpa!SaveVpaDetail.action", data,
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
        当前位置：vpa给药信息
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
         <input type="hidden" id="id" value="<s:property value="#request.medicineVpa.id"/>"/>
    </td>
</tr>
<tr>
    <td>
        药物剂型：
    </td>
    <td>
        <s:select id="form" list="#{1:'溶液剂',2:'片剂',2:'缓释剂'}" listKey="key" listValue="value" value="%{medicineVpa.form}"/>
    </td>
    <td>
        给药剂量(mg)：
    </td>
    <td>
        <s:textfield type="text" id="amt" style="width: 100px;" value="%{medicineVpa.amt}"/>
    </td>
    <td>
        给药剂量2(mg)：
    </td>
    <td>
        <s:textfield type="text" id="amt2" style="width: 100px;" value="%{medicineVpa.amt2}"/>
    </td>
    <td>
        给药剂量3(mg)：
    </td>
    <td>
        <s:textfield type="text" id="amt3" style="width: 100px;" value="%{medicineVpa.amt3}"/>
    </td>
</tr>
<tr>
    <td>
        给药日期：
    </td>
    <td>
        <s:textfield type="text" id="date" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:CurentTime()})"
                     value="%{medicineVpa.date}"/>
    </td>
    <td>
        给药时间：
    </td>
    <td>
        <s:textfield type="text" id="time" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineVpa.time}"/>
    </td>
    <td>
        给药时间2：
    </td>
    <td>
        <s:textfield type="text" id="time2" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineVpa.time2}"/>
    </td>
    <td>
        给药时间3：
    </td>
    <td>
        <s:textfield type="text" id="time3" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineVpa.time3}"/>
    </td>
</tr>
<tr>
    <td>
        抽血日期：
    </td>
    <td>
        <s:textfield type="text" id="cxrq" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:'3000-01-01'})"
                     value="%{medicineVpa.cxrq}"/>
    </td>
    <td>
        抽血时间：
    </td>
    <td>
        <s:textfield type="text" id="cxsj" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineVpa.cxsj}"/>
    </td>
    <td>
        给药频率：
    </td>
    <td>
        <s:select id="rate" list="#{1:'QD(一天一次)',2:'BID(一天两次)',3:'TID(一天三次)'}" listKey="key" listValue="value"
                  value="%{medicineVpa.rate}"/>
    </td>

    <td>
        剂量调整间隔：
    </td>
    <td>
        <s:textfield type="text" id="jg" style="width: 100px;" value="%{medicineVpa.jg}"/>
    </td>
</tr>
<tr>
    <td>
        合用苯妥英：
    </td>
    <td>
        <s:select id="pht" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineVpa.pht}"/>
    </td>
    <td>
        合用拉莫三嗪：
    </td>
    <td>
        <s:select id="lmsq" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineVpa.lmsq}"/>
    </td>
    <td>
        合用氯硝西泮：
    </td>
    <td>
        <s:select id="lxxp" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineVpa.lxxp}"/>
    </td>
    <td>
        合用卡马西平：
    </td>
    <td>
        <s:select id="kmxp" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineVpa.kmxp}"/>
    </td>
</tr>
<tr>

    <td>
        合用妥泰（妥吡酯）：
    </td>
    <td>
        <s:select id="tt" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineVpa.tt}"/>
    </td>
    <td>
        合用苯巴比妥：
    </td>
    <td>
        <s:select id="bbbt" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineVpa.bbbt}"/>
    </td>
    <td>
        合用开普兰：
    </td>
    <td>
        <s:select id="kpl" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineVpa.kpl}"/>
    </td>
    <td>
        合用奥卡西平：
    </td>
    <td>
        <s:select id="okxp" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineVpa.okxp}"/>
    </td>
</tr>
<tr>
    <td>
        期望血药浓度下限：
    </td>
    <td>
        <s:textfield type="text" id="xyxx" style="width: 100px;" value="%{medicineVpa.xyxx}"/>
    </td>
    <td>
        期望血药浓度上限：
    </td>
    <td>
        <s:textfield type="text" id="xysx" style="width: 100px;" value="%{medicineVpa.xysx}"/>
    </td>
    <td>
        上次给药后血浓度：
    </td>
    <td>
        <s:textfield type="text" id="dv" style="width: 100px;" value="%{medicineVpa.dv}"/>
    </td>
    <td>医生建议用量：</td>
    <td><s:textfield type="text" id="jyyl" style="width: 100px;" value="%{medicineVpa.jyyl}"/></td>
</tr>
<tr>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="ycxynd()" value="预测血药浓度 ">
    </td>
    <td>
        <s:textfield type="text" id="ycxy" style="width: 100px;" value="%{medicineVpa.ycxy}" />
    </td>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="ycgyjlfw()" value="预测剂量范围">
    </td>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="SaveVpaDetail()" value="保存给药明细">
    </td>
    <td>
        最小给药量：
    </td>
    <td>
        <s:textfield type="text" id="zxyl" style="width: 100px;" value="%{medicineVpa.zxyl}"/>
    </td>
    <td>
        最大给药量：
    </td>
    <td>
        <s:textfield type="text" id="zdyl" style="width: 100px;" value="%{medicineVpa.zdyl}"/>
    </td>
</tr>
<tr>
    <td colspan="4" align="center" style="text-align: center;">
        <a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
           onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="saveMedVpa()"
           style="text-align:center;">
            <img name="java" src="<%=path %>/images/abc.jpg" border="0"/>
        </a>
    </td>
    <td colspan="4" align="center" style="text-align: center;">
        <a href="<%=path%>/medicine/hosp/vpa!toMedicineVpaList.action?hid=<s:property value="#request.hobi.id"/>&currPage=<s:property value='currPage'/>&totalPages=<s:property value='totalPages'/>"
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