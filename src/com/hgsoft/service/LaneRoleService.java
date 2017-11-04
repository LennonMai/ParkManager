package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneRoleDao;
import com.hgsoft.entity.LaneRole;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Service
public class LaneRoleService extends BaseService<LaneRole> {

	@Autowired
	public void setDao(@Qualifier("laneRoleDao") LaneRoleDao dao) {
		super.setDao(dao);
	}

	private LaneRoleDao getLaneRoleDao() {
		return (LaneRoleDao) this.getDao();
	}

	public List<LaneRole> findLaneRoleByCondition(Pager pager, Short roleNo, String roleName) {
		return getLaneRoleDao().findLaneRoleByCondition(pager, roleNo, roleName);
	}

	public List<LaneRole> ishasLaneRole(Object roleNo) {
		return getLaneRoleDao().ishasLaneRole(roleNo);
	}

	public List<LaneRole> findLaneRole() {
		return getLaneRoleDao().findLaneRole();
	}

	public void delete(Short roleNo) {
		if (this.ishasLaneRole(roleNo) != null) {
			this.deleteById(roleNo);
		}
	}
}
