<%@ page language="java" pageEncoding="gbk" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; gbk"/>
<title>fk��ҩ��Ϣ</title>
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
        font-family: "����";
        font-size: 12px;
        behavior BEHAVIOR : url ( ' <%=path%> /css/selectBox.htc' );
        cursor: hand;
    }
</style>
<script type="text/javascript">

//����fk��ҩ��Ϣ����
function saveMedFk() {
    var hid = $.trim($("#hid").val());
    if (hid.length == 0) {
        alert("������Ϣid����Ϊ�գ�");
        return false;
    }

    var id = $.trim($("#id").val());

    var date = $.trim($("#date").val());  //��ҩ����
    var time = $.trim($("#time").val());  //��ҩʱ��
    var amt = $.trim($("#amt").val());  //��ҩ����
    var time2 = $.trim($("#time2").val());  //��ҩʱ��2
    var amt2 = $.trim($("#amt2").val());  //��ҩ����2
    var cmt = $.trim($("#cmt").val()); //��ҩ��ʽ
    var rate = $.trim($("#rate").val());   //��ҩƵ��
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��
    var hgb = $.trim($("#hgb").val());
    var inhi = $.trim($("#inhi").val());
    var pod = $.trim($("#pod").val());
    var rbc = $.trim($("#rbc").val());  //��ϸ������
    var htc = $.trim($("#htc").val()); //��ϸ���Ȼ�
    var tbil = $.trim($("#tbil").val());  //�ܵ����ػ�
    var alt = $.trim($("#alt").val());  //�ȱ�ת��ø
    var ast = $.trim($("#ast").val());  //�Ȳ�ת��ø

    var jg = $.trim($("#jg").val()); //�����������
    var xyxx = $.trim($("#xyxx").val());//����ѪҺŨ������
    var xysx = $.trim($("#xysx").val()); //����ѪҺŨ������
    var cxrq = $.trim($("#cxrq").val());//��Ѫ����
    var cxsj = $.trim($("#cxsj").val());//��Ѫʱ��
    var zxyl = $.trim($("#zxyl").val());//��С��ҩ��
    var zdyl = $.trim($("#zdyl").val());//�����ҩ��
    var jyyl = $.trim($("#jyyl").val());//ҽ������ҩ��
    var ycxy = $.trim($("#ycxy").val());//Ԥ��ѪҩŨ��
    var data;
    if (id == null) {    //����
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
    } else {  //�޸�
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

    //�ʺ�ֻ����������
    $.post("fk!saveMedFk.action", data,
            function (json) {
                if (json.isSuccess == 1) {
                    $("#id").val(json.id);//��ҩ��Ϣid
                    alert(json.id);
                    alert("����ɹ���");
                    return false;
                }
                if (json.isSuccess == 0) {
                    alert("δ֪����,����ʧ�ܣ�");
                }
            }
    )
}

//Ԥ��ѪҩŨ��
function ycxynd() {
    var id = $.trim($("#id").val());  //��ҩ��Ϣid
    if(id==null){
        id=0;
    }
    var hid = $.trim($("#hid").val());  //סԺ��Ϣid
    if(hid==null){
       hid=0;
    }

    var date = $.trim($("#date").val());  //��ҩ����
    var time = $.trim($("#time").val());  //��ҩʱ��
    var amt = $.trim($("#amt").val());  //��ҩ����
    var time2 = $.trim($("#time2").val());  //��ҩʱ��2
    var amt2 = $.trim($("#amt2").val());  //��ҩ����2
    var cmt = $.trim($("#cmt").val()); //��ҩ��ʽ
    var rate = $.trim($("#rate").val());   //��ҩƵ��
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��
    var hgb = $.trim($("#hgb").val());
    var inhi = $.trim($("#inhi").val());
    var pod = $.trim($("#pod").val());
    var rbc = $.trim($("#rbc").val());  //��ϸ������
    var htc = $.trim($("#htc").val()); //��ϸ���Ȼ�
    var tbil = $.trim($("#tbil").val());  //�ܵ����ػ�
    var alt = $.trim($("#alt").val());  //�ȱ�ת��ø
    var ast = $.trim($("#ast").val());  //�Ȳ�ת��ø

    var jg = $.trim($("#jg").val()); //�����������
    var xyxx = $.trim($("#xyxx").val());//����ѪҺŨ������
    var xysx = $.trim($("#xysx").val()); //����ѪҺŨ������
    var cxrq = $.trim($("#cxrq").val());//��Ѫ����
    var cxsj = $.trim($("#cxsj").val());//��Ѫʱ��

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
                    alert("Ԥ��ɹ���");
                    return false;
                }
                if (json.isSuccess == 0) {
                    alert("Ԥ���쳣��");
                }
            }
    )

}
//Ԥ���ҩ������Χ
function ycgyjlfw() {
    var id = $.trim($("#id").val());  //��ҩ��Ϣid
    if(id==null){
        id=0;
    }
    var hid = $.trim($("#hid").val());  //סԺ��Ϣid
    if(hid==null){
        hid=0;
    }

    var date = $.trim($("#date").val());  //��ҩ����
    var time = $.trim($("#time").val());  //��ҩʱ��
    var amt = $.trim($("#amt").val());  //��ҩ����
    var time2 = $.trim($("#time2").val());  //��ҩʱ��2
    var amt2 = $.trim($("#amt2").val());  //��ҩ����2
    var cmt = $.trim($("#cmt").val()); //��ҩ��ʽ
    var rate = $.trim($("#rate").val());   //��ҩƵ��
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��
    var hgb = $.trim($("#hgb").val());
    var inhi = $.trim($("#inhi").val());
    var pod = $.trim($("#pod").val());
    var rbc = $.trim($("#rbc").val());  //��ϸ������
    var htc = $.trim($("#htc").val()); //��ϸ���Ȼ�
    var tbil = $.trim($("#tbil").val());  //�ܵ����ػ�
    var alt = $.trim($("#alt").val());  //�ȱ�ת��ø
    var ast = $.trim($("#ast").val());  //�Ȳ�ת��ø

    var jg = $.trim($("#jg").val()); //�����������
    var xyxx = $.trim($("#xyxx").val());//����ѪҺŨ������
    var xysx = $.trim($("#xysx").val()); //����ѪҺŨ������
    var cxrq = $.trim($("#cxrq").val());//��Ѫ����
    var cxsj = $.trim($("#cxsj").val());//��Ѫʱ��
    var zxyl = $.trim($("#zxyl").val());//��С��ҩ��
    var zdyl = $.trim($("#zdyl").val());//�����ҩ��
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
                    $("#ycxy").val(str[0]);     //Ԥ��ֵ
                    $("#zdyl").val(str[2]);     // ����ҩ��
                    $("#zxyl").val(str[3]);     // ��С��ҩ��
                    alert("Ԥ��ɹ���");
                    return false;
                }
                if (json.isSuccess == 0) {
                    if(json.param=='error'){
                        alert("Ԥ��ʧ�ܣ�����д��ȷ�ĸ�ҩ�����ͼ����������(amt-jgС��0)");
                    }else{
                        alert("Ԥ���쳣��");
                    }
                }
            }
    )

}

