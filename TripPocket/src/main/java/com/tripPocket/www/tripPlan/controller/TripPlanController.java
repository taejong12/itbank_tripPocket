package com.tripPocket.www.tripPlan.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
		System.out.println("size: "+tripPlanList.size());
		System.out.println("getMemberId: "+tripPlanList.get(0));
		model.addAttribute("tripPlanList", tripPlanList);
		return "tripplan/planList";
	}
	
	@RequestMapping("/planDateSet.do")
	public String planDateSettingPage() {
		return "tripplan/dateSetting";
	}
	
	@RequestMapping("/insertPlanDateSet.do")
	public String insertPlanDateSet(@ModelAttribute TripPlanDTO tripPlanDTO, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		tripPlanDTO.setMemberId(memberDTO.getMemberId());
		tripPlanService.insertPlanDateSet(tripPlanDTO);
		
		// Flash Attribute로 DTO 데이터 저장 (일회성)
	    redirectAttributes.addFlashAttribute("tripPlanDTO", tripPlanDTO);
		return "redirect:/trip/planSpace.do";
	}
	
	@RequestMapping("/planDetail.do")
	public String planDetailPage(@RequestParam("tripPlanId") Integer tripPlanId, Model model) {
		List<TripDayDTO> tripDayList = tripPlanService.selectTripDayListByPlanId(tripPlanId);
		model.addAttribute("tripDayList", tripDayList);
		return "tripplan/planDetail";
	}
	
	@RequestMapping("/planSpace.do")
	public String planSpacePage(@ModelAttribute("tripPlanDTO") TripPlanDTO tripPlanDTO, Model model) {
		model.addAttribute("tripPlanDTO", tripPlanDTO);
		return "tripplan/planSpace";
	}
	
}
