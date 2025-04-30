# 📘 Mini Project: 회원 및 게시판 관리 시스템

> **Spring MVC Legacy 기반 웹 애플리케이션**

Spring MVC 아키텍처에 맞춰 회원 관리와 게시판 기능을 구현한 미니 프로젝트입니다. JSP를 기반으로 한 전통적인 MVC2 구조로 프론트와 백엔드를 구성하고, 오라클 DB 및 MyBatis를 통해 안정적인 데이터 관리를 구현했습니다.

---

## 🧱 프로젝트 개요

- 🔧 **아키텍처**: Spring MVC 2 (Legacy)
- 💾 **DBMS**: Oracle DB
- 📂 **ORM 프레임워크**: MyBatis (XML 기반 Mapper)
- 🌐 **프론트엔드**: JSP, HTML, CSS, Bootstrap, JavaScript
- 🔁 **비동기 처리**: `fetch + PATCH` + JSON 기반 REST API 접근
- 🛠 **버전관리 도구**: Git

---

## ✨ 주요 기능

### 👥 회원 파트

- 🔐 로그인 / 로그아웃 / 회원가입
- 📄 회원 목록, 상세 보기 (✅ 페이징 + 검색 기능 포함)
- 🛠 회원 수정, 탈퇴
- 🚫 로그인 실패 시 계정 잠금 처리
- 🧭 **다음 주소 API 연동**으로 주소 입력 간소화
- 🔒 **비밀번호는 Bcrypt를 사용해 해싱 처리하여 보안 유지**
- 🛡 **관리자 전용 기능**:
  - 전체 회원 조회
  - 계정 잠금/해제 기능 제공
  - 세션값에 따른 페이지 동적 분기 처리

### 📝 게시물 파트

- ➕ 게시물 등록 / 수정 / 삭제
- 📃 게시물 목록, 상세 보기 (✅ 페이징 + 검색 기능 포함)
- 👁 조회수 자동 증가 기능 구현
- 🛡 **관리자 전용 정보 노출**: 동일 페이지라도 추가 데이터 표시

---

## 🧩 사용 기술

| 분류 | 기술 |
|------|------|
| 프론트엔드 | HTML, CSS, Bootstrap, JSP, JavaScript, fetch/PATCH |
| 백엔드 | Spring MVC Legacy, MyBatis, REST API |
| 데이터베이스 | Oracle DB |
| ORM | MyBatis (SQL Mapper XML 사용) |
| 보안 | Bcrypt 해시 처리 (회원 비밀번호) |
| 기타 | Daum 주소 API, Git |

---

## 🧠 학습 및 구현 포인트

- JPA 없이 직접 MyBatis로 SQL 매핑 경험
- RESTful API 설계 (`PATCH`, `POST`, `GET`, `DELETE`)
- JavaScript로 JSON 비동기 통신 구현
- 세션 기반 사용자 권한 분기 처리 (관리자 vs 일반 회원)
- 주소 API 연동 경험
- Bcrypt 해싱으로 비밀번호 보안 강화
- Git으로 버전 관리 및 프로젝트 구조화 연습
- ✅ 회원 및 게시판 목록 페이징 처리 + 검색 기능 구현 완료

---

## 🔗 외부 API

- 🧭 [Daum 주소 검색 API](https://postcode.map.daum.net/)

---

## ✅ 실행 방법

1. Oracle DB에 테이블 및 초기 데이터 생성
2. context 설정 또는 application.properties에서 DB 연결 정보 입력
3. STS 또는 Eclipse 환경에서 프로젝트 실행 (Tomcat)
4. 브라우저에서 `http://localhost:8080/yj` 접속하여 기능 확인

---

## 🚀 향후 개선 사항

- Spring Security 기반 로그인 인증 처리
- JPA 기반 ORM으로 전환 및 연관관계 매핑
- 파일 업로드 및 댓글 기능 확장
- 반응형 웹 구현 (Mobile 대응)

