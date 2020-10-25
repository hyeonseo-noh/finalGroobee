package com.kh.spring.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.member.model.vo.Follow;
import com.kh.spring.member.model.vo.Member;

@Repository("mDao")
public class MemberDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	public Member loginMember(Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	public int idCheck(String userId) {
		return sqlSession.selectOne("memberMapper.idCheck",userId);
	}

	public int insertMember(Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public String findId(Member m) {
		return sqlSession.selectOne("memberMapper.findId",m);
	}

	public int findPwd(Member m) {
		return sqlSession.update("memberMapper.findPwd",m);
	}

	public int totalMember() {
		return sqlSession.selectOne("memberMapper.totalMember");
	}
	public Member selectOne(String mNo) {
		return sqlSession.selectOne("memberMapper.selectOne",mNo);
	}

	public int disableAccount(int mNo) {
		return sqlSession.update("memberMapper.disableAccount",mNo);
	}

	public int deleteAccount(int mNo) {
		return sqlSession.update("memberMapper.deleteAccount",mNo);
	}

	public Member selectNo(String mId) {
		return sqlSession.selectOne("memberMapper.selectNo",mId);
	}

	public int memberUpdate(Member m) {
		return sqlSession.update("memberMapper.memberUpdate", m);
	}

	public ArrayList<Member> memberSearchList(Member m) {
		return (ArrayList)sqlSession.selectList("memberMapper.memberSearchList", m);
	}

}
