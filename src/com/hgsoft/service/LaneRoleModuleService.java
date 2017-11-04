package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneRoleModuleDao;
import com.hgsoft.entity.LaneRoleModule;
import com.hgsoft.util.Pager;

@Service
public class LaneRoleModuleService extends BaseService<LaneRoleModule> {

	@Autowired
	public void setDao(@Qualifier("laneRoleModuleDao") LaneRoleModuleDao dao) {
		super.setDao(dao);
	}

	private LaneRoleModuleDao getLaneRoleModuleDao() {
		return (LaneRoleModuleDao) this.getDao();
	}

	public List<LaneRoleModule> findLaneRoleModuleByCondition(Pager pager, Short roleNo, String moduleNo) {
		return getLaneRoleModuleDao().findLaneRoleModuleByCondition(pager, roleNo, moduleNo);
	}

	public List<LaneRoleModule> ishasRoleModule(Short roleNo, String moduleNo) {
		return getLaneRoleModuleDao().ishasRoleModule(roleNo, moduleNo);
	}

	public List<LaneRoleModule> findRoleModule(Short roleNo) {
		return getLaneRoleModuleDao().findRoleModule(roleNo);
	}

	public boolean _delete(Short roleNo) {
		return getLaneRoleModuleDao()._delete(roleNo);
	}

	public List initOtherRoleModule(Short roleNo) {
		return getLaneRoleModuleDao().initOtherRoleModule(roleNo);
	}
}
