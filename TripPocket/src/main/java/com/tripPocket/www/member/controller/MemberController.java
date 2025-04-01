package com.tripPocket.www.member.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.member.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "loginForm.do", method = RequestMethod.GET)
	public String loginForm() {
		return "member/loginForm";
	}
	
	@RequestMapping(value = "joinForm.do", method = RequestMethod.GET)
	public String joinForm() {
		return "member/joinForm";
	}
	
	@RequestMapping(value = "join.do", method = RequestMethod.POST)
	public String join(@ModelAttribute MemberDTO memberDTO) {
		memberService.insertMember(memberDTO);
		return "redirect:/main.do";
	}
	
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	   public ModelAndView login(@ModelAttribute() MemberDTO memberDTO, HttpServletRequest request,HttpServletResponse response) throws Exception {
	      
	      PrintWriter out = response.getWriter();
	      response.setContentType("text/html;charset=utf-8");
	      int result = memberService.login(memberDTO);
	      HttpSession session = request.getSession();
	      if(result == 1 ) {
	         session.setAttribute("isLogin",true);
	         session.setAttribute("member", memberDTO);
	         
	         out.write("<script>");
	         out.write("alert('로그인에 성공했습니다');");
	         out.write("location.href='/www/main.do';");
	         out.write("</script>");
	      }else {
	         out.write("<script>");
	         out.write("alert('로그인에 실패했습니다');");
	         out.write("location.href='/www/member/loginForm.do';");
	         out.write("</script>");
	      }
	      return null;
	   }

	   @RequestMapping(value = "logout.do", method = RequestMethod.GET)
	   public ModelAndView logout(@ModelAttribute() MemberDTO memberDTO, HttpServletRequest request,HttpServletResponse response) {
	      ModelAndView mav = new ModelAndView("redirect:/member/loginForm.do");
	      HttpSession session = request.getSession();
	      session.invalidate();
	      return mav;
	   }
	
	@RequestMapping(value = "memberIdCheck.do", method = RequestMethod.GET)
	@ResponseBody // 이 메서드가 반환하는 값을 http body로 직접 반환하게 해주는 어노테이션
	public String memberIdCheck(@RequestParam("memberId") String memberId) {
		boolean isDuplicated = memberService.isMemberIdDuplicated(memberId); // 아이디 중복값 확인 메서드
		if (isDuplicated) { // 존재여부
			return "DUPLICATED"; // 존재한다
		} else {
			return "OK"; // 존재하지 않는다
		}
	}
	
}
