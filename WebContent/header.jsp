<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导航栏</title>
</head>
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<body>
	<style>
div.parent {
	background-color: #f2f2f2;
	width: 1366px;
	border-radius: 8px;
}

.title {
	padding: 0 10px;
	color: blue;
	font-size: 40px;
	font-family: 楷体;
	text-shadow: 5px 5px 5px #888888;
}

.title a:hover{
	text-decoration: none;
	color: blue;
}

.right {
	float: right;
	color: red;
	margin: 10px 10px;
}

.searchDiv {
	position: absolute;
	left: 760px;
	top: 10px;
	width: 310px;
}

.searchButton {
	background-color: #337ab7;
}

li {
	background-color: white;
	list-style: none;
}

.onmouse {
	background-color: #d9d6c3;
}

.outmouse {
	background-color: white;
}

#popDiv{
	position: absolute;
	left: 720px;
	top: 45px;
	width: 275px;
	overflow-y:auto;
	max-height:120px;
}
</style>

	<script>
		$(function(){
			$("a").addClass("btn btn-primary btn-sm");
			$("a").eq(2).removeClass("btn btn-primary btn-sm");
			$("a").eq(2).addClass("btn btn-default btn-sm");
			$("a").eq(3).removeClass("btn btn-primary btn-sm");
		});
		
		var xmlHttp;
		function getMoreContents() {
			var content = document.getElementById("keyword");
			if (content.value == "") {
				ClearContent();
				return;//如果不设置，传到后台的是空值，所有的值都会被输出 
			}
			xmlHttp = creatXMLHttp();
			//alert(xmlHttp); 
			//要给服务器发送数据 
			var url = "SearchServlet?keyword=" + encodeURI(content.value);
			xmlHttp.open("GET", url, true);
			xmlHttp.onreadystatechange = callback;
			xmlHttp.send(null);
		}
		//获取XMLHttp对象 
		function creatXMLHttp() {
			var xmlHttp;
			if (window.XMLHttpRequest) {
				xmlHttp = new XMLHttpRequest();
			}
			if (window.ActiveXObject) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				if (!xmlHttp) {
					xmlHttp = new ActiveXOject("Msxml2.XMLHTTP");
				}
			}
			return xmlHttp;
		} //获取XMLHttp对象 
		function callback() {
			if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
				var result = xmlHttp.responseText;
				//解析数据 
				var json = eval("(" + result + ")");
				//动态显示数据，线束数据在输入框对的下面 
				setContent(json);
			}
		}
		//设置关联数据的展示 
		function setContent(contents) {
			ClearContent();
			var size = contents.length;
			for (var i = 0; i < size; i++) {
				var nextNode = contents[i];//json格式的第i个数据 
				var li = document.createElement("li");
				li.onmouseover = function() {
					this.className = "onmouse";
					document.getElementById("keyword").value = this.innerHTML;
				}
				li.onmouseout = function() {
					this.className = "outmouse";
				}
				var text = document.createTextNode(nextNode);
				li.appendChild(text);
				document.getElementById("c").appendChild(li);
			}
		}
		//清空数据 
		function ClearContent() {
			document.getElementById("c").innerHTML = "";
		}
		//当控件失去焦点时，清空数据 
		function outFouce() {
			ClearContent();
		}
		//获得焦点时，
	</script>

	<div class="parent">
		<div class="right">
			欢迎您 ${user.nickname }&nbsp; <a href="AllSongListServlet"><span
				class="glyphicon glyphicon-home"></span>首页</a> <a href="SelectShowPageServlet"><span
				class="glyphicon glyphicon-user"></span>我的</a> <a
				href="ExitSystemServlet">退出</a>
		</div>

		<form action="FindSongServlet" method="post">
			<div class="input-group searchDiv">
				<span class="input-group-addon"><span class="glyphicon glyphicon-search"></span></span>
				<input type="text" id="keyword" name="keyword" onkeyup="getMoreContents()"
					onblur="outFouce()" onfocus="getMoreContents()"
					class="form-control" placeholder="Search for..." /> <span
					class="input-group-addon searchButton"><input type="submit"
					value="搜索">
				</span>
			</div>
			<div id="popDiv">
				<ul id="c">
					<li></li>
				</ul>
			</div>
		</form>

		<div class="title">
			<span class="glyphicon glyphicon-music" style="font-size: 30px;"></span><a href="AllSongListServlet">天堂音乐网</a>
		</div>
	</div>

</body>
</html>