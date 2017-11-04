package com.hgsoft.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.LaneOperator;
import com.hgsoft.entity.LaneOperatorRole;
import com.hgsoft.service.LaneOperatorRoleService;
import com.hgsoft.service.LaneOperatorService;
import com.hgsoft.service.LaneRoleService;
import com.hgsoft.service.SystemLogService;

@Controller
@Scope("prototype")
public class LaneOperatorAction extends BaseAction {
	
	private String roles;
	private String[] _roles;
	private String operatorRoles="";
	private LaneOperator laneOperator;
	@Resource
	private LaneRoleService laneRoleService;
	@Resource
	private LaneOperatorService laneOperatorService;
	@Resource
	private LaneOperatorRoleService laneOperatorRoleService;
	@Resource
	private SystemLogService systemLogService; 
	
	public String list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("parkNo");
		session.removeAttribute("status");
		session.removeAttribute("operatorNo");
		session.removeAttribute("operatorName");
		session.removeAttribute("opCardId");
		session.removeAttribute("opCardNo");
		
		list = laneOperatorService.findByPager(pager);
		return "laneOperator_list";
	}
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("parkNo");
		session.removeAttribute("status");
		session.removeAttribute("operatorNo");
		session.removeAttribute("operatorName");
		session.removeAttribute("opCardId");
		session.removeAttribute("opCardNo");
		
		if (laneOperator.getParkNo()!=null
				|| !laneOperator.getStatus().equals("")
				|| laneOperator.getOperatorNo()!=null
				|| !laneOperator.getOperatorName().equals("")
				|| !laneOperator.getOpCardId().equals("")
				|| laneOperator.getOpCardNo()!=null) {
			session.setAttribute("parkNo", laneOperator.getParkNo());
			session.setAttribute("status", laneOperator.getStatus());
			session.setAttribute("operatorNo", laneOperator.getOperatorNo());
			session.setAttribute("operatorName", laneOperator.getOperatorName());
			session.setAttribute("opCardId", laneOperator.getOpCardId());
			session.setAttribute("opCardNo", laneOperator.getOpCardNo());
			list=laneOperatorService.findLaneOperatorByCondition(pager, laneOperator.getParkNo(), laneOperator.getStatus(), laneOperator.getOperatorNo(), laneOperator.getOperatorName(), laneOperator.getOpCardId(), laneOperator.getOpCardNo());
			return "laneOperator_list";
		}else {
			return list();
		}
	}
	
	//save Operator
	public String add(){
		list=laneRoleService.findLaneRole();
		return "laneOperator_add";
	}
	public String save(){
		if(laneOperatorService.ishasLaneOperator(laneOperator.getOperatorNo())==null){
			
			if(!this.roles.toString().equals("")){
				this._roles=this.trimNull(this.roles.toString().trim().split(","));
				LaneOperatorRole laneOperatorRole=new LaneOperatorRole();
				for(int i=0;i<this._roles.length;i++){
					if(laneOperatorRoleService.ishasLaneOperatorRole(laneOperator.getOperatorNo(), Short.valueOf(this._roles[i].trim()))==null){
						laneOperatorRole.setOperatorNo(laneOperator.getOperatorNo());
					    laneOperatorRole.setRoleNo(Short.valueOf(this._roles[i].trim()));
						laneOperatorRoleService.save(laneOperatorRole);
						}else{
							laneOperatorRole.setOperatorNo(laneOperator.getOperatorNo());
						    laneOperatorRole.setRoleNo(Short.valueOf(this._roles[i].trim()));
						    laneOperatorRoleService._update(laneOperatorRole,laneOperator.getOperatorNo(),Short.valueOf(this._roles[i].trim()));
						} 
						
				}
			}
			
			LaneOperator loTemp=new LaneOperator();
			loTemp.setAreaNo(laneOperator.getAreaNo());
			loTemp.setOpCardId(laneOperator.getOpCardId().trim());
			loTemp.setOpCardNo(laneOperator.getOpCardNo());
			loTemp.setOperatorName(laneOperator.getOperatorName().trim());
			loTemp.setOperatorNo(laneOperator.getOperatorNo());
			loTemp.setParkNo(laneOperator.getParkNo());
			loTemp.setPassword(laneOperator.getPassword().trim());
			loTemp.setStatus(laneOperator.getStatus().trim());
			
			laneOperatorService.save(loTemp);
			result=Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加操作员信息["+laneOperator.getOperatorNo()+"]成功", "操作员信息-添加", "tb_Operator");
			loTemp=null;
		}else{
			message="exitLaneOperator";
			list=laneRoleService.findLaneRole();
			return "laneOperator_add";
		}
		laneOperator=null;
		return list() ;
	}
	//修改跳转
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		String[] roleArray=laneOperatorRoleService.fineLaneOperatorRole(laneOperator.getOperatorNo());
		if(roleArray!=null){
			for(int i=0;i<roleArray.length;i++){
				if(i!=roleArray.length-1)
					operatorRoles+=roleArray[i].toString()+"_";
				else 
					operatorRoles+=roleArray[i].toString();
			}
		}else operatorRoles="";
		list=laneRoleService.findLaneRole();
		laneOperator=laneOperatorService.get(laneOperator.getOperatorNo());

		return "laneOperator_edit";
	}
	public String update(){
		//如果没有设置角色，则不更新该操作员的角色信息
		if(!this.roles.toString().equals("")){
			this._roles=this.trimNull(this.roles.toString().trim().split(","));
			LaneOperatorRole laneOperatorRole=new LaneOperatorRole();
			
			//更新该角色信息前先删除该操作员的角色信息
			laneOperatorRoleService._delete(laneOperator.getOperatorNo());
			for(int i=0;i<this._roles.length;i++){
				if(laneOperatorRoleService.ishasLaneOperatorRole(laneOperator.getOperatorNo(), Short.valueOf(this._roles[i].trim()))==null){
					laneOperatorRole.setOperatorNo(laneOperator.getOperatorNo());
				    laneOperatorRole.setRoleNo(Short.valueOf(this._roles[i].trim()));
					laneOperatorRoleService.save(laneOperatorRole);
					}else{
						laneOperatorRole.setOperatorNo(laneOperator.getOperatorNo());
					    laneOperatorRole.setRoleNo(Short.valueOf(this._roles[i].trim()));
					    laneOperatorRoleService._update(laneOperatorRole,laneOperator.getOperatorNo(),Short.valueOf(this._roles[i].trim()));
					} 
			}
		}
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		LaneOperator loTemp=new LaneOperator();
		loTemp.setAreaNo(laneOperator.getAreaNo());
		loTemp.setOpCardId(laneOperator.getOpCardId().trim());
		loTemp.setOpCardNo(laneOperator.getOpCardNo());
		loTemp.setOperatorName(laneOperator.getOperatorName().trim());
		loTemp.setOperatorNo(laneOperator.getOperatorNo());
		loTemp.setParkNo(laneOperator.getParkNo());
		loTemp.setPassword(laneOperator.getPassword().trim());
		loTemp.setStatus(laneOperator.getStatus().trim());
		
		
		//更新操作员信息
		laneOperatorService.update(loTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改操作员信息["+laneOperator.getOperatorNo()+"]成功", "操作员信息-修改", "tb_Operator");
		loTemp=null;
		
		if (session.getAttribute("parkNo")!=null
				|| session.getAttribute("status")!=null
				|| session.getAttribute("operatorNo")!=null
				|| session.getAttribute("operatorName")!=null
				|| session.getAttribute("opCardId")!=null
				|| session.getAttribute("opCardNo")!=null){
			
			laneOperator.setParkNo((Short)session.getAttribute("parkNo"));
			laneOperator.setStatus((String)session.getAttribute("status"));
			laneOperator.setOperatorNo((Integer)session.getAttribute("operatorNo"));
			laneOperator.setOperatorName((String)session.getAttribute("operatorName"));
			laneOperator.setOpCardId((String)session.getAttribute("opCardId"));
			laneOperator.setOpCardNo((Integer)session.getAttribute("opCardNo"));
			
			list=laneOperatorService.findLaneOperatorByCondition(pager, laneOperator.getParkNo(), laneOperator.getStatus(), laneOperator.getOperatorNo(), laneOperator.getOperatorName(), laneOperator.getOpCardId(), laneOperator.getOpCardNo());
			return "laneOperator_list";
		}else {
			list = laneOperatorService.findByPager(pager);
			laneOperator=null;
			return "laneOperator_list";
		}
	}
	public String delete(){
		//删除操作员信息时同时删除其对应的角色信息
		laneOperatorRoleService._delete(laneOperator.getOperatorNo());
		laneOperatorService.delete(laneOperator.getOperatorNo());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除操作员信息["+laneOperator.getOperatorNo()+"]成功", "操作员信息-删除", "tb_Operator,tb_OperatorRole");
		laneOperator=null;
		return list() ;
	}
	
	@SuppressWarnings({ "unchecked" })
	private String[] trimNull(String[] str){
		List list=new ArrayList();
		for(int i=0;i<str.length;i++){
			if(!str[i].equals("")){
				list.add(str[i]);
			}
		}
		String[] arr=new String[list.size()];
		for(int i=0;i<list.size();i++){
			arr[i]=list.get(i).toString();
		}
		return arr;
	}
	
	//Getter/Setter
	public LaneOperator getLaneOperator() {
		return laneOperator;
	}

	public void setLaneOperator(LaneOperator laneOperator) {
		this.laneOperator = laneOperator;
	}
	public String getRoles() {
		return roles;
	}
	public void setRoles(String roles) {
		this.roles = roles;
	}
	public String[] get_roles() {
		return _roles;
	}
	public void set_roles(String[] roles) {
		_roles = roles;
	}

	public String getOperatorRoles() {
		return operatorRoles;
	}
	public void setOperatorRoles(String operatorRoles) {
		this.operatorRoles = operatorRoles;
	}

}
