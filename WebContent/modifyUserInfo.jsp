<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户-修改信息</title>
</head>
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<body>
	<script>
		$(function(){                                              
			$("#password2").change(function(){                       //验证两次密码是否相同
				var password = $("#password").val();
				var password2 = $(this).val();
				if(password != password2){
					$(this).val("");
					$("#message").html("请输入相同的密码");
				}
				else
					$("#message").html("&nbsp;");
			});
			
			/* $("input").addClass("form-control"); */
			$("select").addClass("form-control");
			
			$("#modify2 div").addClass("input-group");
			$("#modify2 div#submitButton,#message").removeClass("input-group");
			$("#modify2 div span").addClass("input-group-addon");
		});
		
		function check(){
			if($("#password").val().length == 0 || $("#password2").val().length == 0 || 
					$("#nickname").val().length == 0 || $("#birthday").val().length == 0){
				$("#message").html("请填写完整的信息");
				return false;
			}
		}
	</script>
		
	<style>
.modify {
	position: absolute;
	left: 470px;
	top: 170px;
	width: 500px;
	padding: 20px 50px;
	background-color: #f2f2f2;
	border-radius: 15px;
	box-shadow: 5px 5px 3px #888888;
}

div.modify div {
	margin: 10px auto;
}

.backgroung {
	background-image: url(images/background-modify.jpg);
	background-size: 100% 100%;
	width: 1364px;
	height: 768px;
	margin: 0px 1px;
	border-radius: 8px;
}
</style>


	<jsp:include page="header.jsp"></jsp:include>
	
	<div class="backgroung"></div>
	
	<form action="UpdateUserInfoServlet" method="post" onSubmit="return check()">
		<div class="modify" id="modify2">
				<div id="message" style="color:red">&nbsp;</div>
				<div style="font-weight:bold;font-size:18px">修改信息</div>
				<div>
					<span>用&nbsp;户&nbsp;名&nbsp;</span>
						<input type="text" id="account" name="account" class="form-control" readonly="readonly" value="${user.account }">
				</div>
				<div>
					<span>密&nbsp;&nbsp;码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<input type="password" id="password" name="password" class="form-control" value="${user.password }">
				</div>
				<div>
					<span>确认密码</span>
						<input type="password" name="password2" id="password2" class="form-control" value="${user.password }">
				</div>
				<div>
					<span>昵&nbsp;&nbsp;称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<input type="text" name="nickname" id="nickname" class="form-control" value="${user.nickname }">
				</div>
				<div>
					<span>性&nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<select name="gender">
							<option>男</option>
							<option>女</option>
						</select>
				</div>
				<div>
					<span>生&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<input type="text" name="birthday" class="form-control" value="${user.birthday }">
				</div>
				<div id="submitButton"><input type="submit" value="完成修改" class="btn btn-block btn-success"></div>
			</div>
	</form>
</body>
</html>