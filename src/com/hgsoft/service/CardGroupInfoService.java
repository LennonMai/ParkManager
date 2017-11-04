package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CardGroupInfoDao;
import com.hgsoft.entity.CardGroupInfo;
import com.hgsoft.util.Pager;

@Service
public class CardGroupInfoService extends BaseService<CardGroupInfo> {

	@Autowired
	public void setDao(@Qualifier("cardGroupInfoDao") CardGroupInfoDao dao) {
		super.setDao(dao);
	}

	private CardGroupInfoDao getCardGroupInfoDao() {
		return (CardGroupInfoDao) this.getDao();
	}

	public List<CardGroupInfo> getAllCardGroupInfoByPager(Pager pager) {
		return getCardGroupInfoDao().getAllCardGroupInfoByPager(pager);
	}

	public CardGroupInfo getCardGroupInfoByGroupNo(int groupNo) {
		return getCardGroupInfoDao().getCardGroupInfoByGroupNo(groupNo);
	}

	public List<CardGroupInfo> findAllItemByHql(Pager pager, Integer groupNo, String groupName) {
		return getCardGroupInfoDao().findAllItemByHql(pager, groupNo, groupName);
	}

	public Integer getMaxGroupNo() {
		return getCardGroupInfoDao().getMaxGroupNo();
	}

	public CardGroupInfo getCardGroupInfoByGroupNoAndLaneGroupNo(int groupNo, int laneGroupNo) {
		return getCardGroupInfoDao().getCardGroupInfoByGroupNoAndLaneGroupNo(groupNo, laneGroupNo);
	}

	public void deleteByGroupNo(int groupNo) {
		getCardGroupInfoDao().deleteByGroupNo(groupNo);
	}

}
