package com.hgsoft.action;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.Writer;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.service.ModuleService;
import com.hgsoft.service.SystemLogService;
/**
 * 
 * @author qinzuohai
 * ϵͳ��ʼ����������
 */
@Controller
@Scope("prototype")
public class FunctionConfigAction extends BaseAction{
	@Resource
	private ModuleService moduleService;
	@Resource
	private SystemLogService systemLogService;
	public String config(){
		return "functionConfig";
	}
	
	/**
	 * ���ɲ˵���ʼ�� insert SQL��� txt�ļ�
	 * @return url
	 * @throws IOException
	 */
	public String outInitMenuInsertSQL() throws IOException{
		HttpServletResponse _response =ServletActionContext.getResponse();   
		_response.setContentType("application/txt");   
		_response.setHeader("Content-disposition", "attachment;filename=init menu SQL.txt");   
		BufferedOutputStream out = null;    
		try { 
		  out = new BufferedOutputStream(_response.getOutputStream());
		  out.write(moduleService.initMenuInsertSQL().getBytes("utf-8")); 
		  out.flush(); 
		} catch (Exception e) {
			e.printStackTrace();   
		} finally {   
		   if (out != null){   
		     try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}   
		   }   
		}     
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��ɹ�����ϵͳ�˵���ʼ��SQL���TXT�ļ�", "ϵͳ�˵���ʼ��", "t_park_admin_role��t_park_role_module��t_park_admin��t_park_role��t_park_module");
		return "functionConfig";
	}
	/**
	 * �첽�������
	 */
	@SuppressWarnings("unchecked")
	public void createInitMenuInsertSQL(){
		HttpServletResponse reponse=ServletActionContext.getResponse();
		Map initSQL =new HashMap();
		initSQL.put("initMenuInsertSQL", moduleService.initMenuInsertSQL());
		reponse.setCharacterEncoding("UTF-8");
		this.writerJSON(initSQL, reponse);
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��ɹ�����ϵͳ�˵���ʼ��SQL���", "ϵͳ�˵���ʼ��", "t_park_admin_role��t_park_role_module��t_park_admin��t_park_role��t_park_module");
		
	}
	
	
	/**
     * messageд��JSON
     * @param object
     * @param reponse
     * ������jakarta commons-lang 2.4 
	 * jakarta commons-beanutils 1.7.0 
	 * jakarta commons-collections 3.2 
	 * jakarta commons-logging 1.1.1 
	 * ezmorph 1.0.6 
     */
	public void writerJSON(Object object, HttpServletResponse reponse) {
		try {
			reponse=ServletActionContext.getResponse();
			//�˷���ʹ���ڼ�ֵ�������� ,��Map
			JSONObject jsonObject = JSONObject.fromObject(object); 
			Writer writer = reponse.getWriter();
			//System.out.println("Json Data :" + jsonObject.toString());
			writer.write(jsonObject.toString());
			writer.flush();
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
