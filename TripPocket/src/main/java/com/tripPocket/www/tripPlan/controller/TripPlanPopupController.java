package com.tripPocket.www.tripPlan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/popup")
public class TripPlanPopupController {
	
	@RequestMapping("/tripSearch.do")
	public String tripPlanPopupPage() {
		
		return "popup/tripSearch";
	}
}
