<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
<style>
     header {
    position: fixed;
    top: 10px;
    right: 107px;
  }

  body {
    text-align: center;
    margin: 0;
    /* 기본 여백 제거 */
    padding: 0;
    font-family: sans-serif;
  }

  /* 테이블 스타일 */
  table {
    border-collapse: collapse;
    /* 셀 간 간격 제거 */
    margin: 80px auto 0;
    /* 헤더와 겹치지 않도록 상단 여백을 조금 줌 */
    width: 1000px;
    text-align: left;
  }

  /* 등록 버튼 */
  .comment-input button {
      margin-left: 10px;
      padding: 8px 16px;
      border: 1px solid #ccc;
      background: #f7f7f7;
      cursor: pointer;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<a href="/yj">
    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
      <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4z"/>
    </svg></a>
 <h2 style="text-align: left; padding-left: 270px;">게시물 수정</h2>
  <form id="boardForm" method="post">
    <table>
      <tr>
        <td><input name="bno" id="bno" value="${boardDB.bno}" type="hidden">제목</td>
        <td><input type="text" name="title" id ="title" size="50" value="${boardDB.title}"></td>
        <td style="text-align: right;">작성자 ID: <strong>${boardDB.writer}</strong></td>
        <td>비밀번호<input type="password" name="passwd" id ="passwd"></td>
      </tr>
      <tr>
        <td style="position: fixed;">내용</td>
        <td colspan="2">
          <textarea name="content" id="content" rows="10" cols="80" >${boardDB.content}</textarea>
        </td>
      </tr>
      <tr>
        <td colspan="3">
          <!-- 수정 -->
		  <button type="submit" formaction="update">수정</button>
		  <!-- 삭제 -->
		  <button type="submit" formaction="delete">삭제하기</button>
        </td>
      </tr>
    </table>
   </form>
	
</body>
</html>