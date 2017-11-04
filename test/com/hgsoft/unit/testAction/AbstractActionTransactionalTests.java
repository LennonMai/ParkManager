package com.hgsoft.unit.testAction;

import org.springframework.test.AbstractTransactionalSpringContextTests;

/**
 * 基于AbstractTransactionalSpringContextTests的抽象测试类 Library：spring-test.jar
 * 继承此类，某个测试方法需要事物回滚时，直接在方法前加 @Rollback(true)即可
 * 
 * @author Bruce Qin 2010.10.11 hgrica
 */
public abstract class AbstractActionTransactionalTests extends AbstractTransactionalSpringContextTests {
	String applicationContextFile = "classpath:applicationContext.xml";
	public AbstractActionTransactionalTests() {
		super();
	}

	public AbstractActionTransactionalTests(String name) {
		super(name);
	}

	abstract String[] getOtherConfigs();
	protected String[] getConfigLocations() {
		String[] otherConfigs = getOtherConfigs();
		// 所有配置文件列表
		String[] configFiles = new String[otherConfigs.length + 1];
		configFiles[0] = applicationContextFile;
		System.arraycopy(otherConfigs, 0, configFiles, 1, otherConfigs.length);
		return configFiles;
	}

}
