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
	//����������������ʼ�߳�
	public void contextInitialized(ServletContextEvent event) {
	
	    event.getServletContext().log("��ʱ�߳�������");
	    WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
	  
		timeBackupTaskThreadAction=(TimeBackupTaskThreadAction) wac.getBean("timeBackupTaskThread");
        timeBackupTaskThreadAction.start();
		
        //specialWhiteListControlThread = (SpecialWhiteListControlThread) wac.getBean("specialWhiteListControlThread");
        //specialWhiteListControlThread.start();
	}
	
	//����������ֹͣ�����߳�
	public void contextDestroyed(ServletContextEvent event) {
	    event.getServletContext().log("��ʱ�߳�����");
		timeBackupTaskThreadAction.interrupt();
		//specialWhiteListControlThread.interrupt();
	}
}
