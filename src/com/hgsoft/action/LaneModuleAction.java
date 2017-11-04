package com.hgsoft.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.LaneModule;
import com.hgsoft.service.LaneModuleService;
import com.hgsoft.service.SystemLogService;

@Controller
@Scope("prototype")
public class LaneModuleAction extends BaseAction {

	private LaneModule laneModule;
	@Resource
	private LaneModuleService laneModuleService; 
	@Resource
	private SystemLogService systemLogService; 
	public String list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("moduleNo");
		session.removeAttribute("moduleName");
		
		list = laneModuleService.findByPager(pager);
		return "laneModule_list";
	}
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("moduleNo");
		session.removeAttribute("moduleName");
		
		if (!laneModule.getModuleNo().equals("")
				||!laneModule.getModuleName().equals("")) {
			session.setAttribute("moduleNo", laneModule.getModuleNo());
			session.setAttribute("moduleName", laneModule.getModuleName());
			list=laneModuleService.findLaneModuleByCondition(pager, laneModule.getModuleNo(), laneModule.getModuleName());
			return "laneModule_list";
		}else {
			return list();
		}
	}
	
	//save module
	public String add(){
		return "laneModule_add";
	}
	public String save(){
		if(laneModuleService.ishasLaneModule(laneModule.getModuleNo())==null){
			
			LaneModule lmTemp=new LaneModule();
			lmTemp.setModuleNo(laneModule.getModuleNo().trim());
			lmTemp.setModuleName(laneModule.getModuleName().trim());
			lmTemp.setRemark(laneModule.getRemark().trim());
			
			laneModuleService.save(lmTemp);
			result=Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加模块信息["+laneModule.getModuleNo()+"]成功", "模块信息-添加", "tb_Module");
			lmTemp=null;
		}else{
			message="exitLaneModule";
			return "laneModule_add";
		}
		laneModule=null;
		return list() ;
	}
	
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		laneModule=laneModuleService.get(laneModule.getModuleNo());
		return "laneModule_edit";
	}
	public String update(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		LaneModule lmTemp=new LaneModule();
		lmTemp.setModuleNo(laneModule.getModuleNo().trim());
		lmTemp.setModuleName(laneModule.getModuleName().trim());
		lmTemp.setRemark(laneModule.getRemark().trim());
		
		laneModuleService.update(lmTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户更新模块信息["+laneModule.getModuleNo()+"]成功", "模块信息-更新", "tb_Module");
		lmTemp=null;
		
		if (session.getAttribute("moduleNo")!=null
				||session.getAttribute("moduleName")!=null) {
			laneModule.setModuleNo((String)session.getAttribute("moduleNo"));
			laneModule.setModuleName((String)session.getAttribute("moduleName"));
			list=laneModuleService.findLaneModuleByCondition(pager, laneModule.getModuleNo(), laneModule.getModuleName());

			return "laneModule_list";
		}else {
			list = laneModuleService.findByPager(pager);
			laneModule=null;
			return "laneModule_list";
		}
	}
	public String delete(){
		laneModuleService.delete(laneModule.getModuleNo());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除模块信息["+laneModule.getModuleNo()+"]成功", "模块信息-删除", "tb_Module");
		laneModule=null;
		return list() ;
	}
	
	//Getter/Setter
	public LaneModule getLaneModule() {
		return laneModule;
	}

	public void setLaneModule(LaneModule laneModule) {
		this.laneModule = laneModule;
	}

}
