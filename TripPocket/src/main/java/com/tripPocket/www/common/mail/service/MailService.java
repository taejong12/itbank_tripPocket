package com.tripPocket.www.common.mail.service;

public interface MailService {
	
	void sendAuthMail(String title, String memberMail, String html);
	
}
