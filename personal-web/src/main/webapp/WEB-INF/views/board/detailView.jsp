<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세정보1</title>
  <style>
    /* 우상단에 고정된 헤더 */
    header {
      position: fixed;
      top: 10px;
      right: 10px;
    }
    
    /* 전체를 가운데 정렬 */
    body {
      text-align: center;
      margin: 0; /* 기본 여백 제거 */
      padding: 0;
      font-family: sans-serif;
    }

    /* 테이블 스타일 */
    table {
      border-collapse: collapse; /* 셀 간 간격 제거 */
      margin: 80px auto 0;      /* 헤더와 겹치지 않도록 상단 여백을 조금 줌 */
      width: 1000px;
      border: 1px solid #ccc;   /* 테이블 전체 얇은 선 */
      text-align: left;
    }

    /* 테이블 셀 기본 스타일 */
    td {
      padding: 10px;
      vertical-align: top;
    }

    /* 제목 행에만 2px 굵은 밑줄 */
    .title-row{
      border-bottom: 2px solid gray; 
    }

    /* 댓글 입력 섹션 */
    #comment-section {
      width: 1000px;
      margin: 20px auto;       /* 가운데 배치 */
      border: 1px solid #ddd;  /* 테두리 */
      padding: 10px;
      text-align: left;        /* 내용은 왼쪽 정렬 */
      box-sizing: border-box;  /* padding 포함 계산 */
    }

    /* 작성자 이름 스타일 */
    #comment-section strong {
      display: block;
      margin-bottom: 5px;
      font-size: 16px;
    }

    /* 댓글 입력창과 버튼을 한 줄에 배치 */
    .comment-input {
      display: flex;
      align-items: center;
    }

    /* 댓글 입력 필드 */
    .comment-input input {
      flex: 1;               /* 공간을 가득 채움 */
      border: none;
      outline: none;
      font-size: 14px;
      padding: 8px;
      border-radius: 4px;
      border: 1px solid #ccc;
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

 <h1>게시물 상세</h1>
  <!-- 게시물 테이블 -->
  <table>
    <tr class="title-row">
      <td style="font-size: 26px;">${boardDB.title}</td>
      <td style="text-align: right;">작성자 ID: <strong>${boardDB.writer}</strong></td>
      <td style="text-align: left;">${boardDB.reg_date}</td>
      <td>조회수 : ${boardDB.view_count}</td>
    </tr>
    <tr>
      <td colspan="2">
        <div style="padding: 10px;">
         ${boardDB.content}
        </div>
      </td>
    </tr>
    <tr>
    	<td>
	    	<form action="updateForm" method="post">
	    		<input type="hidden" name="bno" value="${boardDB.bno}">
	    		<button type="submit">수정하기</button>
	    	</form>
    	</td>
    </tr>
  </table>
  
  <!-- 댓글 입력 섹션 -->
  <div id="comment-section">
    <strong>김용진</strong>
    <div class="comment-input">
      <input type="text" placeholder="댓글을 남겨주세요">
      <button>등록</button>
    </div>
  </div>
</body>
</html>