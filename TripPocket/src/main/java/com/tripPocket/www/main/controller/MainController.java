package com.tripPocket.www.main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.tripPocket.www.member.dto.MemberDTO;

@Controller
public class MainController {

	@RequestMapping(value = {"/","main.do"}, method = RequestMethod.GET)
	public ModelAndView home( HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("main/main");
		HttpSession session = request.getSession();
		Boolean isLogin = (Boolean) session.getAttribute("isLogin"); // 세션에서 값 가져오기
	    MemberDTO member = (MemberDTO) session.getAttribute("member"); // 세션에서 값 가져오기
	    mav.addObject("isLogin",isLogin);
	    mav.addObject("member",member);
		return mav;
	}
}
