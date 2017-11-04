package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.OwnerIncomeSum;
import com.hgsoft.util.Pager;


/**
 * ҵ����֧������DAO
 * @author caijunhua
 *
 */

@Repository
public class OwnerIncomeSumDao extends BaseDao<OwnerIncomeSum> {
	/**
	 * ���ݲ�ѯ������ѯҵ����֧���
	 * @param pager
	 * @param startTime ��ʼʱ��
	 * @param endTime ����ʱ��
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<OwnerIncomeSum> findOwnerIncomeSumByHql(Pager pager,
			String startTime, String endTime) {

		StringBuffer sf = new StringBuffer("from OwnerIncomeSum ownerIncomeSum where");
		List<Object> list = new ArrayList<Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (null != startTime && !"".equals(startTime)) {
			sf.append(" ownerIncomeSum.genDate >= ? and");
			try {
				list.add(sdf.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (null != endTime && !"".equals(endTime)) {
			sf.append(" ownerIncomeSum.genDate <= ? and");
			try {
				list.add(sdf.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(list.size() != 0 ) {
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		} else {
			sf = sf.replace(sf.length() - 6, sf.length(), "");
		}
		
		// ������������Է�ҳ��������
		Long count = this.executeCount(sf.toString(), list.toArray());
		pager.setTotalSize(count);
		//��ʱ�併������¼����
		return this.executeQuery(pager, sf.toString() + " order by genDate desc", list.toArray());
	}
	
}
