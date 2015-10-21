<%@ page language="java" pageEncoding="gbk" %>
<%
    String path = request.getContextPath();

    String currPage = request.getParameter("currPage");
    String totalPagesq = request.getParameter("totalPages");
    String name = request.getParameter("name");
    if (name != null) {
        name = new String(name.getBytes("ISO-8859-1"), "gbk");
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
    <title>基本信息管理</title>
    <link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/superTables_compressed.css" rel="stylesheet" type="text/css"/>
    <script src="<%=path%>/js/superTables_compressed.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="<%=path%>/js/zdc.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js"></script>
    <script type="text/javascript" src="<%=path%>/artDialog4.1.6/artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="<%=path%>/js/doUtil.js"></script>
    <script type="text/javascript">
        var currPage = "<%=currPage%>";
        var totalPagesq = "<%=totalPagesq%>";
        var names = "<%=name%>"
        plan.hidebreak();

        function deleteHosp(id)//处理记录的删除
        {
            var currPage = $("#currPage1").val();
            var totalPages = $("#totalPages1").val();
            confirm('你确定要删除吗？',
                    function () {
                        $.post("<%=path%>/medicine/hosp/hosp!removeHosp.action?id=" + id,
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
        function updateHosp(id) {
            var url = 'hosp!findHosp.action?id=' + id;
            var currPage = $("#currPage1").val();
            var totalPages = $("#totalPages1").val();

            var name = $("#u").val();
            url += "&currPage=" + currPage + "&totalPages=" + totalPages;

            if (name.length > 0) {
                url += "&name=" + name;
            }
            location.href = url;
        }
        function init() {
            findList(currPage, totalPagesq);
        }

        //根据条件 查询 机构
        function findList(currPage, totalPages) {
            var param = "";
            var name = $.trim($("#name").val());//判断模糊查询条件

            if (names != "null") {
                name = names;
            }
            var data =
            {
                "param": param,
                "currPage": currPage,
                "totalPages": totalPages,
                "name": name
            };

            $("#u").val(name);
            plan.show();
            $.post("<%=path%>/medicine/hosp/hosp!findHospList.action", data,
                    function (json) {
                        var page = json.findOrgResult;
                        var list = page.list;
                        //var forms  ="";//翻页表单
                        //定义一个table 放入数据内容的
                        var tables = "<table id='demoTable' style=' border-top: none; min-width: 100%; _width: 100%;' class=' sDefault sDefault-Main'> <tr style='background:url(<%=path%>/images/thbg.jpg) left top repeat-x; height:25px;'>";
                        //此处tables拼上两个hidden  保存当前也和总页码 为了删除的时候获得
                        tables += "<th>id</th><th>住院号</th><th>姓名</th><th>性别</th><th>年龄</th><th>身高(cm)</th>" +
                                "<th>体重(kg)<input type='hidden' id='currPage1' value='" + page.currPage + "'/>" +
                                "<input type='hidden' id='totalPages1' value='" + page.totalPages + "'/></th>" +
                                "<th>体表面积(cm?)</th><th>手术时间</th><th>修改</th><th>删除</th><th>csa</th>" +
                                "<th>fk</th><th>vpa</th><th>warfarin</th>";
                        var trs = "";
                        $.each(list, function (i, obj) //对从action获取一个json进行遍历操作
                        {
                            var c = "";
                            if (i % 2 == 0) {
                                trs += "<tr class='tstr'>";
                            } else {
                                trs += "<tr >";
                            }
                            var sex ;
                            if(obj[3]=="1"){
                                sex="男";
                            }else{
                                sex="女";
                            }
                            trs += "<td>" + obj[0] + "</td><td>" + obj[1] + "</td><td>" + obj[2] + "</td><td>" + sex + "</td><td>" + obj[4]
                                    + "<td>" + obj[5] + "</td><td>" + obj[6] + "</td><td>" + obj[7] + "</td><td> " + obj[8] +
                                    "</td><td><a href='javascript:void(0)' onclick='updateHosp(" + obj[0] + ")' >修改<a></td>" +
                                    "<td><a href='javascript:void(0)' onclick='return deleteHosp(" + obj[0] + ")'>删除</a></td>" +
                                    "<td><a href='javascript:void(0)' onclick='return handlerCsa(" + obj[0] + ")'>管理</a></td>" +
                                    "<td><a href='javascript:void(0)' onclick='return handlerFk(" + obj[0] + ")'>管理</a></td>" +
                                    "<td><a href='javascript:void(0)' onclick='return handlerVpa(" + obj[0] + ")'>管理</a></td>" +
                                    "<td><a href='javascript:void(0)' onclick='return handlerWf(" + obj[0] + ")'>管理</a></td>" + "</tr>";

                        });
                        if (trs == "") {
                            trs += "<tr ><td colspan='10' align='center'>暂无数据</td></tr>";
                        }
                        tables += trs + "</table>";
                        plan.hidden2(page, tables);
                    }

            )
        }

        function handlerCsa(id)
        {
            var url = 'csa!toMedicineCsaList.action?hid=' + id;
            location.href = url;
        }

        function handlerFk(id)
        {
            var url = 'fk!toMedicineFkList.action?hid=' + id;
            location.href = url;
        }

        function handlerVpa(id)
        {
            var url = 'vpa!toMedicineVpaList.action?hid=' + id;
            location.href = url;
        }

        function handlerWf(id)
        {
            var url = 'wf!toMedicineWfList.action?hid=' + id;
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
                    loct = new String(loct.getBytes("ISO-8859-1"), "gbk");
                else
                    loct = "基本信息管理";
            %><%=loct %>
        </div>
        <div class="maintr"></div>
    </div>
    <div class="mianm">
        <div class="mainmt" style="height:35px;">
            <p>
                姓名：
                <input name="name" id="name" style="width: 100px;"/>
                <a href="javascript:void(0)" onclick="findList(1,0)"> <img
                        style="vertical-align: middle;" src="<%=path%>/images/cx2.gif"
                        border="0"/> </a>
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

            <input id="u" type="hidden"/>
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
