package com.tripPocket.www.tripDestination.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/tripDestination")
public class TripDestinationController {

	@RequestMapping("/list.do")
	public String tripDestinationListPage(@RequestParam(value = "areaCode", defaultValue = "") String areaCode, Model model) {
		model.addAttribute("areaCode", areaCode);
		return "tripDestination/list";
	}
	
	@RequestMapping("/detail.do")
	public String tripDestinationDetailPage(@RequestParam(value = "contentId") String contentId, Model model) {
		model.addAttribute("contentId", contentId);
		return "tripDestination/detail";
	}
	
	@RequestMapping("/searchResult.do")
	public String tripDestinationSearchResultPage(@RequestParam(value = "keyword") String keyword, Model model) {
		model.addAttribute("keyword", keyword);
		return "tripDestination/searchResult";
	}
}
