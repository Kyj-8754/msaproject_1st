<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
<c:if test="${error}">
	alert("입력 자료가 부족합니다")
	history.back();
	return;
</c:if>

alert("수정되었습니다");
//메인 화면으로 이동 
location = "./";
</script>
<body>
</body>
</html>