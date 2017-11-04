package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.InListDao;
import com.hgsoft.entity.InList;
import com.hgsoft.util.Pager;

/**
 * �����ˮService
 * 
 * @author caijunhua
 *
 */

@Service
public class InListService extends BaseService<InList> {

	@Autowired
	public void setDao(@Qualifier("inListDao") InListDao dao) {
		super.setDao(dao);
	}

	private InListDao getInListDao() {
		return (InListDao) this.getDao();
	}

	/**
	 * ���ݲ�ѯ������ѯ�����ˮ
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
	public List<InList> findAllInListByHql(Pager pager, String cardNo, String vehPlate, String listNo, Short vehClass,
			Date startTime1, Date endTime1) {
		return getInListDao().findAllInListByHql(pager, cardNo, vehPlate, listNo, vehClass, startTime1, endTime1);
	}

}
