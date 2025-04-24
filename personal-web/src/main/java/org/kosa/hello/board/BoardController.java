package org.kosa.hello.board;


import java.util.HashMap;
import java.util.Map;

import org.kosa.hello.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@PostMapping("regist")
	@ResponseBody
	public Map<String, Object> regist(@RequestBody Board board) {
		Map<String, Object> result = new HashMap<String, Object>();
		boardService.registForm(board);
		
		result.put("error", false);
		result.put("message", "게시물 등록을 완료했습니다.");
		return result;
	}
	
	
	
	// 게시물 삭제 
	@PostMapping("delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestBody Board board) {
		Map<String, Object> result = new HashMap<String, Object>();
		Board boardDB =  boardService.getBoard(board.getBno());
		
		if(!boardDB.getPasswd().equals(board.getPasswd())) {
			result.put("error", true);
			result.put("message", "게시물 비밀번호가 다름니다.");
			return result;
		}
		
		boardService.delete(board.getBno());
		result.put("error", false);
		result.put("message", "게시물 삭제 완료했습니다.");
		
		
		return result;
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
	@ResponseBody
	public Map<String, Object> update(@RequestBody Board board) {
		Map<String, Object> result = new HashMap<String, Object>();
		Board boardDB = boardService.getBoard(board.getBno());
		
		if (!boardDB.getPasswd().equals(board.getPasswd())) {
			result.put("error", true);
			result.put("message", "게시물 비밀번호가 다름니다.");
			return result;
		}
		
		boardService.update(board);
		result.put("error", false);
		result.put("message", "게시물 수정 완료했습니다.");
		
		return result;
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
