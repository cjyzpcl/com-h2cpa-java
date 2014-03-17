package com.h2cpa.hs.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.PropertyConfigurator;

/**
 * 配置日志
 * 
 * @author lwm
 * 
 */
public class LogServlet extends HttpServlet {

	private static final long serialVersionUID = 4665004761110383741L;

	public void init() throws ServletException {
		// log4j
		
		String rootPath = this.getServletContext().getRealPath("/");
		String log4jPath = this.getInitParameter("log4j");
		System.setProperty("rootPath", rootPath);
		PropertyConfigurator.configure(rootPath + log4jPath);

		// website

		System.setProperty("WEB_NAME", "H2CPA");
		System.setProperty("ADMIN_PATH", "h2cpa");
	}

}
