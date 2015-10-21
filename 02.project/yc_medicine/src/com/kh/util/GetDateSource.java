package com.kh.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.kh.hsfs.impl.AreaImpl;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.opensymphony.xwork2.ActionContext;


public class GetDateSource extends HttpServlet implements ServletContextListener{
	
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		arg0.getServletContext().log("服务器加载完毕......");
		
	}

	public void contextInitialized(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		ServletContext application = arg0.getServletContext();
		String initParams = application.getInitParameter("Address");
		application.log("服务器加载开始......");
		ApplicationContext cxt = WebApplicationContextUtils.getRequiredWebApplicationContext(application);
		AreaImpl modeladds = (AreaImpl)cxt.getBean("areaimpl");
		List larea = modeladds.getMyNewDiqu(initParams);
	    application.log("加载"+initParams+"代码市区县级字典"+larea.size()+"条");
	    List ltowns = modeladds.getMyNewTowns(initParams);
	    application.log("加载"+initParams+"代码乡村级字典"+ltowns.size()+"条");
		application.setAttribute("Areacodes", larea);
		application.setAttribute("Towncodes", ltowns);
		application.setAttribute("Address", initParams);
		
		
		//设置 启动openoffice服务
		//D:\\Program Files\\OpenOffice.org 3为OpenOffice的安装目录
		Properties prop = new Properties();
        InputStream in = DBConnection.class.getResourceAsStream("/config.properties");
        try {
			prop.load(in);
	        String command = prop.getProperty("openoffice").trim()+"\\program\\soffice.exe -headless -accept=\"socket,host=127.0.0.1,port=8100;urp;\"";  
	        Runtime.getRuntime().exec(command);
			application.log("启动 OpenOffice 服务成功");
        } catch (IOException e1) {
        	application.log("启动 OpenOffice 服务失败");
			e1.printStackTrace();
		}
	}
}
