package com.tripPocket.www.tripEvent.controller;

import java.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/event")
public class TripEventController {

    // 1. JSP 전체 페이지 반환용
    @RequestMapping("/random.do")
    public String randomRegion(Model model) {
        String fullRegion = getRandomRegion();
        model.addAttribute("region", fullRegion);
        return "tripEvent/randomResult";
    }

    // 2. AJAX 요청 처리용 (텍스트 응답)
    @RequestMapping(value = "/randomRegion", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String getRandomRegionText() {
        return getRandomRegion();
    }

    // 공통 랜덤 지역 선택 메서드
    private String getRandomRegion() {
        Map<String, List<String>> regionMap = new HashMap<>();
        
        regionMap.put("서울", Arrays.asList(""));
        regionMap.put("제주", Arrays.asList(""));
        regionMap.put("인천", Arrays.asList(""));
        
        regionMap.put("강원도", Arrays.asList("강릉", "속초", "춘천", "원주", "태백", "양양", "고성"));
        regionMap.put("전라남도", Arrays.asList("여수", "순천", "목포", "광양", "담양", "완도", "고흥"));
        regionMap.put("전라북도", Arrays.asList("전주", "익산", "군산", "정읍", "남원"));
        regionMap.put("경상남도", Arrays.asList("부산", "창원", "진주", "김해", "밀양"));
        regionMap.put("경상북도", Arrays.asList("경주", "포항", "대구", "울산", "상주", "구미"));
        regionMap.put("충청남도", Arrays.asList("대전", "천안", "논산", "아산", "공주", "계룡", "보령"));
        regionMap.put("충청북도", Arrays.asList("청주", "충주", "음성", "진천", "옥천", "단양"));

        List<String> topRegions = new ArrayList<>(regionMap.keySet());
        Collections.shuffle(topRegions);
        String selectedTopRegion = topRegions.get(0);

        List<String> subRegions = regionMap.get(selectedTopRegion);
        Collections.shuffle(subRegions);
        String selectedSubRegion = subRegions.get(0);

        return selectedTopRegion + (selectedSubRegion.isEmpty() ? "" : " " + selectedSubRegion);
    }
}
