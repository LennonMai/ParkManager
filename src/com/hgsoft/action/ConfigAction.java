package com.hgsoft.action;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Config;
import com.hgsoft.service.ConfigService;
import com.hgsoft.service.SystemLogService;

/**
 * @author liujiefeng
 * @date May 19, 2010
 * @Description 系统参数设置
 */

@Controller 
@Scope("prototype") 
public class ConfigAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Config config;
	@Resource private ConfigService configService ;
	
	@Resource
	private SystemLogService systemLogService;
	
	public String save(){
		configService.save(config);
		
		/*Admin admin = this.getCurrentOperator(); 
		//操作信息写入系统日志
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户新增的系统参数信息",
				"系统管理--系统参数", "t_park_config");*/
		
		return list();
	}
	public String update(){	
		configService.update(config);
		
		/*Admin admin = this.getCurrentOperator(); 
		//操作信息写入系统日志
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户修改的系统参数信息",
				"系统管理--系统参数", "t_park_config");*/
		
		result = Result.SUCCESS;
		return EDIT;
	}
	public String delete(){
		/*Admin admin = this.getCurrentOperator(); 
		//操作信息写入系统日志
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户删除的系统参数信息",
				"系统管理--系统参数", "t_park_config");*/
		
		configService.deleteById(config.getId());
		
		return list();
	}
	public String edit(){
		config = configService.load(1);
		return EDIT;
	}
	public String list(){
		list = configService.findByPager(pager);
		return LIST;
	}
	public Config getConfig() {
		return config;
	}
	public void setConfig(Config config) {
		this.config = config;
	}
}
