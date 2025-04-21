package org.kosa.hello.member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @Builder
@NoArgsConstructor
public class Member {
	private String userid;
	private String passwd;
	private String name;
	private int age;
	private String loginTime;
	
	
	public boolean isValid() {
		if (userid == null || userid.length() == 0) return false;
		if (passwd == null || passwd.length() == 0) return false;
		if (name == null || name.length() == 0) return false;
		return true;
	}
	
	/*
	 * 1. 테이블 생성
	 * 2. 샘플 데이터 등록
	 * 3. 스프링과 데이터 베이스 연동
	 */
}
