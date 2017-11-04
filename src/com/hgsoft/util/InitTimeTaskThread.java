package com.hgsoft.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.hgsoft.action.SpecialWhiteListControlThread;
import com.hgsoft.action.TimeBackupTaskThreadAction;


public class InitTimeTaskThread  implements ServletContextListener{
	
	private TimeBackupTaskThreadAction timeBackupTaskThreadAction;
	//private SpecialWhiteListControlThread specialWhiteListControlThread;
	//监听服务器启动开始线程
	public void contextInitialized(ServletContextEvent event) {
	
	    event.getServletContext().log("定时线程已启动");
	    WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
	  
		timeBackupTaskThreadAction=(TimeBackupTaskThreadAction) wac.getBean("timeBackupTaskThread");
        timeBackupTaskThreadAction.start();
		
        //specialWhiteListControlThread = (SpecialWhiteListControlThread) wac.getBean("specialWhiteListControlThread");
        //specialWhiteListControlThread.start();
	}
	
	//监听服务器停止结束线程
	public void contextDestroyed(ServletContextEvent event) {
	    event.getServletContext().log("定时线程销毁");
		timeBackupTaskThreadAction.interrupt();
		//specialWhiteListControlThread.interrupt();
	}
}