//�����ҩ��ϸ
function SaveFkDetail() {

    var id = $.trim($("#id").val());  //��ҩ��Ϣid
    var hid = $.trim($("#hid").val());  //סԺ��Ϣid

    var date = $.trim($("#date").val());  //��ҩ����
    var time = $.trim($("#time").val());  //��ҩʱ��

//    $("#amt").val($("#jyyl").val());
    var amt = $.trim($("#amt").val());  //��ҩ����
    var time2 = $.trim($("#time2").val());  //��ҩʱ��2
    var amt2 = $.trim($("#amt2").val());  //��ҩ����2

    var cmt = $.trim($("#cmt").val()); //��ҩ��ʽ
    var rate = $.trim($("#rate").val());   //��ҩƵ��
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��
    var hgb = $.trim($("#hgb").val());
    var inhi = $.trim($("#inhi").val());
    var pod = $.trim($("#pod").val());
    var rbc = $.trim($("#rbc").val());  //��ϸ������
    var htc = $.trim($("#htc").val()); //��ϸ���Ȼ�
    var tbil = $.trim($("#tbil").val());  //�ܵ����ػ�
    var alt = $.trim($("#alt").val());  //�ȱ�ת��ø
    var ast = $.trim($("#ast").val());  //�Ȳ�ת��ø
    var jg = $.trim($("#jg").val()); //�����������
    var cxrq = $.trim($("#cxrq").val());//��Ѫ����
    var cxsj = $.trim($("#cxsj").val());//��Ѫʱ��


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
                    alert("�����ҩ��ϸ�ɹ���");
                    return false;
                }
                if (json.isSuccess == 0) {
                    alert("�����쳣��");
                }
                if (json.isSuccess == 3) {
                    alert("���ȱ����ҩ��Ϣ��");
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
        ��ǰλ�ã�fk��ҩ��Ϣ
    </div>
    <div class="maintr"></div>
</div>

<div class="mianm">
<div class="mainmt">
<table align="center" style="width: 90%; border-bottom:0; margin-top:12px;table-layout: auto">
    <tr>
        <td colspan="8" style="text-align: center;">
            ������Ϣ
        </td>
    </tr>
    <tr>
        <td>
            סԺ�ţ�
        </td>
        <td>
            <input type="hidden" id="hid" value="<s:property value="#request.hobi.id"/>"/>
            <s:textfield type="text" id="hospcode" style="width: 60px;" value="%{hobi.hospcode}" disabled="true"/>
        </td>
        <td>
            ������
        </td>
        <td>
            <s:textfield type="text" id="name" style="width: 60px;" value="%{hobi.name}" disabled="true"/>
        </td>
        <td>
            �Ա�
        </td>
        <td>
            <s:select id="sex" list="#{1:'��',2:'Ů'}" listKey="key" listValue="value"
                      value="%{hobi.sex}" disabled="true" cssStyle="width:60px;"/>
        </td>
        <td>
            ���䣺
        </td>
        <td>
            <s:textfield type="text" id="age" style="width: 60px;" value="%{hobi.age}"
                         disabled="true"/>
        </td>
    </tr>
    <tr>
        <td>
            ��ߣ�
        </td>
        <td>
            <s:textfield type="text" id="height" style="width: 60px;"
                         value="%{hobi.height}" disabled="true"/>
        </td>
        <td>
            ���أ�
        </td>
        <td>
            <s:textfield type="text" id="weight" style="width: 60px;"
                         value="%{hobi.weight}" disabled="true"/>
        </td>
        <td>
            ��������
        </td>
        <td>
            <s:textfield type="text" id="surface_area" style="width: 60px;"
                         value="%{hobi.surface_area}" disabled="true"/>
        </td>
        <td>
            ����ʱ�䣺
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
        ��ҩ��Ϣ
         <input type="hidden" id="id" value="<s:property value="#request.medicineFk.id"/>"/>
    </td>
</tr>
<tr>
    <td>
        ��ҩ��ʽ��
    </td>
    <td>
        <s:select id="cmt" list="#{1:'�ڷ�',2:'������ע'}" listKey="key" listValue="value" value="%{medicineFk.cmt}"/>
    </td>
    <td>
        ��ҩ����(mg)��
    </td>
    <td>
        <s:textfield type="text" id="amt" style="width: 100px;" value="%{medicineFk.amt}"/>
    </td>
    <td>
        ��ҩƵ�ʣ�
    </td>
    <td>
        <s:select id="rate" list="#{1:'QD',2:'Q12D',3:'24H��ע'}" listKey="key" listValue="value"
                  value="%{medicineFk.rate}"/>
    </td>

    <td>
        �������������
    </td>
    <td>
        <s:textfield type="text" id="jg" style="width: 100px;" value="%{medicineFk.jg}"/>
    </td>

</tr>
<tr>
    <td>
        ��ҩ���ڣ�
    </td>
    <td>
        <s:textfield type="text" id="date" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:CurentTime()})"
                     value="%{medicineFk.date}"/>
    </td>
    <td>
        ��ҩʱ�䣺
    </td>
    <td>
        <s:textfield type="text" id="time" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineFk.time}"/>
    </td>
    <td>
        ��ҩʱ��2��
    </td>
    <td>
        <s:textfield type="text" id="time2" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineFk.time2}"/>
    </td>
    <td>
        ��ҩ����2(mg)��
    </td>
    <td>
        <s:textfield type="text" id="amt2" style="width: 100px;" value="%{medicineFk.amt2}"/>
    </td>


