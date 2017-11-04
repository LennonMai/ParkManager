/**
 * 
 */
package com.hgsoft.action;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.SystemPara;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.SystemParaService;
import com.hgsoft.util.ExcelUtil;

/**
 * @author qinzuohai
 *
 */

@Controller
@Scope("prototype")
public class SystemParaAction extends BaseAction{
	@Resource
	private SystemLogService systemLogService; 
	@Resource
	private SystemParaService systemParaService;
	private SystemPara systemPara;
	private List<SystemPara> groupNameList;

	public List<SystemPara> getGroupNameList() {
		return groupNameList;
	}
	public void setGroupNameList(List<SystemPara> groupNameList) {
		this.groupNameList = groupNameList;
	}
	/**
	 * 清空因点击修改设置的currentPage、pageSize、rowIndex session值
	 * 以及点击查询设置的查询条件session值
	 * @return systemPara_list
	 */
	public String list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("paraClass");
		session.removeAttribute("item");
		session.removeAttribute("itemValue");
		session.removeAttribute("groupName");
		groupNameList=systemParaService.findGroupName();
		list=systemParaService.findByPager(pager);
		return "systemPara_list";
	}
	/**
	 * 首先清空上一次因点击修改设置的currentPage、pageSize、rowIndex session值
	 * 以及点击查询设置的查询条件session值。
	 * 设置新的查询条件session值，若无查询条件则return list()
	 * @return systemPara_query or list()
	 */
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("paraClass");
		session.removeAttribute("item");
		session.removeAttribute("itemValue");
		session.removeAttribute("groupName");
		groupNameList=systemParaService.findGroupName();
		if (systemPara.getParaClass()!=null
				|| !systemPara.getItem().equals("")
				|| !systemPara.getItemValue().equals("")
				|| !systemPara.getGroupName().equals("")) {
			session.setAttribute("paraClass", systemPara.getParaClass());
			session.setAttribute("item", systemPara.getItem());
			session.setAttribute("itemValue",systemPara.getItemValue());
			session.setAttribute("groupName",systemPara.getGroupName());
			
			list=systemParaService.findSystemParaByCondition(pager, systemPara.getParaClass(), systemPara.getItem(), systemPara.getItemValue(), systemPara.getGroupName());
			return  "systemPara_list";

		} 
		else {
			return list();
		}
	}
	
	/**
	 * 删除不设置页面定位，直接删除跳转到首页
	 * @return
	 */
	public String delete(){
		systemParaService.deleteBycompositeID(systemPara.getParaClass(), systemPara.getItem().trim());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除参数：["+systemPara.getItem()+"]成功", "系统参数配置-删除参数", "tb_SystemPara");
		systemPara=null;
		return list();
	}
	
	/**
	 * 跳转到添加页面
	 * @return systemPara_add or list()
	 */
	public String add(){
		return "systemPara_add";
	}
	
	/**
	 * 保存
	 * @return systemPara_add or list()
	 */
	public String saveSystemPara(){
		SystemPara temp=new SystemPara();
		if(systemParaService.ishasSystemPara(systemPara.getParaClass(), systemPara.getItem())==null){
			//当参数类型为 -1 时，组别为空， 项顺序itemOrder在该类型中递增
			if(systemPara.getParaClass()==-1){
				temp.setParaClass(systemPara.getParaClass());
				temp.setItem(systemPara.getItem().trim());
				temp.setItemValue(systemPara.getItemValue().trim());
				temp.setGroupName("");
				temp.setItemOrder((short)(systemParaService.findSecondMaxItemOrderByparaClass(systemPara.getParaClass())+1));
				temp.setSendControl(systemPara.getSendControl());
				
				systemParaService.save(temp);
			}else{
				temp.setParaClass(systemPara.getParaClass());
				temp.setItem(systemPara.getItem().trim());
				temp.setItemValue(systemPara.getItemValue().trim());
				temp.setGroupName(systemPara.getGroupName().trim());
				temp.setItemOrder((short)(systemParaService.findMaxItemOrderBygroupName(systemPara.getGroupName())+1));
				temp.setSendControl(systemPara.getSendControl());
				
				systemParaService.save(temp);
			}
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加参数：["+systemPara.getItem()+"]成功", "系统参数配置-添加参数", "tb_SystemPara");
			result = Result.SUCCESS;
		} else {
			message = "hasSystemPara";
			return "systemPara_add";
		}
		systemPara=null;
		return list();
	}
	
	/**
	 * 跳转到修改页面
	 * 设置的currentPage、pageSize、rowIndex 的session值
	 */
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		systemPara=systemParaService.LoadSystemPara(systemPara.getParaClass(), systemPara.getItem().trim()).get(0);
		return "systemPara_edit";
	}
	
	/**
	 * 修改后定位到记录所在的页数和行数
	 * 若操作为查询后的修改，则修改后定位到条件查询后的所在的页面
	 * @return
	 */
	public String updateSystemPara(){		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		SystemPara temp=new SystemPara();
		temp.setParaClass(systemPara.getParaClass());
		temp.setItem(systemPara.getItem().trim());
		temp.setItemValue(systemPara.getItemValue().trim());
		temp.setGroupName(systemPara.getGroupName());
		temp.setItemOrder(systemPara.getItemOrder());
		temp.setSendControl(systemPara.getSendControl());
		
		systemParaService.update(systemPara);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改参数：["+systemPara.getItem()+"]成功", "系统参数配置-修改参数", "tb_SystemPara");
		temp=null;
		if(session.getAttribute("paraClass")!=null
				||session.getAttribute("item")!=null
				||session.getAttribute("itemValue")!=null
				||session.getAttribute("groupName")!=null){
			
			if(session.getAttribute("paraClass")==null){
				list=systemParaService.findSystemParaByCondition(pager,null, session.getAttribute("item").toString(),session.getAttribute("itemValue").toString(), session.getAttribute("groupName").toString());
				systemPara.setParaClass(null);
				systemPara.setItem(session.getAttribute("item").toString());
				systemPara.setItemValue(session.getAttribute("itemValue").toString());
				systemPara.setGroupName(session.getAttribute("groupName").toString());
			}else{
				list=systemParaService.findSystemParaByCondition(pager, Short.parseShort(session.getAttribute("paraClass").toString().trim()), session.getAttribute("item").toString(),session.getAttribute("itemValue").toString(), session.getAttribute("groupName").toString());	
				systemPara.setParaClass(Short.parseShort(session.getAttribute("paraClass").toString().trim()));
				systemPara.setItem(session.getAttribute("item").toString());
				systemPara.setItemValue(session.getAttribute("itemValue").toString());
				systemPara.setGroupName(session.getAttribute("groupName").toString());
			}
			return  "systemPara_list";
		}else {
			systemPara=null;
			list=systemParaService.findByPager(pager);
			return "systemPara_list";	
		}
	}
	/**
	 * 将数据导出到Excel中开始 
	 * @return
	 * @throws ServletException
	 */
	public String dataToExcel()throws ServletException{
	      List<SystemPara> systemParaList= new ArrayList<SystemPara>();
	      systemParaList=systemParaService.findAll();
	      try {
	    	  
	    	  //需要成功获取HttpServletResponse才能成功配置响应头
	    	  HttpServletResponse response = ServletActionContext.getResponse();
	    	  //response.setContentType("application/octets-stream;charset=gb2312");
	    	  response.setContentType("octets/stream");//简单可以设置为信息流
		      response.addHeader("Content-Disposition", "attachment;filename=SystemParameterInfo.xls");	      
		      //客户端不缓存
		      response.addHeader("Pragma","no-cache");
		      response.addHeader("Cache-Control","no-cache");
		      ExcelUtil<SystemPara> _excelUtil = new ExcelUtil<SystemPara>();
		      String[] headers = { "参数类型", "键名", "键值", "组别", "项顺序" };
              OutputStream out = response.getOutputStream();
              _excelUtil.exportExcel(headers, systemParaList, out);
              systemLogService.save(new Date(), 1,this.getCurrentOperator() ,  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户导出参数到Excel文件成功", "系统参数配置-数据导出到Excel", "SystemParameterInfo.xls");
              out.close();
              //reset()--Clears any data that exists in the buffer as well as the status code and headers. 
              //If the response has been committed, this method throws an IllegalStateException. 
		      response.reset();
              //response.resetBuffer();
	      }catch (IOException e) {
	    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将数据导出到Excel时抛出的IO异常", "系统参数配置-数据导出到Excel", "IOException");
			  e.printStackTrace();
	      }
	    return list();
	}
	
	/**
	 * 转码方法
	 * @param str
	 * @return
	 */
	public String getGBKSting(String str){
		String getString=null;
		try {
		    getString= new String(str.getBytes("ISO8859-1"),"GBK");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return getString;
	}
	/**
	 * Getter/Setter方法
	 * @return
	 */
	public SystemPara getSystemPara() {
		return systemPara;
	}
	public void setSystemPara(SystemPara systemPara) {
		this.systemPara = systemPara;
	}
	
}
