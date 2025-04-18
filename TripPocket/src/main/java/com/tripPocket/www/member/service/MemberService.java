package com.tripPocket.www.member.service;

import java.util.List;

import com.tripPocket.www.member.dto.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO memberDTO);

	boolean isMemberIdDuplicated(String memberId);
	
	MemberDTO memberLoginCheck(MemberDTO memberDTO);

	void modMember(MemberDTO memberDTO);

	MemberDTO update(MemberDTO memberDTO);

	boolean isMemberEmailDuplicated(String memberEmail);

	void delMemberWithDependencies(String memberId);

	int findMemberNameAndEmail(MemberDTO memberDTO);

	List<MemberDTO> selectIdListByEmailAndName(MemberDTO memberDTO);

	int findMemberIdAndEmail(MemberDTO memberDTO);

	String selectMemberId(MemberDTO memberDTO);

	int updateMemberPwd(MemberDTO memberDTO);

	MemberDTO selectMember(String memeberId);
	
}
