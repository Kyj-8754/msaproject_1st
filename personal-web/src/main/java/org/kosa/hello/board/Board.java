package org.kosa.hello.board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @Builder
@NoArgsConstructor
public class Board {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private String passwd;
	private String reg_date;
	private int view_count;
	
	
//	public boolean isValid() {
//		if (userid == null || userid.length() == 0) return false;
//		if (passwd == null || passwd.length() == 0) return false;
//		if (name == null || name.length() == 0) return false;
//		return true;
//	}
	
}
