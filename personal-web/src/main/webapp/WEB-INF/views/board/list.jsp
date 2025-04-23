<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style>
   header {
      position: fixed;
      top: 10px;
      right: 10px;
    }

  /* body 전체 내용을 가운데 정렬 */
  body {
    text-align: center;
  }
  
  /* 테이블 가운데 정렬 및 테두리 제거 */
  table {
    border-collapse: collapse; /* 셀 간 간격 제거 */
    margin: 0 auto;            /* 테이블을 가운데 배치 */
    width: 1000px;
  }
  
  /* th, td의 기본 테두리 제거 및 패딩 적용 */
  th, td {
    border: none;
    padding: 6px;
  }
  
  /* thead 영역은 별도의 테두리 없음 */
  thead tr {
    border-bottom: 2px solid gray;
  }
  
  /* tbody의 각 행에 회색 밑줄 추가 */
  tbody tr {
    border-bottom: 1px solid gray;
  }
</style>
</head>
<body> -->
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
			(${pageResponse.pageNo}/${pageResponse.totalPage})<br />

			<form action="list?searchValue=${pageResponse.searchValue}"
				name="searchID" id="searchID">
				검색어 : <input type="text" name="searchValue" id="searchValue"
					value="${pageResponse.searchValue}"> <input type="submit"
					value="검색">
			</form>

			<table class="table table-striped table-hover table-bordered mt-4">
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
							<td><a href="detailView?bno=${item.bno}">${item.title}</a></td>
							<td>${item.writer}</td>
							<td>${item.reg_date}</td>
							<td>${item.view_count}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- 페이지 처리 -->
			<c:if test="${pageResponse.prev}">
				<a
					href="list?pageNo=${pageResponse.startPage-1}&size=${pageResponse.size}<c:if test='${not empty pageResponse.searchValue}'>
      &searchValue=${pageResponse.searchValue}
    </c:if>">
					이전 </a>
			</c:if>
			<c:forEach begin="${pageResponse.startPage}"
				end="${pageResponse.endPage}" var="pageNo">
				<a
					href="list?pageNo=${pageNo}&size=${pageResponse.size}<c:if test='${not empty pageResponse.searchValue}'>&searchValue=${pageResponse.searchValue}</c:if>">
					<c:choose>
						<c:when test="${pageNo == pageResponse.pageNo}">
							<b>${pageNo}</b>
						</c:when>
						<c:otherwise>${pageNo}</c:otherwise>
					</c:choose>
				</a>
			</c:forEach>
			<c:if test="${pageResponse.next}">
				<a
					href="list?pageNo=${pageResponse.endPage+1}&size=${pageResponse.size}<c:if test='${not empty pageResponse.searchValue}'>&searchValue=${pageResponse.searchValue}
    </c:if>">
					다음 </a>
			</c:if>
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