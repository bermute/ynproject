<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="login"></div>

<script>
    var loginId = '${sessionScope.loginId}';
    if (loginId == "" || loginId == "null" || loginId == null) {
        alert('로그인이 필요한 서비스 입니다.');
        location.href = './';
    } else {
        $('#login').html('안녕하세요 ' + loginId + '님, <a href="logout.do">[로그아웃]</a>');
    }
</script>