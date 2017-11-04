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
 * @Description ϵͳ����ģ�����
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
	
	public void getModuleByName() {	//��֤���ڵ���ģ�����Ƿ����
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
		//����ģ����Զ���Ȩ����ɫadmin
		Role role = roleService.get(1);
		modules = role.getModules();
		modules.add(module);
		role.setModules(modules);
		roleService.update(role);
		
		Admin admin = this.getCurrentOperator(); 
		/*//������Ϣд��ϵͳ��־
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û�����ģ����Ϊ"+module.getName()+"��ģ����Ϣ",
				"ϵͳ����--ģ�����", "t_park_module");*/
		
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
		//�ж��޸�ģ������ԭģ�����Ƿ���ͬ�������Ƿ����
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
			//����module�ӽڵ�level
			list = moduleService.findByLevel(level);
			updateLevel(list,module.getId(),module.getLevel());
		}
		
		//�޸�ģ����Զ��޸���Ȩ����ɫadmin
		/*Role role = roleService.get(1);
		modules = role.getModules();
		modules.add(module);
		role.setModules(modules);
		roleService.update(role);*/
		
		Admin admin = this.getCurrentOperator(); 
		/*//������Ϣд��ϵͳ��־
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û��޸�ģ����Ϊ"+module.getName()+"��ģ����Ϣ",
				"ϵͳ����--ģ�����", "t_park_module");*/
		
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
		// //ɾ��ģ����Զ�ɾ����ɫadmin�ϵ�Ȩ��
		// Module module1 = moduleService.get(module.getId());
		// Role role = roleService.get(1);
		// modules = role.getModules();
		// modules.remove(module1);
		// role.setModules(modules);
		// roleService.update(role);
		/*
		 * Admin admin = this.getCurrentOperator(); //������Ϣд��ϵͳ��־
		 * systemLogService.save(new Date(), 0, admin,
		 * "["+admin.getId()+"]"+admin.getUsername()+"�û�ɾ��ģ����Ϊ"+module.getName()+"��ģ����Ϣ",
		 * "ϵͳ����--ģ�����", "t_park_module");
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
			// ���� list����ÿ������Ӧ���¼�������ڣ�����ѭ�����ҷ���
			for(int i = 0; i < list.size(); i++){
				Integer currentId = ((Module)list.get(i)).getId();
				int count = list.size() - i - 1;
				for(int j = i + 1; count > 0 && j < list.size(); j++){
					Module m = (Module)list.get(j);
					//���˽�㲻��currentId���²��㣬��ŵ��ŵ�list���
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
