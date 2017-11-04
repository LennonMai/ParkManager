package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SquadLogDao;
import com.hgsoft.entity.SquadLog;
import com.hgsoft.util.Pager;

/**
 * �ϼ����޸�Service
 * 
 * @author caijunhua
 *
 */

@Service
public class SquadLogService extends BaseService<SquadLog> {

	@Autowired
	public void setDao(@Qualifier("squadLogDao") SquadLogDao dao) {
		super.setDao(dao);
	}

	private SquadLogDao getSquadLogDao() {
		return (SquadLogDao) this.getDao();
	}

	public List<SquadLog> fillAllSquadLog(Pager pager) {
		return getSquadLogDao().fillAllSquadLog(pager);
	}

	/**
	 * ���ݲ�ѯ������ѯ�ϼ���
	 * 
	 * @param pager
	 * @param gateNo
	 *            ���ű���
	 * @param laneNo
	 *            ��������
	 * @param squadDate
	 *            ��������
	 * @param squadNo
	 *            �����
	 * @param operatorNo
	 *            �շ�Ա����
	 * @return
	 */
	public List<SquadLog> fillAllSquadLogByHql(Pager pager, Short gateNo, Short laneNo, Date squadDate, Short squadNo,
			Integer operatorNo) {
		return getSquadLogDao().fillAllSquadLogByHql(pager, gateNo, laneNo, squadDate, squadNo, operatorNo);
	}

	// ͨ������С�������š��������룬�������ں͹���� ��ѯ���Ӱ���Ϣ
	public List<SquadLog> loadSquadLog(Short areaNo, Short parkNo, Short gateNo, Short laneNo, Integer operatorNo,
			Date squadDate, Short squadNo, Date loginTime) {
		return getSquadLogDao().loadSquadLog(areaNo, parkNo, gateNo, laneNo, operatorNo, squadDate, squadNo, loginTime);
	}

	// ͳ��������ˮ����ͨ�з�
	@SuppressWarnings("unchecked")
	public List loadCenterData(String month, Short areaNO, Short parkNo, Short gateNo, Short laneNo, Date squadDate,
			Short squadNo, Short listName) {
		return getSquadLogDao().loadCenterData(month, areaNO, parkNo, gateNo, laneNo, squadDate, squadNo, listName);
	}

}
