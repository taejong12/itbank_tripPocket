package com.tripPocket.www.member.dao;

import com.tripPocket.www.member.dto.MemberDTO;

public interface MemberDAO {

	void insertMember(MemberDTO memberDTO);

	boolean isMemberIdDuplicated(String memberId);
	
	 MemberDTO login(MemberDTO memberDTO);

}