</tr>
<tr>
    <td>
        Ѫ�쵰�ף�
    </td>
    <td>
        <s:textfield type="text" id="hgb" style="width: 100px;" value="%{medicineFk.hgb}"/>
    </td>

    <td>
        �����ҩ�
    </td>
    <td>
        <s:select id="inhi" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineFk.inhi}"/>
    </td>
    <td>
        ����������
    </td>
    <td>
        <s:textfield type="text" id="pod" style="width: 100px;" value="%{medicineFk.pod}"/>
    </td>
    <td>
        ��ϸ��������
    </td>
    <td>
        <s:textfield type="text" id="rbc" style="width: 100px;" value="%{medicineFk.rbc}"/>
    </td>

</tr>
<tr>
    <td>
        ��ϸ���Ȼ���
    </td>
    <td>
        <s:textfield type="text" id="htc" style="width: 100px;" value="%{medicineFk.htc}"/>
    </td>
    <td>
        �ܵ����ػ���
    </td>
    <td>
        <s:textfield type="text" id="tbil" style="width: 100px;" value="%{medicineFk.tbil}"/>
    </td>

    <td>
        �ȱ�ת��ø��
    </td>
    <td>
        <s:textfield type="text" id="alt" style="width: 100px;" value="%{medicineFk.alt}"/>
    </td>
    <td>
        �Ȳ�ת��ø��
    </td>
    <td>
        <s:textfield type="text" id="ast" style="width: 100px;" value="%{medicineFk.ast}"/>
    </td>
