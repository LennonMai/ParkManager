package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.HandInMoneyDao;
import com.hgsoft.entity.HandInMoney;
import com.hgsoft.util.Pager;

/**
 * ���Ӱ����Service
 * 
 * @author caijunhua
 *
 */

@Service
public class HandInMoneyService extends BaseService<HandInMoney> {

	@Autowired
	public void setDao(@Qualifier("handInMoneyDao") HandInMoneyDao dao) {
		super.setDao(dao);
	}

	private HandInMoneyDao getHandInMoneyDao() {
		return (HandInMoneyDao) this.getDao();
	}

	/**
	 * ���ݲ�ѯ������ѯ���Ӱ�
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
	 * @return
	 */
	public List<HandInMoney> findAllHandInMoneyByHql(Pager pager, Short gateNo, Short laneNo, Date squadDate,
			Short squadNo) {
		return getHandInMoneyDao().findAllHandInMoneyByHql(pager, gateNo, laneNo, squadDate, squadNo);
	}

	// ͨ������С�������š��������룬�������ں͹���Ų�ѯ���Ӱ���Ϣ
	public List<HandInMoney> loadHandInMoney(Short areaNo, Short parkNo, Short gateNo, Short laneNo, Date squadDate,
			Short squadNo) {
		return getHandInMoneyDao().loadHandInMoney(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

	// ͨ������С�������š��������룬�������ں͹����ɾ�����Ӱ���Ϣ
	public boolean deleteHandInMoney(Short areaNo, Short parkNo, Short gateNo, Short laneNo, Date squadDate,
			Short squadNo) {
		return getHandInMoneyDao().deleteHandInMoney(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

}
