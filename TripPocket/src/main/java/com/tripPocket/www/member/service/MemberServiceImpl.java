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
	public MemberDTO login(MemberDTO memberDTO) {
	   		return memberDAO.login(memberDTO);
	}


	@Override
	public boolean isMemberIdDuplicated(String memberId) {
		return memberDAO.isMemberIdDuplicated(memberId);
	}

	@Override
	public void modMember(MemberDTO memberDTO) {
		memberDAO.modMember(memberDTO);
		
	}

	@Override
	public MemberDTO update(MemberDTO memberDTO) {
		return memberDAO.update(memberDTO);
	}

	@Override
	public boolean isMemberEmailDuplicated(String memberEmail) {
		return memberDAO.isMemberEmailDuplicated(memberEmail);
	}

	@Override
	public void delMemberWithDependencies(String memberId) {
		memberDAO.deleteTripShareContentByMemberId(memberId);
		memberDAO.deleteTripShareByMemberId(memberId);
		memberDAO.deleteTripDayByMemberId(memberId);
		memberDAO.deleteTripPlanByMemberId(memberId);
		memberDAO.delMemberById(memberId);
		
	}

	@Override
	public void updateProfileImage(String memberId, String memberProfileImage) {
		memberDAO.updateProfileImage(memberId, memberProfileImage);
	}
	
	
}
