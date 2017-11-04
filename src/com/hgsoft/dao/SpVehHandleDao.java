package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SpVehHandle;
import com.hgsoft.util.Pager;


/**
 * ���⳵��������ϢDAO
 * @author caijunhua
 *
 */

@Repository
public class SpVehHandleDao extends BaseDao<SpVehHandle> {
	/**
	 * ���ݲ�ѯ������ѯ���⳵��������Ϣ
	 * @param pager
	 * @param laneType ��������
	 * @param tableName ����
	 * @param status ״̬
	 * @param handleType ��������
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SpVehHandle> findSpVehHandleByHql(Pager pager,
			Short laneType, String tableName, Integer status, Integer handleType) {

		StringBuffer sf = new StringBuffer("from SpVehHandle spVehHandle where");
		List<Object> list = new ArrayList<Object>();
		if (null != laneType && !"".equals(laneType)) {
			sf.append(" spVehHandle.laneType = ? and");
			list.add(laneType);
		}
		if (null != tableName && !"".equals(tableName)) {
			sf.append(" spVehHandle.tableName like ? and");
			list.add("%" + tableName + "%");
		}
		if (null != status && !"".equals(status)) {
			sf.append(" spVehHandle.status = ? and");
			list.add(status);
		}
		if (null != handleType && !"".equals(handleType)) {
			sf.append(" spVehHandle.handleType = ? and");
			list.add(handleType);
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
		return this.executeQuery(pager, sf.toString() + " order by laneType,tableName,status asc", list.toArray());
	}
	
}
