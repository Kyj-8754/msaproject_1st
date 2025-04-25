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
<!-- 상단 헤더부분 -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 메인 콘텐츠 -->
	<div class="container-fluid main-container">
		<div class="row h-100">
			<jsp:include page="/WEB-INF/views/common/nav.jsp"/>
			<!-- 우측 본문 -->
			<main class="col-md-10 main-area">
				<h1><Strong>환영 합니다.</Strong></h1>
				<p id="serverTime">현재 시간 불러오는 중...</p>
				<table class = "table table-striped table-hover table-bordered mt-4">
					<thead class="table-dark text-center">
						<tr>
							<th>제목</th>
							<th>작성자</th>
							<th>등록일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody class="text-center">
						<c:forEach items="${pageResponse.list}" var="item">
							<tr>
								<td><a href="board/detailView?bno=${item.bno}">${item.title}</a></td>
								<td>${item.writer}</td>
								<td>${item.reg_date}</td>
								<td>${item.view_count}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 더미데이터생산 -->
				<!-- <a href="member/dummy">더미데이터 생산하기</a> -->
			</main>
		</div>
	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		<script>
  function updateTime() {
    const now = new Date();
    const formatted = now.toLocaleString("ko-KR", {
      year: 'numeric', month: '2-digit', day: '2-digit',
      hour: '2-digit', minute: '2-digit',
      hour12: false
    });
    document.querySelector("#serverTime").textContent = "현재 시간: " + formatted;
  }

  updateTime(); // 초기 실행
  setInterval(updateTime, 1000); // 1초마다 갱신
</script>
</body>
</html>
