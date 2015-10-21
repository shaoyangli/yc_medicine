package com.kh.hsfs.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

	String noFilterURL = "";
	static List<String> noFilterList=new ArrayList<String>();
	public void destroy() {
		
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest r = (HttpServletRequest) request;
		String requestURI = r.getRequestURI();
		
		String path = r.getContextPath();
		// 去掉一些不需要过滤的控件
		if (requestURI.endsWith("login.jsp")|| requestURI.endsWith("unLoginError.jsp") || requestURI.endsWith("exitLog.jsp")
				|| requestURI.endsWith("LoginAction")) {
			chain.doFilter(request, response);
			return;
		}

		HttpSession session = r.getSession();

		if (null == session.getAttribute("user")) {
			((HttpServletResponse) response).sendRedirect(path+"/hsfs/unLoginError.jsp");
			return;
		} else {
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
//		noFilterURL = filterConfig.getInitParameter("noFilter");
//		String[] noFilters=noFilterURL.split(",");
//		for(int i=0;i<noFilters.length;i++){
//			String noFilter=noFilters[i].trim();
//			noFilterList.add(noFilter);
//		}	
	}

}
