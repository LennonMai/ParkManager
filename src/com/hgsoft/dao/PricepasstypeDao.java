package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;


import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Pricepasstype;
import com.hgsoft.util.Pager;

/**
 * �շ�����Ӱ��Dao
 * @author caijunhua
 */

@Repository
public class PricepasstypeDao extends BaseDao<Pricepasstype> {
	/**
	 * �ж��շ�����Ӱ���Ƿ����
	 */
	public boolean isExist(Short parkNo, Short inGateNo, Short outGateNo, Short feeType, Short verNo) {
		String hql = "from Pricepasstype pst where pst.parkNo=? and pst.inGateNo=? " +
				" and pst.outGateNo=? and pst.feeType=? and pst.verNo=?";
		//Query q = getSession().createQuery(hql);
		Long count = executeCount(hql, parkNo, inGateNo, outGateNo, feeType, verNo);
		return count>0;
	}
	/**
	 * ��ȡ�����շ�����Ӱ��
	 */
	@SuppressWarnings("unchecked")
	public List<Pricepasstype> getAllPricepasstype(Pager pager) {
		String hql = "from Pricepasstype pricepasstype";
		List<Pricepasstype> list = executeQuery(pager, hql);
		if(list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
	/**
	 * ɾ���շ�����Ӱ��
	 */
	public void deletePricepasstype(Short parkNo, Short inGateNo,
			Short outGateNo, Short feeType, Short verNo) {
		String hql = "delete from Pricepasstype pricepasstype" +
				" where pricepasstype.parkNo=" + parkNo + 
				" and pricepasstype.inGateNo=" + inGateNo +
				" and pricepasstype.outGateNo=" + outGateNo +
				" and pricepasstype.feeType=" + feeType +
				" and pricepasstype.verNo=" + verNo;
		Query q = getSession().createQuery(hql);
		q.executeUpdate();
	}
	/**
	 * ȡ���շ�����Ӱ��
	 */
	@SuppressWarnings("unchecked")
	public Pricepasstype getPricepasstype(Short parkNo, Short inGateNo,
			Short outGateNo, Short feeType, Short verNo) {
		String hql = "from Pricepasstype pricepasstype" +
			" where pricepasstype.parkNo=" + parkNo + 
			" and pricepasstype.inGateNo=" + inGateNo +
			" and pricepasstype.outGateNo=" + outGateNo +
			" and pricepasstype.feeType=" + feeType +
			" and pricepasstype.verNo=" + verNo;
		List<Pricepasstype> resultList = this.executeQuery(hql);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList.get(0);
		}
	}
	/**
	 * ����������ѯ
	 */
	@SuppressWarnings("unchecked")
	public List<Pricepasstype> getByCondition(Pager pager, Short parkNo, Short inGateNo,
			Short outGateNo, Short feeType, Short verNo) {
		StringBuffer sf = new StringBuffer("from Pricepasstype pricepasstype where");
		List<Object> objList = new ArrayList<Object>();
		if(null != parkNo && !"".equals(parkNo)) {
			sf.append(" pricepasstype.parkNo = ? and");
			objList.add(parkNo);
		}
		if(null != inGateNo && !"".equals(inGateNo)) {
			sf.append(" pricepasstype.inGateNo = ? and");
			objList.add(inGateNo);
		}
		if(null != outGateNo && !"".equals(outGateNo)) {
			sf.append(" pricepasstype.outGateNo = ? and");
			objList.add(outGateNo);
		}
		if(null != feeType && !"".equals(feeType)) {
			sf.append(" pricepasstype.feeType = ? and");
			objList.add(feeType);
		}
		if(null != verNo && !"".equals(verNo)) {
			sf.append(" pricepasstype.verNo = ? and");
			objList.add(verNo);
		}
		sf = sf.replace(sf.length()-4, sf.length(), "");
		// ������������Է�ҳ��������
		Long count = this.executeCount(sf.toString(), objList.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), objList.toArray());
	}
}
