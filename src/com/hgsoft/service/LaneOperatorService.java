package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneOperatorDao;
import com.hgsoft.entity.LaneOperator;
import com.hgsoft.util.Pager;

@Service
public class LaneOperatorService extends BaseService<LaneOperator> {

	@Autowired
	public void setDao(@Qualifier("laneOperatorDao") LaneOperatorDao dao) {
		super.setDao(dao);
	}

	private LaneOperatorDao getLaneOperatorDao() {
		return (LaneOperatorDao) this.getDao();
	}

	public List<LaneOperator> findLaneOperatorByCondition(Pager pager, Short parkNo, String status, Integer operatorNo,
			String operatorName, String opCardId, Integer opCardNo) {
		return getLaneOperatorDao().findLaneOperatorByCondition(pager, parkNo, status, operatorNo, operatorName,
				opCardId, opCardNo);
	}

	public List<LaneOperator> ishasLaneOperator(Object operatorNo) {
		return getLaneOperatorDao().ishasLaneOperator(operatorNo);
	}

	public void delete(Integer operatorNo) {
		if (this.ishasLaneOperator(operatorNo) != null) {
			this.deleteById(operatorNo);
		}

	}
}
