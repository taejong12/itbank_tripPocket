package com.tripPocket.www.tripEvent.controller;

import java.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tripPocket.www.tripEvent.dto.RegionDTO;

@Controller
@RequestMapping("/event")
public class TripEventController {

	@RequestMapping("/random.do")
	public String randomRegion(Model model) {
	    List<RegionDTO> regionList = getTopRegionList();
	    model.addAttribute("regionList", regionList);

	    RegionDTO randomRegion = getRandomRegion(regionList);
	    model.addAttribute("region", randomRegion);

	    return "tripEvent/randomResult";
	}

	@RequestMapping(value = "/randomRegion", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getRandomRegionText() {
	    List<RegionDTO> regionList = getTopRegionList();
	    RegionDTO randomRegion = getRandomRegion(regionList);
	    return randomRegion.getName();
	}

	// 지역명 + 코드 매핑
	private List<RegionDTO> getTopRegionList() {
	    List<RegionDTO> list = new ArrayList<>();
	    list.add(new RegionDTO("서울", 1));
	    list.add(new RegionDTO("인천", 2));
	    list.add(new RegionDTO("대전", 3));
	    list.add(new RegionDTO("대구", 4));
	    list.add(new RegionDTO("광주", 5));
	    list.add(new RegionDTO("부산", 6));
	    list.add(new RegionDTO("울산", 7));
	    list.add(new RegionDTO("세종", 8));
	    list.add(new RegionDTO("경기", 31));
	    list.add(new RegionDTO("강원", 32));
	    list.add(new RegionDTO("충북", 33));
	    list.add(new RegionDTO("충남", 34));
	    list.add(new RegionDTO("경북", 35));
	    list.add(new RegionDTO("경남", 36));
	    list.add(new RegionDTO("전북", 37));
	    list.add(new RegionDTO("전남", 38));
	    list.add(new RegionDTO("제주", 39));
	    return list;
	}

	private RegionDTO getRandomRegion(List<RegionDTO> regionList) {
	    Collections.shuffle(regionList);
	    return regionList.get(0);
	}
	
	@RequestMapping(value = "/randomRegion", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getRandomRegionJson() {
		List<RegionDTO> regionList = getTopRegionList();
	    RegionDTO randomRegion = getRandomRegion(regionList); // 지역명, 코드 포함된 객체
	    Map<String, Object> result = new HashMap<>();
	    result.put("name", randomRegion.getName());
	    result.put("code", randomRegion.getCode());
	    return result;
	}
}
