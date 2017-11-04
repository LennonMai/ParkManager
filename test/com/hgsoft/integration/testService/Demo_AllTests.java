package com.hgsoft.integration.testService;

import junit.framework.Test;
import junit.framework.TestSuite;
/**
 * AllTests 是JUnit Test Suite,可以吧所有JUnit Test Case集合在一起进行测试
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