</tr>
<tr>
    <td>
        ��Ѫ���ڣ�
    </td>
    <td>
        <s:textfield type="text" id="cxrq" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:'3000-01-01'})"
                     value="%{medicineFk.cxrq}"/>
    </td>
    <td>
        ��Ѫʱ�䣺
    </td>
    <td>
        <s:textfield type="text" id="cxsj" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineFk.cxsj}"/>
    </td>
    <td>
        �ϴθ�ҩ��ѪŨ�ȣ�
    </td>
    <td>
        <s:textfield type="text" id="dv" style="width: 100px;" value="%{medicineFk.dv}"/>
    </td>
    <td>ҽ������������</td>
    <td><s:textfield type="text" id="jyyl" style="width: 100px;" value="%{medicineFk.jyyl}"/></td>
</tr>
<tr>
    <td>
        ����ѪҩŨ�����ޣ�
    </td>
    <td>
        <s:textfield type="text" id="xyxx" style="width: 100px;" value="%{medicineFk.xyxx}"/>
    </td>
    <td>
        ����ѪҩŨ�����ޣ�
    </td>
    <td>
        <s:textfield type="text" id="xysx" style="width: 100px;" value="%{medicineFk.xysx}"/>
    </td>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="SaveFkDetail()" value="�����ҩ��ϸ">
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
        <input type="button" onclick="ycxynd()" value="Ԥ��ѪҩŨ�� ">
    </td>
    <td>
        <s:textfield type="text" id="ycxy" style="width: 100px;" value="%{medicineFk.ycxy}" />
    </td>

    <td colspan="2" align="center" style="text-align: center;">
        <input type="button" onclick="ycgyjlfw()" value="Ԥ���ҩ������Χ">
    </td>
    <td>
        ��С��ҩ����
    </td>
    <td>
        <s:textfield type="text" id="zxyl" style="width: 100px;" value="%{medicineFk.zxyl}"/>
    </td>
    <td>
        ����ҩ����
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