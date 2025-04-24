<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<c:set var="root" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${root}/resources/css/common.css" />
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
				<h2>게시물 수정</h2>
				<div class="card-body">
					<form id="boardForm" method="post">
						<!-- 레이블 줄 -->
						<div class="row mb-2">
							<div class="col-md-6 col-lg-6">
								<label for="title" class="form-label">제목</label>
							</div>
							<div class="col-md-3 col-lg-3">
								<label for="writer" class="form-label">작성자 ID</label>
							</div>
							<div class="col-md-3 col-lg-3">
								<label for="passwd" class="form-label">비밀번호</label>
							</div>
						</div>

						<!-- 입력 필드 줄 -->
						<div class="row align-items-center mb-4">
							<div class="col-md-6 col-lg-6">
								<input type="hidden" name="bno" id="bno" value="${boardDB.bno}">
								<input type="text" class="form-control" name="title" id="title"
									value="${boardDB.title}" required>
							</div>
							<div class="col-md-3 col-lg-3">
								<input type="text" class="form-control" name="writer" id="writer" readonly value="${boardDB.writer}">
							</div>
							<div class="col-md-3 col-lg-3">
								<input type="password" class="form-control" name="passwd"
									id="passwd" required>
							</div>
						</div>
						<div class="mb-4">
							<label for="content" class="form-label">내용</label>
							<textarea class="form-control" name="content" id="content"
								rows="10"
								style="resize: none; overflow: auto; max-height: 300px;"
								required>${boardDB.content}</textarea>
						</div>
						<div class="d-flex justify-content-end">
							<!-- 수정 -->
							<button type="submit" formaction="update" id="update" class="btn btn-primary me-2">수정</button>
							<!-- 삭제 -->
							<button type="submit" formaction="delete" id="delete" class="btn btn-danger">삭제하기</button>
						</div>
					</form>
				</div>
			</main>
		</div>
	</div>
</body>
<script type="text/javascript">
 let update = document.querySelector("#boardForm");
if(update){
	update.addEventListener('submit', e =>{
		const clickedBtn = e.submitter; 
	    const actionType = clickedBtn?.id;
	    const param = {
	    		title: document.querySelector("#title").value,
	    		bno : document.querySelector("#bno").value,
				passwd : document.querySelector("#passwd").value,
				content : document.querySelector("#content").value,
			 } 
	   const contextPath = "${pageContext.request.contextPath}";
	    
	    if (actionType === "update") {
	    	e.preventDefault();
	      const confirmUpdate = confirm("게시물 수정하시겠습니까?");
	      if (!confirmUpdate) {
	        return;
	      }
	      
	      
	      fetch("update", { 
	    		method: 'post', 
	    		headers: {
	      		'Content-Type':'application/json;charset=utf-8',
	    },
		    body: JSON.stringify(param)
		  })
		    .then(response => {return response.json()})
		    .then(json => {
		  	  
		  	  if(json.error){
		  		  alert(json.message);
		  	  }else{
		  		  alert(json.message);
		  			location= contextPath + "/board/detailView?bno=" + param.bno;
		  	  }
		    })
	    }

	    if (actionType === "delete") {
	      const confirmUpdate = confirm("게시물 삭제하시겠습니까?");
	        e.preventDefault();
	      if (!confirmUpdate) {
	        return;
	      }
	      
	      fetch("delete", { 
	    		method: 'post', 
	    		headers: {
	      		'Content-Type':'application/json;charset=utf-8',
	    },
		    body: JSON.stringify(param)
		  })
		    .then(response => {return response.json()})
		    .then(json => {
		  	  
		  	  if(json.error){
		  		  alert(json.message);
		  	  }else{
		  		  alert(json.message);
		  			location= contextPath + "/board/list";
		  	  }
		    })
	    }
	});
}
</script>
</html>