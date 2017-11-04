package com.hgsoft.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.LaneRole;
import com.hgsoft.entity.LaneRoleModule;
import com.hgsoft.service.LaneModuleService;
import com.hgsoft.service.LaneOperatorRoleService;
import com.hgsoft.service.LaneRoleModuleService;
import com.hgsoft.service.LaneRoleService;
import com.hgsoft.service.SystemLogService;

@Controller
@Scope("prototype")
public class LaneRoleAction extends BaseAction {

	private LaneRole laneRole;
	@Resource
	private LaneRoleService laneRoleService; 
	@Resource
	private LaneModuleService laneModuleService;
	@Resource
	private LaneRoleModuleService laneRoleModuleService;
	@Resource
	private LaneOperatorRoleService laneOperatorRoleService; 
	@Resource
	private SystemLogService systemLogService; 
	private String modulePrivilege;
	@SuppressWarnings("rawtypes")
	private HashMap<String, List> mpMap;
	private StringBuffer rmPrivilege;
	
	public String list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("roleNo");
		session.removeAttribute("roleName");
		
		list = laneRoleService.findByPager(pager);
		return "laneRole_list";
	}
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("roleNo");
		session.removeAttribute("roleName");
		
		if (laneRole.getRoleNo()!=null
				|| !laneRole.getRoleName().equals("")) {
			
			session.setAttribute("roleNo", laneRole.getRoleNo());
			session.setAttribute("roleName", laneRole.getRoleName());
			list=laneRoleService.findLaneRoleByCondition(pager, laneRole.getRoleNo(), laneRole.getRoleName());
			return "laneRole_list";
		}else {
			return list();
		}	
	}
	//save role
	public String add(){
		return "laneRole_add";
	}
	public String save(){
		if(laneRoleService.ishasLaneRole(laneRole.getRoleNo())==null){
			
			LaneRole lrTemp=new LaneRole();
			lrTemp.setRoleNo(laneRole.getRoleNo());
			lrTemp.setRoleName(laneRole.getRoleName().trim());
			lrTemp.setRemark(laneRole.getRemark().trim());
			
			laneRoleService.save(lrTemp);
			result=Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加角色信息["+laneRole.getRoleNo()+"]成功", "角色信息-添加", "tb_Role");
			
			lrTemp=null;
			
		}else{
			message="exitLaneRole";
			return "laneRole_add";
		}
		
		laneRole=null;
		return list() ;
	}
	
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		laneRole=laneRoleService.get(laneRole.getRoleNo());
		return "laneRole_edit";
	}
	public String update(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		LaneRole lrTemp=new LaneRole();
		lrTemp.setRoleNo(laneRole.getRoleNo());
		lrTemp.setRoleName(laneRole.getRoleName().trim());
		lrTemp.setRemark(laneRole.getRemark().trim());
		
		laneRoleService.update(lrTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改角色信息["+laneRole.getRoleNo()+"]成功", "角色信息-修改", "tb_Role");
		
		lrTemp=null;
		
		if (session.getAttribute("roleNo")!=null
				|| session.getAttribute("roleName")!=null) {
			laneRole.setRoleNo((Short)session.getAttribute("roleNo"));
			laneRole.setRoleName((String)session.getAttribute("roleName"));
			list=laneRoleService.findLaneRoleByCondition(pager, laneRole.getRoleNo(), laneRole.getRoleName());
			
			return "laneRole_list";
		}else {
			list = laneRoleService.findByPager(pager);
			laneRole=null;
			return "laneRole_list";
		}	
	}
	public String delete(){
		laneRoleService.delete(laneRole.getRoleNo());
		message="deleteSuccess";
		laneRoleModuleService._delete(laneRole.getRoleNo());
		laneOperatorRoleService._deleteByroleNo(laneRole.getRoleNo());
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除角色信息["+laneRole.getRoleNo()+"]成功", "角色信息-删除", "tb_Role,tb_RoleModule");
		laneRole=null;
		return list() ;
	}
	
	public String setPermission(){
		rmPrivilege=new StringBuffer("");
		List<LaneRoleModule> rmList=laneRoleModuleService.findRoleModule(laneRole.getRoleNo());
		if(rmList!=null){
			for(int i=0;i<rmList.size();i++){
				rmPrivilege.append(rmList.get(i).getRoleNo().toString().trim()+"_"+rmList.get(i).getModuleNo().toString().trim()+"_"+rmList.get(i).getPrivilege().toString().trim()+",");
			}
		}
		list=laneModuleService.findLaneModule();
		return "laneRole_setPermission" ;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String setModulePrivilege(){
		if(!modulePrivilege.equals("")){
			String[] mp=modulePrivilege.split(",");
            LaneRoleModule laneRoleModule=new LaneRoleModule();
		    String module;
		    String privilege;
		    mpMap=new HashMap<String, List>();
		    
			for(int i=0;i<mp.length;i++){
				List plist=new ArrayList();
				module=mp[i].split("_")[0].trim();
				privilege=mp[i].split("_")[1].trim();
				
				//System.out.println(module+" : -"+privilege+"-");
				
				plist.add(privilege);
				for(int j=0;j<mp.length;j++){
					String _module=mp[j].split("_")[0].trim();
					String _privilege=mp[j].split("_")[1].trim();
					if(module.equals(_module)&&
							!privilege.equals(_privilege)){
						plist.add(_privilege);
					}
					mpMap.put(module,plist);
				}
			}
			//先根据角色编码删除该角色的所有权限

			if(laneRoleModuleService._delete(laneRole.getRoleNo())){
				for(Entry<String, List> entry:mpMap.entrySet()){
					String _module=entry.getKey().toString();
					List _plist=entry.getValue();
					short _privilege=0;
					for(int i=0;i<_plist.size();i++){
						if(Short.valueOf(_plist.get(i).toString().trim())==15){
							_privilege=15;
							break;
						}else{
							_privilege+=Short.valueOf(_plist.get(i).toString().trim());
						} 
					}
					//保存处理好的角色 模块 权限
					laneRoleModule.setRoleNo(laneRole.getRoleNo());
					laneRoleModule.setModuleNo(_module);
					laneRoleModule.setPrivilege(_privilege);
					if(laneRoleModuleService.ishasRoleModule(laneRole.getRoleNo(), _module)==null){
						laneRoleModuleService.save(laneRoleModule);
						
					}

					//System.out.println("mpMap->"+_module+" : "+_privilege);
					
					rmPrivilege=new StringBuffer("");
					List<LaneRoleModule> rmList=laneRoleModuleService.findRoleModule(laneRole.getRoleNo());
					for(int i=0;i<rmList.size();i++){
						rmPrivilege.append(rmList.get(i).getRoleNo().toString().trim()+"_"+rmList.get(i).getModuleNo().toString().trim()+"_"+rmList.get(i).getPrivilege().toString().trim()+",");
					}
				}
				//当保存完所设置的权限时，则初始化其它模块的权限值为0
				List initList=new ArrayList();
				LaneRoleModule _laneRoleModule=new LaneRoleModule();
				initList=laneRoleModuleService.initOtherRoleModule(laneRole.getRoleNo());
				short v=0;
				for(int k=0;k<initList.size();k++){
					_laneRoleModule.setRoleNo(laneRole.getRoleNo());
					_laneRoleModule.setModuleNo(initList.get(k).toString().trim());
					_laneRoleModule.setPrivilege(v);
					laneRoleModuleService.save(_laneRoleModule);
				}
				message="updateSuccess";
				systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户更新角色["+laneRole.getRoleNo()+"]权限成功", "角色信息-设置角色权限", "tb_RoleModule");
				
			}else message="updateFail";
		}else{
			//取消所有权限
			laneRoleModuleService._delete(laneRole.getRoleNo());
			message="clearSuccess";
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户更新角色["+laneRole.getRoleNo()+"]权限成功", "角色信息-设置角色权限", "tb_RoleModule");
			
		}
		
		//System.out.println("rmPrivilege->"+rmPrivilege);
		//返回初始化的所有模块
		list=laneModuleService.findLaneModule();
		return "laneRole_setPermission";
	}
	
	//Getter/Setter
	public LaneRole getLaneRole() {
		return laneRole;
	}

	public void setLaneRole(LaneRole laneRole) {
		this.laneRole = laneRole;
	}

	public String getModulePrivilege() {
		return modulePrivilege;
	}
	public void setModulePrivilege(String modulePrivilege) {
		this.modulePrivilege = modulePrivilege;
	}
	public StringBuffer getRmPrivilege() {
		return rmPrivilege;
	}
	public void setRmPrivilege(StringBuffer rmPrivilege) {
		this.rmPrivilege = rmPrivilege;
	}
	
	
}
