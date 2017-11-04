package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CardGroupDao;
import com.hgsoft.entity.CardGroup;
import com.hgsoft.util.Pager;

@Service
public class CardGroupService extends BaseService<CardGroup> {

	@Autowired
	public void setDao(@Qualifier("cardGroupDao") CardGroupDao dao) {
		super.setDao(dao);
	}

	private CardGroupDao getCardGroupDao() {
		return (CardGroupDao) this.getDao();
	}

	public List<CardGroup> getCardGroupByGroupNo(Pager pager, int groupNo) {
		return getCardGroupDao().getCardGroupByGroupNo(pager, groupNo);
	}

	public List<Object[]> getUserCardInfoAndCardGroupByGroupNoAndLaneGroupNo(Pager pager, int groupNo,
			int laneGroupNo) {
		return getCardGroupDao().getUserCardInfoAndCardGroupByGroupNoAndLaneGroupNo(pager, groupNo, laneGroupNo);
	}

	public void deleteByRecNO(int recNo) {
		getCardGroupDao().deleteByRecNO(recNo);
	}

	public void deleteByGroupNo(int groupNo) {
		getCardGroupDao().deleteByGroupNo(groupNo);
	}

	public void deleteByCardNo(String cardNo) {
		getCardGroupDao().deleteByCardNo(cardNo);
	}

}
