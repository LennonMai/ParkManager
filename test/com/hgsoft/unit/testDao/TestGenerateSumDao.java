package com.hgsoft.unit.testDao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.GenerateSumDao;
import com.hgsoft.util.Pager;

public class TestGenerateSumDao extends AbstractDaoTransactionalTests {

	@Autowired
	private GenerateSumDao generateSumDao;
	
	//��ѯ�����ܺϼ����б�
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testQueryGateSum() {
		List list = generateSumDao.queryGateSum(new Pager(), null, null, null, null, null);
		assertNotNull("list����Ϊ��", list);
//		System.out.println("list_size:" + list.size());
	}
	
	//��ѯ�����ϼ����б�
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testQueryLaneSum() {
		List list = generateSumDao.queryLaneSum(null, null, null, null);
		assertNotNull("list����Ϊ��", list);
	}
	
	//��ѯû�ϼƳ������б�
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testLaneNotSum() {
		List list = generateSumDao.queryLaneNotSum(null, null, null, null);
		assertNotNull("list����Ϊ��", list);
	}
	
	//������������
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testCountCenterLaneData() {
		List list = generateSumDao.countCenterLaneData(null, null, null, null, null, null, null);
		assertNull("list���鲻Ϊ��", list);
	}
	
	//���ɳ����ϼ���
	@Test
	@Rollback(true)
	public void testGenerateLaneSum() {
		boolean test = generateSumDao.generateLaneSum(null, null, null, null, null, null, null, null, null);
		assertFalse("�������ɹ�", test);
	}
	
	//���ɴ��źϼ���
	@Test
	@Rollback(true)
	public void testGenerateGateSum() {
		boolean test =  generateSumDao.generateGateSum(null, null, null, null);
		assertFalse("�������ɹ�", test);
	}
	
	//��ѯ�����ϼ����Ƿ����
	@Test
	@Rollback(true)
	public void testSelectLaneSum() {
		int size = generateSumDao.selectLaneSum(null, null, null, null, null, null);
		assertEquals("��¼����Ϊ0", 0, size);
	}
	
	//���㹤����
	@Test
	@Rollback(true)
	public void testCountSquad() {
		int squadCount = generateSumDao.countSquad();
		System.out.println("squadCount:"+squadCount);
//		assertEquals("��������Ϊ3", 3, squadCount);
	}
	
	//������ų��ڳ�����
	@Test
	@Rollback(true)
	public void testCountLane() {
		int outLane = generateSumDao.countLane(null);
		System.out.println("outLane:"+outLane);
//		assertEquals("���ڳ�������Ϊ3", 3, outLane);
	}
	
	//�����Ѿ��ϼƵĴ��ų�����
	@Test
	@Rollback(true)
	public void testCountLaneSummation() {
		int laneSummationCount = generateSumDao.countLaneSummation(null, null, null, null);
		System.out.println("laneSummationCount:"+laneSummationCount);
//		assertEquals("�ϼƵĴ��ų�������Ϊ3", 3, laneSummationCount);
	}
	
	//���㳵��������еļ�¼��
	@Test
	@Rollback(true)
	public void testCountSquadLog() {
		int squadLogCount = generateSumDao.countSquadLog(null, null, null, null);
		System.out.println("squadLogCount:"+squadLogCount);
//		assertEquals("�ϼƵĴ��ų�������Ϊ3", 3, squadCount);
	}

	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}
}
