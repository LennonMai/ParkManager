package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneOperatorRoleDao;
import com.hgsoft.entity.LaneOperatorRole;
import com.hgsoft.util.Pager;

@Service
public class LaneOperatorRoleService extends BaseService<LaneOperatorRole> {

	@Autowired
	public void setDao(@Qualifier("laneOperatorRoleDao") LaneOperatorRoleDao dao) {
		super.setDao(dao);
	}

	private LaneOperatorRoleDao getLaneOperatorRoleDao() {
		return (LaneOperatorRoleDao) this.getDao();
	}

	public List<LaneOperatorRole> findLaneOperatorRoleByCondition(Pager pager, Integer operatorNo, Short roleNo) {
		return getLaneOperatorRoleDao().findLaneOperatorRoleByCondition(pager, operatorNo, roleNo);
	}

	public List<LaneOperatorRole> ishasLaneOperatorRole(Integer operatorNo, Short roleNo) {
		return getLaneOperatorRoleDao().ishasLaneOperatorRole(operatorNo, roleNo);
	}

	public boolean _update(LaneOperatorRole laneOperatorRole, Integer operatorNo, Short roleNo) {
		return getLaneOperatorRoleDao()._update(laneOperatorRole, operatorNo, roleNo);
	}

	public String[] fineLaneOperatorRole(Integer operatorNo) {
		return getLaneOperatorRoleDao().fineLaneOperatorRole(operatorNo);
	}

	public boolean _delete(Integer operatorNo) {
		return getLaneOperatorRoleDao()._delete(operatorNo);
	}

	public boolean _deleteByroleNo(Short roleNo) {
		return getLaneOperatorRoleDao()._deleteByroleNo(roleNo);
	}
}
