package com.tripPocket.www.member.service;

import com.tripPocket.www.member.dto.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO memberDTO);

	boolean isMemberIdDuplicated(String memberId);

}
