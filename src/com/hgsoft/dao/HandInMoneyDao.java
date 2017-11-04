package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.HandInMoney;
import com.hgsoft.util.Pager;


/**
 * ���Ӱ����DAO
 * @author caijunhua
 *
 */

@Repository
public class HandInMoneyDao extends BaseDao<HandInMoney> {
	/**
	 * ���ݲ�ѯ������ѯ���Ӱ�
	 * @param pager
	 * @param gateNo ���ű���
	 * @param laneNo ��������
	 * @param squadDate ��������
	 * @param squadNo �����
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<HandInMoney> findAllHandInMoneyByHql(Pager pager,
			Short gateNo, Short laneNo, Date squadDate, Short squadNo) {

		StringBuffer sf = new StringBuffer("from HandInMoney handInMoney where");
		List<Object> obj = new ArrayList<Object>();
		if (gateNo != null) {
			sf.append(" handInMoney.gateNo=? and");
			obj.add(gateNo);
		}
		if (laneNo != null) {
			sf.append(" handInMoney.laneNo=? and");
			obj.add(laneNo);
		}
		if (squadDate != null) {
			sf.append(" handInMoney.squadDate=? and");
			obj.add(squadDate);
		}
		if (squadNo != null) {
			sf.append(" handInMoney.squadNo=? and");
			obj.add(squadNo);
		}
		if(obj.size() != 0 ) {
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		} else {
			sf = sf.replace(sf.length() - 6, sf.length(), "");
		}
		
		// ������������Է�ҳ��������
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//��ʱ�併������¼����
		return this.executeQuery(pager, sf.toString() + " order by squadDate desc", obj.toArray());
	}
	
	//ͨ������С�������š��������룬�������ں͹���� ��ѯ���Ӱ���Ϣ
	@SuppressWarnings("unchecked")
	public List<HandInMoney> loadHandInMoney(Short areaNo, Short parkNo, Short gateNo, 
			Short laneNo, Date squadDate, Short squadNo) {
		String hql = "from HandInMoney handInMoney where handInMoney.areaNo=? " +
				"and handInMoney.parkNo=? and handInMoney.gateNo=? and handInMoney.laneNo=? " +
				"and handInMoney.squadDate=? and handInMoney.squadNo=?";
		List resultList = executeQuery(hql, areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	
	//ͨ������С�������š��������룬�������ں͹���� ɾ�����Ӱ���Ϣ
	public boolean deleteHandInMoney(Short areaNo, Short parkNo, Short gateNo, 
			Short laneNo, Date squadDate, Short squadNo) {
		if(null != loadHandInMoney(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo)) {
			HandInMoney handInMoney = loadHandInMoney(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo).get(0);
			delete(handInMoney);
			return true;
		} else {
			return false;
		}
	}
}
