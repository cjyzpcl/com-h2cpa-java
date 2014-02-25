package com.h2cpa.hs.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.NDC;

/**
 * IP过滤器
 * @author lwm
 *
 */
public class IPFilter implements Filter {
	private static Logger logger = Logger.getLogger(IPFilter.class);

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		NDC.clear();
		NDC.push(httpRequest.getRemoteAddr());
		
		//过滤掉SQL注入
		if (httpRequest.getRequestURI().indexOf("'") != -1) {
			logger.warn(httpRequest.getRemoteAddr() + "-SQL注入");
			httpResponse.sendRedirect(httpRequest.getContextPath() + "/index");
		}
		
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
