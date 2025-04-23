<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 메인 콘텐츠 -->
<div class="container-fluid main-container">
	<div class="row h-100">
		<jsp:include page="/WEB-INF/views/common/nav.jsp" />
		<!-- 우측 본문 -->
		<main class="col-md-10 main-area">

			<div
				class="container d-flex justify-content-center align-items-center min-vh-100">
				<div class="card shadow p-4 rounded w-100" style="max-width: 600px;">
					<h1 class="text-center mb-4">회원가입</h1>
					<form class="row g-3 needs-validation" name="registerForm"
						id="registerForm" action="register" method="post" novalidate>
						<div class="mb-3">
							<label for="validationuserid" class="form-label">아이디</label>
							<div class="input-group has-validation">
								<input type="text" class="form-control" name="userid"
									id="userid" aria-describedby="inputGroupPrepend" required>
								<button class="btn btn-outline-secondary" type="button"
									id="checkIdBtn">중복 확인</button>
								<div class="invalid-feedback" id="useridFeedback">아이디는 영문
									또는 숫자로 최소 8자 이상입력 해 주세요</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationpasswd" class="form-label">비밀번호</label>
							<div class="input-group has-validation">
								<input type="password" class="form-control" name="passwd"
									id="passwd" aria-describedby="inputGroupPrepend" required>
								<div class="invalid-feedback" id="passwdFeedback">비밀번호는 8자
									이상이며, 영문자/숫자/특수문자를 포함해야 합니다.</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationpasswd2" class="form-label">비밀번호확인</label>
							<div class="input-group has-validation">
								<input type="password" class="form-control" name="passwd2"
									id="passwd2" aria-describedby="inputGroupPrepend" required>
								<div class="invalid-feedback" id="passwd2Feedback">비밀번호가
									같지 않습니다.</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationName" class="form-label">이름</label>
							<div class="input-group has-validation">
								<input type="text" class="form-control" name="name" id="name"
									aria-describedby="inputGroupPrepend" required>
								<div class="invalid-feedback">이름을 입력해 주세요</div>
							</div>
						</div>
						<div class="mb-3">
							<label class="form-label">생년월일</label>
							<div class="d-flex gap-2">
								<select class="form-select" id="birthYear" name="birthYear"
									required>
									<option value="">년</option>
								</select> <select class="form-select" id="birthMonth" name="birthMonth"
									required>
									<option value="">월</option>
								</select> <select class="form-select" id="birthDay" name="birthDay"
									required>
									<option value="">일</option>
								</select>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationPhoneNo" class="form-label">핸드폰 번호</label>
							<div class="input-group has-validation">
								<input type="text" class="form-control" name="phone_no"
									id="phone_no" aria-describedby="inputGroupPrepend" required
									placeholder="숫자만 입력 01012345678">
								<div class="invalid-feedback">숫자만 입력해 주세요.</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationPostCode" class="form-label">우편 번호</label>
							<div class="input-group">
								<input type="text" class="form-control" name="postcode"
									id="postcode" required>
								<button type="button" class="btn btn-outline-secondary"
									onclick="execDaumPostcode()">우편번호 찾기</button>
							</div>
						</div>
						<div class="row g-3">
							<div class="col">
								<label for="validationPostCode" class="form-label">도로명주소</label>
								<div class="input-group has-validation">
									<input type="text" class="form-control" name="roadAddress"
										id="roadAddress" aria-describedby="inputGroupPrepend" required>
								</div>
							</div>
							<div class="col">
								<label for="validationJibunAddress" class="form-label">지번주소</label>
								<div class="input-group has-validation">
									<input type="text" class="form-control" name="jibunAddress"
										id="jibunAddress" aria-describedby="inputGroupPrepend"
										required>
								</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="validationDetailAdd" class="form-label">상세주소</label>
							<div class="input-group has-validation">
								<input type="text" class="form-control" name="detail_Add"
									id="detail_Add" aria-describedby="inputGroupPrepend" required>
								<div class="invalid-feedback">상세주소를 입력해 주세요</div>
							</div>
						</div>
						<div class="d-flex justify-content-center gap-2">
							<button class="btn btn-primary" type="submit">회원 가입</button>
							<button class="btn btn-secondary" type="reset">초기화</button>
						</div>
					</form>
				</div>
			</div>
		</main>
	</div>
