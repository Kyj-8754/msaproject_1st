<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세정보</title>
  <style>
     /* 기본 바디 스타일 */
     body {
      background-color: #f9f9f9;
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
    }
    
    /* 우상단 헤더: 홈으로 아이콘 */
    header {
      position: fixed;
      top: 10px;
      right: 10px;
      z-index: 1000;
    }
    
    /* 중앙에 배치할 컨테이너 */
    .container {
      max-width: 600px;          /* 최대 너비 */
      margin: 120px auto 40px;    /* 상단 여백 120px (헤더와 제목 공간 확보), 하단 여백 40px */
      padding: 20px;
      background-color: #fff;
      border: 1px solid #ddd;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      text-align: left;
    }
    
    /* 페이지 제목 */
    h1 {
      text-align: center;
      margin-top: 80px;
      font-size: 28px;
      color: #333;
    }
    
    /* 회원 정보 항목 */
    .member-info div {
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 1px dashed #ccc;
    }
    .member-info div:last-child {
      border-bottom: none;
      margin-bottom: 0;
    }
    
    /* 항목의 제목 (라벨) */
    .member-info strong {
      display: inline-block;
      width: 150px; /* 라벨 폭을 고정하면 정렬이 깔끔해집니다. */
    }
  </style>
</head>
<body>
 <h1>회원 상세보기</h1>
  <div class="container">
    <div class="member-info">
      <div><strong>아이디:</strong> ${memberDB.userid}</div>
      <div><strong>이름:</strong> ${memberDB.name}</div>
      <div><strong>나이:</strong> ${memberDB.age}</div>
      <div><strong>최근로그인일시:</strong> ${memberDB.loginTime}</div>
    </div>
	<a href="/yj">메인으로</a>
	<a href="updateForm?userid=${memberDB.userid}">회원 수정</a>
	<a href="unregister?userid=${memberDB.userid}">회원 탈퇴</a>
  </div>
</body>
</html>