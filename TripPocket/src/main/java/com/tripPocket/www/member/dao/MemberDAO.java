package com.tripPocket.www.member.dao;

import com.tripPocket.www.member.dto.MemberDTO;

public interface MemberDAO {

	void insertMember(MemberDTO memberDTO);

	boolean isMemberIdDuplicated(String memberId);
	 MemberDTO login(MemberDTO memberDTO);

	void modMember(MemberDTO memberDTO);

	MemberDTO update(MemberDTO memberDTO);

	boolean isMemberEmailDuplicated(String memberEmail);

	void deleteTripShareContentByMemberId(String memberId);

	void deleteTripShareByMemberId(String memberId);

	void deleteTripDayByMemberId(String memberId);

	void deleteTripPlanByMemberId(String memberId);

	void delMemberById(String memberId);

	void updateProfileImage(String memberId, String memberProfileImage);


}
