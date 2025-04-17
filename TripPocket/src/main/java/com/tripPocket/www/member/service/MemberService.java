package com.tripPocket.www.member.service;

import com.tripPocket.www.member.dto.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO memberDTO);

	boolean isMemberIdDuplicated(String memberId);
	
	MemberDTO memberLoginCheck(MemberDTO memberDTO);

	void modMember(MemberDTO memberDTO);

	MemberDTO update(MemberDTO memberDTO);

	boolean isMemberEmailDuplicated(String memberEmail);

	void delMemberWithDependencies(String memberId);

}
