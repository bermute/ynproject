<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f2f5;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    table {
        width: 90%;
        max-width: 800px;
        margin: 30px auto;
        border-collapse: collapse;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        border-radius: 8px;
        overflow: hidden;
    }
    table caption {
        font-size: 1.8rem;
        font-weight: bold;
        padding: 20px;
        color: #222;
        background-color: #e9ecef;
        border-bottom: 2px solid #ddd;
    }
    th, td {
        text-align: left;
        padding: 20px;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #f8f9fa;
        font-weight: bold;
        color: #333;
    }
    td {
        color: #555;
        word-break: break-word;
    }
    tr:last-child td {
        border-bottom: none;
    }
    .actions {
        text-align: center;
        padding: 20px;
    }
    .actions a {
        text-decoration: none;
        background-color: #007BFF;
        color: white;
        padding: 12px 24px;
        margin: 0 10px;
        border-radius: 6px;
        font-size: 1rem;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }
    .actions a:hover {
        background-color: #0056b3;
        transform: translateY(-2px);
    }
    @media (max-width: 600px) {
        table {
            width: 100%;
            margin: 20px;
        }
        .actions a {
            padding: 10px 20px;
            margin: 5px;
            font-size: 0.9rem;
        }
    }
</style>
</head>
<body>
    <jsp:include page="loginBox.jsp" />
    <table>
        <caption>상세보기</caption>
        <tr>
            <th>작성자</th>
            <td>${info.user_name}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td>${info.subject}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td>${info.content}</td>
        </tr>
        <tr>
            <td colspan="2" class="actions">
                <a href="list.go">리스트</a>
                <a href="update.go?idx=${info.idx}">수정하기</a>
                <a href="detailDel.do?idx=${info.idx}">삭제</a>
            </td>
        </tr>
    </table>
</body>
<script>
    var session = '${sessionScope.loginId}';
</script>
</html>
