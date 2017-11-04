

package com.hgsoft.integration.testAction;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.SquadLogAction;
//import com.hgsoft.entity.SquadLog;

/**
*@author caijunhua
*/

public class TestSquadLogAction extends AbstractActionTransactionalTests {
	
	private SquadLogAction squadLogAction;
//	private SquadLog squadLog;
	private static ApplicationContext context;

	//跳转合计数修改列表页面
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testList() {
		if(null == context) {
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空", context);
		squadLogAction = (SquadLogAction) context.getBean("squadLogAction");
		assertNotNull("action对象为空", squadLogAction);
		String str = squadLogAction.list();
		assertEquals("list", str);
		List list = squadLogAction.getList();
		assertNotNull("list对象为空!", list);
	}
	
	
	
	
	/*
	public void testEdit() {
		fail("Not yet implemented");
	}

	public void testQuerySquadLog() {
		fail("Not yet implemented");
	}

	public void testUpdate() {
		fail("Not yet implemented");
	}

	public void testAjaxLane() {
		fail("Not yet implemented");
	}*/

	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}

}
