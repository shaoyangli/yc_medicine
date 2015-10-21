<%@ page language="java" import="java.util.*" pageEncoding="gbk" %>
<%
    String path = request.getContextPath();
    String year = Calendar.getInstance().get(Calendar.YEAR) + "";
    Date date = new Date();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>�й���������廯ҩ������������ƽ̨</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <style type="text/css">
        . {
            margin: 0px;
            padding: 0px;
        }

        body {
            background-color: #4D67A4;
            background-image: url(<%=path%>/images/bg.jpg);
        }

        .container {
            margin: 0px auto;
            width: 960px;
            text-align: center;
            width: 100%;
            text-align: center;
        }

        .login-top {
            background-image: url(<%=path%>/images/top_logo.jpg);
            background-repeat: no-repeat;
            background-position: center;
            height: 300px;
        }

        .login-center {
            background-image: url(<%=path%>/images/form-bg.jpg);
            background-repeat: no-repeat;
            background-position: center;
            height: 200px;
        }

        .login-form {
            position: relative;
            left: -20px;
            top: 38px;
        }

        .login-form input {
            text-align: left;
            height: 40px;
            line-height: 40px;
            width: 240px;
            margin-right: 20px;
            background-color: #E7E7E7;
            border: 1px solid #ccc;
            padding: 0px 10px
        }

        .button {
            background: url(<%=path%>/images/submit.png) no-repeat;
            border: 0px;
            cursor: pointer;
            width: 124px;
            height: 46px;
            margin-top: -3px;
            position: absolute;
        }

        .login-bottom {
            color: #7F91BE;
            height: 100px;
            font-size: 12px;
            text-align: center;
        }

    </style>
    <script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.js">

    </script>
    <script type="text/javascript">

        //���»س�����ѯ
        document.onkeydown = function (e) {
            var key;
            if (navigator.appName == "Microsoft Internet Explorer") {
                key = event.keyCode;
            }
            else {
                key = e.which;
            }
            if (key == 13) {
                var name = document.activeElement.name
                //alert(name);
                var loginpass = $.trim($("#loginpass").val());
                var loginname = $.trim($("#loginname").val());
                if (loginname.length == 0 || loginname == '�û���') {
                    $("#loginname").focus();
                    return false;
                }
                else if (loginpass.length == 0 || loginpass == '�û���¼����') {
                    $("#loginpass").focus();
                    return false;
                }
                else if (loginname.length > 0 && name != 'loginPass') {
                    $("#loginpass").focus();
                    return false;
                }

                else {
                    userLogin();
                }

            }
        }
        function show(msg) {
            if (msg != "")
                alert(msg);
        }
        function checkObj(obj) {
            if (!/^[0-9a-z]*$/i.test(obj.value)) {
                alert("ֻ��������ĸ,������ϣ�");
                obj.value = '';
                obj.focus();
                return false;
            }
        }
        function userLogin() {

            var loginpass = $.trim($("#loginpass").val());
            var loginname = $.trim($("#loginname").val());
            //var year = $("#buryear").val();
            var year = "<%=year%>";

            //var checkData = /<|>|'|;|&|#|"|%/;
            if (loginname.length == 0 || loginname == '�û���') {
                alert("�û�������Ϊ�գ�");
                //$("#loginname").value = "";
                $("#loginname").focus();
                return false;
            }
            if (loginpass.length == 0 || loginpass == '�û���¼����') {
                alert("���벻��Ϊ�գ�");
                //$("#loginpass").value = "";
                $("#loginpass").focus();
                return false;
            }

            if (year.length == 0) {
                alert("��ѡ����ȣ�");
                return false;
            }
            data = {"loginName": loginname, "loginPass": loginpass, "year": year};
            $.post("user!userLogin.action", data,
                    function (json) {
                        var result = json.isSuccess;
                        if (result == 0) {
                            location.href = "<%=path%>/hsfs/manage.jsp";
                        }
                        else if (result == 1) {
                            alert("�û������������,���飡");
                        }

                    })
        }
    </script>
</head>
<body>
<div class="container">
    <div class="login-top"></div>
    <div class="login-center">
        <p class="login-form">
            <input type="text" name="loginName" id="loginname" value="�û���" style="color: gray;"
                   onfocus="javascript:if(this.value == '�û���')
					this.value = ''; this.style.color='black';"
                   onblur="if(this.value == '') {this.value = '�û���';
					this.style.color = 'gray';}"/>
            <input type="password" name="loginPass" id="loginpass" value="�û���¼����" style="color: gray;"
                   onfocus="javascript:if(this.value == '�û���¼����')
					this.value = ''; this.style.color='black';"
                   onblur="if(this.value == '') {this.value = '�û���¼����';
					this.style.color = 'gray';}"/>
            <button class="button" type="button" onclick="userLogin()"></button>
        </p>
    </div>
    <div class="login-bottom">
    </div>
</div>
</body>
</html>
