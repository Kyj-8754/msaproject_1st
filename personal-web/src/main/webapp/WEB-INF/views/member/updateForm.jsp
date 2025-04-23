<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" type="text/css"
	href="${root}/resources/css/common.css" />
<!-- 별도 css추가 -->
<style>
.login-container {
	width: 100%;
	max-width: 400px;
	background-color: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
	<!-- 상단 헤더 부분 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<!-- 메인 콘텐츠 -->
	<div class="container-fluid main-container">
		<div class="row h-100">
			<jsp:include page="/WEB-INF/views/common/nav.jsp" />
			<!-- 우측 본문 -->
			<main class="col-md-10 main-area  d-flex justify-content-center">
				<form class="container" action="update" id="update" method="post">
					<div class="title">회원 정보 수정</div>


					<div class="form-group">
						<label class="label">아이디</label> <input type="text" name="userid"
							id="userid" value="${member.userid}" readonly>
					</div>

					<div class="form-group">
						<label class="label">비밀번호</label> <input type="password"
							name="passwd" id="passwd" placeholder="새 비밀번호 입력">
					</div>

					<div class="form-group">
						<label class="label">이름</label> <input type="text" name="name"
							id="name" value="${member.name}">
					</div>

					<div class="form-group">
						<label class="label">나이</label> <input type="text" name="age"
							id="age" value="${member.age}">
					</div>

					<button type="submit" class="submit" id="submit">변경하기</button>
				</form>
			</main>
		</div>
	</div>
</body>
<script type="text/javascript">
  //회원 탈퇴 이벤트
  document.querySelector('#unregister').addEventListener('click', function(e) {
  // 3) 비밀번호 입력
  const pwd = prompt('비밀번호를 입력하세요.');
  if (!pwd) {
    alert('비밀번호를 입력해야 탈퇴가 가능합니다.');
    return;
  }

  // 4a) 전통적 폼 제출 방식
  document.getElementById('unregPassword').value = pwd;
  document.getElementById('unregisterForm').submit();
  
  
// 로그인 확인후 패치
		let updateForm = document.querySelector("#update");
		updateForm.addEventListener("submit", e => {
			 e.preventDefault();
			 const param = {
				userid : document.querySelector("#userid").value,
				passwd : document.querySelector("#passwd").value,
				name : document.querySelector("#name").value,
				age : document.querySelector("#age").value
			 }
		/* const userid = document.querySelector("#userid");
		const passwd = document.querySelector("#passwd");
		const name = document.querySelector("#name");
		const age = document.querySelector("#age"); */
			if(userid.value.length == 0){
				alert("아이디를 입력해주세요.");
				userid.focus();
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
			  alert("값 입력을 확인해 주세요");
		  }else{
			  alert("수정 되었습니다.")
			  // location = "./"; //상대경로
			  // location = "/sts3/"; //절대경로
			   const contextPath = "${pageContext.request.contextPath}";
 			location= contextPath + "/detailView";  // 또는 원하는 경로
		  }
	  })
		 		});
</script>
</html>