package com.hgsoft.integration.testService;

import java.util.List;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.SysparamconfService;

public class Demo_testSysparamconfService extends AbstractServiceTransactionalTests {

	/**
	 * 注入SysparamconfService
	 */
	@Autowired
	private SysparamconfService sysparamconfService;

	/**
	 * 重载AbstractServiceTransactionalTests的方法，
	 * 返回applicationContext.xml的文件路径，部署
	 * applicationContext.xml
	 */
	@Override
	String[] getOtherConfigs() {
		return new String[] { applicationContextFile };
	}
	@Test
	public void testCheckPnameByPname() {
		String pname;
		pname = "endAccount_amongTime";
		List<Sysparamconf> li = sysparamconfService.checkPnameByPname(pname);
		assertNotNull(li);
		System.out.println("pname:" + li.get(0));

	}

	@Test
	@Rollback(true)
	public void testWriteSysparameterSysparamconf() {	
		Sysparamconf sysparamconf = new Sysparamconf();
		boolean test;
		sysparamconf.setPname("testName2");
		sysparamconf.setPtype(1);
		sysparamconf.setPvalue("testName2_value2");
		test = sysparamconfService.writeSysparameter(sysparamconf);
		assertTrue(test);

	}

}
