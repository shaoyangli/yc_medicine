<%@ page language="java" pageEncoding="gbk" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; gbk"/>
<title>vpa��ҩ��Ϣ</title>
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

//����vpa��ҩ��Ϣ����
function saveMedVpa() {
    var hid = $.trim($("#hid").val());
    if (hid.length == 0) {
        alert("������Ϣid����Ϊ�գ�");
        return false;
    }

    var id = $.trim($("#id").val());
    var date = $.trim($("#date").val());  //��ҩ����
    var time = $.trim($("#time").val());  //��ҩʱ��
    var time2 = $.trim($("#time2").val());  //��ҩʱ��
    var time3 = $.trim($("#time3").val());  //��ҩʱ��
    var amt = $.trim($("#amt").val());  //��ҩ����
    var amt2 = $.trim($("#amt2").val());  //��ҩ����
    var amt3 = $.trim($("#amt3").val());  //��ҩ����
    var rate = $.trim($("#rate").val());   //��ҩƵ��QD(һ��һ��)��BIDһ������ TIDһ������
    var form = $.trim($("#form").val());
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��

    var lmsq = $.trim($("#lmsq").val()); //�Ƿ������Ī��ຣ��������롱1����δ�������롰0��
    var lxxp = $.trim($("#lxxp").val()); //�Ƿ���������������������롱1����δ�������롰0����
    var kmxp = $.trim($("#kmxp").val()); //�Ƿ���ÿ�����ƽ���������롱1����δ�������롰0����
    var tt = $.trim($("#tt").val()); //�Ƿ������̩�������������������롱1����δ�������롰0����
    var bbbt = $.trim($("#bbbt").val());  //�Ƿ��úϱ��ͱ��ף��������롱1����δ�������롰0����
    var kpl = $.trim($("#kpl").val());  //�Ƿ���ÿ���������������̹�����������롱1����δ�������롰0��
    var okxp = $.trim($("#okxp").val());  //�Ƿ���ð¿���ƽ���������롱1����δ�������롰0����
    var pht = $.trim($("#pht").val());  //�Ƿ���ñ���Ӣ���������롱1����δ�������롰0����

    var xyxx = $.trim($("#xyxx").val());//����ѪҺŨ������
    var xysx = $.trim($("#xysx").val()); //����ѪҺŨ������
    var cxrq = $.trim($("#cxrq").val());//��Ѫ����
    var cxsj = $.trim($("#cxsj").val());//��Ѫʱ��
    var zxyl = $.trim($("#zxyl").val());//��С��ҩ��
    var zdyl = $.trim($("#zdyl").val());//�����ҩ��
    var jg = $.trim($("#jg").val()); //�����������
    var jyyl = $.trim($("#jyyl").val());//ҽ������ҩ��
    var ycxy = $.trim($("#ycxy").val());//Ԥ��ѪҩŨ��
    var data;
    if (id == null) {    //����
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
    } else {  //�޸�
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

    //�ʺ�ֻ����������
    $.post("vpa!saveMedVpa.action", data,
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
    var time2 = $.trim($("#time2").val());  //��ҩʱ��2
    var time3 = $.trim($("#time3").val());  //��ҩʱ��3
    var amt = $.trim($("#amt").val());  //��ҩ����
    var amt2 = $.trim($("#amt2").val());  //��ҩ����2
    var amt3 = $.trim($("#amt3").val());  //��ҩ����3

    var rate = $.trim($("#rate").val());   //��ҩƵ��QD(һ��һ��)��BIDһ������ TIDһ������
    var form = $.trim($("#form").val());
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��

    var lmsq = $.trim($("#lmsq").val()); //�Ƿ������Ī��ຣ��������롱1����δ�������롰0��
    var lxxp = $.trim($("#lxxp").val()); //�Ƿ���������������������롱1����δ�������롰0����
    var kmxp = $.trim($("#kmxp").val()); //�Ƿ���ÿ�����ƽ���������롱1����δ�������롰0����
    var tt = $.trim($("#tt").val()); //�Ƿ������̩�������������������롱1����δ�������롰0����
    var bbbt = $.trim($("#bbbt").val());  //�Ƿ��úϱ��ͱ��ף��������롱1����δ�������롰0����
    var kpl = $.trim($("#kpl").val());  //�Ƿ���ÿ���������������̹�����������롱1����δ�������롰0��
    var okxp = $.trim($("#okxp").val());  //�Ƿ���ð¿���ƽ���������롱1����δ�������롰0����
    var pht = $.trim($("#pht").val());  //�Ƿ���ñ���Ӣ���������롱1����δ�������롰0����

    var jg = $.trim($("#jg").val()); //�����������
    var cxrq = $.trim($("#cxrq").val());//��Ѫ����
    var cxsj = $.trim($("#cxsj").val());//��Ѫʱ��

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
    var time2 = $.trim($("#time2").val());  //��ҩʱ��2
    var time3 = $.trim($("#time3").val());  //��ҩʱ��3
    var amt = $.trim($("#amt").val());  //��ҩ����
    var amt2 = $.trim($("#amt2").val());  //��ҩ����2
    var amt3 = $.trim($("#amt3").val());  //��ҩ����3

    var rate = $.trim($("#rate").val());   //��ҩƵ��QD(һ��һ��)��BIDһ������ TIDһ������
    var form = $.trim($("#form").val());
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��

    var lmsq = $.trim($("#lmsq").val()); //�Ƿ������Ī��ຣ��������롱1����δ�������롰0��
    var lxxp = $.trim($("#lxxp").val()); //�Ƿ���������������������롱1����δ�������롰0����
    var kmxp = $.trim($("#kmxp").val()); //�Ƿ���ÿ�����ƽ���������롱1����δ�������롰0����
    var tt = $.trim($("#tt").val()); //�Ƿ������̩�������������������롱1����δ�������롰0����
    var bbbt = $.trim($("#bbbt").val());  //�Ƿ��úϱ��ͱ��ף��������롱1����δ�������롰0����
    var kpl = $.trim($("#kpl").val());  //�Ƿ���ÿ���������������̹�����������롱1����δ�������롰0��
    var okxp = $.trim($("#okxp").val());  //�Ƿ���ð¿���ƽ���������롱1����δ�������롰0����
    var pht = $.trim($("#pht").val());  //�Ƿ���ñ���Ӣ���������롱1����δ�������롰0����

    var xyxx = $.trim($("#xyxx").val());//����ѪҺŨ������
    var xysx = $.trim($("#xysx").val()); //����ѪҺŨ������
    var jg = $.trim($("#jg").val()); //�����������
    var cxrq = $.trim($("#cxrq").val());//��Ѫ����
    var cxsj = $.trim($("#cxsj").val());//��Ѫʱ��
    var zxyl = $.trim($("#zxyl").val());//��С��ҩ��
    var zdyl = $.trim($("#zdyl").val());//�����ҩ��
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
function SaveVpaDetail() {

    var id = $.trim($("#id").val());  //��ҩ��Ϣid
    var hid = $.trim($("#hid").val());  //סԺ��Ϣid

    var date = $.trim($("#date").val());  //��ҩ����
    var time = $.trim($("#time").val());  //��ҩʱ��
    var time2 = $.trim($("#time2").val());  //��ҩʱ��2
    var time3 = $.trim($("#time3").val());  //��ҩʱ��3
    var amt = $.trim($("#amt").val());  //��ҩ����
    var amt2 = $.trim($("#amt2").val());  //��ҩ����2
    var amt3 = $.trim($("#amt3").val());  //��ҩ����3

    var rate = $.trim($("#rate").val());   //��ҩƵ��QD(һ��һ��)��BIDһ������ TIDһ������
    var form = $.trim($("#form").val());
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��

    var lmsq = $.trim($("#lmsq").val()); //�Ƿ������Ī��ຣ��������롱1����δ�������롰0��
    var lxxp = $.trim($("#lxxp").val()); //�Ƿ���������������������롱1����δ�������롰0����
    var kmxp = $.trim($("#kmxp").val()); //�Ƿ���ÿ�����ƽ���������롱1����δ�������롰0����
    var tt = $.trim($("#tt").val()); //�Ƿ������̩�������������������롱1����δ�������롰0����
    var bbbt = $.trim($("#bbbt").val());  //�Ƿ��úϱ��ͱ��ף��������롱1����δ�������롰0����
    var kpl = $.trim($("#kpl").val());  //�Ƿ���ÿ���������������̹�����������롱1����δ�������롰0��
    var okxp = $.trim($("#okxp").val());  //�Ƿ���ð¿���ƽ���������롱1����δ�������롰0����
    var pht = $.trim($("#pht").val());  //�Ƿ���ñ���Ӣ���������롱1����δ�������롰0����

    var jg = $.trim($("#jg").val()); //�����������
    var cxrq = $.trim($("#cxrq").val());//��Ѫ����
    var cxsj = $.trim($("#cxsj").val());//��Ѫʱ��


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
        ��ǰλ�ã�vpa��ҩ��Ϣ
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
         <input type="hidden" id="id" value="<s:property value="#request.medicineVpa.id"/>"/>
    </td>
</tr>
<tr>
    <td>
        ҩ����ͣ�
    </td>
    <td>
        <s:select id="form" list="#{1:'��Һ��',2:'Ƭ��',2:'���ͼ�'}" listKey="key" listValue="value" value="%{medicineVpa.form}"/>
    </td>
    <td>
        ��ҩ����(mg)��
    </td>
    <td>
        <s:textfield type="text" id="amt" style="width: 100px;" value="%{medicineVpa.amt}"/>
    </td>
    <td>
        ��ҩ����2(mg)��
    </td>
    <td>
        <s:textfield type="text" id="amt2" style="width: 100px;" value="%{medicineVpa.amt2}"/>
    </td>
    <td>
        ��ҩ����3(mg)��
    </td>
    <td>
        <s:textfield type="text" id="amt3" style="width: 100px;" value="%{medicineVpa.amt3}"/>
    </td>
</tr>
<tr>
    <td>
        ��ҩ���ڣ�
    </td>
    <td>
        <s:textfield type="text" id="date" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:CurentTime()})"
                     value="%{medicineVpa.date}"/>
    </td>
    <td>
        ��ҩʱ�䣺
    </td>
    <td>
        <s:textfield type="text" id="time" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineVpa.time}"/>
    </td>
    <td>
        ��ҩʱ��2��
    </td>
    <td>
        <s:textfield type="text" id="time2" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineVpa.time2}"/>
    </td>
    <td>
        ��ҩʱ��3��
    </td>
    <td>
        <s:textfield type="text" id="time3" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineVpa.time3}"/>
    </td>
