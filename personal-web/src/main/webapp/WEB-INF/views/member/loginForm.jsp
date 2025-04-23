<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
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
<!-- 메인 콘텐츠 -->
	<div class="container-fluid main-container">
		<div class="row h-100">
			<jsp:include page="/WEB-INF/views/common/nav.jsp"/>
			<!-- 우측 본문 -->
			<main class="col-md-10 main-area  d-flex justify-content-center">
				<div class="login-container mt-5">
					<h3 class="text-center mb-4">로그인</h3>
					<form action="login" id="login" method="post">
						<div class="mb-3">
							<label for="userid" class="form-label">아이디</label> <input
								type="text" class="form-control" id="userid" name="userid"
								value="${param.userid}" required>
						</div>
						<div class="mb-3">
							<label for="passwd" class="form-label">비밀번호</label> <input
								type="password" class="form-control" id="passwd" name="passwd"
								required>
						</div>
						<div class="d-flex justify-content-center gap-2">
						<input type="submit" class="btn btn-primary" value="로그인">
						</div>
						<div class="d-flex justify-content-center gap-2">
						<a href="findID">아이디 찾기</a>
						<a href="findPW">비밀번호 찾기</a>
						</div>
					</form>
				</div>
			</main>
		</div>
	</div>
</body>
<script type="text/javascript">
// 로그인 확인후 패치
		let loginForm = document.querySelector("#login");
		loginForm.addEventListener("submit", e => {
			console.log("fetch 실행됨")
			 e.preventDefault();
		const userid = document.querySelector("#userid");
		const passwd = document.querySelector("#passwd");
			if(userid.value.length == 0){
				alert("아이디를 입력해주세요.");
				userid.focus();
				return;
			}
			
		fetch("login", { 
	  		method: 'post', 
	  		headers: {
	    		'Content-Type':'application/json;charset=utf-8',
	  },
	  body: JSON.stringify({ userid: userid.value,
		  passwd: passwd.value})
	})
	  .then(response => {return response.json()})
	  .then(json => {
		  const { status, message } = json;
		    switch (status) {
		     	case 'SUCCESS':
		        alert('로그인 되었습니다.');
		        // 로그인 성공하면 메인으로 이동
		        const ctx = '${pageContext.request.contextPath}';
		        location.href = `${ctx}/yj`;
		        break;

		      case 'NO_USER':
		        alert(message);  // "등록된 회원이 아닙니다."
		        userid.value = '';
		        passwd.value = '';
		        userid.focus();
		        break;

		      case 'FAIL_CREDENTIALS':
		        alert(message);  
		        // 남은 시도 횟수만큼 비밀번호만 초기화
		        passwd.value = '';
		        passwd.focus();
		        break;

		      case 'FAIL_LOCKED':
		        alert(message); 
		        userid.value = '';
		        passwd.value = '';
		        userid.focus();
		        break;

		      default:
		        alert('알 수 없는 오류가 발생했습니다.');
		    }
		  })
		  .catch(err => {
		    console.error(err);
		    alert('로그인 처리 중 오류가 발생했습니다.');
		  });
		 });
</script>
</html>