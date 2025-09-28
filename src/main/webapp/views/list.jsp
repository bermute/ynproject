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
    #selId ,#codeType{
    	width: 100px;
    }
    #act{ 
    	display: inline-block;
    }
    button:disabled {
	    background-color: #ccc;     /* 회색 배경 */
	    color: #666;               /* 글자색 어둡게 */
	    cursor: not-allowed;       /* 마우스 커서 변경 */
	    opacity: 0.7;              /* 흐리게 */
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
			  <c:if test="${empty list}">
			    <tr>
			      <td colspan="6" class="text-center">작성된 데이터가 없습니다.</td>
			    </tr>
			  </c:if>
			  <c:forEach var="row" items="${list}">
			    <tr>
			      <td>${row.codeType}</td>
			      <td>${row.num}</td>
			      <td>
			        <a href="detail.go?num=${row.num}">${row.title}</a>
			      </td>
			      <td>${row.name}</td>
			      <td>${row.bHit}</td>
			      <td>${row.regdate}</td>
			    </tr>
			  </c:forEach>
	    </tbody>
    </table>
    <div id="pages">
		<div class="btn-group" role="group">
	    	<a class="btn btn-outline-secondary ${page == 1 ? 'disabled' : ''}"
	    			href="list.go?page=${first}&cnt=${cnt}"> &lt;&lt; </a>
	    	<a class="btn btn-outline-secondary ${page == 1 ? 'disabled' : ''}"
	    			href="list.go?page=${prev}&cnt=${cnt}">&lt;</a>
			
		    <c:forEach var="p" begin="${start}" end="${end}">
		      <a class="btn ${p == page ? 'btn-primary' : 'btn-outline-primary'} ${page == p ? 'disabled' : ''}"
		         href="list.go?page=${p}&cnt=${cnt}">${p}</a>
		    </c:forEach>	
	
	    	<a class="btn btn-outline-secondary ${page == totalPage ? 'disabled' : ''}"
	    		href="list.go?page=${next}&cnt=${cnt}">&gt;</a>
	    	<a class="btn btn-outline-secondary ${page == totalPage ? 'disabled' : ''}"
	    		href="list.go?page=${last}&cnt=${cnt}">&gt;&gt;</a>


		</div>	  
    </div>
    <div id="no-data" style="display: none;">작성된 데이터가 없습니다.</div>
</body>
<script type="text/javascript">
function selEvent() {
	  let selId = document.getElementById("selId").value;
	  let act = document.getElementById("act");
	  switch (selId) {
	    case '01':
	      act.innerHTML = '';
	      break;
	    case '02':
	      act.innerHTML =
	        '<select id="codeType" class="form-control">' +
	        '<option value="01">자유</option>' +
	        '<option value="02">익명</option>' +
	        '<option value="03">QnA</option>' +
	        '</select>';
	      break;
	    case '03':
	    case '04':
	    case '05':
	      act.innerHTML = '<input type="text" class="form-control">';
	      break;
		case '06': 
			act.innerHTML=
   	 			'<input type="text" id="startDate"  class="form-control d-inline-block" ><input type="text" id="endDate"  class="form-control d-inline-block" >';
		    break;
	}
}

function readFilters(){
const selId = document.getElementById("selId").value;
const codeTypeEl = document.getElementById("codeType");
const context = document.getElementById("act").querySelector('input');
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");
const base = { selId, cnt: 10 };

	switch (selId) {
	  case '01':
	    return base;
	  case '02':
	    return { ...base, codeType: codeTypeEl ? codeTypeEl.value : "" };
	  case '03':
	    return { ...base, title: context ? context.value.trim() : "" };
	  case '04':
	    return { ...base, name: context ? context.value.trim() : "" };
	  case '05':
	    return { ...base, num: context ? context.value.trim() : "" };
	  case '06':
	    return {
	      ...base,
	      startDate: startDate ? startDate.value.trim() : "",
	      endDate: endDate ? endDate.value.trim() : ""
	    };
	  default:
	    return base;
	}
}
let lastPage = 0;
let lastFiltersKey = '';
function filtersKeyOf(f) {
	  // 검색조건이 같으면 pager 유지, 다르면 1페이지로
	  const { selId, codeType, title, name, num, startDate, endDate, cnt } = f;
	  return JSON.stringify({ selId, codeType, title, name, num, startDate, endDate, cnt });
	}
function loadPage(page) {
	
	
  const filters = readFilters();
  const key = filtersKeyOf(filters);

  // 조건이 바뀌었으면 1페이지로 강제
  if (key !== lastFiltersKey) page = 1;
  const payload = { ...filters, page };

  $.ajax({
    type: 'POST',
    url: 'search.ajax',
    contentType: 'application/json',
    dataType: 'json',
    data: JSON.stringify(payload),
    success: function (res) {
    	//console.log('res: ' +JSON.stringify(res));
    	
	        drawList(res.list);
	        drawPagination(page, res.totalPages);
	        lastPage = page;
	        lastFiltersKey = key;
     	 
    },
    error: function (e) {
      console.error(e);
    }
  });
}

//리스트 렌더
function drawList(list) {
  const $list = $('#list');
  if (!list || list.length === 0) {
    $list.html('');
    $('#no-data').show();
    return;
  }
  let html = '';
  list.forEach(view => {
	  html += '<tr>';
	  html += '<td>' + (view.codeType ?? '') + '</td>';
	  html += '<td>' + (view.num ?? '') + '</td>';
	  html += '<td><a href="detail.do?num=' + (view.num ?? '') + '">' + (view.title ?? '') + '</a></td>';
	  html += '<td>' + (view.name ?? '') + '</td>';
	  html += '<td>' + (view.bHit ?? '') + '</td>';
	  html += '<td>' + (view.regdate ?? '') + '</td>';
	  html += '</tr>';
	});
  $list.html(html);
  $('#no-data').hide();
}
function searchClick() {
    loadPage(1);
}

function drawPagination(curPage,totalPages){
	let pages = document.getElementById('pages');
	let prev = (curPage - 1) < 1 ? 1 : (curPage - 1) ;
 	let next = (curPage + 1) > totalPages ? totalPages : (curPage + 1);
	let drawString = '';

    let group = Math.floor((curPage - 1) / 5);
    let start = group * 5 + 1;
    let end = Math.min(totalPages, start + 5 - 1);
    let first = (start-1) <= 1 ? 1:(start-1)
   	let last = (end+1) >= totalPages ? totalPages:(end+1);
    
    
    drawString += '<button onclick="drawBtn(' + first + ')" ' + (curPage === 1 ? 'disabled' : '') + '> << </button>';
    drawString += '<button onclick="drawBtn(' + prev + ')" ' + (curPage === 1 ? 'disabled' : '') + '> < </button>';
			
    for (let i = start; i <= end; i++) {
        drawString += '<button onclick="drawBtn(' + i + ')" ' + (i === curPage ? 'disabled' : '') + '>' + i + '</button>';
    }

    drawString += '<button onclick="drawBtn(' + next + ')" ' + (curPage === totalPages ? 'disabled' : '') + '> > </button>';
    drawString += '<button onclick="drawBtn(' + last + ')" ' + (curPage === totalPages ? 'disabled' : '') + '> >> </button>';

    pages.innerHTML = drawString;
};
function drawBtn(page){
	  const filters = readFilters();
	  const key = filtersKeyOf(filters);
	  if (key !== lastFiltersKey) return;
	loadPage(page);
}

</script>
</html>
