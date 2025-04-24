package org.kosa.hello.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kosa.hello.page.PageResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginService{
	// 인터페이스 자동 상속
	@Autowired
	private LoginDAO loginDAO;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	// 로그인 최대값
	private int max_fail = 5;

	// 로그인
	public LoginResult login(String userid, String passwd) {
		// 회원 정보 받아오기
		Member member = loginDAO.getMember(userid);
		// 회원 정보 판단 여부, 탈퇴한사람은 로그인 불가능
		if (member == null || member.getIs_deleted() == 'Y') {
			return new LoginResult(LoginStatus.NO_USER, null, 0);
		}
		// 회원 차단여부 판단로직
		 if (member.getFail_login() >= max_fail) {
		        return new LoginResult(LoginStatus.FAIL_LOCKED, null, member.getFail_login());
		    }
		 
		// 회원 아이디/비밀번호 검증
		if (!passwordEncoder.matches(passwd, member.getPasswd())) {
			loginDAO.fail_login(userid);
	        int fails = member.getFail_login()+1;
	        return new LoginResult(LoginStatus.FAIL_CREDENTIALS, null, fails);
	    }
		
		//로그인 한시간 기록
		loginDAO.setLoginTime(userid);
		// 로그인 횟수 초기화
	    loginDAO.unban(userid);
	    
	    return new LoginResult(LoginStatus.SUCCESS, member, 0);
	}
	

	// 멤버정보 가져오기
	public Member getMember(String userid) {
		return loginDAO.getMember(userid);
	}
	
	// 멤버 업데이트
	public boolean update(Member member) {
			return loginDAO.update(member) > 0;
	}
	
	
	// 회원 등록
	public int registForm(Member member) {
		return loginDAO.regist(member);
	}
	// 회원 리스트
	public PageResponseVO list(String searchValue, int pageNumber, int size) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNumber-1)*size+1);
		map.put("end", pageNumber * size);
		map.put("searchValue", searchValue);
		
		return new PageResponseVO(
				loginDAO.list(map),
				loginDAO.getTotalCount(map),
				pageNumber,
				size,
				searchValue);
		
	}
	// 회원 삭제
	public boolean delete(String userid) {
		return loginDAO.delete(userid);
	}
	
	//회원 밴처리
	public void ban(String userid) {
		loginDAO.ban(userid);
	}

	//회원 밴해제처리
	public void unban(String userid) {
		loginDAO.unban(userid);
	}
	
}
