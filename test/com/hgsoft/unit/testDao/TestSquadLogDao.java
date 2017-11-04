package com.hgsoft.unit.testDao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hgsoft.dao.SquadLogDao;
import com.hgsoft.util.Pager;

public class TestSquadLogDao extends AbstractDaoTransactionalTests{

	@Autowired
	private SquadLogDao squadLogDao;
	
	/**
	 * ���ݲ�ѯ������ѯ�ϼ���
	 * @param pager
	 * @param gateNo ���ű���
	 * @param laneNo ��������
	 * @param squadDate ��������
	 * @param squadNo �����
	 * @param operatorNo �շ�Ա����
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Test
	public void testFillAllSquadLogByHql() {
		List list = squadLogDao.fillAllSquadLogByHql(new Pager(), null, null, null, null, null);
		assertNotNull("list����Ϊ��", list);
	}
	
	//ͨ������С�������š��������룬����Ա�ţ��������ڣ�����ţ���¼ʱ�� ��ѯ�ϼ�����Ϣ
	@SuppressWarnings("unchecked")
	@Test
	public void testLoadSquadLog() {
		List list = squadLogDao.loadSquadLog(null, null, null, null, null, null, null, null);
		assertNull("list���鲻Ϊ��", list);
	}
	
	//ͳ��������ˮ����ͨ�з�
	@SuppressWarnings("unchecked")
	@Test
	public void testLoadCenterData() {
		//List list = squadLogDao.loadCenterData(null, null, null, null, null);
		//assertNull("list���鲻Ϊ��", list);
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}

}
