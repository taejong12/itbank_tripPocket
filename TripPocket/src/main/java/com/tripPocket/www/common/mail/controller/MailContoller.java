package com.tripPocket.www.common.mail.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;

public interface MailContoller {

	ResponseEntity<Map<String, Object>> sendAuthMail(String memberMail, HttpSession session);

	ResponseEntity<?> authCodeConfirm(String memberAuthCode, HttpSession session);
}
