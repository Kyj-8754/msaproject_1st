<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- 로그인/회원가입 배너 -->
	<div class="text-end bg-light py-2 px-4">
		<c:if test="${empty member}">
			<a href="${root}/member/loginForm">로그인</a>/
		<a href="${root}/member/registForm">회원 가입</a>
		</c:if>
		<c:if test="${not empty member}">
			<span class="me-3"><a href="${root}/member/detailView?userid=${member.userid}">${member.name}</a>님</span>
			<a href="${root}/member/logout">로그아웃</a>
		<!-- char는 String형태가아니라서 이럼, 나중에는 String으로 모두 하는게 편함 -->
			<c:if test="${member.supervisor == 'Y'}">
				/ <a href="${root}/member/list">유저관리</a>
			</c:if>
		</c:if>
	</div>
	<!-- 헤더 -->
	<header class="header border-bottom"
		style="height: 350px; overflow: hidden;">
		<a href="${root}"><img src="${root}/resources/image/bannerlogo.jpg"
			alt="사이트 배너" style="width: 100%; height: 100%; object-fit: cover;"></a>
	</header>
