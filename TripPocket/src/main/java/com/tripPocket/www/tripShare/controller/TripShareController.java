package com.tripPocket.www.tripShare.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;
import com.tripPocket.www.tripShare.service.TripShareService;

@Controller
@RequestMapping("/share")
public class TripShareController {

	@Autowired
	private TripShareService tripShareService;
	
	@RequestMapping("/shareList.do")
	public String shareListPage(@ModelAttribute()TripShareDTO tripShareDTO, Model model, HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");

	    if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return "redirect:/member/loginForm.do"; // 로그인 페이지로 이동
	    }

	    List<TripShareDTO> tripShareList = tripShareService.shareList(tripShareDTO);
	    model.addAttribute("tripShareList", tripShareList);
	    return "tripShare/shareList"; // 공유 리스트 페이지의 뷰 이름 반환
	    
	}
	@RequestMapping(value = "/shareForm.do", method = RequestMethod.GET)
	public String writeForm(@ModelAttribute()TripShareDTO tripShareDTO, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		 MemberDTO member = (MemberDTO) session.getAttribute("member");
		 List<TripPlanDTO> planList = tripShareService.getTripPlansByMemberId(member.getMemberId());
		 
		    model.addAttribute("tripPlanList", planList);
	   
		
	    
	    return "tripShare/shareForm"; // Tiles 설정상 이게 view 이름일 것
	}
	 @RequestMapping("/getTripDays.do")
	 @ResponseBody
	    public List<TripDayDTO> getTripDays(@ModelAttribute()TripDayDTO tripDayDTO) {
	        // tripPlanId 출력
	        

	        // 서비스 계층에서 데이터 가져오기
	        List<TripDayDTO> tripDays = tripShareService.selectTripDayList(tripDayDTO);

	        // 가져온 데이터 출력 (디버깅 용도)
	        for (TripDayDTO dto : tripDays) {
	            System.out.println(dto.getTripDayAdr());
	            System.out.println(dto.getTripDayDay());
	            System.out.println(dto.getTripDayDate());
	            System.out.println(dto.getTripDayImage());
	            System.out.println(dto.getTripPlanId());
	            System.out.println(dto.getTripPlanAddDate());
	            System.out.println(dto.getTripPlanModDate());
	        }

	        return tripDays;
	    }
	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public String write(@ModelAttribute()TripShareDTO tripShareDTO, Model model) {
	   
		 tripShareService.write(tripShareDTO);
	   
		
	    
	    return "redirect:/share/shareList.do"; // Tiles 설정상 이게 view 이름일 것
	}
	
	
}