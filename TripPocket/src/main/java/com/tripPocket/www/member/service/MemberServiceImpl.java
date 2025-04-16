package com.tripPocket.www.member.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tripPocket.www.member.dao.MemberDAO;
import com.tripPocket.www.member.dto.MemberDTO;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoEmptyResponseException;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.exception.NurigoUnknownException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.MultipleDetailMessageSentResponse;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class MemberServiceImpl implements MemberService {

	private final DefaultMessageService messageService;	
	
	public MemberServiceImpl() {
		this.messageService = NurigoApp.INSTANCE.initialize(
			// 앱키
            "NCSKWZTGDMVLME8E", 
            // 시크릿키
            "ZXNX1A5BSPQ4SMKLRNGMAG2BCOYH5O2K", 
            "https://api.coolsms.co.kr"
        );
	}
	
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
		
		Message message = new Message();
		// 사전 등록한 발신번호
		message.setFrom("01050607980");
		// 수신번호
        message.setTo(tel);
        
        String code = createRandomNumber();
        message.setText("Trip Pocket [인증번호]: " + code);
        
        SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(message));
        
        map.put("response", response);
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