</div>
<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<script type="text/javascript">
	
			
			let existUserId = true; 
			let validClicked = false; 

			// 등록폼 보내기
		 	let registerForm = document.querySelector("#registerForm");
			let validButton = document.querySelector("#checkIdBtn");
		 	
			
	//부트스트랩 사용하기
	//페이지 로드시 생년월일 
	document.addEventListener('DOMContentLoaded', () => {
  const yearSelect = document.getElementById('birthYear');
  const monthSelect = document.getElementById('birthMonth');
  const daySelect = document.getElementById('birthDay');

  // 연도
  const currentYear = new Date().getFullYear();
  for (let y = currentYear; y >= 1950; y--) {
    const option = document.createElement("option");
    option.value = y;
    option.textContent = y + "년";
    yearSelect.appendChild(option);
  }

  // 월
  for (let m = 1; m <= 12; m++) {
    const option = document.createElement("option");
    option.value = m.toString().padStart(2, '0');
    option.textContent = m + "월";
    monthSelect.appendChild(option);
  }
  
//일
  for (let d = 1; d <= 31; d++) {
    const option = document.createElement("option");
    option.value = d.toString().padStart(2, '0');
    option.textContent = d + "일";
    daySelect.appendChild(option);
  }
	});
	
	
	//실시간으로 체크하여 validation 반영하는 툴
	document.querySelectorAll('.form-control').forEach(input => {
	  input.addEventListener('input', () => {
		  // 기본 필드 네임
		  const fieldName = input.getAttribute('name');
		  let valid = input.checkValidity();
		  
			if (fieldName === 'passwd') {
			    valid = validatePassword(input.value);
			  }

		    if (fieldName === 'userid') {
		      valid = validateUserId(input.value);
		    }
		    
		    if (fieldName === 'phone_no') {
			      valid = validatePhoneNo(input.value);
			  }
		  
		  
		// is-invalid 와 is-valid를 바꿔 주는 구문
	    if (valid) {
	      input.classList.remove('is-invalid')
	      input.classList.add('is-valid')
	    } else {
	      input.classList.remove('is-valid')
	      input.classList.add('is-invalid')
	    }
	  });
	});
	
	const passwd = document.getElementById('passwd');
	const passwd2 = document.getElementById('passwd2');

	//실시간 비밀번호 검증 로직
	passwd2.addEventListener('input', () => {
		  if (checkPasswordMatch(passwd.value, passwd2.value)) {
		    passwd2.classList.remove('is-invalid');
		    passwd2.classList.add('is-valid');
		  } else {
		    passwd2.classList.remove('is-valid');
		    passwd2.classList.add('is-invalid');
		  }
		});
	
	// 비밀번호 검사 (영문자, 숫자, 특수문자는 1개 이상, 최소 길이 8자)
	function validatePassword(value) {
	    const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+=-]).{8,}$/;
	    return pwRegex.test(value);
  	}
	
	// 비밀번호 검사 같은지 검사
	function checkPasswordMatch(value, value2) {
	    return value === value2;
  	}
	
	// 아이디 길이 검사 (8자 이상)
	function validateUserId(value) {
		const trimmed = value.trim();
		  const isValidLength = trimmed.length >= 8;
		  const isValidChars = /^[a-zA-Z0-9]+$/.test(trimmed);
	
		  return isValidLength && isValidChars;
	}
	
	
	// 핸드폰 입력 검사
	function validatePhoneNo(value) {
		const pwRegex = /^01[016]\d{8}$/;
	    return pwRegex.test(value);
	}

	if (registerForm) {
 		//이벤트 핸들러 등록 
 		registerForm.addEventListener("submit", e => {
			e.preventDefault();  // form의 기본 동작을 취소함.
			
			if (!confirm("회원 가입하시겠습니까?")) return;
			
			
			 
			if (validClicked == false) {
				alert("아이디 중복을 검사해주세요");
				return ;
			}
			
			if (existUserId) {
				alert("아이디가 중복되어 가입할 수 없는 아이디입니다");
				return ;
			}
			
			// 필수 항목들 다시 가져오기
			const requiredFields = [
			  { id: "userid", label: "아이디" },
			  { id: "passwd", label: "비밀번호" },
			  { id: "passwd2", label: "비밀번호 확인" },
			  { id: "name", label: "이름" },
			  { id: "postcode", label: "우편번호" },
			  { id: "roadAddress", label: "도로명 주소" },
			  { id: "jibunAddress", label: "지번 주소" },
			  { id: "detail_Add", label: "상세 주소" },
			  { id: "birthYear", label: "생년" },
			  { id: "birthMonth", label: "월" },
			  { id: "birthDay", label: "일" },
			  { id: "phone_no", label: "핸드폰 번호" },
			];
			
			//필드값 확인
			 for (const field of requiredFields) {
				    const element = document.getElementById(field.id);
				    
				    if (!element || element.value.trim() === "") {
				      alert(field.label + "을(를) 입력해 주세요.");
				      element.focus();
				      return;
				    }
				  }
			
			const passwd = document.querySelector("#passwd").value;
			const passwd2 = document.querySelector("#passwd2").value;
			const userid = document.querySelector("#userid").value;
			const name = document.querySelector("#name").value;
			const postcode = document.querySelector("#postcode").value;
			const roadaddress = document.querySelector("#roadAddress").value;
			const jibunaddress = document.querySelector("#jibunAddress").value;
			const detail_add = document.querySelector("#detail_Add").value;
			//나이 계산용
			const birthYear = document.querySelector("#birthYear").value;
			const currentYear = new Date().getFullYear();
			const age = currentYear - birthYear + 1;
			const phone_no = document.querySelector("#phone_no").value; 
			
			
			// rest api 등록 보내기
			fetch("postregi", { 
		  		method: 'post', 
		  		headers: {
		    		'Content-Type':'application/json;charset=utf-8',
		  },
		  body: JSON.stringify({userid, passwd, postcode, roadaddress, jibunaddress, detail_add,  name, age, phone_no})
		})
		  .then(response => response.text())
		  .then(result => {
			  const register = result === 'true';
			  if(!register){
				  alert("회원가입에 실패 하였습니다.")
				  return;
			  }else{
				  alert("회원가입에 성공 하셨습니다.");
				  location.href = "loginForm";
			  }
		  })
			 		});
 	}
	
 	// 아이디 중복확인
 	if (validButton) {
 		validButton.addEventListener("click", e => {
 			// 아이디 중복 검사 기능 구현, JSON
 			// 문자열을 객체로 변환 -> JSON.parse()
 			// 객체를 문자열로 변환 -> JSON.stringify()
			const userid = document.querySelector("#userid");
 			if(userid.value.length == 0){
 				alert("아이디를 입력해주세요.");
				userid.focus();
 				return;
 			}
 			
			fetch("isExistUserId", { 
		  		method: 'post', 
		  		headers: {
		    		'Content-Type':'application/json;charset=utf-8',
		  },
		  body: JSON.stringify({userid:userid.value})
		})
		  .then(response => {return response.json()})
		  .then(json => {
			  existUserId = json.existUserId;
			  if(existUserId){
				  alert("["+userid.value+"]"+"해당 아이디는 사용 불가능 합니다.")
			  }else{
				  alert("["+userid.value+"]"+"해당 아이디는 사용 가능합니다.")
				  validClicked = true;
			  }
			  console.log('POST요청결과:', json) 
		  })
			 		});
 	}

	</script>
<!-- 주소 api -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	//주소 api 함수
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	</script>
</body>
</html>