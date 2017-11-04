package com.hgsoft.action;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Module;
import com.hgsoft.entity.Role;
import com.hgsoft.service.ModuleService;
import com.hgsoft.service.RoleService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date July 19, 2010
 * @Description 系统功能模块管理
 */

@Controller
@Scope("prototype")
@SuppressWarnings("unchecked")
public class ModuleAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Module module;

	@Resource
	private ModuleService moduleService;
	@Resource
	private RoleService roleService;
	@Resource
	private SystemLogService systemLogService;
	
	private String moduleName;
	
	Set<Module> modules;
	
	public void getModuleByName() {	//验证父节点下模块名是否存在
		Module module1 = moduleService.getModuleByName(module.getName(), module.getParent().getId());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch(IOException e) {
			e.printStackTrace();
		}
		if(module1 == null) {
			out.print("success");
		} else {
			out.print("fail");
		}
	}

	public String save() {
		if(null != moduleService.getModuleByName(module.getName(), module.getParent().getId())) {
			result = Result.FAIL1;
			return edit();
		}
		if (module.getParent() != null && (module.getParent().getId() < 1)) {
			module.setParent(null);
		} else {
			module.setParent(moduleService.get(module.getParent().getId()));
		}

		if (module.getParent() == null) {
			module.setLevel(1);
		} else {
			module.setLevel(module.getParent().getLevel() + 1);
		}
		module.setFunctions(module.getFunctions()==null?null:module.getFunctions().trim().replaceAll("\r","").replaceAll("\n",""));
		module.setUrl(module.getUrl()==null?null:module.getUrl().trim().replaceAll("\r","").replaceAll("\n",""));
		moduleService.save(module);
		//新增模块后自动授权给角色admin
		Role role = roleService.get(1);
		modules = role.getModules();
		modules.add(module);
		role.setModules(modules);
		roleService.update(role);
		
		Admin admin = this.getCurrentOperator(); 
		/*//操作信息写入系统日志
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户新增模块名为"+module.getName()+"的模块信息",
				"系统管理--模块管理", "t_park_module");*/
		
		/*
		Admin admin=(Admin)ActionContext.getContext().getSession().get("operator");
		Set set=admin.getRoles();
		Role role = null;
		for(Object o:set){
			role=(Role)o;
			if(role.getId()==1){
				mm=role.getModules();
				flag=true;
			}
		}
		if(flag){			 
			mm.add(module);
			role.setModules(mm);
			roleService.update(role);
		}
		admin=adminService.find(admin.getId());
		ActionContext.getContext().getSession().put("operator", admin);
		*/
		return edit();
	}

	public String update() {
		//判断修改模块名与原模块名是否相同，或者是否存在
		if(null != moduleService.getModuleByName(module.getName(), module.getParent().getId()) && !moduleName.equals(module.getName())) {
			result = Result.FAIL1; 
			return edit();
		}
		if (module.getParent() != null && (module.getParent().getId() < 1)) {
			module.setParent(null);
		} else {
			module.setParent(moduleService.get(module.getParent().getId()));
		}
 
		Integer level = module.getLevel();
		if (module.getParent() == null){
			module.setLevel(1);
		} else {
			module.setLevel(module.getParent().getLevel() + 1);
		}
		Module temp = moduleService.get(module.getId());
		module.setRoles(temp.getRoles());
		module.setFunctions(module.getFunctions().trim().replaceAll("\r","").replaceAll("\n",""));
		moduleService.update(module);
		if(!level.equals(module.getLevel())){
			//更新module子节点level
			list = moduleService.findByLevel(level);
			updateLevel(list,module.getId(),module.getLevel());
		}
		
		//修改模块后自动修改授权给角色admin
		/*Role role = roleService.get(1);
		modules = role.getModules();
		modules.add(module);
		role.setModules(modules);
		roleService.update(role);*/
		
		Admin admin = this.getCurrentOperator(); 
		/*//操作信息写入系统日志
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户修改模块名为"+module.getName()+"的模块信息",
				"系统管理--模块管理", "t_park_module");*/
		
		result = Result.SUCCESS;
		
		return edit();
	}
	
	private void updateLevel(List list,Integer parent,int level){
		for(int i=0;i<list.size();i++){
			Module module = (Module)list.get(i);
			if(module.getParent()!=null && module.getParent().getId().equals(parent)){
				module.setLevel(level+1);
				moduleService.update(module);
				updateLevel(list,module.getId(),level+1);
			}
		}
	}

	public String delete() {
		// //删除模块后自动删除角色admin上的权限
		// Module module1 = moduleService.get(module.getId());
		// Role role = roleService.get(1);
		// modules = role.getModules();
		// modules.remove(module1);
		// role.setModules(modules);
		// roleService.update(role);
		/*
		 * Admin admin = this.getCurrentOperator(); //操作信息写入系统日志
		 * systemLogService.save(new Date(), 0, admin,
		 * "["+admin.getId()+"]"+admin.getUsername()+"用户删除模块名为"+module.getName()+"的模块信息",
		 * "系统管理--模块管理", "t_park_module");
		 */
		if(moduleService.isHasChild(module.getId())) {
			result = Result.FAIL;
		} else {
			moduleService.deleteModuleById(module.getId());
			result = Result.SUCCESS;
		}
		return edit();
	}

	public String edit() {
		list = moduleService.findAll();
		if(list != null){
			// 排序 list，把每个结点对应的下级结点相邻，采用循环查找方法
			for(int i = 0; i < list.size(); i++){
				Integer currentId = ((Module)list.get(i)).getId();
				int count = list.size() - i - 1;
				for(int j = i + 1; count > 0 && j < list.size(); j++){
					Module m = (Module)list.get(j);
					//若此结点不是currentId的下层结点，则放到放到list最后
					if(m.getParent() == null ){
						list.remove(j);
						list.add(m);
						j--;
					}else if(!m.getParent().getId().equals(currentId)){
						list.remove(j);
						list.add(m);
						j--;
					}
					count--;
				}
			}
		}
		return EDIT;
	}
	
	public Module getModule() {
		return module;
	}

	public void setModule(Module module) {
		this.module = module;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
}
