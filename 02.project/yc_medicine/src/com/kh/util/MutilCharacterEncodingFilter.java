package com.kh.util;
/*
 * 此方法针对利用ajax post 方式提交中文的时候出现乱码的情况,此时手动传UTF-8编码 避免乱码问题
 */

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.ClassUtils;
import org.springframework.web.filter.OncePerRequestFilter;

public class MutilCharacterEncodingFilter extends OncePerRequestFilter {


	private final static boolean responseSetCharacterEncodingAvailable = ClassUtils
			.hasMethod(HttpServletResponse.class, "setCharacterEncoding",
					new Class[] { String.class });

	private String encoding;

	private boolean forceEncoding = false;

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain arg2)
			throws ServletException, IOException {
		
		
//		request.setCharacterEncoding("GBK");
//		String url=request.getQueryString();

//		Matcher m = null;
//		System.out.println(url);
		String url =request.getQueryString();
		//System.out.println(url);
//		if(url!=null&&!url.equals("")){
//			request.setCharacterEncoding(url);
//		}else{

			if(this.encoding != null && (this.forceEncoding || request.getCharacterEncoding() == null)){
				request.setCharacterEncoding(this.encoding);
				//System.out.println("gbk当期编码---"+this.encoding);
				if(this.forceEncoding && responseSetCharacterEncodingAvailable){
					response.setCharacterEncoding(this.encoding);
				}
			}
//		}
//		if(url!=null){
//			System.out.println(inputPattern.matcher(url));
//			System.out.println(inputPattern.matcher(url).matches());
//		}
//		
//		if (url != null && (m = inputPattern.matcher(url)).matches()) {
//			String inputEncoding = m.group(1);
//			request.setCharacterEncoding(inputEncoding);
//			m = outputPattern.matcher(url);
//			if(m.matches()){
//				response.setCharacterEncoding(m.group(1));
//			}
//			else{
//				if(this.forceEncoding && responseSetCharacterEncodingAvailable ){
//					response.setCharacterEncoding(this.encoding);
//				}
//			}
//		}
//		else{
//			if(this.encoding != null && (this.forceEncoding || request.getCharacterEncoding() == null)){
//				request.setCharacterEncoding(this.encoding);
//				if(this.forceEncoding && responseSetCharacterEncodingAvailable){
//					response.setCharacterEncoding(this.encoding);
//				}
//			}
//		}
		arg2.doFilter(request, response);
	}

	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	public void setForceEncoding(boolean forceEncoding) {
		this.forceEncoding = forceEncoding;
	}

}
