<%@ page language="java" pageEncoding="gbk" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; gbk"/>
<title>wf��ҩ��Ϣ</title>
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

//����wf��ҩ��Ϣ����
function saveMedWf() {
    var hid = $.trim($("#hid").val());
    if (hid.length == 0) {
        alert("������Ϣid����Ϊ�գ�");
        return false;
    }

    var id = $.trim($("#id").val());
    var dose = $.trim($("#dose").val());  //��ҩ����
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��
    var adm = $.trim($("#adm").val()); //�Ƿ���ð���ͪ
    var cyp = $.trim($("#cyp").val());   //CYP2C9�����ͣ���Ϊ*1/*1��,���롰0������Ϊ*1/*3��,���롰1��
    var vkorc = $.trim($("#vkorc").val()); //VKORC1�����ͣ���ΪAA��,���롰0������ΪAG��GG��,���롰1����

    var xyxx = $.trim($("#xyxx").val());//����ѪҺŨ������
    var xysx = $.trim($("#xysx").val()); //����ѪҺŨ������
    var zxyl = $.trim($("#zxyl").val());//��С��ҩ��
    var zdyl = $.trim($("#zdyl").val());//�����ҩ��
    var jg = $.trim($("#jg").val()); //�����������
    var jyyl = $.trim($("#jyyl").val());//ҽ������ҩ��
    var ycxy = $.trim($("#ycxy").val());//Ԥ��ѪҩŨ��

    var data;
    if (id == null) {    //����
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
    } else {  //�޸�
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

    //�ʺ�ֻ����������
    $.post("wf!saveMedWf.action", data,
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

    var dose = $.trim($("#dose").val());  //��ҩ����
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��
    var adm = $.trim($("#adm").val()); //�Ƿ���ð���ͪ
    var cyp = $.trim($("#cyp").val());   //CYP2C9�����ͣ���Ϊ*1/*1��,���롰0������Ϊ*1/*3��,���롰1��
    var vkorc = $.trim($("#vkorc").val()); //VKORC1�����ͣ���ΪAA��,���롰0������ΪAG��GG��,���롰1����
    var jg = $.trim($("#jg").val()); //�����������
    var jyyl = $.trim($("#jyyl").val());//ҽ������ҩ��
    var ycxy = $.trim($("#ycxy").val());//Ԥ��ѪҩŨ��

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

    var dose = $.trim($("#dose").val());  //��ҩ����
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��
    var adm = $.trim($("#adm").val()); //�Ƿ���ð���ͪ
    var cyp = $.trim($("#cyp").val());   //CYP2C9�����ͣ���Ϊ*1/*1��,���롰0������Ϊ*1/*3��,���롰1��
    var vkorc = $.trim($("#vkorc").val()); //VKORC1�����ͣ���ΪAA��,���롰0������ΪAG��GG��,���롰1����

    var xyxx = $.trim($("#xyxx").val());//����ѪҺŨ������
    var xysx = $.trim($("#xysx").val()); //����ѪҺŨ������
    var jg = $.trim($("#jg").val()); //�����������
    var jyyl = $.trim($("#jyyl").val());//ҽ������ҩ��
    var ycxy = $.trim($("#ycxy").val());//Ԥ��ѪҩŨ��
    var zxyl = $.trim($("#zxyl").val());//��С��ҩ��
    var zdyl = $.trim($("#zdyl").val());//�����ҩ��
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
function SaveWfDetail() {

    var id = $.trim($("#id").val());  //��ҩ��Ϣid
    var hid = $.trim($("#hid").val());  //סԺ��Ϣid

    var dose = $.trim($("#dose").val());  //��ҩ����
    var dv = $.trim($("#dv").val());   //�ϴθ�ҩ����ѪҩŨ��
    var adm = $.trim($("#adm").val()); //�Ƿ���ð���ͪ
    var cyp = $.trim($("#cyp").val());   //CYP2C9�����ͣ���Ϊ*1/*1��,���롰0������Ϊ*1/*3��,���롰1��
    var vkorc = $.trim($("#vkorc").val()); //VKORC1�����ͣ���ΪAA��,���롰0������ΪAG��GG��,���롰1����

    var jg = $.trim($("#jg").val()); //�����������



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
        ��ǰλ�ã�wf��ҩ��Ϣ
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
         <input type="hidden" id="id" value="<s:property value="#request.medicineWf.id"/>"/>
    </td>
</tr>
<tr>
    <td>
        ��ҩ����(mg)��
    </td>
    <td>
        <s:textfield type="text" id="dose" style="width: 100px;" value="%{medicineWf.dose}"/>
    </td>
    <td>
        �������������
    </td>
    <td>
        <s:textfield type="text" id="jg" style="width: 100px;" value="%{medicineWf.jg}"/>
    </td>
    <td>
        ���ð���ͪ��
    </td>
    <td>
        <s:select id="adm" list="#{0:'δ����',1:'����'}" listKey="key" listValue="value"
                  value="%{medicineWf.adm}"/>
    </td>

    <td>
        CYP2C9�����ͣ�
    </td>
    <td>
        <s:select id="cyp" list="#{0:'*1/*1��',1:'*1/*3��'}" listKey="key" listValue="value"
                  value="%{medicineWf.cyp}"/>
    </td>
</tr>
<tr>
    <td>
        VKORC1�����ͣ�
    </td>
    <td>
        <s:select id="vkorc" list="#{0:'AA��',1:'AG��GG��'}" listKey="key" listValue="value"
                  value="%{medicineWf.vkorc}"/>
    </td>
    <td>
        �ϴθ�ҩ��ѪŨ�ȣ�
    </td>
    <td>
        <s:textfield type="text" id="dv" style="width: 100px;" value="%{medicineWf.dv}"/>
    </td>
    <td>ҽ������������</td>
    <td><s:textfield type="text" id="jyyl" style="width: 100px;" value="%{medicineWf.jyyl}"/></td>
    <td></td><td></td>
</tr>
<tr>
    <td>
        ����ѪҩŨ�����ޣ�
    </td>
    <td>
        <s:textfield type="text" id="xyxx" style="width: 100px;" value="%{medicineWf.xyxx}"/>
    </td>
    <td>
        ����ѪҩŨ�����ޣ�
    </td>
    <td>
        <s:textfield type="text" id="xysx" style="width: 100px;" value="%{medicineWf.xysx}"/>
    </td>
    <td>
    <td align="center" style="text-align: center;">
        <input type="button" onclick="SaveWfDetail()" value="�����ҩ��ϸ">
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
        <input type="button" onclick="ycxynd()" value="Ԥ��ѪҩŨ�� ">
    </td>
    <td>
        <s:textfield type="text" id="ycxy" style="width: 100px;" value="%{medicineWf.ycxy}" />
    </td>
    <td colspan="2" align="center" style="text-align: center;">
        <input type="button" onclick="ycgyjlfw()" value="Ԥ���ҩ������Χ">
    </td>
    <td>
        ��С��ҩ����
    </td>
    <td>
        <s:textfield type="text" id="zxyl" style="width: 100px;" value="%{medicineWf.zxyl}"/>
    </td>
    <td>
        ����ҩ����
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