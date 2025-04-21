package org.kosa.hello.member;

import java.util.HashMap;
import java.util.Map;

import org.kosa.hello.page.PageResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService{
	// 인터페이스 자동 상속
	@Autowired
	private LoginDAO loginDAO;
	
	// 로그인 최대값
	private int max_fail = 5;
	
	
//	public Member login(String userid, String passwd) {
//		//2. 아이디를 이용하여 회원 정보를 얻는다(java : Service)   
//		Member member = loginDAO.getMember(userid);
//		//3. 회원 정보가 존재하지 않을 경우(java : Service) -> 아이디 또는 비밀번호가 잘못되었습니다 오류 메시지 출력한다 (Controller에서 설정 후 jsp 출력 )
//		if (member == null) return null;
//		
//		// 회원 차단여부 판단로직
//		if(member.getFail_login() >= max_file){
//			return null;
//		}
//		
//		//4. 회원 정보가 존재할 경우 비밀번호가 맞는지 확인하고 맞지 않으면(java : Service ) -> 아이디 또는 비밀번호가 잘못되었습니다 오류 메시지 출력한다 (Controller에서 설정 후 jsp 출력)
//		boolean result = member.getPasswd().equals(passwd);
//		if (result == false) {
//			loginDAO.fail_login(userid);
//			return null;
//			}
//		
//		//5. 로그인이 성공이면 로그인한 시간을 기록한다(java : Service -> db)
//		loginDAO.setLoginTime(userid);
//
//		return member;
//	}
	
	public LoginResult login(String userid, String passwd) {
		// 회원 정보 받아오기
		Member member = loginDAO.getMember(userid);
		// 회원 정보 판단 여부, 탈퇴한사람은 로그인 불가능
		if (member == null || member.getIs_deleted() == 'Y') {
			return new LoginResult(LoginStatus.NO_USER, null, 0);
		}
		// 회원 차단여부 판단로직
		 if (member.getFail_login()+1 >= max_fail) {
		        return new LoginResult(LoginStatus.FAIL_LOCKED, null, member.getFail_login());
		    }
		 
		// 회원 아이디/비밀번호 검증
		if (!member.getPasswd().equals(passwd)) {
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
	

	
	public Member getMember(String userid) {
		return loginDAO.getMember(userid);
	}
	public Member update(String userid, String passwd, String name, int age) {
		Member member = loginDAO.getMember(userid);
		if (member != null) {
			member.setPasswd(passwd);
			member.setName(name);
			member.setAge(age);
			
			return member;
		}
		return null;
	}

	public Member update(Member member) {
		Member memberDB = loginDAO.getMember(member.getUserid());
		if (memberDB == null) {
			return null;
		}
		loginDAO.update(member);
		return member;
	}

	public int registForm(Member member) {
		return loginDAO.regist(member);
	}

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

	public void delete(String userid) {
		loginDAO.delete(userid);
	}

	
}
