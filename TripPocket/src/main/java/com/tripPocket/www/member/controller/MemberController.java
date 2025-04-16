package com.tripPocket.www.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

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
	
	@RequestMapping("/sendSms.do")
	public ResponseEntity<?> sendSms(@RequestParam String tel, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map = memberService.sendSms(tel);
		
		session.setAttribute("code", map.get("code"));
		session.setAttribute("codeTime", System.currentTimeMillis());
		
		return ResponseEntity.ok(true);
	}
	
	@RequestMapping("/codeDiff.do")
	public ResponseEntity<?> codeDiff(@RequestParam String memberCode, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		String saveCode = (String) session.getAttribute("code");
		
		Long time = (Long) session.getAttribute("codeTime");
		
		// 3분 타이머
		if(System.currentTimeMillis() - time > 180_000) {
			map.put("result", "인증번호 만료");
			return ResponseEntity.status(HttpStatus.GONE).body(map);
		}
		
		if(saveCode != null && saveCode.equals(memberCode)) {
			session.removeAttribute("code");
			map.put("result", true);
			return ResponseEntity.ok(map);
		} else {
			map.put("result", false);
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(map);
		}
	}
}
