package com.hgsoft.interceptor;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import com.hgsoft.entity.Admin;
import com.hgsoft.service.AdminService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

@Component
public class PermissionInterceptor implements Interceptor {

	private static final long serialVersionUID = 1L;
	@Resource AdminService adminService;
	
	@SuppressWarnings("unchecked")
	public String intercept(ActionInvocation invocation) throws Exception {
		ActionContext request = ActionContext.getContext();
		Map session = request.getSession();
		Admin operator = (Admin)session.get("operator");				
		String basePath = ServletActionContext.getRequest().getContextPath();
		String uri = ServletActionContext.getRequest().getRequestURI().replaceFirst(basePath, "");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		long fristTime;
		long secondTime = calendar.getTimeInMillis();
		String functions ;
		if(!uri.equals("/login.do") && !uri.equals("/randomCode.do")){
			if(operator != null){
				operator = adminService.load(operator.getId());
				session.put("operator", operator);
			}
			if(operator == null){
				request.put("message", "您还未登录或者登录已超时，请重新登陆");
				request.put("result", "RELOAD");
				return "login";
			}	
			fristTime = (Long)session.get(operator.getId()+"time");
			if(secondTime-fristTime>1000*60*4){//后面表示分钟，4分钟			
				functions = adminService.getFunctions(operator);//每过4分钟再与数据库交互查询权限，减少与数据库交互次数，提高效率
				session.put("functions", functions);
				session.put(operator.getId()+"time", secondTime);				
			}	
			functions = (String)session.get("functions");
			//System.out.println(uri);
			if(functions == null || !functions.contains(uri)){
				request.put("message", "您的操作权限不足，请联系管理员");
				return "globalError";
			}
		}
		return invocation.invoke();
	}

	public void init() {
	}
	
	public void destroy() {
	}
}
