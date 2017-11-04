package com.hgsoft.unit.testAction;

import org.springframework.test.AbstractTransactionalSpringContextTests;

/**
 * ����AbstractTransactionalSpringContextTests�ĳ�������� Library��spring-test.jar
 * �̳д��࣬ĳ�����Է�����Ҫ����ع�ʱ��ֱ���ڷ���ǰ�� @Rollback(true)����
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
		// ���������ļ��б�
		String[] configFiles = new String[otherConfigs.length + 1];
		configFiles[0] = applicationContextFile;
		System.arraycopy(otherConfigs, 0, configFiles, 1, otherConfigs.length);
		return configFiles;
	}

}
