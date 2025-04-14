package com.tripPocket.www.tripPlan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping("/planInsertForm.do")
	public String planInsertForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		
		if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return "redirect:/member/loginForm.do"; // 로그인 페이지로 이동
	    }
		return "tripplan/planInsert";
	}
	
	@RequestMapping("/insertPlan.do")
	public String insertPlan(@ModelAttribute TripPlanDTO tripPlanDTO, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		
		if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        // 로그인 페이지로 이동
	        return "redirect:/member/loginForm.do"; 
	    }
		
		tripPlanDTO.setMemberId(memberDTO.getMemberId());
		int tripPlanId = tripPlanService.insertPlan(tripPlanDTO);
		
		return "redirect:/trip/planDetail.do?tripPlanId="+tripPlanId;
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
    public ResponseEntity<Map<String, Object>> insertTripDay(@RequestBody TripDayDTO tripDayDTO) {
		
		tripDayDTO = tripPlanService.insertTripDay(tripDayDTO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
        if (tripDayDTO.getTripDayId() > 0) {
        	map.put("tripDayId", tripDayDTO.getTripDayId());
            return ResponseEntity.ok(map);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
        }
    }
	
	@RequestMapping("/deleteTripDay.do")
	public ResponseEntity<Map<String, Object>> deleteTripDay(@RequestBody Integer tripDayId) {
		Map<String, Object> map = new HashMap<String, Object>();
		
        int result = tripPlanService.deleteTripDayByTripDayId(tripDayId);

        if (result > 0) {
        	map.put("result", "여행 장소 삭제 완료");
        	return ResponseEntity.ok(map);
        } else {
        	map.put("result", "여행 장소 삭제 실페");
        	return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
        }
    }
	
	@RequestMapping("/deleteTripPlan.do")
	public ResponseEntity<Map<String, Object>> deleteTripPlan(@RequestBody Integer tripPlanId) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int result = tripPlanService.deleteTripPlanByTripPlanId(tripPlanId);
		
		if (result > 0) {
			map.put("result", "여행 계획 삭제 완료");
			return ResponseEntity.ok(map);
		} else {
			map.put("result", "여행 계획 삭제 실페");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
	}
}