</tr>
<tr>
    <td>
        ��Ѫ���ڣ�
    </td>
    <td>
        <s:textfield type="text" id="cxrq" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:'3000-01-01'})"
                     value="%{medicineVpa.cxrq}"/>
    </td>
    <td>
        ��Ѫʱ�䣺
    </td>
    <td>
        <s:textfield type="text" id="cxsj" style="width: 100px;"
                     onclick="WdatePicker({dateFmt:'HH:mm',maxDate:CurentTime()})" value="%{medicineVpa.cxsj}"/>
    </td>
    <td>
        ��ҩƵ�ʣ�
    </td>
    <td>
        <s:select id="rate" list="#{1:'QD(һ��һ��)',2:'BID(һ������)',3:'TID(һ������)'}" listKey="key" listValue="value"
                  value="%{medicineVpa.rate}"/>
    </td>

    <td>
        �������������
    </td>
    <td>
        <s:textfield type="text" id="jg" style="width: 100px;" value="%{medicineVpa.jg}"/>
    </td>
</tr>
<tr>
    <td>
        ���ñ���Ӣ��
    </td>
    <td>
        <s:select id="pht" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineVpa.pht}"/>
    </td>
    <td>
        ������Ī��ຣ�
    </td>
    <td>
        <s:select id="lmsq" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineVpa.lmsq}"/>
    </td>
    <td>
        ��������������
    </td>
    <td>
        <s:select id="lxxp" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineVpa.lxxp}"/>
    </td>
    <td>
        ���ÿ�����ƽ��
    </td>
    <td>
        <s:select id="kmxp" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineVpa.kmxp}"/>
    </td>
