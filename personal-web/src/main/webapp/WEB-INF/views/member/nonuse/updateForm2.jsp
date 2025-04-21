<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<form action="update2" method="post">
	아이디 : <input type="text" name="userid" value="${member.userid}" readonly="readonly"> <br/>
	비밀번호 : <input type="password" name="passwd" > <br/>
	이름 : <input type="text" name="name" value="${member.name}" > <br/>
	나이: <input type="number" name="age" value="${member.age}"> <br/>
	<input type="submit" value="변경" >
</form>

<script type="text/javascript">
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
</body>
</html>