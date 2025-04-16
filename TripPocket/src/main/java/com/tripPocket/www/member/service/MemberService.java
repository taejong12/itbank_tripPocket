package com.tripPocket.www.member.service;

import java.util.Map;

import com.tripPocket.www.member.dto.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO memberDTO);

	boolean isMemberIdDuplicated(String memberId);
	
	MemberDTO login(MemberDTO memberDTO);

	void modMember(MemberDTO memberDTO);

	MemberDTO update(MemberDTO memberDTO);

	boolean isMemberEmailDuplicated(String memberEmail);

	void delMemberWithDependencies(String memberId);

	Map<String, Object> sendSms(String tel);

}