</tr>
<tr>

    <td>
        ������̩������������
    </td>
    <td>
        <s:select id="tt" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineVpa.tt}"/>
    </td>
    <td>
        ���ñ��ͱ��ף�
    </td>
    <td>
        <s:select id="bbbt" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineVpa.bbbt}"/>
    </td>
    <td>
        ���ÿ�������
    </td>
    <td>
        <s:select id="kpl" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineVpa.kpl}"/>
    </td>
    <td>
        ���ð¿���ƽ��
    </td>
    <td>
        <s:select id="okxp" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineVpa.okxp}"/>
    </td>
</tr>
<tr>
    <td>
        ����ѪҩŨ�����ޣ�
    </td>
    <td>
        <s:textfield type="text" id="xyxx" style="width: 100px;" value="%{medicineVpa.xyxx}"/>
    </td>
    <td>
        ����ѪҩŨ�����ޣ�
    </td>
    <td>
        <s:textfield type="text" id="xysx" style="width: 100px;" value="%{medicineVpa.xysx}"/>
    </td>
    <td>
        �ϴθ�ҩ��ѪŨ�ȣ�
    </td>
    <td>
        <s:textfield type="text" id="dv" style="width: 100px;" value="%{medicineVpa.dv}"/>
    </td>
    <td>ҽ������������</td>
    <td><s:textfield type="text" id="jyyl" style="width: 100px;" value="%{medicineVpa.jyyl}"/></td>
</tr>
<tr>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="ycxynd()" value="Ԥ��ѪҩŨ�� ">
    </td>
    <td>
        <s:textfield type="text" id="ycxy" style="width: 100px;" value="%{medicineVpa.ycxy}" />
    </td>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="ycgyjlfw()" value="Ԥ�������Χ">
    </td>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="SaveVpaDetail()" value="�����ҩ��ϸ">
    </td>
    <td>
        ��С��ҩ����
    </td>
    <td>
        <s:textfield type="text" id="zxyl" style="width: 100px;" value="%{medicineVpa.zxyl}"/>
    </td>
    <td>
        ����ҩ����
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