<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<c:set var="root" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${root}/resources/css/common.css" />
</head>
<body>
	<!-- 상단 헤더부분 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- 메인 콘텐츠 -->
	<div class="container-fluid main-container">
		<div class="row h-100">
			<jsp:include page="/WEB-INF/views/common/nav.jsp" />
			<!-- 우측 본문 -->
			<main class="col-md-10 main-area">
				<h2>게시물 등록</h2>
				<div class="card-body">
					<form action="regist" method="post">
						<div class="mb-3">
							<label for="title" class="form-label">제목</label> <input
								type="text" class="form-control" name="title" id="title"
								placeholder="제목을 입력하세요" required>
						</div>

						<div class="row mb-3">
							<div class="col-md-6">
								<label for="writer" class="form-label">작성자 ID</label> <input
									type="text" class="form-control" name="writer" id="writer"
									required>
							</div>
							<div class="col-md-6">
								<label for="passwd" class="form-label">비밀번호</label> <input
									type="password" class="form-control" name="passwd" id="passwd"
									required>
							</div>
						</div>

						<div class="mb-4">
							<label for="content" class="form-label">내용</label>
							<textarea class="form-control" name="content" id="content"
								rows="10"
								style="resize: none; overflow: auto; max-height: 300px;"
								required></textarea>
						</div>

						<div class="d-flex justify-content-end">
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</form>
				</div>
			</main>
		</div>
	</div>
</body>
</html>