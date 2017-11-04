package com.hgsoft.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.LaneOperatorRole;
import com.hgsoft.service.LaneOperatorRoleService;

@Controller
@Scope("prototype")
public class LaneOperatorRoleAction extends BaseAction {
	
	private LaneOperatorRole laneOperatorRole;
	
	@Resource
	private LaneOperatorRoleService laneOperatorRoleService;
	public String list() {
		list = laneOperatorRoleService.findByPager(pager);
		return "laneOperatorRole_list";
	}
	public String query(){
		if (laneOperatorRole.getOperatorNo()!=null
				|| laneOperatorRole.getRoleNo()!=null) {
			
			list=laneOperatorRoleService.findLaneOperatorRoleByCondition(pager, laneOperatorRole.getOperatorNo(), laneOperatorRole.getRoleNo());
		}else {
			return list();
		}
		
		return "laneOperatorRole_list";
	}
	//Getter/Setter
	public LaneOperatorRole getLaneOperatorRole() {
		return laneOperatorRole;
	}
	public void setLaneOperatorRole(LaneOperatorRole laneOperatorRole) {
		this.laneOperatorRole = laneOperatorRole;
	}
}
