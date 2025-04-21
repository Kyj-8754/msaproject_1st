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
		<input type="submit" value="회원가입"> 
		<input type="reset" value="초기화"><br />
	</form>
	<script type="text/javascript">
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
				const age = document.querySelector("#age").value;
				
				
				/*
				다른 방식
				const param = {
					passwd : registerForm.passwd.value;
					userid : registerForm.userid.value;
					// name은 제대로 안받는다고 한다(정말인지 확인 필요)
					name : document.querySelector("#name").value;
					age : registerForm.age.value;	
				}
				*/
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
			  body: JSON.stringify({userid, passwd, name, age})
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