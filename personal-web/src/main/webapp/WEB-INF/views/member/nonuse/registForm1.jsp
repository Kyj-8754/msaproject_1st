<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body class="container mt-5">
	<a href="./">홈으로</a>
	<form class="needs-validation" action="regist" method="post" novalidate>
        <h1 class="text-center">회원가입</h1>

        <div class="mb-3">
            <label for="userid" class="form-label">아이디</label>
            <input type="text" class="form-control" id="userid" name="userid" required>
            <div class="invalid-feedback">아이디를 입력해주세요.</div>
            
        </div>

        <div class="mb-3">
            <label for="passwd" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="passwd" name="passwd" required>
            <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
        </div>

        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" class="form-control" id="name" name="name" required>
            <div class="invalid-feedback">이름을 입력해주세요.</div>
        </div>

        <div class="mb-3">
            <label for="age" class="form-label">나이</label>
            <input type="number" class="form-control" id="age" name="age" min="1" required>
            <div class="invalid-feedback">유효한 나이를 입력해주세요.</div>
        </div>
			<!-- <input type="email" name="email" placeholder="[선택] 이메일주소 (비밀번호 찾기 등 본인 확인용)" /><br> -->
			<!--  <input type="text" name="birth" placeholder="생년월일 8자리" maxlength="8" /><br> -->

			<!--     <div>
      <select name="hobby">
        <option value="">취미 선택</option>
        <option value="exercise">운동</option>
        <option value="reading">독서</option>
        <option value="game">게임</option>
        <option value="etc">기타</option>
      </select>
    </div> -->
			<!--  <div class="inline-buttons" id="gender">
      <button type="button" data-value="male">남자</button>
      <button type="button" data-value="female">여자</button>
    </div>
    <input type="hidden" name="gender" id="gender-input">

    <input type="hidden" name="nationality" id="nationality-input" value="korean">

    <input type="tel" name="phone" placeholder="휴대전화번호" /> -->

			<div class="mb-3">
            <label class="form-label">[필수] 인증 약관 전체동의</label>
            <!-- 실제 동의 체크박스를 추가해도 좋음 -->
        </div>
		<button type="submit" class="btn btn-primary w-100">인증요청</button>
	</form>
	<script type="text/javascript">
<c:if test="${error}">
	alert("가입할수 없는 아이디 입니다.");
</c:if>

</script>
	<script>
        (() => {
            'use strict'
            window.addEventListener('load', () => {
                const forms = document.querySelectorAll('.needs-validation');
                Array.prototype.slice.call(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            });
        })();
    </script>
</body>
</html>