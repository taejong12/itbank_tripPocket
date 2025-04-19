package com.tripPocket.www.common.interceptor;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Boolean isLogin = (Boolean) session.getAttribute("isLogin");

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        
        if (uri.equals(contextPath+"/member/loginKeep.do")) {
            return true;
        }
        
        if (isLogin != null) {
	        List<String> blockedUrls = Arrays.asList(
        		"/member/loginForm.do", 
        		"/member/joinForm.do", 
        		"/member/join.do", 
        		"/member/memberLoginCheck.do", 
        		"/member/findIdForm.do", 
        		"/member/findIdList.do", 
        		"/member/findPwdForm.do"
	        );
	        
	        for (String url : blockedUrls) {
	            if (uri.contains(contextPath+url)) {
	                response.sendRedirect(contextPath + "/");
	                return false;
	            }
	        }
        }

        if(isLogin == null) {
        	Cookie[] cookies = request.getCookies();
	    	if (cookies != null) {
	    		for (Cookie cookie : cookies) {
	    			if ("loginKeep".equals(cookie.getName())) {
	    				session.setAttribute("memberId", cookie.getValue());
	    				response.sendRedirect(contextPath + "/member/loginKeep.do");
	    				return false;
	    			}
	    		}
	    	}
	    	
	    	List<String> allowUrls = Arrays.asList(
	    	    "/",
	    	    "/main.do",
	    	    "/member/loginForm.do",
	    	    "/member/joinForm.do",
	    	    "/member/findIdForm.do",
	    	    "/member/findPwdForm.do"
	    	);
	    	
	    	for (String url : allowUrls) {
	            if (uri.equals(contextPath+url)) {
	                return true;
	            }
	        }
        	
        	List<String> blockedUrls = Arrays.asList(
    			"/member/mypage.do", 
    			"/member/modMember.do", 
    			"/member/delMember.do"
        	);
        	
        	for (String url : blockedUrls) {
	            if (uri.contains(contextPath+url)) {
	                response.sendRedirect(contextPath + "/member/loginForm.do");
	                return false;
	            }
	        }
        	
        	List<String> prefixBlockedUrls = Arrays.asList(
        		"/plan"
        	);
        	
        	for (String url : prefixBlockedUrls) {
        	    if (uri.startsWith(url + "/")) {
        	        response.sendRedirect(contextPath + "/member/loginForm.do");
        	        return false;
        	    }
        	}
        }
        return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
