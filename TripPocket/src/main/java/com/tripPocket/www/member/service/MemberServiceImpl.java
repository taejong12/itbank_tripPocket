package com.tripPocket.www.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tripPocket.www.member.dao.MemberDAO;
import com.tripPocket.www.member.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	public void insertMember(MemberDTO memberDTO) {
		memberDAO.insertMember(memberDTO);
	}

	@Override
	public boolean isMemberIdDuplicated(String memberId) {
		return memberDAO.isMemberIdDuplicated(memberId);
	}
}
