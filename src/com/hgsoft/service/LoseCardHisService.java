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
	 * 查询丢卡历史记录
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager, String startTime, String endTime, String cardNo, String vehPlate, String owner) {
		return loseCardHisDao.query(pager, startTime, endTime, cardNo, vehPlate, owner);
	}

	/**
	 * 根据 cardNo 和 opTime获得对象
	 */
	public LoseCardHis get(String cardNo, Date opTime) {
		return loseCardHisDao.getById(cardNo, opTime);
	}

	/**
	 * 根据卡号，删除tb_losecardhis中数据
	 */
	public void deleteByCardNoAndOpTime(String cardNo, String opTime) {
		loseCardHisDao.deleteByCardNoAndOpTime(cardNo, opTime);
	}

	/**
	 * 根据出口流水号，到总试图中查询数据
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
