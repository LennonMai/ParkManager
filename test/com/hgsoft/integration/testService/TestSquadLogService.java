package com.hgsoft.integration.testService;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.service.SquadLogService;
import com.hgsoft.util.Pager;

public class TestSquadLogService extends AbstractServiceTransactionalTests {
	
	@Autowired
	private SquadLogService squadLogService;

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
	@Rollback(true)
	public void testFillAllSquadLogByHql() {
		List list = squadLogService.fillAllSquadLogByHql(new Pager(), null, null, null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
	}

	//ͨ������С�������š��������룬�������ں͹���� ��ѯ���Ӱ���Ϣ
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testLoadSquadLog() {
		List list = squadLogService.loadSquadLog(null, null, null, null, null, null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
	}

	//ͳ��������ˮ����ͨ�з�
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testLoadCenterData() {
		//List list = squadLogService.loadCenterData(null, null, null, null, null);
		//assertNotNull("list����Ϊ�գ�",list);
	}

	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}

}
