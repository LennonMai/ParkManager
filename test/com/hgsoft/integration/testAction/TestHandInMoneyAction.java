package com.hgsoft.integration.testAction;

import java.util.List;

import org.springframework.context.ApplicationContext;

import com.hgsoft.action.HandInMoneyAction;
import com.hgsoft.entity.HandInMoney;
import com.hgsoft.util.Pager;

/**
*@author caijunhua
*/

public class TestHandInMoneyAction extends AbstractActionTransactionalTests {
	
	private HandInMoneyAction handInMoneyAction;
	private HandInMoney handInMoney;
	private static ApplicationContext context;

	//��ѯ���Ӱ�
	@SuppressWarnings("unchecked")
	public void testQueryHandInMoney() {
		if(null == context) {
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ��", context);
		handInMoneyAction = (HandInMoneyAction) context.getBean("handInMoneyAction");
		assertNotNull("action����Ϊ��", handInMoneyAction);
		handInMoney = new HandInMoney();
		assertNotNull("entity����Ϊ��", handInMoney);
		
		handInMoneyAction.setPager(new Pager());
		handInMoney.setGateNo(null);
		handInMoney.setLaneNo(null);
		handInMoney.setSquadDate(null);
		handInMoney.setSquadNo(null);
		handInMoneyAction.setHandInMoney(handInMoney);
		
		String str = handInMoneyAction.queryHandInMoney();
		assertEquals("list", str);
		List list = handInMoneyAction.getList();
		assertNotNull("list����Ϊ��", list);
	}

	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}

}
