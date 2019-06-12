<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的歌曲</title>
</head>
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<body>
	<script>
		$(function(){
			$("td button").addClass("btn btn-success btn-sm");
			$(".page span a").addClass("btn btn-info btn-lg");
			$("nav div button").addClass("btn btn-info btn-lg");
			
			$(".modal-body div").addClass("input-group");
			$(".modal-body div#submitButton").removeClass("input-group");
			$(".modal-body div span").addClass("input-group-addon");
			
			//解决form传非文件参数为空的问题
			$("#form1").submit(function(){
				var f = document.getElementById("uploadFile").files;
				var num = new Number(f[0].size/(1024 * 1024));
				var filesize = num.toFixed(1) + "M";
				$(this).attr("action", "UploadMusicServlet?singer=" + encodeURI($("#singer").val()) + "&filesize=" + filesize);
			});
			
			$("#audio")[0].onended = function(){               //自动播放下一首音乐
				palyForward();
			};
			
			$(document).ready(function(){                         //加载事件
				if(window.location.search.split("=")[2] == 1) {   //播放上一页最后一首歌时，再播放下一曲
					var button = $("table button:first");
					var tr = $("tr").eq(1);
					$("#audio").attr("src", button.attr("id"));
					tr.addClass("playNow");
				}		   
			});
		});
		
		function play(button){
			$("#audio").attr("src", $(button).attr("id"));
			var tr = $(button).parent().parent();
			$("tr").removeClass("playNow");
			tr.addClass("playNow");
		}
		
		function dblPlay(tr){                                           //双击歌曲所在列播放本歌曲
			var button = $(tr).find("button");
			$("#audio").attr("src", button.attr("id"));
			$("tr").removeClass("playNow");
			$(tr).addClass("playNow");
		}
		
		function palyBackward(){
			if($(".playNow")[0].previousSibling.previousSibling.previousSibling.previousSibling != null){
				var tr = $(".playNow")[0].previousSibling.previousSibling;
				
				var button = $(tr).find("button");
				$("#audio").attr("src", button.attr("id"));
				$("tr").removeClass("playNow");
				$(tr).addClass("playNow");
			}
		}
		
		function palyForward(){
			//判断是否为本页最后一首歌曲
			if($(".playNow")[0].nextSibling.nextSibling != null){
				var tr = $(".playNow")[0].nextSibling.nextSibling;
				
				var button = $(tr).find("button");
				$("#audio").attr("src", button.attr("id"));
				$("tr").removeClass("playNow");
				$(tr).addClass("playNow");
			}
			else{
				window.open("?start=${next}&palyForward=1", "_self");
			}
		}
	</script>
	
	<style>
		table{
			font-size:20px;
			font-family:仿宋;
			border-radius:15px;
			overflow:hidden;
		}
		
		table tr#head{
			font-size:25px;
			background-color:lightgray;
		}
		.page{
			position: absolute;
			left: 432px;
			top: 500px;
		}
		.page span{
			background-color:lightgray;
		}
		.page span a{
			margin:20px;
		}
		.page span span{
			font-size:18px;
			color:blue;
			background-color:white;
		}
		.playNow{
			border:2px solid #f47920;
		}
		.playPnael{
			background-color:#f2f2f2;
			border:1px solid gray;
		}
		div.modal-body div{
			margin:10px auto;
		}
	</style>
	
	<jsp:include page="header.jsp"></jsp:include>

	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">上传音乐<span class="glyphicon glyphicon-upload"></span></button>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">上传音乐</h4>
				</div>
				<div class="modal-body">
					<form id="form1" action="UploadMusicServlet" method="post" enctype="multipart/form-data">
						<div>
							<span>文件路径</span><input type="file" name="uploadFile" id="uploadFile" class="form-control">
						</div>
						<div>
							<span>歌&nbsp;&nbsp;手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="singer" id="singer" placeholder="请输入歌手名" class="form-control">
						</div>
						<div id="submitButton">
							<input type="submit" value="上传" class="btn btn-block btn-success">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<a href="modifyUserInfo.jsp">修改信息</a>
	
	<table style="width:800px; margin:10px auto" class="table table-striped table-hover table-condensed">
		<tr id="head">
			<td>歌曲</td>
			<td>歌手</td>
			<td>试听</td>
			<td>大小</td>
		</tr>
	
		<c:forEach items="${songs }" var="song">
			<tr ondblclick="dblPlay(this)">
				<td>${song.name }</td>
				<td>${song.singer }</td>
				<td><button id="${song.path }" onclick="play(this)"><span class="glyphicon glyphicon-play"></span></button></td>
				<td>${song.filesize }</td>
			</tr>
		</c:forEach>	
	</table>
	
	<div class="page">
		<span>
			<a href="?start=0">首 页</a>
			<a href="?start=${pre}">&#8678;上一页</a>
			<span>第${param.start / 8 + 1 }/${last / 8 + 1}页</span>     <!-- 获得当前页数 -->
			<a href="?start=${next}">下一页&#8680;</a>
			<a href="?start=${last}">末 页</a>
		</span>
	</div>
	
	<nav class="navbar navbar-default navbar-fixed-bottom">
		<div align="center" class="playPnael">
			<div class="pull-left">
				<button onclick="palyBackward()"><span class="glyphicon glyphicon-backward"></span>上一曲</button>
			</div>
			<div class="pull-right">
				<button onclick="palyForward()">下一曲<span class="glyphicon glyphicon-forward"></span></button>
			</div>
			<div>
				<audio controls="controls" autoplay="autoplay" id="audio"></audio>
			</div>
		</div>
	</nav>
</body>
</html>