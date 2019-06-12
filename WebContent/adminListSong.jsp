<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员-歌曲管理</title>
</head>
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<body>
	<script>
		$(function(){
			$("a").addClass("btn btn-default btn-sm");
		});
	</script>

	<style>
table {
	font-size: 20px;
	font-family: 仿宋;
	border-radius: 15px;
	overflow: hidden;
}

table tr#head {
	font-size: 25px;
	background-color: lightgray;
}

.page {
	position: absolute;
	left: 425px;
	top: 560px;
}

.page span {
	background-color: lightgray;
}

.page span a {
	margin: 20px;
}

.page span span {
	font-size: 18px;
	color: blue;
	background-color: white;
}
</style>

	<jsp:include page="header.jsp"></jsp:include>
	
	<a href="UserListServlet">用户管理</a>
	<a href="AdminSongListServlet" class="btn disabled">歌曲管理</a>

	<table style="width:800px; margin:20px auto" class="table table-striped table-hover table-condensed">
		<tr id="head">
			<td>歌曲</td>
			<td>歌手</td>
			<td>大小</td>
			<td>删除</td>
		</tr>
	
		<c:forEach items="${songs }" var="song">
			<tr>
				<td>${song.name }</td>
				<td>${song.singer }</td>
				<td>${song.filesize }</td>
				<td><a href="javascript:if(confirm('确认删除歌曲   ${song.name } ？')){location='DeleteSongServlet?id=${song.id }'}">删除</a></td>
			</tr>
		</c:forEach>	
	</table>

	<div class="page">
		<span>
			<a href="?start=0">首 页</a>
			<a href="?start=${pre}">&#8678;上一页</a>
			<span>第${param.start / 10 + 1 }/${last / 10 + 1}页</span>     <!-- 获得当前页数 -->
			<a href="?start=${next}">下一页&#8680;</a>
			<a href="?start=${last}">末 页</a>
		</span>
	</div>
</body>
</html>