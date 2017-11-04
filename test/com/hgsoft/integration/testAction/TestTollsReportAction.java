package com.hgsoft.integration.testAction;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.AdminAction;
import com.hgsoft.action.TollsReportAction;
import com.hgsoft.entity.Admin;
import com.hgsoft.service.ReportService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.opensymphony.xwork2.ActionContext;

/**
*@author caijunhua
*/

public class TestTollsReportAction extends AbstractActionTransactionalTests {
	
	private TollsReportAction action;
	private static ApplicationContext context;
	
	@Resource
	SysparamconfService sysparamconfService;
	@Resource
	ReportService reportService;
	@Resource
	SystemLogService systemLogService;
	
	Admin admin;
	
	
	public void onSetUpBeforeTransaction() {
		if(null == context) {
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空", context);
		action = (TollsReportAction) context.getBean("tollsReportAction");
		assertNotNull("action对象为空", action);
		MockHttpSession session = new MockHttpSession();
		admin = new Admin();
//		session.putValue("operator", admin);
		session.setAttribute("operator", admin);
	}
	
	@Test
	@Rollback
	public void testTollsTradeDay() {
		action.tollsTradeDayReport();
		
	}

	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}

}
