/**
*CopyRight (c) caijunhua (chase)  ���ݻ�����Ϣ������޹�˾ http://www.hgsoft.com.cn
*Email:chaseWin@163.com
*ת����ע����Ȩ����
*/

package com.hgsoft.integration.testAction;

//import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.GenerateSumAction;

public class TestGenerateSumAction extends AbstractActionTransactionalTests {
	
	private GenerateSumAction generateSumAction;
	private ApplicationContext context;

	//��ת���ɺϼ����б�ҳ��
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testList() {
		if(null == context) {
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ��", context);
		generateSumAction = (GenerateSumAction) context.getBean("generateSumAction");
		assertNotNull("action����Ϊ��", generateSumAction);
		String str = generateSumAction.list();
		assertEquals("list", str);
//		List list = generateSumAction.getList();
//		assertNotNull("list����Ϊ��", list);
	}

	
	
	/*
	public void testQueryGateSum() {
		fail("Not yet implemented");
	}

	public void testQueryLaneSum() {
		fail("Not yet implemented");
	}

	public void testSumLane() {
		fail("Not yet implemented");
	}

	public void testSumAllLane() {
		fail("Not yet implemented");
	}

	public void testGenerateLaneSum() {
		fail("Not yet implemented");
	}

	public void testGenerateOneLaneSum() {
		fail("Not yet implemented");
	}

	public void testGenerateGateSum() {
		fail("Not yet implemented");
	}

	public void testPrintLaneSum() {
		fail("Not yet implemented");
	}

	public void testPrintGateSum() {
		fail("Not yet implemented");
	}*/

	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}

}
