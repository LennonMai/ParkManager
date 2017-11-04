package com.hgsoft.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CardHandOutInDao;
import com.hgsoft.entity.CardHandOutIn;
import com.hgsoft.util.Pager;

@Service
public class CardHandOutInService extends BaseService<CardHandOutIn> {

	@Autowired
	public void setDao(@Qualifier("cardHandOutInDao") CardHandOutInDao dao) {
		super.setDao(dao);
	}

	private CardHandOutInDao getCardHandOutInDao() {
		return (CardHandOutInDao) this.getDao();
	}

	public List<CardHandOutIn> findAllItemByHql(Pager pager, Timestamp squadDate, Short squadNo, Short type,
			Short parkNo, Short gateNo, Short laneNo, Integer operatorNo, Integer recorderNo) {
		return getCardHandOutInDao().findAllItemByHql(pager, squadDate, squadNo, type, parkNo, gateNo, laneNo,
				operatorNo, recorderNo);
	}

	public Integer getMaxRecordNo() {
		return getCardHandOutInDao().getMaxRecordNo();
	}

}
