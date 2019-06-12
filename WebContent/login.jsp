<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录界面</title>
</head>
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<body>
	<style>
.login {
	position: absolute;
	left: 810px;
	top: 200px;
	background-color: #f2f2f2;
	width: 350px;
	height: 420px;
	padding: 25px;
	border-radius: 15px;
	box-shadow: 5px 5px 3px #888888;
}

div.login div {
	margin: 15px auto;
}

.backgroung {
	background-image: url(images/background-login.jpg);
	background-size: 100% 100%;
	width: 1364px;
	height: 768px;
	margin: 0px 1px;
	border-radius: 8px;
}
</style>

	<script>
		function check() {
			if ($("#account").val().length == 0
					|| $("#password").val().length == 0) {
				$("#message").html("账号或密码不能为空！");
				return false;
			}
		}
	</script>

	<jsp:include page="header.jsp"></jsp:include>

	<div class="backgroung"></div>

	<form action="LoginServlet" method="post" onSubmit="return check()">
		<div class="login">
			<div id="message" style="color: red">&nbsp;${error }</div>
			<div style="font-weight: bold; font-size: 18px; text-align: center">账户登录</div>
			<div class="input-group">
				<span class="input-group-addon"> <span class="glyphicon glyphicon-user"></span> 用户名</span> <input type="text"
					id="account" name="account" placeholder="手机/会员名/邮箱"
					class="form-control" value="${account }">
			</div>
			<div class="input-group">
				<span class="input-group-addon"> <span class="glyphicon glyphicon-lock"></span> 密&nbsp;&nbsp;码&nbsp;&nbsp;</span><input
					type="password" id="password" name="password" placeholder="密码"
					class="form-control" value="${password }">
			</div>
			<div class="pull-left">
				<input type="checkbox" name="isUseCookie" checked="checked"/>记住登录密码
			</div>
			<div class="pull-right">
				<a href="register.jsp">注册</a>
			</div>
			<div>
				<input type="submit" value="登录" class="btn btn-block btn-success">
			</div>
		</div>
	</form>
</body>
</html>