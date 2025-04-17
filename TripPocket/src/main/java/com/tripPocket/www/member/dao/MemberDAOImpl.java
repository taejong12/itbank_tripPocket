package com.tripPocket.www.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tripPocket.www.member.dto.MemberDTO;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
@Repository
public class MemberDAOImpl implements MemberDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertMember(MemberDTO memberDTO) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		memberDTO.setMemberPwd(encoder.encode(memberDTO.getMemberPwd()));
		sqlSession.insert("mapper.member.insertMember", memberDTO);
	}

	 public boolean isMemberIdDuplicated(String memberId) {
        int count = sqlSession.selectOne("mapper.member.isMemberIdDuplicated", memberId);
        return count > 0;
	 }
	 
	 
	@Override
	public MemberDTO memberLoginCheck(MemberDTO memberDTO) {
		
		String inputPwd = memberDTO.getMemberPwd();
		
		memberDTO = sqlSession.selectOne("mapper.member.memberLoginCheck", memberDTO);
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		String encodedPwd = memberDTO.getMemberPwd();

		if (encoder.matches(inputPwd, encodedPwd)) {
			return memberDTO;
		} else {
			return null;
		}
	}

	@Override
	public void modMember(MemberDTO memberDTO) {
		sqlSession.update("mapper.member.modMember",memberDTO);
	}

	@Override
	public MemberDTO update(MemberDTO memberDTO) {
		return sqlSession.selectOne("mapper.member.update",memberDTO);
	}

	@Override
	public boolean isMemberEmailDuplicated(String memberEmail) {
		 int count = sqlSession.selectOne("mapper.member.isMemberEmailDuplicated", memberEmail);
	        return count > 0;
	}

	@Override
	public void deleteTripShareContentByMemberId(String memberId) {
	    sqlSession.delete("mapper.member.deleteTripShareContentByMemberId", memberId);
	}

	@Override
	public void deleteTripShareByMemberId(String memberId) {
	    sqlSession.delete("mapper.member.deleteTripShareByMemberId", memberId);
	}

	@Override
	public void deleteTripDayByMemberId(String memberId) {
	    sqlSession.delete("mapper.member.deleteTripDayByMemberId", memberId);
	}

	@Override
	public void deleteTripPlanByMemberId(String memberId) {
	    sqlSession.delete("mapper.member.deleteTripPlanByMemberId", memberId);
	}

	@Override
	public void delMemberById(String memberId) {
	    sqlSession.delete("mapper.member.delMemberById", memberId);
	}

	
}
