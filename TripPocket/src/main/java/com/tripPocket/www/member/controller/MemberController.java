package com.tripPocket.www.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tripPocket.www.common.mail.controller.MailContoller;
import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.member.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MailContoller mailContoller;
	
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
	
	@RequestMapping(value = "memberLoginCheck.do", method = RequestMethod.POST)
	public String memberLoginCheck(@ModelAttribute MemberDTO memberDTO, HttpSession session, Model model, HttpServletResponse response) throws Exception {
		MemberDTO member = memberService.memberLoginCheck(memberDTO);

		if(member != null) {
			session.setAttribute("isLogin", true);
			session.setAttribute("member", member);
			
			if ("on".equals(memberDTO.getLoginKeep())) {
				Cookie loginCookie = new Cookie("loginKeep", member.getMemberId());
				loginCookie.setMaxAge(60 * 60 * 24 * 7);
				loginCookie.setPath("/");
				response.addCookie(loginCookie);
			}
			
			return "redirect:/";
		}else {
			model.addAttribute("loginFail", "fail");
			return "member/loginForm";
		}
	}

	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public ModelAndView logout(@ModelAttribute() MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("redirect:/");
		HttpSession session = request.getSession();
		session.invalidate();
		
	    Cookie loginCookie = new Cookie("loginKeep", null);
	    loginCookie.setMaxAge(0);
	    loginCookie.setPath("/");
	    response.addCookie(loginCookie);
		
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
	
	@RequestMapping("/sendAuthMail.do")
	public ResponseEntity<?> sendAuthMail(@RequestParam String memberMail, HttpSession session){
		return mailContoller.sendAuthMail(memberMail, session);
	}
	
	@RequestMapping("/authCodeConfirm.do")
	public ResponseEntity<?> authCodeConfirm(@RequestParam String memberAuthCode, HttpSession session){
		return mailContoller.authCodeConfirm(memberAuthCode, session);
	}
	
	@RequestMapping("/findIdForm.do")
	public String findIdForm(){
		return "member/findIdForm";
	}
	
	@RequestMapping("/sendFindIdAuthMail.do")
	public ResponseEntity<?> sendFindIdAuthMail(@ModelAttribute MemberDTO memberDTO, HttpSession session){
		int result = memberService.findMemberNameAndEmail(memberDTO);
		
		if(result > 0) {
			return mailContoller.sendAuthMail(memberDTO.getMemberEmail(), session);
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("result", false);
			map.put("msg", "이메일이 존재하지 않습니다.");
			return ResponseEntity.ok(map);
		}
	}
	
	@RequestMapping("/findIdList.do")
	public String findIdList(@ModelAttribute MemberDTO memberDTO, Model model, HttpSession session){
		String authCheck = (String) session.getAttribute("authCheck");
		
		if(authCheck != "true" || authCheck == null || memberDTO == null) {
			return "redirect:/member/loginForm.do";
		}
		
		List<MemberDTO> memberList = memberService.selectIdListByEmailAndName(memberDTO);
		model.addAttribute("memberList", memberList);
		
		session.removeAttribute("authCheck");
		
		return "member/memberIdList";
	}
	
	@RequestMapping("/findPwdForm.do")
	public String findPwdForm(){
		return "member/findPwdForm";
	}
	
	@RequestMapping("/sendFindPwdAuthMail.do")
	public ResponseEntity<?> sendFindPwdAuthMail(@ModelAttribute MemberDTO memberDTO, HttpSession session){
		int result = memberService.findMemberIdAndEmail(memberDTO);
		
		if(result > 0) {
			return mailContoller.sendAuthMail(memberDTO.getMemberEmail(), session);
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("result", false);
			map.put("msg", "이메일이 존재하지 않습니다.");
			return ResponseEntity.ok(map);
		}
	}
	
	@RequestMapping("/findPwd.do")
	public String findPwd(@ModelAttribute MemberDTO memberDTO, Model model, HttpSession session){
		String authCheck = (String) session.getAttribute("authCheck");
		
		if(authCheck != "true" || authCheck == null || memberDTO == null) {
			return "redirect:/member/loginForm.do";
		}
		
		String memberId = memberService.selectMemberId(memberDTO);
		model.addAttribute("memberId", memberId);
		
		session.removeAttribute("authCheck");
		session.setAttribute("pwdUpdateAuth", "true");
		
		return "member/pwdUpdateForm";
	}
	
	@RequestMapping("/pwdUpdate.do")
	public String pwdUpdate(@ModelAttribute MemberDTO memberDTO, Model model, HttpSession session){
		String pwdUpdateAuth = (String) session.getAttribute("pwdUpdateAuth");
		System.out.println("pwdUpdate.do: " + pwdUpdateAuth);
		if(pwdUpdateAuth != "true" || pwdUpdateAuth == null || memberDTO == null) {
			return "redirect:/member/loginForm.do";
		}
		
		int result = memberService.updateMemberPwd(memberDTO);
		
		String updateCheck = null;
		
		if(result > 0) {
			updateCheck = "true";
		}
		
		session.removeAttribute("pwdUpdateAuth");
		model.addAttribute("updateCheck", updateCheck);
		
		return "member/pwdUpdateComplete";
	}
	
	@RequestMapping("/loginKeep.do")
	public String cookieLoginKeep(HttpSession session, HttpServletResponse response) {
		String memeberId = (String) session.getAttribute("memebrId");
		
		if(memeberId == null || memeberId == "") {
			return "redirect:/";
		}
		
		MemberDTO memberDTO = memberService.selectMember(memeberId);
		
		if(memberDTO == null) {
			session.invalidate();
		    Cookie loginCookie = new Cookie("loginKeep", null);
		    loginCookie.setMaxAge(0);
		    loginCookie.setPath("/");
		    response.addCookie(loginCookie);
			return "redirect:/";
		}
		
		session.setAttribute("isLogin", true);
		session.setAttribute("member", memberDTO);
		session.removeAttribute("memebrId");
		
		return "redirect:/";
	}
}
