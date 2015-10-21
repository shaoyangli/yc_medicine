<%@ page language="java"  pageEncoding="gbk" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
    String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta http-equiv="Content-Type" content="text/html; gbk" />
    <title>基本信息修改</title>
    <link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript"
            src="<%=path%>/js/zdc.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
    <script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
    <script language="javascript" type="text/javascript"
            src="<%=path%>/js/My97DatePicker/WdatePicker.js">
    </script>
    <script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
    <style type="text/css">
        .search {
            font-family: "宋体";
            font-size: 12px;
            behavior BEHAVIOR: url('<%=path%>/css/selectBox.htc');
            cursor: hand;
        }
    </style>
    <script type="text/javascript">

        //重载页面
        function reset()
        {
            document.location.reload(true);
        }

        function updateHosp(){
            var hospcode = $.trim($("#hospcode").val());
            if (hospcode.length == 0) {
                alert("住院号不能为空！");
                $("#hospcode").focus();
                return false;
            }
            var name = $.trim($("#name").val());
            if (name.length == 0) {
                alert("姓名不能为空！");
                $("#name").focus();
                return false;
            }
            var sex = $.trim($("#sex").val());
            if (sex.length == 0) {
                alert("性别不能为空！");
                $("#sex").focus();
                return false;
            }
            var age = $.trim($("#age").val());
            if (age.length == 0) {
                alert("年龄不能为空！");
                $("#age").focus();
                return false;
            }
            var height = $.trim($("#height").val());
            if (height.length == 0) {
                alert("身高不能为空！");
                $("#height").focus();
                return false;
            }
            var weight = $.trim($("#weight").val());
            if (weight.length == 0) {
                alert("体重不能为空！");
                $("#weight").focus();
                return false;
            }

            var surface_area = $.trim($("#surface_area").val());
            if (surface_area.length == 0) {
                alert("体表面积不能为空！");
                $("#surface_area").focus();
                return false;
            }

            var operation_time = $.trim($("#operation_time").val());
            if (operation_time.length == 0) {
                alert("手术时间不能为空！");
                $("#operation_time").focus();
                return false;
            }

            var Id = $("#id").val();

            var data;
            data = {"hobi.hospcode": hospcode,
                "hobi.name": name,
                "hobi.sex": sex,
                "hobi.age": age,
                "hobi.height": height,
                "hobi.weight": weight,
                "hobi.surface_area": surface_area,
                "hobi.operation_time": operation_time,
                "hobi.id": Id};
            //帐号只能输入数字
            $.post("hosp!saveHosp.action", data,
                    function (json) {
                        if (json.isSuccess == 1) {
                            alert("操作成功！");
                            return false;
                        }
                        if (json.isSuccess == 0) {
                            alert("未知错误,保存失败！");
                        }
                    })
        }


    </script>
</head>
<body>
<!---main begin------------------------->
<div class="main">
    <div class="maint">
        <div class="maintl"></div>
        <div class="maintm">
            <img src="<%=path%>/images/tb1.jpg" />
            当前位置：基本信息修改
        </div>
        <div class="maintr"></div>
    </div>

    <div class="mianm">
        <div class="mainmt">
            <table align="center" style="width: 60%; border-bottom:0; margin-top:12px;table-layout: fixed">
                <tr>
                    <td colspan="4" class="tstd" style="text-align: center;">
                        基本信息修改
                    </td>
                </tr>
                <tr>
                    <td class="tstd" style="text-align: left;">
                        住院号：
                    </td>
                    <td>
                        <input type="hidden" id="id" value="<s:property value="#request.hobi.id"/>"/>
                        <input type="text" id="hospcode" value="<s:property value="#request.hobi.hospcode"/>"/>
                    </td>
                    <td class="tstd" style="text-align:left;">
                        姓名：
                    </td>
                    <td>
                        <input type="text" id="name" value="<s:property value="#request.hobi.name"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="tstd" style="text-align: left;">
                        性别：
                    </td>
                    <td>
                        <s:select id="sex" list="#{1:'男',2:'女'}" listKey="key" listValue="value"
                                  value="%{hobi.sex}" > </s:select>
                    </td>
                    <td class="tstd" style="text-align:left;">
                        年龄：
                    </td>
                    <td>
                        <input type="text" id="age" value="<s:property value="#request.hobi.age"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="tstd" style="text-align: left;">
                        身高(cm)：
                    </td>
                    <td>
                        <input type="text" id="height" value="<s:property value="#request.hobi.height"/>"/>
                    </td>
                    <td class="tstd" style="text-align:left;">
                        体重(kg)：
                    </td>
                    <td>
                        <input type="text" id="weight" value="<s:property value="#request.hobi.weight"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="tstd" style="text-align: left;">
                        体表面积(cm?)：
                    </td>
                    <td>
                        <input type="text" id="surface_area" value="<s:property value="#request.hobi.surface_area"/>"/>
                    </td>
                    <td class="tstd" style="text-align:left;">
                        手术时间：
                    </td>
                    <td>
                        <input type="text" id="operation_time"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1890-01-01 11:30:00',maxDate:CurentTime()})"
                               value="<s:property value="#request.hobi.operation_time"/>"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" style="text-align: center;">
                        <a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/axg.jpg'"
                           onmouseout="document.java.src='<%=path %>/images/xg.jpg'" onclick="updateHosp()"> <img
                                name="java" src="<%=path %>/images/xg.jpg" border="0"/>
                        </a>
                    </td>
                    <td colspan="2" align="center" style="text-align: center;">
                        <a href="<%=path%>/medicine/hosp/hospinfoList.jsp?currPage=<s:property value='currPage'/>&totalPages=<s:property value='totalPages'/>"  onmouseover="document.java12.src='<%=path%>/images/fh.jpg'"
                           onmouseout="document.java12.src='<%=path%>/images/afh.jpg'">
                            <img name="java12" src="<%=path%>/images/afh.jpg" border="0"/>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
        <!---nr end------------------------->
    </div>
    <div class="mainb">
        <div class="mainbl"></div>
        <div class="mainbm"></div>
        <div class="mainbr"></div>
    </div>
</div>
</body>
</html>