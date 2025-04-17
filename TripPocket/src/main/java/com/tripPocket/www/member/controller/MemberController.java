package com.tripPocket.www.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
	      response.setContentType("text/html;charset=utf-8");
	      MemberDTO member = memberService.login(memberDTO);
	      HttpSession session = request.getSession();
	      PrintWriter out = response.getWriter();
	      String contextPath = request.getContextPath();
	      if(member != null ) {
	         session.setAttribute("isLogin",true);
	         session.setAttribute("member", member);
	         out.write("<script>");
	         out.write("alert('로그인에 성공했습니다');");
	         out.write("location.href='" + contextPath + "/main.do';");
	         out.write("</script>");
	      }else {
	         out.write("<script>");
	         out.write("alert('로그인에 실패했습니다');");
	         out.write("location.href='" + contextPath + "/member/loginForm.do';");
	         out.write("</script>");
	      }
	      return null;
	   }

	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public ModelAndView logout(@ModelAttribute() MemberDTO memberDTO, HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("redirect:/");
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
	
	@RequestMapping(value = "memberEmailCheck.do", method = RequestMethod.GET)
	@ResponseBody // 이 메서드가 반환하는 값을 http body로 직접 반환하게 해주는 어노테이션
	public String memberEmailCheck(@RequestParam("memberEmail") String memberEmail) {
		boolean isDuplicated = memberService.isMemberEmailDuplicated(memberEmail); // 아이디 중복값 확인 메서드
		if (isDuplicated) { // 존재여부
			return "DUPLICATED"; // 존재한다
		} else {
			return "OK"; // 존재하지 않는다
		}
	}
	
	@RequestMapping(value = "mypage.do", method = RequestMethod.GET)
	public ModelAndView mypage(@ModelAttribute() MemberDTO memberDTO, HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("/member/mypage");
		return mav;
	}
	
	@RequestMapping(value = "modMember.do", method = RequestMethod.POST)
	public ModelAndView modMember(@ModelAttribute() MemberDTO memberDTO, HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		memberService.modMember(memberDTO);
		MemberDTO member = memberService.update(memberDTO);
		String contextPath = request.getContextPath();
		session.setAttribute("member", member);
		out.write("<script>");
		out.write("alert('변경이 완료되었습니다');");
		out.write("location.href='" + contextPath + "/member/mypage.do';");
		out.write("</script>");
		return null;
	}
	
	@RequestMapping(value = "delMember.do", method = RequestMethod.POST)
	public String delMember(@RequestParam("memberId") String memberId, HttpServletRequest request, HttpServletResponse response) throws IOException {
	    response.setContentType("text/html;charset=utf-8");
	    memberService.delMemberWithDependencies(memberId); // 연관 삭제 포함
	    request.getSession().invalidate();
	    PrintWriter out = response.getWriter();
	    String contextPath = request.getContextPath();
	    out.write("<script>");
	    out.write("alert('탈퇴 완료되었습니다');");
	    out.write("location.href='" + contextPath + "/main.do';");
	    out.write("</script>");
	    return null;
	}
	
	@RequestMapping("/sendMail.do")
	public ResponseEntity<?> sendMail(@RequestParam String memberMail, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		String title = "[Trip Pocket] 인증번호 전송";
		String authCode = createRandomNumber();

		String html = "<html><body>";
		html += "<div>Trip Pocket 인증번호를 안내드립니다.</div><br>";
		html += "<div>인증번호: <h1>"+authCode+"</h1></div><br>";
		html += "<div>감사합니다.</div>";
		html += "</html></body>";
		
		memberService.sendMail(title, memberMail, html);
		
		String msg = "메일이 전송 되었습니다.";
		map.put("result", true);
		map.put("msg", msg);
		
		session.setAttribute("authCode", authCode);
		
		return ResponseEntity.ok(map);
	}
	
	@RequestMapping("/authCodeConfirm.do")
	public ResponseEntity<?> authCodeConfirm(@RequestParam String memberAuthCode, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		String saveCode = (String) session.getAttribute("authCode");
		String msg = null;
		
		if(saveCode != null && saveCode.equals(memberAuthCode)) {
			session.removeAttribute("authCode");
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
	
	public String createRandomNumber() {
	    Random rand = new Random();
	    String numStr = "";
	    for(int i = 0; i < 6; i++) {
	        numStr += Integer.toString(rand.nextInt(10));
	    }
	    return numStr;
	}
}
