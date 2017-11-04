package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SpVehHandleDao;
import com.hgsoft.entity.SpVehHandle;
import com.hgsoft.util.Pager;

/**
 * ���⳵��������ϢService
 * 
 * @author caijunhua
 *
 */

@Service
public class SpVehHandleService extends BaseService<SpVehHandle> {

	@Autowired
	public void setDao(@Qualifier("spVehHandleDao") SpVehHandleDao dao) {
		super.setDao(dao);
	}

	private SpVehHandleDao getSpVehHandleDao() {
		return (SpVehHandleDao) this.getDao();
	}

	/**
	 * ���ݲ�ѯ������ѯ���⳵��������Ϣ
	 * 
	 * @param pager
	 * @param laneType
	 *            ��������
	 * @param tableName
	 *            ����
	 * @param status
	 *            ״̬
	 * @param handleType
	 *            ��������
	 * @return
	 */
	public List<SpVehHandle> findSpVehHandleByHql(Pager pager, Short laneType, String tableName, Integer status,
			Integer handleType) {
		return getSpVehHandleDao().findSpVehHandleByHql(pager, laneType, tableName, status, handleType);
	}

}
