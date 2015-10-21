<%@ page language="java" pageEncoding="gbk" import="com.kh.hsfs.model.*,com.kh.util.*" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
    String path = request.getContextPath();

    String currPage = request.getParameter("currPage");
    String totalPagesq = request.getParameter("totalPages");
    String date1 = request.getParameter("date11");

    String date2 = request.getParameter("date12");

    String hid = request.getParameter("hid");


    if (date1 != null) {
        date1 = new String(date1.getBytes("ISO-8859-1"), "gbk");
    }
    if (date2 != null) {
        date2 = new String(date2.getBytes("ISO-8859-1"), "gbk");
    }
    if (currPage == null || currPage.equals("null")) {
        currPage = "1";
    }
    if (totalPagesq == null || totalPagesq.equals("null")) {
        totalPagesq = "1";
    }


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk"/>
    <title>Fk给药信息管理</title>
    <link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet" type="text/css"/>
    <script src="<%=path%>/js/superTables_compressed.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
    <script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
    <script type="text/javascript"  src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
        var currPage = "<%=currPage%>";
        var totalPagesq = "<%=totalPagesq%>";
        var hid = "<%=hid%>"; //基础信息id
        plan.hidebreak();

        function deleteFk(id)//处理记录的删除
        {
            var currPage = $("#currPage1").val();
            var totalPages = $("#totalPages1").val();
            confirm('你确定要删除吗？',
                    function () {
                        $.post("<%=path%>/medicine/hosp/fk!removeFk.action?id=" + id,
                                function (json) {
                                    if (json.isSuccess == 1) {
                                        alertFind("删除成功！", currPage, totalPages)
                                    }
                                    else {
                                        alert("删除失败！");
                                    }
                                })
                    })
        }
        function toUpdateFk(id, hid) {
            var url = 'fk!toUpdateFk.action?id=' + id + "&hid=" + hid;
            var currPage = $("#currPage1").val();
            var totalPages = $("#totalPages1").val();
            url += "&currPage=" + currPage + "&totalPages=" + totalPages;

            location.href = url;
        }
        function init() {
            findList(currPage, totalPagesq);
        }

        //根据条件 查询 机构
        function findList(currPage, totalPages ) {
            var date1 = $.trim($("#date1").val());
            var date2 = $.trim($("#date2").val());

            var data =
            {
                "currPage": currPage,
                "totalPages": totalPages,
                "date1": date1,
                "date2": date2,
                "hid":hid
            };

            $("#dat1").val(date1);
            $("#dat2").val(date2);
            plan.show();
            $.post("<%=path%>/medicine/hosp/fk!findFkList.action", data,
                    function (json) {
                        var page = json.findOrgResult;
                        var list = page.list;
                        //定义一个table 放入数据内容的
                        var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>";
                        //此处tables拼上两个hidden  保存当前也和总页码 为了删除的时候获得
                        tables += "<th>id</th><th>给药方式</th><th>给药日期</th><th>给药时间</th><th>抽血日期</th>" +
                                "<th>抽血时间</th><th>给药剂量</th><th>上次给药后血液浓度</th><th>预测血液浓度</th>" +
                                "<th>修改</th><th>删除<input type='hidden' id='currPage1' value='" + page.currPage + "'/>" +
                                "<input type='hidden' id='totalPages1' value='" + page.totalPages + "'/></th>";
                        var trs = "";
                        $.each(list, function (i, obj) //对从action获取一个json进行遍历操作
                        {
                            var c = "";
                            if (i % 2 == 0) {
                                trs += "<tr class='tstr'>";
                            } else {
                                trs += "<tr >";
                            }
                            var cmtVal;
                            if (obj[9] == "1") {
                                cmtVal = "口服给药";
                            } else {
                                cmtVal = "静脉给药";
                            }
                            trs += "<td>" + obj[0] + "</td><td>" + cmtVal + "</td><td>" + obj[2] + "</td><td>" + obj[3]
                                    + "</td><td>" + obj[6] + "</td><td>" + obj[7] + "</td><td>" + obj[8] + "</td><td> " + obj[12] + "</td><td>" + obj[26]
                                    +"</td><td><a href='javascript:void(0)' onclick='toUpdateFk(" + obj[0] + "," + obj[1] + ")' >修改<a></td>" +
                                    "<td><a href='javascript:void(0)' onclick='return deleteFk(" + obj[0] + ")'>删除</a></td>";
                        });
                        if (trs == "") {
                            trs += "<tr ><td colspan='10' align='center'>暂无数据</td></tr>";
                        }
                        tables += trs + "</table>";
                        plan.hidden2(page, tables);
                    }

            )
        }

        //新增
        function addFkRecord() {
            var url = 'fk!toUpdateFk.action?hid=' + hid;
            var currPage = $("#currPage1").val();
            var totalPages = $("#totalPages1").val();
            url += "&currPage=" + currPage + "&totalPages=" + totalPages;
            location.href = url;
        }
    </script>

</head>
<body onload="init();">
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
                    loct = "fk给药信息管理";
            %><%=loct %>
        </div>
        <div class="maintr"></div>
    </div>
    <div class="mianm" style="height:100px;min-height:10%">
        <div class="mainmt">
            <table align="center" style="width: 90%; border-bottom:0; margin-top:12px;table-layout: auto;">
                <tr>
                    <td colspan="8" style="text-align: left;">
                        基本信息
                    </td>
                </tr>
                <tr>
                    <td>
                        住院号：
                    </td>
                    <td>
                        <input type="hidden" id="id" value="<s:property value="#request.hobi.id"/>" />
                        <s:textfield type="text" id="hospcode" style="width: 60px;" value="%{hobi.hospcode}"
                                     disabled="true"/>
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
                                  value="%{hobi.sex}" disabled="true" cssStyle="width:60px;"> </s:select>
                    </td>
                    <td>
                        年龄：
                    </td>
                    <td>
                        <s:textfield type="text" id="age" style="width: 60px;" value="%{hobi.age}" disabled="true"/>
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
        </div>
    </div>
    <div class="mianm">
        <div class="mainmt" style="height:35px;">
            <p>
                给药日期：
                <input type="text" id="date1" style="width: 100px;"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:CurentTime()})"/>
                ~<input type="text" id="date2" style="width: 100px;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'1890-01-01',maxDate:CurentTime()})"/>
                <a href="javascript:void(0)" onclick="findList(1,0)">
                    <img style="vertical-align: middle;" src="<%=path%>/images/cx2.gif" border="0"/>
                </a>
                <input type="button" onclick="addFkRecord()" value="  新 增  ">
            </p>
        </div>
        <div class="mianmm">
            <table id="mytable">
                <tr>
                    <td
                            style="border: none; text-align: left; color: #324269;">
                        <img src="<%=path%>/images/lbt.gif"/>
                        查询列表
                    </td>
                </tr>
            </table>

            <input id="dat1" type="hidden"/>
            <input id="dat2" type="hidden"/>
            <!-- 隐藏部分 开始 -->
            <div id="pagelist" style="margin:0 auto;" class="fakeContainer">
            </div>
            <div id="pagelist1">
            </div>
            <!-- 隐藏部分结束 -->
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