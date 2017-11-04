package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.GenerateSumDao;
import com.hgsoft.entity.SquadLog;
import com.hgsoft.util.Pager;

/**
 * ���ɺϼ���Service
 * 
 * @author caijunhua
 *
 */

@Service
public class GenerateSumService extends BaseService<SquadLog> {

	@Autowired
	public void setDao(@Qualifier("generateSumDao") GenerateSumDao dao) {
		super.setDao(dao);
	}

	private GenerateSumDao getGenerateSumDao() {
		return (GenerateSumDao) this.getDao();
	}

	// ��ѯ�����ܺϼ����б�
	@SuppressWarnings("unchecked")
	public List queryGateSum(Pager pager, Integer areaNo, Integer parkNo, String gateNo, Date squadDate,
			String stationYNSum) {
		return getGenerateSumDao().queryGateSum(pager, areaNo, parkNo, gateNo, squadDate, stationYNSum);
	}

	// ��ѯ�����ϼ����б�
	@SuppressWarnings("unchecked")
	public List queryLaneSum(Integer areaNo, Integer parkNo, String gateNo, Date squadDate) {
		return getGenerateSumDao().queryLaneSum(areaNo, parkNo, gateNo, squadDate);
	}

	// //���ݴ������Ʋ���ű��
	// public int queryGateNo(String gateName) {
	// return ((GenerateSumDao)getDao()).queryGateNo(gateName);
	// }

	// ������������
	@SuppressWarnings("unchecked")
	public List countCenterLaneData(String month, Integer areaNo, Integer parkNo, String gateNo, String laneNo,
			Date squadDate, String squadNo) {
		return getGenerateSumDao().countCenterLaneData(month, areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

	// ��ѯû�ϼƳ������б�
	@SuppressWarnings("unchecked")
	public List queryLaneNotSum(Integer areaNo, Integer parkNo, String gateNo, Date squadDate) {
		return getGenerateSumDao().queryLaneNotSum(areaNo, parkNo, gateNo, squadDate);
	}

	// ���ɳ����ϼ���
	public void generateLaneSum(String areaNo, String parkNo, String gateNo, String laneNo, String squadDate,
			String squadNo, String laneTypeNo, String recordCnt, String moneySummation) {
		getGenerateSumDao().generateLaneSum(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo, laneTypeNo, recordCnt,
				moneySummation);
	}

	// ���ɴ��źϼ���
	public void generateGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		getGenerateSumDao().generateGateSum(areaNo, parkNo, gateNo, squadDate);
	}

	// ��ѯ�����ϼ����Ƿ����
	public int selectLaneSum(String areaNo, String parkNo, String gateNo, String laneNo, String squadDate,
			String squadNo) {
		return getGenerateSumDao().selectLaneSum(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

	public void deleteLaneSum(String areaNo, String parkNo, String gateNo, String laneNo, String squadDate,
			String squadNo) {
		getGenerateSumDao().deleteLaneSum(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

	public void deleteAllLaneSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		getGenerateSumDao().deleteAllLaneSum(areaNo, parkNo, gateNo, squadDate);
	}

	// ��ѯ���źϼ����Ƿ����
	public int selectGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		return getGenerateSumDao().selectGateSum(areaNo, parkNo, gateNo, squadDate);
	}

	// ��ѯ�ϼ�ʱ��ɾ��֮ǰ���ɵ�����
	public void deleteGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		getGenerateSumDao().deleteGateSum(areaNo, parkNo, gateNo, squadDate);
	}

	// ���㹤����
	public int countSquad() {
		return getGenerateSumDao().countSquad();
	}

	// ������ų��ڳ�����
	public int countLane(String gateNo) {
		return getGenerateSumDao().countLane(gateNo);
	}

	// �����Ѿ��ϼƵĴ��ų�����
	public int countLaneSummation(String areaNo, String parkNo, String gateNo, String squadDate) {
		return getGenerateSumDao().countLaneSummation(areaNo, parkNo, gateNo, squadDate);
	}

	// ���㳵��������еļ�¼��
	public int countSquadLog(String areaNo, String parkNo, String gateNo, String squadDate) {
		return getGenerateSumDao().countSquadLog(areaNo, parkNo, gateNo, squadDate);
	}

	// �����˺ϼ�����վ��������Ϣ��д�뱨��δͳ����Ϣ��
	public void insertSunInfo(String areaNo, String parkNo, String gateNo, String squadDate, String squadNo) {
		getGenerateSumDao().insertSunInfo(areaNo, parkNo, gateNo, squadDate, squadNo);
	}

}
