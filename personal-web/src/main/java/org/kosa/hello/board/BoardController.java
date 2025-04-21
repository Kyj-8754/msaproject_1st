package org.kosa.hello.board;


import org.kosa.hello.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardService boardService;
	
	// 게시판 등록 페이지 진입
	@RequestMapping("registForm")
		public String registForm() {
			
			return "board/registForm";
		}
	
	// 게시판 등록하기
	@RequestMapping("regist")
	public String regist(@ModelAttribute Board board) {
		
		boardService.registForm(board);
		return "board/list";
	}
	
	// 게시물 삭제 
	@PostMapping("delete")
	public String delete(Model model, @RequestParam int bno, String passwd) {
		Board board =  boardService.getBoard(bno);
		
		if(board.getPasswd() != passwd) {
			model.addAttribute("error","삭제가 불가능 합니다.");
			return "";
		}
		
		
		boardService.delete(bno);
		return "board/list";
	}
	
	// 게시판 목록 진입
	@RequestMapping("list")
	public String list(Model model, String pageNo, String size, String searchValue) {
		
		model.addAttribute("pageResponse",boardService.list(searchValue,
				Util.parseInt(pageNo, 1),
				Util.parseInt(size, 10)
				));
		
		return "board/list";
	}
	
	// 게시판 상세 디테일 
	@RequestMapping("detailView")
	public String detailView(Model model, @RequestParam int bno) {
		boardService.increseView(bno);
		Board boardDB = boardService.getBoard(bno);
		if (boardDB == null) {
			return "redirect:/";
		}
		model.addAttribute("boardDB", boardDB);
		return "board/detailView"; 
		}
	
	// 게시판 수정하기폼
	@RequestMapping("updateForm")
	public String updateForm(@RequestParam int bno, Model model) {
		
		Board boardDB = boardService.getBoard(bno);
		if (boardDB == null) {
			return "redirect:/";
		}
		model.addAttribute("boardDB", boardDB);
		
		return "board/updateForm";
	}
		
	// 게시판 수정
	@PostMapping("update")
	public String update(Board board) {
		
		Board boardDB = boardService.getBoard(board.getBno());
		System.out.println("boardDB" + boardDB.getPasswd() + "board" + board.getPasswd());
		if (!boardDB.getPasswd().equals(board.getPasswd())) {
			
			return "redirect:list";
		}
		
		boardService.update(board);
		
		return "redirect:/board/detailView?bno=" + board.getBno();
	}
	
	// 가상 데이터 만들기
	//테스트 유저 만드는 명령문
//	@RequestMapping("/test")
//	public String registBulk() {
//	    for (int i = 1; i <= 215; i++) {
//	        Board board = new Board();
//	        board.setContent("테스트 내용입니다." + i);
//	        board.setPasswd("1004");
//	        board.setWriter("홍길동" + i);
//	        board.setTitle("테스트 제목입니다." + i);
//	        boardService.registForm(board);
//	    }
//	    return "215명 등록 완료!";
//	}
}
