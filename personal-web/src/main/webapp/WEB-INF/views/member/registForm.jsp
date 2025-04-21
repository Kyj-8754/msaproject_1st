<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
1.서버에서 회원 가입 기능이 있는 rest api로 동작되게 구현한다.
2. 회원 가입 버튼이 눌리면 fetch api를 사용하면

 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<form name="registerForm" id="registerForm" action="register" method="post">
		아이디 
		<input type="text" name="userid" id="userid" required="required" placeholder="아이디를 입력해주세요"> 
		<input type="button" value="중복확인" id="validButton"><br/> 비밀번호
		<input type="password" name="passwd" id="passwd" required="required" placeholder="비밀번호를 입력해주세요"><br/> 비밀번호확인 
		<input type="password" name="passwd2" id="passwd2" required="required" placeholder="비밀번호확인를 입력해주세요"><br /> 이름 
		<input type="text" name="name" id="name" required="required" placeholder="이름을 입력해주세요"><br/>나이 
		<input type="number" name="age" id="age" required="required" placeholder="나이를 입력해주세요"><br />
		<input type="text" name="phone_no" id="phone_no" required="required" placeholder="핸드폰을 입력해 주세요"><br/> 
		<input type="text" id="postcode" placeholder="우편번호">
		<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br/>
		<input type="text" id="roadAddress" placeholder="도로명주소">
		<input type="text" id="jibunAddress" placeholder="지번주소"><br/>
		<span id="guide" style="color:#999;display:none"></span>
		<input type="text" id="detail_Add" placeholder="상세주소"><br/>
		<input type="submit" value="회원가입">
		<input type="reset" value="초기화"><br/>
	</form>
	<!-- 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
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
    
    
		let existUserId = true; 
		let validClicked = false; 

		// 등록폼 보내기
	 	let registerForm = document.querySelector("#registerForm");
		let validButton = document.querySelector("#validButton");
	 	
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
				
				const passwd = document.querySelector("#passwd").value;
				const passwd2 = document.querySelector("#passwd2").value;
				const userid = document.querySelector("#userid").value;
				const name = document.querySelector("#name").value;
				const postcode = document.querySelector("#postcode").value;
				const roadaddress = document.querySelector("#roadAddress").value;
				const jibunaddress = document.querySelector("#jibunAddress").value;
				const detail_add = document.querySelector("#detail_Add").value;
				const age = document.querySelector("#age").value;
				const phone_no = document.querySelector("#phone_no").value;
				
				
				if (passwd != passwd2) {
					alert("비밀번호가 잘못되었습니다");
					passwd = "";
					passwd2 = "";
					passwd.focus();
					return;
				}
				
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
	 	
	 	
	 	<c:if test="${param.error}">
	 		alert("입력값 오류입니다");
	 	</c:if>
	 	
	 	/* function test() {
            let promise = new Promise((resolve, reject) => {
                if (Math.random() < 0.5) { 
                    return reject("실패") //0.5보다 작으면 '실패'반환
                }
                resolve(10) //성공 시 10을 반환
             });

            promise
                .then(v => console.log(" 성공 : ", v))
                .catch(s => console.log("실패 = ", s));
        }

        test(); */
	 	
	</script>
</body>
</html>