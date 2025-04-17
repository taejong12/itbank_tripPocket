package com.tripPocket.www.common.mail.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import com.tripPocket.www.common.mail.service.MailService;
import com.tripPocket.www.common.random.AuthCodeRandom;
import com.tripPocket.www.member.dto.MemberDTO;

@Controller
public class MailControllerImpl implements MailContoller{
	
	@Autowired
	private AuthCodeRandom authCodeRandom;
	
	@Autowired
	private MailService mailService;

	@Override
	public ResponseEntity<Map<String, Object>> sendAuthMail(String memberMail, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
				
		String title = "[Trip Pocket] 인증번호 전송";
		String authCode = authCodeRandom.createRandomNumber();

		String html = "<html><body>";
		html += "<div>Trip Pocket 인증번호를 안내드립니다.</div><br>";
		html += "<div>인증번호: <h1>"+authCode+"</h1></div><br>";
		html += "<div>감사합니다.</div>";
		html += "</html></body>";
		
		mailService.sendAuthMail(title, memberMail, html);
		
		String msg = "메일이 전송 되었습니다.";
		map.put("result", true);
		map.put("msg", msg);
		
		session.setAttribute("authCode", authCode);
		
		return ResponseEntity.ok(map);
	}

	@Override
	public ResponseEntity<?> authCodeConfirm(String memberAuthCode, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String saveCode = (String) session.getAttribute("authCode");
		String msg = null;
		
		if(saveCode != null && saveCode.equals(memberAuthCode)) {
			session.removeAttribute("authCode");
			session.setAttribute("authCheck", "true");
			msg = "인증 성공";
			map.put("result", true);
			map.put("msg", msg);
			return ResponseEntity.ok(map);
		} else {
			msg = "인증 실패";
			map.put("result", false);
			map.put("msg", msg);
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(map);
		}
	}

}