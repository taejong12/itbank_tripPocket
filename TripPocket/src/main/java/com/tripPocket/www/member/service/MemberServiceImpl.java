package com.tripPocket.www.member.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.tripPocket.www.member.dao.MemberDAO;
import com.tripPocket.www.member.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private JavaMailSender mailSender;
	
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
	public void sendMail(String title, String memberMail, String html) {
		
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");
			
			messageHelper.setFrom("trippcoket@gmail.com", "Trip Pocket");
			messageHelper.setSubject(title);
			messageHelper.setTo(memberMail);
			messageHelper.setText(html, true);
			
			mailSender.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
