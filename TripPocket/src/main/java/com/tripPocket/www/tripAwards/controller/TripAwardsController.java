package com.tripPocket.www.tripAwards.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.tripAwards.dto.TripAwardsDTO;
import com.tripPocket.www.tripAwards.service.TripAwardsService;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;

@Controller
@RequestMapping("/awards")
public class TripAwardsController {
	
	
	
	@Autowired
	private TripAwardsService tripawardsservice;
	
	@RequestMapping(value = "/awardsList.do", method = RequestMethod.GET)
	public ModelAndView listAwardsRanking(TripPlanDTO tripPlanDTO, HttpServletRequest request) {

	    List<TripAwardsDTO> awardsList = TripAwardsService.SearchAwards("title", "ArticleNo", "imgFileNo", "content");
		
		
	    HttpSession session = request.getSession();
	    MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");

	    // 로그인 안 된 경우 로그인 페이지로 리다이렉트
	    if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return new ModelAndView("redirect:/member/loginForm.do");
	    }
	  
	    TripAwardsDTO dto = new TripAwardsDTO();
	    dto.setAwardsId(awardsList, null);

	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("awards/awardsList"); // forward 방식
	    mav.addObject("tripAwardsDTO", dto); // 뷰에서 ${tripAwardsDTO.awardsList} 로 사용

	    return mav;
	}

	
	@RequestMapping(value = "/trip/awardsSearch.do", method = RequestMethod.GET)
	public ModelAndView searchAwardsByCategory(@RequestParam("category") String category) {
	    List<TripAwardsDTO> resultList = new ArrayList<>();

	    switch (category) {
	        case "firstAwards":
	            resultList = tripawardsservice.getFirstPostedReview();  // 첫 후기
	            break;
	        case "secondAwards":
	            resultList = tripawardsservice.getSecondPostedReview(); // 두 번째 후기
	            break;
	        case "monthlyAwards":
	            resultList = tripawardsservice.getTopViewedThisMonth(); // 조회수 높은
	            break;
	            
	        case "photoAwards":
	            resultList = tripawardsservice.getMostLikedPhotos();    // 좋아요 높은
	            break;
	    }

	    ModelAndView mav = new ModelAndView("awards/awardsBest");
	    mav.addObject("resultList", resultList);
	    mav.addObject("category", category);
	    return mav;
	}
	
    // 각 수상 내역 조회 (first, second, photo, monthly awards)
    @RequestMapping(value = "/awardsBest.do", method = RequestMethod.GET)
    public ModelAndView listAwardsbyList(HttpServletRequest request) {
        // 각 카테고리별 수상 내역 조회
    	
        HttpSession session = request.getSession();
	    MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
	    // 로그인 안 된 경우 로그인 페이지로 리다이렉트
	    if (memberDTO == null) {
	        System.out.println("세션에 회원 정보가 없습니다.");
	        return new ModelAndView("redirect:/member/loginForm.do");
	    }
    	
        List<TripAwardsDTO> firstAwardsList = tripawardsservice.getAwardsByCategory("firstAwards");
        List<TripAwardsDTO> secondAwardsList = tripawardsservice.getAwardsByCategory("secondAwards");
        List<TripAwardsDTO> photoAwardsList = tripawardsservice.getAwardsByCategory("photoAwards");
        List<TripAwardsDTO> monthlyAwardsList = tripawardsservice.getAwardsByCategory("monthlyAwards");

        // JSP 페이지로 전달할 데이터 설정
        ModelAndView mav = new ModelAndView("awards/awardsBest");
        mav.addObject("firstAwardsList", firstAwardsList);
        mav.addObject("secondAwardsList", secondAwardsList);
        mav.addObject("photoAwardsList", photoAwardsList);
        mav.addObject("monthlyAwardsList", monthlyAwardsList);
      


        return mav;
    }
    
    }

