package com.hgsoft.integration.testService;

import junit.framework.Test;
import junit.framework.TestSuite;
/**
 * AllTests ��JUnit Test Suite,���԰�����JUnit Test Case������һ����в���
 * @author qinzuohai
 *
 */
public class Demo_AllTests {

	public static Test suite() {
		TestSuite suite = new TestSuite(Demo_AllTests.class.getName());
		//$JUnit-BEGIN$
		suite.addTestSuite(Demo_testSysparamconfService.class);
		//$JUnit-END$
		return suite;
	}

}
