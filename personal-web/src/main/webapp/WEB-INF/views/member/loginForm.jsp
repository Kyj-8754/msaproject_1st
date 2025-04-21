<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 창</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <style>
	header {
		position: fixed;
		top: 10px;
		right: 10px;
	}
    body {
      background-color: #f8f9fa;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }

    .login-container {
      width: 100%;
      max-width: 400px;
      padding: 30px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .btn-login {
      width: 100%;
      padding: 10px;
      background-color: #6c757d;
      color: white;
      border: none;
      border-radius: 5px;
      transition: background-color 0.3s ease;
    }

    .btn-login:hover {
      background-color: #0d6efd; /* 파란색 hover */
    }
  </style>
</head>
<body>

<div class="login-container">
    <h3 class="text-center mb-4">로그인</h3>
    <form action="login" id = "login" method="post">
      <div class="mb-3">
        <label for="userid" class="form-label">아이디</label>
        <input type="text" class="form-control" id="userid" name="userid" value="${param.userid}" required>
      </div>
      <div class="mb-3">
        <label for="passwd" class="form-label">비밀번호</label>
        <input type="password" class="form-control" id="passwd" name="passwd" required>
      </div>
      <input type="submit" class="btn-login" value="로그인">
    </form>
  </div>
  
<%-- <form action="login">
 아이디 : <input type="text" name = "userid" value="${param.userid}"><br/>
 비밀번호 : <input type="password" name = "passwd"><br/>
	<input type="submit" value="로그인">
</form> --%>
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
	  body: JSON.stringify({userid : userid.value, passwd : passwd.value})
	})
	  .then(response => {return response.json()})
	  .then(json => {
		  if(json.error){
			  alert("값 입력을 확인해 주세요");
			  userid.value = "";
			  passwd.value = "";
			  userid.focus();
		  }else{
			  alert("로그인 되었습니다.")
			  // location = "./"; //상대경로
			  // location = "/sts3/"; //절대경로
			   const contextPath = "${pageContext.request.contextPath}";
 			location= contextPath + "/";  // 또는 원하는 경로
		  }
		  console.log('POST요청결과:', json) 
	  })
		 		});
<c:if test="${error}">
	alert("아이디 또는 비밀번호가 잘못되었습니다");
</c:if>
</script> 
</body>
</html>