package com.tripPocket.www.tripPlan.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripPlan.service.TripPlanService;

@Controller
@RequestMapping("/trip")
public class TripPlanController {
	
	@Autowired
	private TripPlanService tripPlanService;
	
	@RequestMapping("/planList.do")
	public String planListPage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		
		if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return "redirect:/member/loginForm.do"; // 로그인 페이지로 이동
	    }
		
		List<TripPlanDTO> tripPlanList = tripPlanService.selectPlanList(memberDTO.getMemberId());
		model.addAttribute("tripPlanList", tripPlanList);
		return "tripplan/planList";
	}
	
	@RequestMapping("/planDateSet.do")
	public String planDateSettingPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		
		if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return "redirect:/member/loginForm.do"; // 로그인 페이지로 이동
	    }
		return "tripplan/dateSetting";
	}
	
	@RequestMapping("/insertPlanDateSet.do")
	public String insertPlanDateSet(@ModelAttribute TripPlanDTO tripPlanDTO, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		
		if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return "redirect:/member/loginForm.do"; // 로그인 페이지로 이동
	    }
		
		tripPlanDTO.setMemberId(memberDTO.getMemberId());
		tripPlanService.insertPlanDateSet(tripPlanDTO);
		
		return "redirect:/trip/planList.do";
	}
	
	@RequestMapping("/planDetail.do")
	public String planDetailPage(@RequestParam("tripPlanId") Integer tripPlanId, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		
		if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return "redirect:/member/loginForm.do"; // 로그인 페이지로 이동
	    }
		
		TripPlanDTO tripPlanDTO = tripPlanService.selectTripPlanById(tripPlanId);
		List<TripDayDTO> tripDayList = tripPlanService.selectTripDayListByPlanId(tripPlanId);
		
		model.addAttribute("tripPlanDTO", tripPlanDTO);
		model.addAttribute("tripDayList", tripDayList);
		return "tripplan/planDetail";
	}
	
	@RequestMapping("/insertTripDay.do")
    public ResponseEntity<String> insertTripDay(@RequestBody TripDayDTO tripDayDTO) {
		int result = tripPlanService.insertTripDay(tripDayDTO);

        if (result > 0) {
            return ResponseEntity.ok("장소 저장 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("저장 실패");
        }
    }
	
}
