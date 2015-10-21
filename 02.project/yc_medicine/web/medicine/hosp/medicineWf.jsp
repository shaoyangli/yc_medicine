<%@ page language="java" pageEncoding="gbk" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; gbk"/>
<title>wf给药信息</title>
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

//保存wf给药信息数据
function saveMedWf() {
    var hid = $.trim($("#hid").val());
    if (hid.length == 0) {
        alert("基本信息id不能为空！");
        return false;
    }

    var id = $.trim($("#id").val());
    var dose = $.trim($("#dose").val());  //给药剂量
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度
    var adm = $.trim($("#adm").val()); //是否合用胺碘酮
    var cyp = $.trim($("#cyp").val());   //CYP2C9基因型，若为*1/*1型,输入“0”，若为*1/*3型,输入“1”
    var vkorc = $.trim($("#vkorc").val()); //VKORC1基因型，若为AA型,输入“0”，若为AG或GG型,输入“1”；

    var xyxx = $.trim($("#xyxx").val());//期望血液浓度下限
    var xysx = $.trim($("#xysx").val()); //期望血液浓度上限
    var zxyl = $.trim($("#zxyl").val());//最小用药量
    var zdyl = $.trim($("#zdyl").val());//最大用药量
    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var jyyl = $.trim($("#jyyl").val());//医生建议药量
    var ycxy = $.trim($("#ycxy").val());//预测血药浓度

    var data;
    if (id == null) {    //新增
        data = {
            "medicineWf.hid": hid,
            "medicineWf.dose": dose,
            "medicineWf.dv": dv,
            "medicineWf.adm": adm,
            "medicineWf.cyp": cyp,
            "medicineWf.vkorc": vkorc,
            "medicineWf.jg": jg,
            "medicineWf.xyxx": xyxx,
            "medicineWf.xysx": xysx,
            "medicineWf.zxyl": zxyl,
            "medicineWf.zdyl": zdyl,
            "medicineWf.jyyl": jyyl,
            "medicineWf.ycxy": ycxy
        };
    } else {  //修改
        data = {
            "medicineWf.id": id,
            "medicineWf.hid": hid,
            "medicineWf.dose": dose,
            "medicineWf.dv": dv,
            "medicineWf.adm": adm,
            "medicineWf.cyp": cyp,
            "medicineWf.vkorc": vkorc,
            "medicineWf.jg": jg,
            "medicineWf.xyxx": xyxx,
            "medicineWf.xysx": xysx,
            "medicineWf.zxyl": zxyl,
            "medicineWf.zdyl": zdyl,
            "medicineWf.jyyl": jyyl,
            "medicineWf.ycxy": ycxy
        };
    }

    //帐号只能输入数字
    $.post("wf!saveMedWf.action", data,
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

    var dose = $.trim($("#dose").val());  //给药剂量
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度
    var adm = $.trim($("#adm").val()); //是否合用胺碘酮
    var cyp = $.trim($("#cyp").val());   //CYP2C9基因型，若为*1/*1型,输入“0”，若为*1/*3型,输入“1”
    var vkorc = $.trim($("#vkorc").val()); //VKORC1基因型，若为AA型,输入“0”，若为AG或GG型,输入“1”；
    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var jyyl = $.trim($("#jyyl").val());//医生建议药量
    var ycxy = $.trim($("#ycxy").val());//预测血药浓度

    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineWf.dose": dose,
        "medicineWf.dv": dv,
        "medicineWf.adm": adm,
        "medicineWf.cyp": cyp,
        "medicineWf.vkorc": vkorc,
        "medicineWf.jg": jg,
        "medicineWf.jyyl": jyyl,
        "medicineWf.ycxy": ycxy
    };
    $.post("wf!ycxynd.action", data,
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

    var dose = $.trim($("#dose").val());  //给药剂量
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度
    var adm = $.trim($("#adm").val()); //是否合用胺碘酮
    var cyp = $.trim($("#cyp").val());   //CYP2C9基因型，若为*1/*1型,输入“0”，若为*1/*3型,输入“1”
    var vkorc = $.trim($("#vkorc").val()); //VKORC1基因型，若为AA型,输入“0”，若为AG或GG型,输入“1”；

    var xyxx = $.trim($("#xyxx").val());//期望血液浓度下限
    var xysx = $.trim($("#xysx").val()); //期望血液浓度上限
    var jg = $.trim($("#jg").val()); //剂量调整间隔
    var jyyl = $.trim($("#jyyl").val());//医生建议药量
    var ycxy = $.trim($("#ycxy").val());//预测血药浓度
    var zxyl = $.trim($("#zxyl").val());//最小用药量
    var zdyl = $.trim($("#zdyl").val());//最大用药量
    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineWf.dose": dose,
        "medicineWf.dv": dv,
        "medicineWf.adm": adm,
        "medicineWf.cyp": cyp,
        "medicineWf.vkorc": vkorc,
        "medicineWf.jg": jg,
        "medicineWf.xyxx": xyxx,
        "medicineWf.xysx": xysx,
        "medicineWf.xysx": xysx,
        "medicineWf.jyyl": jyyl,
        "medicineWf.ycxy": ycxy,
        "medicineWf.zxyl": zxyl,
        "medicineWf.zdyl": zdyl
    };
    $.post("wf!ycgyjlfw.action", data,
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
function SaveWfDetail() {

    var id = $.trim($("#id").val());  //给药信息id
    var hid = $.trim($("#hid").val());  //住院信息id

    var dose = $.trim($("#dose").val());  //给药剂量
    var dv = $.trim($("#dv").val());   //上次给药后检测血药浓度
    var adm = $.trim($("#adm").val()); //是否合用胺碘酮
    var cyp = $.trim($("#cyp").val());   //CYP2C9基因型，若为*1/*1型,输入“0”，若为*1/*3型,输入“1”
    var vkorc = $.trim($("#vkorc").val()); //VKORC1基因型，若为AA型,输入“0”，若为AG或GG型,输入“1”；

    var jg = $.trim($("#jg").val()); //剂量调整间隔



    var data;
    data = {
        "id": Number(id),
        "hid": Number(hid),
        "medicineWf.hid": Number(hid),
        "medicineWf.dose": dose,
        "medicineWf.dv": dv,
        "medicineWf.adm": adm,
        "medicineWf.cyp": cyp,
        "medicineWf.vkorc": vkorc,
        "medicineWf.jg": jg
    };
    $.post("wf!SaveWfDetail.action", data,
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
        当前位置：wf给药信息
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
         <input type="hidden" id="id" value="<s:property value="#request.medicineWf.id"/>"/>
    </td>
</tr>
<tr>
    <td>
        给药剂量(mg)：
    </td>
    <td>
        <s:textfield type="text" id="dose" style="width: 100px;" value="%{medicineWf.dose}"/>
    </td>
    <td>
        剂量调整间隔：
    </td>
    <td>
        <s:textfield type="text" id="jg" style="width: 100px;" value="%{medicineWf.jg}"/>
    </td>
    <td>
        合用胺碘酮：
    </td>
    <td>
        <s:select id="adm" list="#{0:'未合用',1:'合用'}" listKey="key" listValue="value"
                  value="%{medicineWf.adm}"/>
    </td>

    <td>
        CYP2C9基因型：
    </td>
    <td>
        <s:select id="cyp" list="#{0:'*1/*1型',1:'*1/*3型'}" listKey="key" listValue="value"
                  value="%{medicineWf.cyp}"/>
    </td>
</tr>
<tr>
    <td>
        VKORC1基因型：
    </td>
    <td>
        <s:select id="vkorc" list="#{0:'AA型',1:'AG或GG型'}" listKey="key" listValue="value"
                  value="%{medicineWf.vkorc}"/>
    </td>
    <td>
        上次给药后血浓度：
    </td>
    <td>
        <s:textfield type="text" id="dv" style="width: 100px;" value="%{medicineWf.dv}"/>
    </td>
    <td>医生建议用量：</td>
    <td><s:textfield type="text" id="jyyl" style="width: 100px;" value="%{medicineWf.jyyl}"/></td>
    <td></td><td></td>
</tr>
<tr>
    <td>
        期望血药浓度下限：
    </td>
    <td>
        <s:textfield type="text" id="xyxx" style="width: 100px;" value="%{medicineWf.xyxx}"/>
    </td>
    <td>
        期望血药浓度上限：
    </td>
    <td>
        <s:textfield type="text" id="xysx" style="width: 100px;" value="%{medicineWf.xysx}"/>
    </td>
    <td>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="SaveWfDetail()" value="保存给药明细">
    </td>
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
        <s:textfield type="text" id="ycxy" style="width: 100px;" value="%{medicineWf.ycxy}" />
    </td>
    <td colspan="2" align="center" style="text-align: center;">
        <input type="button" onclick="ycgyjlfw()" value="预测给药剂量范围">
    </td>
    <td>
        最小给药量：
    </td>
    <td>
        <s:textfield type="text" id="zxyl" style="width: 100px;" value="%{medicineWf.zxyl}"/>
    </td>
    <td>
        最大给药量：
    </td>
    <td>
        <s:textfield type="text" id="zdyl" style="width: 100px;" value="%{medicineWf.zdyl}"/>
    </td>
</tr>
<tr>
    <td colspan="4" align="center" style="text-align: center;">
        <a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
           onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="saveMedWf()"
           style="text-align:center;">
            <img name="java" src="<%=path %>/images/abc.jpg" border="0"/>
        </a>
    </td>
    <td colspan="4" align="center" style="text-align: center;">
        <a href="<%=path%>/medicine/hosp/wf!toMedicineWfList.action?hid=<s:property value="#request.hobi.id"/>&currPage=<s:property value='currPage'/>&totalPages=<s:property value='totalPages'/>"
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