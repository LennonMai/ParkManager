package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.OutListDao;
import com.hgsoft.entity.OutList;
import com.hgsoft.util.Pager;

/**
 * �����ˮService
 * 
 * @author caijunhua
 *
 */

@Service
public class OutListService extends BaseService<OutList> {

	@Autowired
	public void setDao(@Qualifier("outListDao") OutListDao dao) {
		super.setDao(dao);
	}

	private OutListDao getOutListDao() {
		return (OutListDao) this.getDao();
	}

	/**
	 * ���ݲ�ѯ������ѯ������ˮ
	 * 
	 * @param pager
	 * @param cardNo
	 *            ����
	 * @param vehPlate
	 *            ���ƺ�
	 * @param listNo
	 *            ��ˮ��
	 * @param vehClass
	 *            ����
	 * @param startTime1
	 *            ��ʼʱ��
	 * @param endTime1
	 *            ����ʱ��
	 * @return
	 */
	public List<OutList> findAllOutListByHql(Pager pager, String cardNo, String vehPlate, String listNo, Short vehClass,
			Date startTime1, Date endTime1) {
		return getOutListDao().findAllOutListByHql(pager, cardNo, vehPlate, listNo, vehClass, startTime1, endTime1);
	}

}
