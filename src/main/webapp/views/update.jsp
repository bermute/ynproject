<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
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
    h3 {
        color: #333;
        margin-bottom: 20px;
    }
    form {
        width: 90%;
        max-width: 600px;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        text-align: left;
        padding: 10px 15px;
    }
    th {
        background-color: #f5f5f5;
        font-weight: bold;
        width: 30%;
        vertical-align: top;
    }
    td input, td textarea, td button {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 1rem;
    }
    textarea {
        height: 100px;
        resize: vertical;
    }
    button {
        background-color: #007BFF;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    button:hover {
        background-color: #0056b3;
    }
    @media (max-width: 600px) {
        form {
            padding: 15px;
        }
        th, td {
            display: block;
            width: 100%;
        }
        th {
            margin-top: 10px;
        }
    }
</style>
</head>
<body>
    <jsp:include page="loginBox.jsp" />
    <h3>글쓰기</h3>
    <form action="update.do" method="post">
    <input value="${info.idx}" name="idx" type="hidden">
        <table>
            <tr>
                <th>제목</th>
                <td><input type="text" name="subject" placeholder="제목을 입력하세요" value="${info.subject}"></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${info.user_name}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" placeholder="내용을 입력하세요">${info.content}</textarea></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <button type="submit">수정하기</button>
                </td>
            </tr>
        </table>
    </form>
</body>
<script>
    $(document).ready(function() {
        var s = $('.dat').val();
        var ss = $('.dat2').val();
    });
</script>
</html>
