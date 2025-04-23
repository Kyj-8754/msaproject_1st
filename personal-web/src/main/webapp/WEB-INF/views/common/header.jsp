<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 커뮤니티</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	
<c:set var="root" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css" href="${root}/resources/css/common.css"/>
</head>
<body>
<!-- 로그인/회원가입 배너 -->
	<div class="text-end bg-light py-2 px-4">
		<c:if test="${empty member}">
			<a href="${root}/member/loginForm">로그인</a>/
		<a href="${root}/member/registForm">회원 가입</a>
		</c:if>
		<c:if test="${not empty member}">
			<span class="me-3"><a href="${root}/member/detailView">${member.name}</a>님</span>
			<a href="${root}/member/logout">로그아웃</a>
		</c:if>
	</div>
	<!-- 헤더 -->
	<header class="header border-bottom"
		style="height: 350px; overflow: hidden;">
		<a href="${root}"><img src="${root}/resources/image/bannerlogo.jpg"
			alt="사이트 배너" style="width: 100%; height: 100%; object-fit: cover;"></a>
	</header>
