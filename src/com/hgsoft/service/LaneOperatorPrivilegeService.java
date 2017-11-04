package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneOperatorPrivilegeDao;
import com.hgsoft.entity.LaneOperatorPrivilege;
import com.hgsoft.util.Pager;

@Service
public class LaneOperatorPrivilegeService extends BaseService<LaneOperatorPrivilege> {

	@Autowired
	public void setDao(@Qualifier("laneOperatorPrivilegeDao") LaneOperatorPrivilegeDao dao) {
		super.setDao(dao);
	}

	private LaneOperatorPrivilegeDao getLaneOperatorPrivilegeDao() {
		return (LaneOperatorPrivilegeDao) this.getDao();
	}

	public List<LaneOperatorPrivilege> findLaneOperatorPrivilegeByCondition(Pager pager, Integer operatorNo,
			String moduleNo) {
		return getLaneOperatorPrivilegeDao().findLaneOperatorPrivilegeByCondition(pager, operatorNo, moduleNo);
	}

}
