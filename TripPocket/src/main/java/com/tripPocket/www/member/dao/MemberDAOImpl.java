package com.tripPocket.www.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tripPocket.www.member.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertMember(MemberDTO memberDTO) {
	 sqlSession.insert("mapper.member.insertMember", memberDTO);
	}

	 public boolean isMemberIdDuplicated(String memberId) {
        int count = sqlSession.selectOne("mapper.member.isMemberIdDuplicated", memberId);
        return count > 0;
	 }
	 
	 
	 @Override
	 public int login(MemberDTO memberDTO) {
	      
	    return sqlSession.selectOne("mapper.member.login",memberDTO);
	 }

	
}
