<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f5f5f5;
      margin: 0;
      padding: 20px;
    }

    .container {
      max-width: 600px;
      margin: 0 auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .title {
      text-align: center;
      font-size: 24px;
      margin-bottom: 20px;
    }

    .form-group {
      margin-bottom: 15px;
    }

    .label {
      display: block;
      font-weight: bold;
      margin-bottom: 5px;
    }

    input[type="text"],
    input[type="password"],
    input[type="tel"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
    }

    input[readonly] {
      background-color: #eee;
    }

    .submit {
		margin-left: 10px;
		padding: 8px 16px;
		border: 1px solid #ccc;
		background: #f7f7f7;
		cursor: pointer;
		border-radius: 4px;
    }

    .submit:hover {
      background-color: #2196f3; /* 파란색 hover 효과 */
    }
 header {
      position: fixed;
      top: 10px;
      right: 10px;
    }
  </style>
<script type="text/javascript">
<c:if test="${error}">
alert("입력 자료가 부족합니다")
</c:if>
<c:if test="${errorNotExist}">
alert("수정하려고하시려는 회원이 존재하지 않습니다.\n확인좀 해줘 ~~~~ ")
</c:if>
</script>
</head>
<body>

 <form class="container" action="update" id = "update" method="post">
    <div class="title">회원 정보 수정</div>


    <div class="form-group">
      <label class="label">아이디</label>
      <input type="text" name="userid" id="userid" value="${member.userid}" readonly>
    </div>

    <div class="form-group">
      <label class="label">비밀번호</label>
      <input type="password" name="passwd" id="passwd" placeholder="새 비밀번호 입력">
    </div>

    <div class="form-group">
      <label class="label">이름</label>
      <input type="text" name="name" id="name" value="${member.name}">
    </div>
    
	 <div class="form-group">
      <label class="label">나이</label>
      <input type="text" name="age" id="age" value="${member.age}">
    </div>
	
    <button type="submit" class="submit" id="submit">변경하기</button>
  </form>
  
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
<c:if test="${error}">
	alert("아이디 또는 비밀번호가 잘못되었습니다");
</c:if>
</script>
</body>
</html>