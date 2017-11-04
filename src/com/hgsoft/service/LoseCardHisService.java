package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.LoseCardHisDao;
import com.hgsoft.entity.AllOutList;
import com.hgsoft.entity.LoseCardHis;
import com.hgsoft.util.Pager;

@Service
public class LoseCardHisService {

	@Resource
	private LoseCardHisDao loseCardHisDao;

	/**
	 * ��ѯ������ʷ��¼
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager, String startTime, String endTime, String cardNo, String vehPlate, String owner) {
		return loseCardHisDao.query(pager, startTime, endTime, cardNo, vehPlate, owner);
	}

	/**
	 * ���� cardNo �� opTime��ö���
	 */
	public LoseCardHis get(String cardNo, Date opTime) {
		return loseCardHisDao.getById(cardNo, opTime);
	}

	/**
	 * ���ݿ��ţ�ɾ��tb_losecardhis������
	 */
	public void deleteByCardNoAndOpTime(String cardNo, String opTime) {
		loseCardHisDao.deleteByCardNoAndOpTime(cardNo, opTime);
	}

	/**
	 * ���ݳ�����ˮ�ţ�������ͼ�в�ѯ����
	 * 
	 * @param outListNo
	 * @return
	 */
	public AllOutList getByOutListNo(String outListNo) {
		return loseCardHisDao.getByOutListNo(outListNo);
	}

	public void saveHis(LoseCardHis his) {
		loseCardHisDao.save(his);
	}
}
