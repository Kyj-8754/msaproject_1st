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
<link rel="stylesheet" type="text/css"
	href="${root}/resources/css/common.css" />
<style>

/* 테이블 스타일 */
table {
	border-collapse: collapse; /* 셀 간 간격 제거 */
	margin: 80px auto 0; /* 헤더와 겹치지 않도록 상단 여백을 조금 줌 */
	width: 1000px;
	border: 1px solid #ccc; /* 테이블 전체 얇은 선 */
	text-align: left;
}

/* 테이블 셀 기본 스타일 */
td {
	padding: 10px;
	vertical-align: top;
}

/* 제목 행에만 2px 굵은 밑줄 */
.title-row {
	border-bottom: 2px solid gray;
}

/* 댓글 입력 섹션 */
#comment-section {
	width: 1000px;
	margin: 20px auto; /* 가운데 배치 */
	border: 1px solid #ddd; /* 테두리 */
	padding: 10px;
	text-align: left; /* 내용은 왼쪽 정렬 */
	box-sizing: border-box; /* padding 포함 계산 */
}

/* 작성자 이름 스타일 */
#comment-section strong {
	display: block;
	margin-bottom: 5px;
	font-size: 16px;
}

/* 댓글 입력창과 버튼을 한 줄에 배치 */
.comment-input {
	display: flex;
	align-items: center;
}

/* 댓글 입력 필드 */
.comment-input input {
	flex: 1; /* 공간을 가득 채움 */
	border: none;
	outline: none;
	font-size: 14px;
	padding: 8px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

/* 등록 버튼 */
.comment-input button {
	margin-left: 10px;
	padding: 8px 16px;
	border: 1px solid #ccc;
	background: #f7f7f7;
	cursor: pointer;
	border-radius: 4px;
}
</style>
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
				<h2>게시물 상세</h2>
				<!-- 게시글 내용 테이블 -->
				<div class="container mt-5">
					<table class="table" style="width: 100%; max-width: 1000px; margin: 0 auto;">
						<tbody>
							<tr class="title-row">
								<td colspan="4" style="font-size: 26px; font-weight: bold;">${boardDB.title}</td>
							</tr>
							<tr class="text-muted small">
								<td style="width: 25%;">작성자: <strong>${boardDB.writer}</strong></td>
								<td style="width: 25%;">작성일: ${boardDB.reg_date}</td>
								<td style="width: 25%;">조회수: ${boardDB.view_count}</td>
								<td style="text-align: right;">
									<form action="updateForm" method="post" class="d-inline">
										<input type="hidden" name="bno" value="${boardDB.bno}">
										<button type="submit" class="btn btn-outline-primary btn-sm">수정하기</button>
									</form>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div class="p-3" style="min-height: 150px;">${boardDB.content}</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<!-- 댓글 입력 섹션 -->
				<div class="container mt-4" style="max-width: 1000px;">
					<div class="border rounded p-3">
						<strong class="mb-2 d-block">김용진</strong>
							<div class="d-flex align-items-center">
						      <input type="text" class="form-control me-2" style="min-width: 0;" placeholder="댓글을 남겨주세요">
						      <button class="btn btn-secondary flex-shrink-0">등록</button>
						    </div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>