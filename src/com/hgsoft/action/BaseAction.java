package com.hgsoft.action;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.hgsoft.entity.Admin;
import com.hgsoft.service.ModuleService;
import com.hgsoft.util.Pager;

/**
 * @author liujiefeng
 * @date May 19, 2010
 * @Description action����
 */

@Controller
@Scope("prototype") 
@SuppressWarnings("unchecked")
public class BaseAction{

	private static final long serialVersionUID = 1L;
	
	protected Result result;//����JSP���
	protected String message;//����JSP��ϸ��Ϣ
	protected List list;
	protected Admin operator;//��Ҫֱ�����ã���getCurrentOperator()����
	@Resource protected Pager pager;
	@Resource private ModuleService moduleService;
	
	protected static final String SUCCESS = "success";
	protected static final String ERROR = "error";
	protected static final String INPUT = "input";
	protected static final String LOGIN = "login";
	protected static final String ADD = "add";
	protected static final String EDIT = "edit";
	protected static final String LIST = "list";
	
	@PostConstruct
	public void init() {
		//ActionContext ��Action����֮��Żᱻ��������˲�Ӧ����Action�ĳ�ʼ������������
//		operator = (Admin)ActionContext.getContext().getSession().get("operator");	
	}
	
	public Admin getCurrentOperator(){
		return (Admin)ActionContext.getContext().getSession().get("operator");	
	}
	public String add(){
		return ADD;
	}
	public String edit(){
		return EDIT;
	}
	public Pager getPager() {
		return pager;
	}
	public void setPager(Pager pager) {
		this.pager = pager;
	}
	public List getList() {
		return list;
	}
	public String getMessage() {
		return message;
	}
	public String getBasePath(){
		return ServletActionContext.getRequest().getContextPath();
	}
	public void setMid(Integer id) {
		ActionContext.getContext().getSession().put("currentPosition", moduleService.getCurrentPosition(id));
	}
	public String getResult(){
		return result.toString();
	}
	
	public static enum Result{
		SUCCESS,SUCCESS1,SUCCESS2,FAIL,RELOAD,FAIL1,FAIL2,FAIL3,FAIL4,FAIL5,FAIL6,FAIL7
	}
}
