package com.tripPocket.www.tripShare.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
import org.springframework.web.servlet.ModelAndView;

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
	@RequestMapping("/myShare.do")
	public String myShare(@ModelAttribute()TripShareDTO tripShareDTO, Model model, HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");

	    if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return "redirect:/member/loginForm.do"; // 로그인 페이지로 이동
	    }

	    List<TripShareDTO> myList = tripShareService.myList(memberDTO.getMemberId());
	    model.addAttribute("myList", myList);
	    return "tripShare/myShare"; // 공유 리스트 페이지의 뷰 이름 반환
	    
	}
	@RequestMapping(value = "/shareForm.do", method = RequestMethod.GET)
	public String writeForm(@ModelAttribute()TripShareDTO tripShareDTO, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
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
	        }

	        return tripDays;
	    }
	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public String write(@ModelAttribute()TripShareDTO tripShareDTO, Model model) {
	   
		 tripShareService.write(tripShareDTO);
	   
		
	    
	    return "redirect:/share/shareList.do"; // Tiles 설정상 이게 view 이름일 것
	}
	@RequestMapping("/shareDetail.do")
	
	public ModelAndView shareDetail(@ModelAttribute TripShareDTO tripShareDTO, HttpServletRequest request) {
	    TripShareDTO share = tripShareService.detailList(tripShareDTO);
	    MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");

	    // 여행 일차 정보 정렬 (tripDayDay 기준으로 정렬)
	    List<TripDayDTO> sortedList = share.getTripDayList();
	    Collections.sort(sortedList, new Comparator<TripDayDTO>() {
	        public int compare(TripDayDTO o1, TripDayDTO o2) {
	            // tripDayDay 기준으로 정렬 (여행 순서대로)
	            return Integer.compare(o1.getTripDayDay(), o2.getTripDayDay());
	        }
	    });

	    ModelAndView mav = new ModelAndView("tripShare/shareDetail");
	    mav.addObject("share", share); // 공유 제목 등 전체 정보
	    mav.addObject("detailList", sortedList); // 정렬된 여행 일차 리스트
	    mav.addObject("member", member); // 로그인 사용자 정보

	    return mav;
	}
	@RequestMapping("/shareImport.do")
	public String importShared(@RequestParam("tripShareId") Long tripShareId,
	                           @RequestParam("tripPlanId") Long tripPlanId,   // ✅ tripPlanId 추가
	                           HttpServletRequest request) {
		
	    MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
	    if (member == null) return "redirect:/member/loginForm.do";

	    // ✅ tripPlanId도 서비스에 같이 넘김
	    tripShareService.importToMyPlan(tripShareId, member.getMemberId());

	    return "redirect:/trip/planList.do";
	}
	
	
}