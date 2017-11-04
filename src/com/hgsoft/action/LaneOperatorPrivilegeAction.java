package com.hgsoft.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.LaneOperatorPrivilege;
import com.hgsoft.service.LaneOperatorPrivilegeService;

@Controller
@Scope("prototype")
public class LaneOperatorPrivilegeAction extends BaseAction{


	private LaneOperatorPrivilege laneOperatorPrivilege;
	@Resource
	private LaneOperatorPrivilegeService laneOperatorPrivilegeService;
	
	public String list() {
		list = laneOperatorPrivilegeService.findByPager(pager);
		return "laneOperatorPrivilege_list";
	}
	public String query(){
		if (laneOperatorPrivilege.getOperatorNo()!=null
				|| !laneOperatorPrivilege.getModuleNo().equals("")) {
			list=laneOperatorPrivilegeService.findLaneOperatorPrivilegeByCondition(pager, laneOperatorPrivilege.getOperatorNo(), laneOperatorPrivilege.getModuleNo());
		}else {
			return list();
		}
		
		return "laneOperatorPrivilege_list";
	}
	
	//Getter/Setter
	public LaneOperatorPrivilege getLaneOperatorPrivilege() {
		return laneOperatorPrivilege;
	}

	public void setLaneOperatorPrivilege(LaneOperatorPrivilege laneOperatorPrivilege) {
		this.laneOperatorPrivilege = laneOperatorPrivilege;
	}
}
