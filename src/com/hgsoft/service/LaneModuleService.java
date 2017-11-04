package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneModuleDao;
import com.hgsoft.entity.LaneModule;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Service
public class LaneModuleService extends BaseService<LaneModule> {

	@Autowired
	public void setDao(@Qualifier("laneModuleDao") LaneModuleDao dao) {
		super.setDao(dao);
	}

	private LaneModuleDao getLaneModuleDao() {
		return (LaneModuleDao) this.getDao();
	}

	public List<LaneModule> findLaneModuleByCondition(Pager pager, String moduleNo, String moduleName) {
		return getLaneModuleDao().findLaneModuleByCondition(pager, moduleNo, moduleName);
	}

	public List<LaneModule> findLaneModule() {
		return getLaneModuleDao().findLaneModule();
	}

	public List<LaneModule> ishasLaneModule(Object moduleNo) {
		return getLaneModuleDao().ishasLaneModule(moduleNo);
	}

	public void delete(String moduleNo) {
		if (this.ishasLaneModule(moduleNo) != null) {
			this.deleteById(moduleNo);
		}

	}
}
