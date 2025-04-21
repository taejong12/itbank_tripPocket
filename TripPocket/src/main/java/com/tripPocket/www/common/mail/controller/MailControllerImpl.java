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
		
		String html = "<html><body style='font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px;'>";
		html += "<div style='max-width: 600px; margin: auto; background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);'>";
		html += "<h2 style='color: #333333;'>Trip Pocket 인증번호 안내</h2>";
		html += "<p style='font-size: 16px; color: #555555;'>아래 인증번호를 입력하여 본인 확인을 완료해주세요.</p>";
		html += "<div style='margin: 30px 0; text-align: center;'>";
		html += "<span style='display: inline-block; padding: 15px 25px; font-size: 24px; background-color: #4CAF50; color: white; border-radius: 6px;'>" + authCode + "</span>";
		html += "</div>";
		html += "<p style='font-size: 14px; color: #999999;'>본 이메일은 발신 전용입니다. 문의가 필요하신 경우 웹사이트를 통해 연락해주세요.</p>";
		html += "<p style='font-size: 14px; color: #999999;'>감사합니다.<br>Trip Pocket 드림</p>";
		html += "</div>";
		html += "</body></html>";
		
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