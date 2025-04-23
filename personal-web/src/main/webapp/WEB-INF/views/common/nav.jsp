<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 경로 지정문제 -->
<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- 좌측 nav -->
			<nav class="col-md-2 nav-area d-flex flex-column">
				<ul class="nav flex-column">
					<li class="nav-item"><a href="${root}/board/list" class="nav-link">게시판
							목록</a></li>
					<li class="nav-item"><a href="${root}/board/registForm"
						class="nav-link">게시판 등록</a></li>
				</ul>
			</nav>