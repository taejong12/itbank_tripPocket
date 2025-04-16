package com.tripPocket.www.member.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

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
	public Map<String, Object> sendSms(String tel) {
		
		Map<String, Object> map = new HashMap<String, Object>();
        
        String code = createRandomNumber();
        
        map.put("code", code);
        
        return map; 
	}
	
	public String createRandomNumber() {
	    Random rand = new Random();
	    String numStr = "";
	    for(int i = 0; i < 6; i++) {
	        numStr += Integer.toString(rand.nextInt(10));
	    }
	    return numStr;
	}
}
