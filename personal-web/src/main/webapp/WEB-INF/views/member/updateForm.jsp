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
				<div class="container d-flex justify-content-center align-items-center min-vh-100">
				<div class="card shadow p-4 rounded w-100" style="max-width: 600px;">
					<h1 class="text-center mb-4">회원 정보 수정</h1>
					<form class="row g-3 needs-validation" name="update"
						id="update" action="update" method="post" novalidate>
						<div class="mb-3">
							<label for="validationuserid" class="form-label">아이디</label>
							<div class="input-group has-validation">
								<input type="text" class="form-control" name="userid"
									id="userid" aria-describedby="inputGroupPrepend" readonly="readonly" value="${member.userid}">
							</div>
						</div>
						<div class="mb-3">
							<label for="validationpasswd" class="form-label">비밀번호</label>
							<div class="input-group has-validation">
								<input type="password" class="form-control" name="passwd"
									id="passwd" aria-describedby="inputGroupPrepend" required>
									<div class="invalid-feedback" id="passwdFeedback">기존 비밀번호를 입력해 주세요.</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationNewpasswd" class="form-label">새 비밀번호</label>
							<div class="input-group has-validation">
								<input type="password" class="form-control" name="newPasswd"
									id="newPasswd" aria-describedby="inputGroupPrepend" required>
									<div class="invalid-feedback" id="passwdFeedback">비밀번호는 8자
									이상이며, 영문자/숫자/특수문자를 포함해야 합니다.</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationNewpasswd2" class="form-label">새 비밀번호확인</label>
							<div class="input-group has-validation">
								<input type="password" class="form-control" name="newPasswd2"
									id="newPasswd2" aria-describedby="inputGroupPrepend" required>
								<div class="invalid-feedback" id="passwd2Feedback">비밀번호가
									같지 않습니다.</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationName" class="form-label">이름</label>
							<div class="input-group has-validation">
								<input type="text" class="form-control" name="name" id="name"
									aria-describedby="inputGroupPrepend" readonly="readonly" value="${member.name}">
							</div>
						</div>
						<div class="d-flex justify-content-center gap-2">
							<button class="btn btn-primary" type="submit">수정</button>
						</div>
					</form>
				</div>
			</div>
			</main>
		</div>
	</div>
</body>
<script type="text/javascript">

//실시간으로 체크하여 validation 반영하는 툴
const passwd = document.getElementById('passwd');
const newPasswd = document.getElementById('newPasswd');
const newPasswd2 = document.getElementById('newPasswd2');

/* //실시간 비밀번호 입력확인
passwd.addEventListener('input', () => {
	  if (passwd.value) {
		  passwd.classList.remove('is-invalid');
		  passwd.classList.add('is-valid');
	  } else {
		  passwd.classList.remove('is-valid');
		  passwd.classList.add('is-invalid');
	  }
	});
	  
//실시간 비밀번호 정규식 검사
newPasswd.addEventListener('input', () => {
	  if (validatePassword(newPasswd.value)) {
		  newPasswd.classList.remove('is-invalid');
		  newPasswd.classList.add('is-valid');
	  } else {
		  newPasswd.classList.remove('is-valid');
		  newPasswd.classList.add('is-invalid');
	  }
	});
	
//실시간 비밀번호 같은지 검사
newPasswd2.addEventListener('input', () => {
	  if (checkPasswordMatch(newPasswd.value, newPasswd2.value)) {
		  newPasswd2.classList.remove('is-invalid');
		  newPasswd2.classList.add('is-valid');
	  } else {
		  newPasswd2.classList.remove('is-valid');
		  newPasswd2.classList.add('is-invalid');
	  }
	});
	 */
	 
	 passwd.addEventListener('input', () => {
		  toggleValidationClass(passwd, passwd.value.length > 0);
		});

		newPasswd.addEventListener('input', () => {
		  toggleValidationClass(newPasswd, validatePassword(newPasswd.value));
		});

		newPasswd2.addEventListener('input', () => {
		  toggleValidationClass(newPasswd2, checkPasswordMatch(newPasswd.value, newPasswd2.value));
		});
	 
	 function validateFormBeforeSubmit() {
		  const pwFilled = passwd.value.length > 0;
		  const pwValid = validatePassword(newPasswd.value);
		  const pwNotMatch = checkNotPasswordMatch(passwd.value, newPasswd.value);
		  const pwMatch = checkPasswordMatch(newPasswd.value, newPasswd2.value);
		  
		  toggleValidationClass(passwd, pwFilled);
		  toggleValidationClass(newPasswd, pwValid);
		  toggleValidationClass(newPasswd, pwNotMatch)
		  toggleValidationClass(newPasswd2, pwMatch);

		  return pwFilled && pwValid && pwNotMatch &&pwMatch;
		}
	 
// 인풋 검사하여 반환
function toggleValidationClass(input, isValid) {
	  input.classList.remove(isValid ? 'is-invalid' : 'is-valid');
	  input.classList.add(isValid ? 'is-valid' : 'is-invalid');
	}

//비밀번호 검사 (영문자, 숫자, 특수문자는 1개 이상, 최소 길이 8자)
function validatePassword(value) {
    const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+=-]).{8,}$/;
    return pwRegex.test(value);
	}
	
	
//비밀번호 검사 같은지 검사
function checkPasswordMatch(value, value2) {
    return value.length > 0 && value2.length > 0 && value === value2;
	}
	
//기존 비밀번호와 새 비밀번호는 같을 수 없다.
function checkNotPasswordMatch(value, value2) {
    return value !== value2;
	}	
	


// 수정하는 폼
	let updateForm = document.querySelector("#update");
	
	if(updateForm){
	updateForm.addEventListener("submit", e => {
		 e.preventDefault();
	
		 //입력값 제대로 안되면 밑으로 진행 불가능
		 if (!validateFormBeforeSubmit()) {
			    alert("입력한 정보를 다시 확인해주세요.");
			    return;
			  }
		 
		 // 수정 하기전 질문
		const confirmUpdate = confirm("정말 수정하시겠습니까?");
	    if (!confirmUpdate) return;

		 const param = {
			userid : document.querySelector("#userid").value,
			passwd : document.querySelector("#passwd").value,
			newPasswd : document.querySelector("#newPasswd").value,
			newPasswd2 : document.querySelector("#newPasswd2").value,
		 }
	
		 
		if(param.newPasswd !== param.newPasswd2){
			alert("새로운 비밀번호 입력 확인해 주세요.");
			document.querySelector("#newPasswd").focus();
			return;
		}
		 
		// 패치로 컨트롤러 접근
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
		   const contextPath = "${pageContext.request.contextPath}";
			location= contextPath + "/member/loginForm";  // 또는 원하는 경로
	  }
  })
	 		});
	}
</script>
</html>