package org.kosa.hello;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;


/**
 * Handles requests for the application home page.
 */
@Controller 
@Slf4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	// 홈
	@RequestMapping("/") // GET/POST
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	// 로그인 페이지로
	@RequestMapping("member/loginForm")
	public String loginForm() {
		
		return "member/loginForm";
	}
	
	// 회원 가입 페이지로
	@RequestMapping("member/registForm")
	public String registForm() {
		
		return "member/registForm";
	}

	//로그 아웃
	@RequestMapping("member/logout")
	public String logout(HttpSession session) {
		//세션에 기록된 정보를 모두 제거한다 
		session.invalidate();
		
		return "redirect:/";
	}
}
