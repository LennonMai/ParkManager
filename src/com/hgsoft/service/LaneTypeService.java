package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneTypeDao;
import com.hgsoft.entity.LaneType;
import com.hgsoft.util.Pager;

@Service
public class LaneTypeService extends BaseService<LaneType> {

	@Autowired
	public void setDao(@Qualifier("laneTypeDao") LaneTypeDao dao) {
		super.setDao(dao);
	}

	private LaneTypeDao getLaneTypeDao() {
		return (LaneTypeDao) this.getDao();
	}

	public List<LaneType> findByCondition(Pager pager, Short laneTypeNo, String laneTypeName) {
		return getLaneTypeDao().findByCondition(pager, laneTypeNo, laneTypeName);
	}

}
