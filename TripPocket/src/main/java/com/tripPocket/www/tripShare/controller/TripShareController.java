package com.tripPocket.www.tripShare.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dto.TripShareContentDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;
import com.tripPocket.www.tripShare.dto.TripShareLogDTO;
import com.tripPocket.www.tripShare.service.TripShareService;

@Controller
@RequestMapping("/share")
public class TripShareController {

	@Autowired
	private TripShareService tripShareService;
	
	@RequestMapping("/shareList.do")
	public String shareListPage(@ModelAttribute()TripShareDTO tripShareDTO, Model model, HttpServletRequest request) {
	    
	    return "tripShare/shareList"; // 공유 리스트 페이지의 뷰 이름 반환
	    
	}
	@RequestMapping(value = "/shareListAjax.do", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> shareListAjax(@RequestParam String sortType) {
	    Map<String, Object> result = new HashMap<>();

	    List<TripShareDTO> tripShareList = tripShareService.shareListSorted(sortType);
	    result.put("list", tripShareList);

	    return ResponseEntity.ok(result);
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
		MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
		List<TripPlanDTO> planList = tripShareService.getTripPlansByMemberId(member.getMemberId());
		 
		model.addAttribute("tripPlanList", planList);
	   
		return "tripShare/shareForm"; // Tiles 설정상 이게 view 이름일 것
	}
	
	 @RequestMapping("/getTripDays.do")
	 @ResponseBody
	 public List<TripDayDTO> getTripDays(@ModelAttribute()TripDayDTO tripDayDTO) {
		// 서비스 계층에서 데이터 가져오기
        List<TripDayDTO> tripDays = tripShareService.selectTripDayList(tripDayDTO);
        if (tripDays == null) {
            System.out.println("tripDays is null");
        } else if (tripDays.isEmpty()) {
            System.out.println("tripDays is empty");
        } else {
            System.out.println("tripDays size: " + tripDays.size());
        }

        // tripDays가 null이거나 비어있는 경우 빈 리스트로 반환
        if (tripDays == null) {
            tripDays = new ArrayList<>();
        }
        
       
        return tripDays;
    }
	 
	 @RequestMapping(value = "/write.do", method = RequestMethod.POST)
	 public String write(@ModelAttribute() TripShareDTO tripShareDTO, 
	                     HttpServletRequest request, 
	                     Model model) {
	     MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
	     tripShareDTO.setMemberId(member.getMemberId());
	     
	   
	     
	     tripShareService.write(tripShareDTO);
	     
	     return "redirect:/share/myShare.do"; 
	 }
	
	@RequestMapping("/shareDetail.do")
	public ModelAndView shareDetail(@ModelAttribute TripShareDTO tripShareDTO, HttpSession session) {
		MemberDTO member = (MemberDTO) session.getAttribute("member"); // 로그인된 사용자 ID
		TripShareDTO share = tripShareService.detailList(tripShareDTO);
		 

	    // 중복 조회 방지
	    boolean alreadyViewed = tripShareService.existsTripShareViewLog(tripShareDTO.getTripShareId(), member.getMemberId());
	    if (!alreadyViewed) {
	        tripShareService.insertTripShareViewLog(tripShareDTO.getTripShareId(), member.getMemberId());
	       
	    }
	    // 조회수 count 가져와서 DTO에 세팅
	    int viewCount = tripShareService.getTripShareViewCount(tripShareDTO.getTripShareId());
	    share.setTripShareViewCount(viewCount); // DTO에 넣기 (JSP에서 사용 가능)
	    
	    int ShareCount = tripShareService.getTripShareShareCount(tripShareDTO.getTripShareId());
	    share.setTripShareShareCount(ShareCount); 
	    
	    // 여행 일차 정렬 (tripDayDay 기준)
	    List<TripShareContentDTO> sortedList = share.getTripShareContentList();
	    Collections.sort(sortedList, new Comparator<TripShareContentDTO>() {
	        @Override
	        public int compare(TripShareContentDTO o1, TripShareContentDTO o2) {
	            Integer d1 = o1.getTripShareDayDay();
	            Integer d2 = o2.getTripShareDayDay();

	            if (d1 == null && d2 == null) return 0;
	            if (d1 == null) return 1; // null은 뒤로
	            if (d2 == null) return -1;

	            return d1.compareTo(d2);
	        }
	    });

	    ModelAndView mav = new ModelAndView("tripShare/shareDetail");
	    mav.addObject("share", share); // 전체 공유 정보 (제목, 작성자 등)
	    mav.addObject("detailList", sortedList); // 정렬된 Day별 내용 리스트

	    return mav;
	}
	
	@RequestMapping("/shareImport.do")
	public String importShared(
			@RequestParam("tripShareId") Long tripShareId,
			@RequestParam("tripPlanId") Long tripPlanId,   // ✅ tripPlanId 추가
			HttpServletRequest request) {
		
	    MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
	    if (member == null) return "redirect:/member/loginForm.do";

	    // ✅ tripPlanId도 서비스에 같이 넘김
	    tripShareService.importToMyPlan(tripShareId, member.getMemberId());
	    
	    boolean alreadyShared = tripShareService.existsShareLog(tripShareId, member.getMemberId()); 
	    
	    if (!alreadyShared) {
	    	//로그추가
	    	tripShareService.insertShareLog(tripShareId,member.getMemberId());
	    }

	    return "redirect:/plan/planList.do";
	}
	
	@RequestMapping("/shareDelete.do")
	public String deleteShare(@RequestParam("tripShareId") int tripShareId) {
	    tripShareService.shareDelete(tripShareId);  // 서비스에서 삭제 실행
	    return "redirect:/share/myShare.do"; // 삭제 후 myShare.jsp로 리다이렉트
	}
	
	@RequestMapping("/myDetail.do")
	public String myDetail(@RequestParam("tripShareId") int tripShareId, Model model) {
	    TripShareDTO share = tripShareService.getShareDetail(tripShareId);
	    List<TripShareContentDTO> detailList = tripShareService.getTripDayDetailList(tripShareId);
	    MemberDTO member = tripShareService.getWriterByShareId(tripShareId);

	    model.addAttribute("share", share);
	    model.addAttribute("detailList", detailList);
	    model.addAttribute("member", member);

	    return "tripShare/myDetail"; // → myDetail.jsp로 포워딩
	}
	
	@RequestMapping("/modForm.do")
	public String modForm(@RequestParam("tripShareId") int tripShareId, Model model) {
	    TripShareDTO share = tripShareService.getShareDetail(tripShareId);
	    List<TripShareContentDTO> detailList = tripShareService.getTripDayDetailList(tripShareId);
	    MemberDTO member = tripShareService.getWriterByShareId(tripShareId);

	    model.addAttribute("share", share);
	    model.addAttribute("detailList", detailList);
	    model.addAttribute("member", member);

	    return "tripShare/modForm"; // → myDetail.jsp로 포워딩
	}
	
	 @RequestMapping("/updateContents.do")
	    public String updateTripShareContents(
	    		@RequestParam("tripShareId") Long tripShareId,
	    		@RequestParam("dayContents") List<String> dayContents,
	    		@RequestParam("dayIds") List<Long> dayIds,
	    		RedirectAttributes redirectAttributes) {

		 List<Map<String, Object>> contentList = new ArrayList<>();

		    for (int i = 0; i < dayIds.size(); i++) {
		        Map<String, Object> content = new HashMap<>();
		        content.put("tripShareId", tripShareId);
		        content.put("tripDayId", dayIds.get(i));
		        content.put("tripShareContent", dayContents.get(i));
		        contentList.add(content);
		    }

		    tripShareService.updateTripShareContents(contentList);

		    redirectAttributes.addFlashAttribute("message", "후기 수정 완료");
		    return "redirect:/share/myDetail.do?tripShareId=" + tripShareId;
		}
	}

	

