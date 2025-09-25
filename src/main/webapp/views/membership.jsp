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
		padding : 5px 10px;
		
        
        
	}
	table{
		position: relative;
		left: 250px;
	}
    body{
        color: rgb(131, 129, 129);
        background-color: rgb(172, 172, 172);
    }
    div{
        margin: 10px 0;
        text-align: center;
    }
	div.eg{
		background-color: aqua;
		width:700px ;
		height: 200px;
		margin: 0 auto;
		background: url(img/eagle.jpg) -11px -220px;
		background-size: cover;
	}
	input[type="text"]:hover{
		background-color: #d5e2d5d0
	}
	h1{
		position: relative;
		top: 150px;
		color: rgb(255, 254, 254);
	}
	ul{
		list-style-type: none;
		display:inline-flex;

	}
	.content{
		margin: 0 15px;
	}
	.container{
		background-color:white ;
		margin: 0 auto;
		max-width: 800px;
		padding: 20px;
		border-radius: 8px;

	}

	
</style>
</head>
<body>
	<div class="container">
		<header>
			<div class="eg"><h1>Welcome to eaglePage </h1></div>
		</header>
		<div>
<!-- 			<ul>
				<li class="content"><a href="#">아이디 찾기</a></li>
				<li class="content"><a href="#">비밀번호 찾기</a></li>
				<li class="content"><a href="#">고객센터</a></li>
				<li class="content"><a href="#">ANYTHING</a></li>
			</ul> -->
		</div>
		
		<form action="membership.do" method="post">

			<table>
				<tr>
					<div><h3>회원가입</h3></div>
					<th>ID</th>
					<td>
						<input type="text" name="id" required placeholder="아이디를 입력하세요"/>
						<!-- <button type="button" id="idCheck">중복체크</button>
						<p id ="responseText"></p> -->
					</td>
				</tr>
				<tr>
					<th>PW</th>
					<td>
						<input type="text" name="pw" placeholder="비밀번호를 입력하세요"/>
					</td>
				</tr>
				<tr>
					<th>NAME</th>
					<td>
						<input type="text" name="name" placeholder="이름을 입력하세요"/>
					</td>
				</tr>
				<tr>
					<th>AGE</th>
					<td>
						<input type="text" name="age" placeholder="나이를 입력하세요"/>
					</td>
				</tr>
				<tr>
					<th>GENDER</th>
					<td>
						<input type="radio" name="gender" value = "남"/>남
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="gender" value = "여"/>여
					</td>
				</tr>
				<tr>
					<th>EMAIL</th>
					<td>
						<input type="text" name="email" placeholder="이메일 입력하세요"/>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="회원가입"/>
					</th>
				</tr>
			</table>
			
		</form>
	</div>
</body>
<script>
	var msg = '${result}';
	if (msg !="") {
		alert(msg);
	}
	$('#idCheck').click(function(){
		var id = $('input[name="id"]').val();
		console.log(id);
		$.ajax({
			type:'post',
			url:'idCheck.ajax',
			data:{'id':id},
			dataType:'JSON',
			success:function(data){
				console.log(data);
				if (data.idCheck > 0) {
					$('#responseText').html(id+"는 이미 사용중 입니다.");
					$('#responseText').css({'color':'red'});
				}else {
					$('#responseText').html(id+"는 사용 가능합니다.");
					$('#responseText').css({'color':'green'});
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	});

	
</script>
</html>






























