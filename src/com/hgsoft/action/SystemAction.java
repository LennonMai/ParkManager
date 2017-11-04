package com.hgsoft.action;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Role;
import com.hgsoft.service.ModuleService;

/**
 * @author liujiefeng
 * @date May 19, 2010
 * @Description ÍøÕ¾ºóÌ¨
 */

@Controller
@Scope("prototype") 
public class SystemAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	@Resource ModuleService moduleService;
	
	public String index(){
		return "index";
	}
	public String top(){
		return "top";
	}
	@SuppressWarnings("unchecked")
	public String left(){
		HashSet set = new HashSet();
		Set roles = getCurrentOperator().getRoles();
		if(roles != null && !roles.isEmpty()){
			Iterator it = roles.iterator();
			while(it.hasNext()){
				Role role = (Role)it.next();
				set.addAll(role.getModules());
			}
			if(set!=null && !set.isEmpty()){
				list = moduleService.getMenus(set);
			}
		}
		return "left";
	}
	public String right(){
		return "right";
	}
	
	public String middle(){
		return "middle";
	}
}
