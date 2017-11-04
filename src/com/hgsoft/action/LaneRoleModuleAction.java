package com.hgsoft.action;

import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.LaneRoleModule;
import com.hgsoft.service.LaneRoleModuleService;

@Controller
@Scope("prototype")
public class LaneRoleModuleAction extends BaseAction{
	private LaneRoleModule laneRoleModule;
	@Resource
	private LaneRoleModuleService laneRoleModuleService; 
	
	public String list() {
		list = laneRoleModuleService.findByPager(pager);
		return "laneRoleModule_list";
	}
	public String query(){
		if (laneRoleModule.getRoleNo()!=null
				|| !laneRoleModule.getModuleNo().equals("")) {
			list=laneRoleModuleService.findLaneRoleModuleByCondition(pager, laneRoleModule.getRoleNo(), laneRoleModule.getModuleNo());
		}else {
			return list();
		}
		
		return "laneRoleModule_list";
	}
	
	//Getter/Setter
	public LaneRoleModule getLaneRoleModule() {
		return laneRoleModule;
	}

	public void setLaneRoleModule(LaneRoleModule laneRoleModule) {
		this.laneRoleModule = laneRoleModule;
	}
}
