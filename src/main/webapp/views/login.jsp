<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	table,th,td{
		border: 1px solid rgba(255, 255, 255, 0);
		border-collapse: collapse;
		padding : 5px 10px; ;
	
	}
    body{
        color: rgb(131, 129, 129);
        background-color: rgb(172, 172, 172);
    }		
    div{
        margin: 10px 0;
        text-align: center;
    }
    
	.container{
		background-color:white ;
		margin: 0 auto;
		max-width: 800px;
		padding: 20px;
		border-radius: 8px;
        height: 600px;

	}
    table{
		position: relative;
		left: 275px;
	}    	
    
    ul{
		list-style-type: none;
		display:inline-flex;    
	}
	.content{
		margin: 0 15px;
	}	
	.eg{
		background-color: aqua;
		width:700px ;
		height: 200px;
		margin: 0 auto;
		background: url(resources/img/eagle.jpg) -11px -220px;
		background-size: cover;

	}
	h1{
		position: relative;
		top: 150px;
		color: rgb(255, 254, 254);
	}	
</style>
</head>
<body>
	<div class="container">
		<header>
			<div class="eg">
				<h1>Welcome to eaglePage </h1>
			</div>
		</header>
		<div>
			<ul>
<!-- 				<li class="content"><a href="#">아이디 찾기</a></li>
				<li class="content"><a href="#">비밀번호 찾기</a></li>
				<li class="content"><a href="#">고객센터</a></li>
				<li class="content"><a href="#">ANYTHING</a></li> -->
			</ul>
		</div>		
		<form action="login.do" method="post">
			<h3>로그인</h3>
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" name="id"/></td>
				</tr>
				<tr>
					<th>PW</th>
					<td><input type="password" name="pw"/></td>
				</tr>
				<tr>
					<th colspan="2">
						<button>로그인</button>
						<input type="button" value="회원가입" onclick="location.href='membership.go'"/>
					</th>
				</tr>
			</table>
		</form>
	</div>	
</body>
<script>
	var msg = '${result}';
    var loginId = '${sessionScope.loginId}';
	if (msg !="") {
	}

</script>
</html>