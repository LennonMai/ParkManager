package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.InList;
import com.hgsoft.util.Pager;

/**
 * �����ˮDAO
 * @author caijunhua
 *
 */

@Repository 
public class InListDao extends BaseDao<InList> {
	/**
	 * ���ݲ�ѯ������ѯ�����ˮ
	 * @param pager
	 * @param cardNo ����
	 * @param vehPlate ���ƺ�
	 * @param listNo ��ˮ��
	 * @param vehClass ����
	 * @param startTime1 ��ʼʱ��
	 * @param endTime1 ����ʱ��
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<InList> findAllInListByHql(Pager pager,
			String cardNo, String vehPlate, String listNo, Short vehClass,Date startTime1,Date endTime1) {

		StringBuffer sf = new StringBuffer("from InList inlist where");
		List<Object> obj = new ArrayList<Object>();
		if (cardNo != null) {
			sf.append(" inlist.cardNo=? and");
			obj.add(cardNo);
		}
		if (!vehPlate.equals("")) {
			sf.append(" inlist.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!listNo.equals("")) {
			sf.append(" inlist.listNo like ? and");
			obj.add("%" + listNo + "%");
		}
		if (vehClass != null) {
			sf.append(" inlist.vehClass=? and");
			obj.add(vehClass);
		}
		if (startTime1 != null) {
			sf.append(" inlist.opTime>=? and");
			obj.add(startTime1);
		}
		if (endTime1 != null) {
			sf.append(" inlist.opTime<=? and");
			obj.add(endTime1);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//System.out.println(sf.toString()+"--------------"+obj.get(1));
		
		// ������������Է�ҳ��������
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//��ʱ�併������¼����
		return this.executeQuery(pager, sf.toString() + " order by opTime desc", obj.toArray());
	}
}
