package org.kosa.hello.member;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kosa.hello.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("member")
public class MemberController {

	@Autowired
	LoginService loginService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
		// 회원 가입 동기
		@RequestMapping("regist")
		public String regist(@ModelAttribute Member member) {
			if(!member.isValid()) {
				return "redirect:member/registForm?error=true";
			}
			
			loginService.registForm(member);
			return "redirect:/";
		}
		
		// 유저 가입
		// 비동기 처리
		// json으로 받은 값 rest api로 처리
		@PostMapping("postregi")
		@ResponseBody
		public boolean postRegist(@RequestBody Member member) {
			String raw = member.getPasswd();
		    String hash = passwordEncoder.encode(raw);
		    member.setPasswd(hash);
			
			int result = loginService.registForm(member);
			System.out.println("insert 결과: " + result);
			return result == 1;
		}
		
		//아이디 찾는로직
//		@RequestMapping("")
//		public String findID() {
//			
//		}
		
		//비밀번호 찾는 로직
		
		


		// 로그인 처리
		@PostMapping("login")
		@ResponseBody
		public Map<String, Object> login(@RequestBody Member member, HttpSession session) {
			LoginResult member_result = loginService.login(member.getUserid(), member.getPasswd());
			Map<String, Object> result = new HashMap<String, Object>();
			int MAX_FAILS = 5;
			
			switch (member_result.getStatus()) {
		      case SUCCESS:
		        session.setAttribute("member", member_result.getMember());
		        result.put("status", "SUCCESS");
		        break;
		      case NO_USER:
		        result.put("status", "NO_USER");
		        result.put("message", "등록된 회원이 아닙니다.");
		        break;
		      case FAIL_CREDENTIALS:
		        result.put("status", "FAIL_CREDENTIALS");
		        result.put("message", String.format(
		          "비밀번호 %d회 실패, %d회 남았습니다.",
		          member_result.getFailCount(), MAX_FAILS - member_result.getFailCount()
		        ));
		        break;
		      case FAIL_LOCKED:
		        result.put("status", "FAIL_LOCKED");
		        result.put("message", "계정이 잠금되었습니다.");
		        break;
		    }
			
			return result;
		}
		
		
		// 유저 디테일
		@RequestMapping("detailView")
		public String detailView(Model model, String userid, HttpSession session) {
			
			Member SessionMember = (Member)session.getAttribute("member");
			
			 
			Member memberDB = loginService.getMember(userid);
			if (memberDB == null) {
				return "redirect:/";
			}
			model.addAttribute("memberDB", memberDB);
			model.addAttribute("SessionMember", SessionMember);
			return "member/detailView"; 
			}
		
		
		// 유저 업데이트 폼으로 넘어가기
		@RequestMapping("updateForm")
		public String updateForm(Model model, String userid, HttpSession session) {
			
			//1. 입력값 검증 (java : Controller)
			if (userid == null || userid.length() == 0) {
				//jsp로 오류 메시지 출력 
//				model.addAttribute("error", true);
				return "redirect:/";  
			}
			
			Member member = loginService.getMember(userid);
			if (member == null) {
				//jsp로 오류 메시지 출력 
//				model.addAttribute("error", true);
				return "redirect:/";  
			}
			
			model.addAttribute("member", member);
			return "member/updateForm";
			}
		
		
		//유저 업데이트
		@PostMapping("update")
		@ResponseBody
		public Map<String, Object> update(@RequestBody Member member, HttpSession session){
			Map<String, Object> result = new HashMap<String, Object>();
			System.out.println(member);
			if (member.getUserid() == null || member.getUserid().length() == 0 
				|| member.getPasswd() == null || member.getPasswd().length() == 0 
				|| member.getName() == null || member.getName().length() == 0) 
				{
					//jsp로 오류 메시지 출력 
						result.put("error", true);
				}
			
			Member memberInfo = loginService.update(member);
				result.put("error", memberInfo == null);
			
			session.setAttribute("member", memberInfo);
			return result;
			}
	
		

			// userid 중복확인
			@PostMapping("isExistUserId")
		    @ResponseBody
		    public Map<String, Object> isExistUserId(@RequestBody Member member) {
				Map<String, Object> map = new HashMap<String, Object>();
				log.info("member ->" + member);
				Member memberInfo = loginService.getMember(member.getUserid());
				
				map.put("existUserId", memberInfo != null);
				
				return map;
		    }
			
			
			// 유저 삭제
			@RequestMapping("unregister")
			public String delete(HttpSession session) {
				Member member =  (Member)session.getAttribute("member");
				if(member != null) {
				loginService.delete(member.getUserid());
				session.invalidate();
				}
				return "redirect:/";
			}
			
			
			// 유저 리스트
			@RequestMapping("list")
			public String list(Model model, String pageNo, String size, String searchValue) {
				
				model.addAttribute("pageResponse",loginService.list(searchValue,
						Util.parseInt(pageNo, 1),
						Util.parseInt(size, 10)
						));
				return "member/list";
			}
			
			//유저 밴처리
			@PostMapping("ban")
			@ResponseBody
			public Map<String, Object> ban(HttpSession session, 
					@RequestBody Map<String, String> memberban){
				Map<String, Object> result = new HashMap<String, Object>();
				 Member admin = (Member) session.getAttribute("member");
				 // 세션에 관리자 판단 여부 로직
				if (admin == null || !admin.getSupervisor().equals("Y")) {
					result.put("success",false);
					result.put("message", "관리자 권한이 필요합니다.");
					return result;
			    }
				
				// 회원 DB
				// 1. 유저 상태 조회
			    Member targetUser = loginService.getMember(memberban.get("userid"));
			    if (targetUser == null) {
			        result.put("success", false);
			        result.put("message", "해당 유저가 존재하지 않습니다.");
			        return result;
			    }
				// 회원 밴 처리
			    if(memberban.get("banned").equals("Y")) {
			    	loginService.ban(memberban.get("userid"));
			    	result.put("success", true);
			    	result.put("message", "해당 유저 밴 처리에 성공하였습니다.");
			    }else if(memberban.get("banned").equals("N")) {
			    	loginService.unban(memberban.get("userid"));
			    	result.put("success", true);
			    	result.put("message", "해당 유저 해제 처리에 하였습니다.");
			    }
			    else{
			    	result.put("success", false);
			    	result.put("message", "알 수 없는 오류로 처리 실패했습니다.");
			    }
				
				return result;
				}
			
				
		
}
