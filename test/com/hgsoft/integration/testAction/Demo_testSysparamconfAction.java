package com.hgsoft.integration.testAction;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hgsoft.action.SysparamconfAction;
import com.hgsoft.service.SysparamconfService;

public class Demo_testSysparamconfAction extends
		AbstractActionTransactionalTests {

	@Autowired
	private SysparamconfService sysparamconfService;

	private SysparamconfAction sysparamconfAction;

	public SysparamconfAction getSysparamconfAction() {
		return sysparamconfAction;
	}

	public void setSysparamconfAction(SysparamconfAction sysparamconfAction) {
		this.sysparamconfAction = sysparamconfAction;
	}

	@Test
	public void testDataToExcel() {
		sysparamconfAction=new SysparamconfAction();
		System.out.println(sysparamconfAction.edit());
	}

	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[] { applicationContextFile};
	}

}
