package com.tripPocket.www.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	 public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(); // session 설정
        Boolean isLogin = (Boolean) session.getAttribute("isLogin"); // 세션의 등록된 isLogin의 값을 가져온다 (true=로그인,false=비로그인)
        if (isLogin == null || !isLogin) { // 비로그인 상태인지 확인
            response.sendRedirect(request.getContextPath() + "/member/loginForm.do"); // 비로그인 상태면 로그인폼으로 이동
            return false; // 컨트롤러 작동 금지 
        }
        return true; // 로그인상태면 컨트롤러 작동
    }

	
	
}
