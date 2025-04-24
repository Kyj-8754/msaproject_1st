package org.kosa.hello.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

// DB연동 SQL
@Mapper
public interface LoginDAO {
	
	public Member getMember(String userid);
	public void setLoginTime(String userid);
	public int update(Member member);
	public int regist(Member member);
	public List<Member> list(Map<String, Object> map);
	public int getTotalCount(Map<String, Object> map);
	public int fail_login(String userid);
	public int unban(String userid);
	public boolean ban(String userid);
	public boolean delete(String userid);
}
