package com.tripPocket.www.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.member.service.MemberService;

import net.coobird.thumbnailator.Thumbnails;

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
	
	@RequestMapping(value = "uploadProfileImage.do", method = RequestMethod.POST)
	@ResponseBody
	public String uploadProfileImage(@RequestParam("profileImage") MultipartFile profileImage, 
	                                 HttpSession session, HttpServletRequest request) throws Exception {
	    // 로그인 유저 정보 가져오기
	    MemberDTO member = (MemberDTO) session.getAttribute("member");

	    // 기본 경로 + memberId 디렉토리 생성
	    String basePath = request.getSession().getServletContext().getRealPath("/resources/img/profile/");
	    String memberFolder = member.getMemberId();  // 사용자 ID로 폴더 분리
	    String uploadPath = basePath + File.separator + memberFolder;

	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs();  // 사용자별 폴더 생성
	    }

	    // 원본 이미지 파일 이름과 확장자 추출
	    String originalFileName = profileImage.getOriginalFilename();
	    String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
	    
	    // 확장자를 포함한 새로운 파일 이름 생성
	    String fileName = UUID.randomUUID().toString() + extension;
	    File dest = new File(uploadPath + File.separator + fileName);
	    
	    try {
	        // 파일을 임시로 저장 (리사이즈 작업을 위해 먼저 업로드)
	        profileImage.transferTo(dest);

	        // 리사이즈된 이미지 저장 경로 설정
	        File resizedFile = new File(uploadPath + File.separator + "resized_" + fileName);

	        // 리사이즈 처리 (예: 200x200 크기)
	        Thumbnails.of(dest)  // 원본 이미지
	                .size(100, 100)  // 원하는 크기로 리사이즈
	                .outputFormat("png")  // 출력 포맷 (선택)
	                .toFile(resizedFile);  // 리사이즈된 이미지 저장

	        // 원본 이미지 파일 삭제 (필요한 경우)
	        if (dest.exists() && !dest.delete()) {
	            // 삭제 실패시 로그 출력
	            System.err.println("원본 이미지 삭제 실패: " + dest.getAbsolutePath());
	        }

	    } catch (IOException e) {
	        // 업로드 실패 시 로그 출력 및 메시지 반환
	        e.printStackTrace();
	        return "<script>alert('파일 업로드에 실패했습니다.\n다시 시도해주세요.');</script>";
	    }

	    // DB에 상대 경로만 저장 (예: hong123/resized_uuid_image.jpg)
	    String savedPath = memberFolder + "/" + "resized_" + fileName;
	    member.setMemberProfileImage(savedPath);
	    memberService.updateProfileImage(member.getMemberId(), savedPath);

	    // 세션 갱신
	    session.setAttribute("member", member);

	    return savedPath;
	}



	@RequestMapping(value = "resetProfileImage.do", method = RequestMethod.POST)
	@ResponseBody
	public String resetProfileImage(HttpSession session, HttpServletRequest request) {
	    // 세션에서 로그인한 사용자 가져오기
	    MemberDTO member = (MemberDTO) session.getAttribute("member");

	    // 사용자 디렉토리 경로
	    String basePath = request.getSession().getServletContext().getRealPath("/resources/img/profile/");
	    String memberFolder = member.getMemberId();  // 사용자 ID로 폴더 분리
	    String uploadPath = basePath + File.separator + memberFolder;

	    File uploadDir = new File(uploadPath);
	    if (uploadDir.exists()) {
	        // 기존 이미지 삭제 (기본 이미지 제외)
	        File[] files = uploadDir.listFiles();
	        if (files != null) {
	            for (File file : files) {
	                if (!file.getName().equals("basic.png")) {
	                    if (file.exists() && file.delete()) {
	                        System.out.println(file.getName() + " 삭제됨");  // 삭제된 파일 로그 출력
	                    } else {
	                        System.out.println(file.getName() + " 삭제 실패");  // 삭제 실패 로그 출력
	                    }
	                }
	            }
	        }

	        // 폴더 삭제 (비어 있으면 삭제)
	        if (uploadDir.listFiles().length == 0 && uploadDir.delete()) {
	            System.out.println(memberFolder + " 폴더 삭제됨");  // 폴더 삭제 로그 출력
	        }
	    }

	    // 기본 이미지로 복원
	    member.setMemberProfileImage("basic.png");
	    memberService.updateProfileImage(member.getMemberId(), "basic.png");  // DB에 기본 이미지 저장

	    // 세션 갱신
	    session.setAttribute("member", member);

	    return "basic.png";  // 기본 이미지 파일명 반환
	}


}
