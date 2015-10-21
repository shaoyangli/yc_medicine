<%@ page language="java" import="java.util.*,com.kh.hsfs.model.*" pageEncoding="utf-8" %>
<%@page import="java.text.SimpleDateFormat" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>添加基本信息</title>
    <link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/grxx.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" type="text/javascript"
            src="<%=path%>/js/zdc.js">
    </script>
    <script language="javascript" type="text/javascript"
            src="<%=path%>/js/My97DatePicker/WdatePicker.js">
    </script>
    <script language="javascript" type="text/javascript"
            src="<%=path%>/js/jquery-1.4.4.js">
    </script>
    <style type="text/css">
        a {
            color: #5d7bc7;
            text-decoration: none;
        }
    </style>
    <script type="text/javascript">
        //        function init() {
        //            findHospitalInfo();
        //        }
        //        function findHospitalInfo() {
        //
        //            $.post("hosp!findAllHosp.action",
        //                    function (json) {
        //                        var result = json.list;
        //                        var tables = "<table align='center' style='width: 60%; margin-top:0; table-layout:fixed; border-top:0;'>";
        //                        tables += "<tr><th>id</th><th>住院号</th><th>姓名</th><th>性别</th><th>年龄</th><th>身高</th><th>体重</th><th>修改</th><th>删除</th></tr>";
        //                        $.each(result, function (i, obj) {
        //                            if (i % 2 == 0) {
        //                                tables += "<tr class='tstr'>";
        //                            } else {
        //                                tables += "<tr >";
        //                            }
        //                            tables += "<td>" + obj[0] + "</td><input type='hidden' id='" + obj[0] + "0' value='" + obj[0] + "'>" +
        //                                    "<input type='hidden' id='" + obj[0] + "1' value='" + obj[1] + "'><input type='hidden' id='" + obj[0] + "2' value='" + obj[2] + "'>" +
        //                                    "<input type='hidden' id='" + obj[0] + "3' value='" + obj[3] + "'><input type='hidden' id='" + obj[0] + "4' value='" + obj[4] + "'>" +
        //                                    "<input type='hidden' id='" + obj[0] + "5' value='" + obj[5] + "'><input type='hidden' id='" + obj[0] + "6' value='" + obj[6] + "'>" +
        //                                    "<input type='hidden' id='" + obj[0] + "7' value='" + obj[7] + "'><input type='hidden' id='" + obj[0] + "8' value='" + obj[8] + "'><td>" +
        //                                    obj[1] + "</td><td>" + obj[2] + "</td><td>" + obj[3] + "</td><td>" + obj[4] + "</td><td>" + obj[5] +
        //                                    "</td><td>" + obj[6] + "</td><td><a href='javascript:void(0)' onclick='updateHosp(\"" + obj[0] + "\")'>修改</a>" +
        //                                    "</td><td><a href='javascript:void(0)' onclick='removeHosp(" + obj[0] + ")'>删除</a></td>";
        //                        });
        //                        tables += "</table>";
        ////                        alert(tables);
        //                        $("#hosps").empty();
        //                        $("#hosps").append(tables);
        //
        //                    })
        //
        //        }

        //验证表单中的数据
        function saveHosp() {
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
//                            $("#hospcode").val('');
//                            $("#id").val(0);
//                            findHospitalInfo();
                            return false;
                        }
                        if (json.isSuccess == 0) {
                            alert("未知错误,保存失败！");
//                            $("#id").val(0);
                        }
                    })
        }
        //    function updateHosp(id) {
        //        var hospcode = $("#" + id + "1").val();
        //        var name = $("#" + id + "2").val();
        //        var sex = $("#" + id + "3").val();
        //        var age = $("#" + id + "4").val();
        //        var height = $("#" + id + "5").val();
        //        var weight = $("#" + id + "6").val();
        //        var surface_area = $("#" + id + "7").val();
        //        var operation_time = $("#" + id + "8").val();
        //
        //        $("#id").val(id);
        //        $("#hospcode").val(hospcode);
        //        $("#name").val(name);
        //        $("#sex").val(sex);
        //        $("#age").val(age);
        //        $("#height").val(height);
        //        $("#weight").val(weight);
        //        $("#surface_area").val(surface_area);
        //        $("#operation_time").val(operation_time);
        //    }
            function removeHosp(id) {
                var data = {"id": id};
                if (confirm("确定删除该基本信息么？")) {
                    $.post("hosp!removeHosp.action", data,
                            function (json) {
                                var result = json.isSuccess;
                                if (result == 1) {
                                    alert("该记录成功删除！");
                                    findHospitalInfo();
                                    return false;
                                }
                                if (result == 0) {
                                    alert("未知错误,请联系管理员！");
                                }
                            })
                }

            }

        //重载页面
        function resets() {
            $("#id").val('');
            $("#hospcode").val('');
            $("#name").val('');
            $("#sex").val('');
            $("#age").val('');
            $("#height").val('');
            $("#weight").val('');
            $("#surface_area").val('');
            $("#operation_time").val('');
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
            当前位置：
            <% String loct = request.getParameter("loct");
                if (loct != null)
                    loct = new String(loct.getBytes("ISO-8859-1"), "utf-8");
                else
                    loct = "添加基本信息";
            %><%=loct %>
        </div>
        <div class="maintr"></div>
    </div>
    <div class="mianm">
        <div class="mainmt">
            <div class="mianmm">

                <table align="center" style="width: 60%; border-bottom:0; margin-top:12px;table-layout: fixed">
                    <tr>
                        <td colspan="4" class="tstd" style="text-align: center;">
                            添加基本信息
                        </td>
                    </tr>
                    <tr>
                        <td class="tstd" style="text-align: left;">
                            住院号：
                        </td>
                        <td>
                            <input type="text" id="hospcode"/>
                        </td>
                        <td class="tstd" style="text-align:left;">
                            姓名：
                        </td>
                        <td>
                            <input type="text" id="name"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tstd" style="text-align: left;">
                            性别：
                        </td>
                        <td>
                            <select  id="sex" style="width: 100px;">
                                <option value="1">男</option>
                                <option value="2">女</option>
                            </select>
                        </td>
                        <td class="tstd" style="text-align:left;">
                            年龄：
                        </td>
                        <td>
                            <input type="text" id="age"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tstd" style="text-align: left;">
                            身高(cm)：
                        </td>
                        <td>
                            <input type="text" id="height"/>
                        </td>
                        <td class="tstd" style="text-align:left;">
                            体重(kg)：
                        </td>
                        <td>
                            <input type="text" id="weight"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tstd" style="text-align: left;">
                            体表面积(cm?)：
                        </td>
                        <td>
                            <input type="text" id="surface_area"/>
                        </td>
                        <td class="tstd" style="text-align:left;">
                            手术时间：
                        </td>
                        <td>
                            <input type="text" id="operation_time"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1890-01-01 11:30:00',maxDate:CurentTime()})"/>
                        </td>

                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="text-align: center;">
                            <a href="javascript:void(0)" onmouseover="document.jav.src='<%=path%>/images/qk.jpg'"
                               onmouseout="document.jav.src='<%=path%>/images/aqk.jpg'" onclick="return resets();"
                               style="text-align:center;"> <img
                                    name="jav" src="<%=path%>/images/aqk.jpg" border="0"/>
                            </a>
                        </td>
                        <td colspan="2" align="center" style="text-align: center;">
                            <a href="javascript:void(0)" onmouseover="document.java.src='<%=path%>/images/bc.jpg'"
                               onmouseout="document.java.src='<%=path %>/images/abc.jpg'" onclick="saveHosp()"
                               style="text-align:center;">
                                <img name="java" src="<%=path %>/images/abc.jpg" border="0"/>
                            </a>
                        </td>
                    </tr>
                    <%--<tr>--%>
                    <%--<td colspan="4"--%>
                    <%--style="border: none; text-align: left; color: #324269;">--%>
                    <%--<img src="<%=path%>/images/lbt.gif"/>--%>
                    <%--基本信息列表--%>
                    <input type="hidden" id="id" value="0"/>
                    <%--</td>--%>

                    <%--</tr>--%>
                </table>

                <%--<div id="hosps">--%>

                <%--</div>--%>
            </div>

        </div>
    </div>
    <div class="mainb">
        <div class="mainbl">
        </div>
        <div class="mainbm"></div>
        <div class="mainbr"></div>
    </div>

</div>

</body>
</html>
