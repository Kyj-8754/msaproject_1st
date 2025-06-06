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
<link rel="stylesheet" type="text/css" href="${root}/resources/css/common.css"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid main-container">
	<div class="row h-100">
		<jsp:include page="/WEB-INF/views/common/nav.jsp" />
		<!-- 우측 본문 -->
		<main class="col-md-10 main-area">
			<h2>게시물 목록</h2>
			건수 : <select name="size" id="size">
				<c:forTokens items="10,30,90,100" delims="," var="size">
					<option value="${size}"
						${pageResponse.size == size ? 'selected' : ''}>${size}</option>
				</c:forTokens>
			</select>

			<!-- 현재 페이지 번호 / 전체 페이지 번호 -->
			(${pageResponse.pageNo}/${pageResponse.totalPage})

			<form action="list?searchValue=${pageResponse.searchValue}"
				name="searchID" id="searchID">
				검색어 : <input type="text" name="searchValue" id="searchValue"
					value="${pageResponse.searchValue}"> <input type="submit"
					value="검색">
			</form>

			<table class="table table-striped table-hover table-bordered mt-4">
				<thead class="table-dark text-center">
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
						<th>조회수</th>
						<c:if test="${member.supervisor == 'Y'}">
						<th>삭제여부</th>
						<th>삭제일</th>
						</c:if>
					</tr>
				</thead>
				<tbody class="text-center">
					<c:forEach items="${pageResponse.list}" var="item">
						<tr>
							<td>${item.bno}</td>
							<td><a href="detailView?bno=${item.bno}">${item.title}</a></td>
							<td>${item.writer}</td>
							<td>${item.reg_date}</td>
							<td>${item.view_count}</td>
							<c:if test="${member.supervisor == 'Y'}">
							<td>${item.is_deleted}</td>
							<td>${item.deleted_at}</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- 페이지 처리 -->
			<div class="d-flex justify-content-center">
			<c:if test="${pageResponse.prev}">
				<a href="list?pageNo=${pageResponse.startPage-1}&size=${pageResponse.size}
				<c:if test='${not empty pageResponse.searchValue}'>&searchValue=${pageResponse.searchValue}
    			</c:if>">이전 </a>
			</c:if>
			<c:forEach begin="${pageResponse.startPage}"
				end="${pageResponse.endPage}" var="pageNo">
				<a href="list?pageNo=${pageNo}&size=${pageResponse.size} <c:if test='${not empty pageResponse.searchValue}'>&searchValue=${pageResponse.searchValue}</c:if>">
					<c:choose>
						<c:when test="${pageNo == pageResponse.pageNo}">
							<b>${pageNo}</b>
						</c:when>
						<c:otherwise>${pageNo}</c:otherwise>
					</c:choose>
				</a>&nbsp;
			</c:forEach>
			<c:if test="${pageResponse.next}">
				<a
					href="list?pageNo=${pageResponse.endPage+1}&size=${pageResponse.size}<c:if test='${not empty pageResponse.searchValue}'>&searchValue=${pageResponse.searchValue}
    </c:if>">
					다음 </a>
			</c:if>
			</div>
		</main>
	</div>
</div>

<script type="text/javascript">
	 const size = document.querySelector("#size");
	size.addEventListener("change", e => {
		location = "list?pageNo=1&size=" + size.value;	
	});
</script>

</body>
</html>