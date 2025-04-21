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
	public void unban(String userid);
	public void delete(String userid);
}
