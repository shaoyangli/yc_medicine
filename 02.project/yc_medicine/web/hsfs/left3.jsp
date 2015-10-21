<%@ page language="java" pageEncoding="gbk" %>
<%@page import="java.util.Calendar" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
    String year = (String) session.getAttribute("year");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk"/>
    <meta name="keywords" content="菜单"/>
    <meta name="description" content="折叠菜单"/>

    <title>折叠菜单</title>
    <link href="<%=path %>/css/menu.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path %>/css/left.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=path %>/js/menu.js"></script>

    <script>
        function syssrc(str, str1) {
            var url = "", str1 = encodeURIComponent(str1);
            url = str + "?loct=" + str1;
            if (str.indexOf("?") > 0)
                url = str + "&loct=" + str1;
            url = "<%=path%>/hsfs/" + url;
            window.parent.frames["listFrame"].location.href = url;
        }
    </script>
    <style type="text/css">
        a {
            blr: expression_r(this.onFocus=this.close());
        }

        a {
            blr: expression_r(this.onFocus=this.blur());
        }

        a:focus {
            -moz-outline-style: none;
            outline: none;
        }

        .menu li ul.level2 li a:link {
            border: 0;
            color: #666;
            text-decoration: none;
        }

        .menu li ul.level2 li a:visited {
            font-size: 12px;
            color: #324269;
            text-decoration: none;
        }

        .menu li ul.level2 li a:hover {
            font-size: 12px;
            color: #324269;
        }

        .menu li ul.level2 li a:active {
            font-size: 12px;
            color: #666;
        }

    </style>
</head>
<body>
<div class="leftt">
    <img src="<%=path %>/images/gl.gif"/>
    管理菜单
</div>

<div class="leftm">
    <div class="box">
        <ul class="menu">
            <s:iterator value="#session.userPowers" var="power" status="st">
                <s:if test="#power.fatherId == 0">
                    <li class="level1">

                        <a href="javascript:void(0)"><img src="<%=path %>/images/zlimg.gif"/> <s:property
                                value="#power.powerName"/></a>
                        <s:if test="#st.count == 1">
                            <ul style="display: block" class="level2">
                                <s:iterator value="#session.userPowers" var="p">
                                    <s:if test="#p.fatherId == #power.powerId">
                                        <li>
                                            <a href="javascript:syssrc('<s:property value="#p.powerUrl"/>','<s:property value="#p.powerName"/>')">
                                                <img src="<%=path %>/images/xsj.gif"/>
                                                <s:property value="#p.powerName"/>
                                            </a>
                                        </li>
                                    </s:if>
                                </s:iterator>
                            </ul>
                        </s:if>
                        <s:elseif test="#st.count > 1">
                            <ul style="display: none" class="level2">
                                <s:iterator value="#session.userPowers" var="p">
                                    <s:if test="#p.fatherId == #power.powerId">
                                        <li>
                                            <a href="javascript:syssrc('<s:property value="#p.powerUrl"/>','<s:property value="#p.powerName"/>')">
                                                <img src="<%=path %>/images/xsj.gif"/>
                                                <s:property value="#p.powerName"/>
                                            </a>
                                        </li>
                                    </s:if>
                                </s:iterator>
                            </ul>
                        </s:elseif>
                    </li>
                </s:if>
            </s:iterator>
            <%--<li class="level1">--%>
                <%--<a href="javascript:void(0)" id="imgmenu111"><img--%>
                        <%--src="<%=path %>/images/zlimg.gif"/> 实用工具</a>--%>
                <%--<ul style="display: none" class="level2" id="submenu111">--%>
                    <%--<li>--%>
                        <%--<a href="http://www.12306.cn/mormhweb/kyfw/ypcx/" target="_blank"><img--%>
                                <%--src="<%=path %>/images/xsj.gif"/>--%>
                            <%--火车时刻--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="http://www.17u.cn/THFlight.aspx?TCAllianceID=11103084&RefId=11103084&tckeywordid=15904505&"--%>
                           <%--target="_blank"><img src="<%=path %>/images/xsj.gif"/>--%>
                            <%--飞机航班--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="http://www.ip138.com/post/" target="_blank"><img src="<%=path %>/images/xsj.gif"/>--%>
                            <%--邮编/区号--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="http://time.123cha.com/" target="_blank"><img src="<%=path %>/images/xsj.gif"/>--%>
                            <%--国际时间--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--&lt;%&ndash;<li>--%>
                        <%--<a href="javascript:syssrc('word/wordlist.jsp')"><img--%>
                                <%--src="<%=path %>/images/xsj.gif" />操作说明文档</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="<%=path %>/hsfs/word/hsfs 2.html" target="_blank"><img--%>
                                <%--src="<%=path %>/images/xsj.gif" />   操作说明文档下载</a>--%>
                    <%--</li>&ndash;%&gt;--%>
                <%--</ul>--%>
            <%--</li>--%>
        </ul>
    </div>
</div>
<div class="leftb"></div>

</body>
</html>
