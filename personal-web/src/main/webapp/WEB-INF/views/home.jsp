<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
	
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<h1>회원</h1>
<ul>
	<li><a href="member/list">회원 목록</a></li>
	<c:if test="${empty member}">
		<li><a href="member/loginForm">로그인</a></li>
		<li><a href="member/registForm">회원 가입</a></li>
	</c:if>
	<c:if test="${not empty member}">
		<li><a href="member/detailView">${member.name}</a></li>
		<!-- 사용안하는 기능 -->
		<%-- <li>디테일 2로<br/>
		<a href="detailView2">${member.name}</a></li> --%>
		<li><a href="member/logout">로그아웃</a></li>
	</c:if>
</ul>
<h1>게시판</h1>
<ul>
	<li><a href="board/list">게시판 목록</a></li>
	<li><a href="board/registForm">게시판 등록</a></li>
	<!-- 사용 안하는 기능, 가상 데이터 입력용 -->
	<!-- <li><a href="board/test">게시판 테스트 만들기</a></li> -->
</ul>
</body>
</html>
