<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    h1 {
        margin-bottom: 20px;
        color: #333;
    }
    button {
        padding: 10px 20px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 1rem;
        margin-bottom: 20px;
        transition: background-color 0.3s ease;
    }
    button:hover {
        background-color: #0056b3;
    }
    table {
        width: 90%;
        max-width: 800px;
        border-collapse: collapse;
        margin-bottom: 20px;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        overflow: hidden;
    }
    thead {
        background-color: #007BFF;
        color: white;
    }
    thead th {
        padding: 15px;
        text-align: left;
    }
    tbody td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    tbody tr:last-child td {
        border-bottom: none;
    }
    tbody tr:hover {
        background-color: #f1f1f1;
    }
    #no-data {
        color: #555;
        margin: 20px 0;
        font-size: 1.2rem;
    }
    #selId ,#selId2{
    	width: 100px;
    }
    #act{ 
    	display: inline-block;
    }
    
</style>
</head>
<body>
    <jsp:include page="loginBox.jsp" />
    <h1>게시판</h1>
    <button onclick="location.href='write.go'">글쓰기</button>
    <select class="form-control" id="selId" onchange="selEvent()">
    	<option value="01">전체</option>
    	<option value="02">타입</option>
    	<option value="03">제목</option>
    	<option value="04">작성자</option>
    	<option value="05">번호</option>
    	<option value="06">작성일</option>
    </select>
    <div id="act"></div>
    <button onclick="searchClick()">검색</button>
    <table>
        <thead>
            <tr>
                <th>타입</th>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody id="list">
            <!-- 데이터가 없을 경우 아래 메시지 표시 -->
        </tbody>
    </table>
    <div id="pages">
    	
    </div>
    <div id="no-data" style="display: none;">작성된 데이터가 없습니다.</div>
</body>
<script type="text/javascript">
function selEvent(){
let selId= document.getElementById("selId").value;
let act = document.getElementById("act");
	switch (selId) {
		case '01':
			act.innerHTML=
				'';
			break;		
		case '02': 
			act.innerHTML=
			'<select id="selId2" class="form-control">'+
		    	'<option value="01">자유</option>'+
		    	'<option value="02">익명</option>'+
		    	'<option value="03">QnA</option>'+
		    '</select>';
			break;
		case '03': 
			act.innerHTML=
   	 			'<input type="text">';
		    
			break;
		case '04': 
			act.innerHTML=
   	 			'<input type="text">';
		    break;
		case '05': 
			act.innerHTML=
   	 			'<input type="text">';
		    break;
		case '06': 
			act.innerHTML=
   	 			'<input type="text" id="startDate"><input type="text" id="endDate">';
		    break;
	}
}
let pagingInited = false; //추가
let cntPage = 0; //추가
function searchClick( show = 1 ){
let selId2 = document.getElementById("selId2");
let selId= document.getElementById("selId").value;
let context = document.getElementById("act").firstChild
let startDate = document.getElementById("startDate");
let endDate = document.getElementById("endDate");
let data = {};

	if (selId2) {
		selId2= selId2.value;	
	}
	if (context) {
		context= context.value;	
	}
	if (startDate && endDate){
		startDate = startDate.value;
		endDate = endDate.value;
	}
	
	//추가
	if (show === 1) {
		  pagingInited = false;
	}

	
	switch (selId) {
		case '02': 
		    data = {"codeType": selId2};
			break;
		case '03': 
			data = {"title": context };
			break;
		case '04': 
			data = {"name": context };
		    break;
		case '05': 
			data = {"num": context };
		    break;
		case '06': 
			data = {"startDate": startDate , "endDate" : endDate };
		    break;
	}
	console.log("startDate : "+startDate+ " endDate: " + endDate);
	data.page = show;
	data.cnt = 10;
	filter('search.ajax','post',data);	
}

filter('search.ajax','post',{"page" : 1 , "cnt" : 10 });
    function filter(url,type,data) {
        $.ajax({
            type: type,
            contentType: 'application/json',
            url: url,
            data: JSON.stringify(data),
            dataType: 'JSON',
            success: function(res) {
            //console.log(JSON.stringify(res));
                if (res.list.length > 0) {
                    drawList(res.list);
                  
                    //추가
                    if (!pagingInited || cntPage !== res.totalPages) {
					$('#pages').twbsPagination('destroy');                	
                    $('#pages').twbsPagination({
		                startPage:1, 
		                totalPages:res.totalPages, 
		                visiblePages:5,
		                initiateStartPageClick: false,
		                first:'<<',
		                prev:'<',
		                next:'>',
		                last:'>>',
		                onPageClick:function(evt,page){
		                   //console.log('evt',evt); 
		                   //console.log('page',page);
		                   searchClick(page);
		                }
                    });
                  	//추가
                    pagingInited = true;
                    cntPage = res.totalPages;
                  } 
                } else {
                    $('#list').html('');
                    $('#no-data').show();
                }
            },
            error: function(e) {
                console.error(e);
            }
        });
    }

    function drawList(list) {
        var content = '';
        list.forEach(function(view, idx) {
            content += '<tr>';
            content += '<td>' + view.codeType + '</td>';
            content += '<td>' + view.num + '</td>';
            content += '<td><a href="detail.do?num=' + view.num + '">' + view.title + '</a></td>';
            content += '<td>' + view.name + '</td>';
            content += '<td>' + view.bHit + '</td>';
            content += '<td>' + view.regdate + '</td>';
            content += '</tr>';
        });
        $('#list').html(content);
        $('#no-data').hide();
    }
</script>
</html>
