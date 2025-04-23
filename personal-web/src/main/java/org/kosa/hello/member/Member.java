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
	private char is_deleted;
	private String deleted_at;
	private String phone_no;
	private String postcode;
	private String roadaddress;
	private String jibunaddress;
	private String detail_add;
	private int fail_login;
	private String supervisor;
	private String regi_date;
	private String birthdate;
	
	
	public boolean isValid() {
		if (userid == null || userid.length() == 0) return false;
		if (passwd == null || passwd.length() == 0) return false;
		if (name == null || name.length() == 0) return false;
		return true;
	}
}
