package com.hgsoft.unit.testDao;

import org.springframework.test.AbstractTransactionalSpringContextTests;

/**
 * ����AbstractTransactionalSpringContextTests�ĳ��������
 * Library��spring-test.jar 
 * �̳д��࣬ĳ�����Է�����Ҫ����ع�ʱ��ֱ���ڷ���ǰ��	@Rollback(true)����
 * @author Bruce Qin 2010.10.11 hgrica
 */
public abstract class AbstractDaoTransactionalTests extends
		AbstractTransactionalSpringContextTests {

	// �ļ�ϵͳ����·��
	// String filePath = "file:D:/WorkSpace_JEE/ParkManager/src/";
	// String applicationContextFile = "applicationContext.xml";

	// ��Ŀclasspath·��
	 String applicationContextFile="classpath:applicationContext.xml";

	/**
	 * �޲ι��캯��
	 */
	public AbstractDaoTransactionalTests() {
		super();
	}

	/**
	 * �вι��캯��
	 * 
	 * @param name
	 */
	public AbstractDaoTransactionalTests(String name) {
		super(name);
	}

	/**
	 * ��Ҫ���ص������ļ���ַ�б�
	 * @return new String[]{applicationContextFile};
	 */
	abstract String[] getOtherConfigs();

	/**
	 * ���ǵĻ�ȡ�����ļ���ַ�ķ���
	 */
	protected String[] getConfigLocations() {
		String[] otherConfigs = getOtherConfigs();
		// ���������ļ��б�
		String[] configFiles = new String[otherConfigs.length + 1];
		configFiles[0] = applicationContextFile;

		/**
		 * public static void arraycopy(Object src, int srcPos, Object dest, int
		 * destPos, int length) 
		 * Դ������λ���� srcPos��srcPos+length-1 ֮����������
		 * ���Ƶ�Ŀ�������е� destPos �� destPos+length-1 λ�á�
		 */
		System.arraycopy(otherConfigs, 0, configFiles, 1, otherConfigs.length);
		return configFiles;
	}
	/**
	 * ���Եķ����б�
	 * 
	 * @return
	 */
	// abstract String[] getIgnoreMethods();
	/**
	 * ���к��Է����б��еķ������ڲ���ʱ��ִ��
	 * 
	 * @param testMethodName
	 * @return
	 */
	// protected boolean isDisableInThisEnvironment(String testMethodName){
	// for(String methodName:getIgnoreMethods()){
	// if(methodName.equals(testMethodName))
	// return true;
	// }
	// return false;
	// }

}
