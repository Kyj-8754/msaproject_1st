package org.kosa.hello.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosa.hello.page.PageResponseVO_board;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService{
	// 인터페이스 자동 상속
	@Autowired
	private BoardDAO boardDAO;

	
	// 보드 디테일 가져오기
	public Board getBoard(int bno) {
		
		return boardDAO.getBoard(bno);
	}
	
	// 조회수 1 증가하기
	public int increseView(int bno) {
		return boardDAO.increseView(bno);
	};
	
	// 보드 등록하기
	public int registForm(Board board) {
		return boardDAO.regist(board);
	}
	
	// 보드 삭제 명령문
	public int delete(int bno) {
		return boardDAO.delete(bno);
	}
	
	// 보드 수정 명령문
		public void update(Board board) {
			boardDAO.update(board);
		}

		
	public PageResponseVO_board list(String searchValue, int pageNumber, int size) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNumber-1)*size+1);
		map.put("end", pageNumber * size);
		map.put("searchValue", searchValue);
		return new PageResponseVO_board(
				boardDAO.list(map),
				boardDAO.getTotalCount(map),
				pageNumber,
				size,
				searchValue);
	}

public PageResponseVO_board list_admin(String searchValue, int pageNumber, int size) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNumber-1)*size+1);
		map.put("end", pageNumber * size);
		map.put("searchValue", searchValue);
		return new PageResponseVO_board(
				boardDAO.list_admin(map),
				boardDAO.getTotalCount(map),
				pageNumber,
				size,
				searchValue);
	}
	

//	public int getTotalCount() {
//		return loginDAO.getTotalCount();
//	}

	
}
