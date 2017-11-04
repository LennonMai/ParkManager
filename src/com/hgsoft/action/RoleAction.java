package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Module;
import com.hgsoft.entity.Role;
import com.hgsoft.service.ModuleService;
import com.hgsoft.service.RoleService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.util.JdbcUtil;

/**
 * @author caijunhua
 * @date July 19, 2010
 * @Description ��ɫȨ�޹���
 */

@Controller 
@Scope("prototype") 
public class RoleAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Role role;
	@Resource private RoleService roleService ;
	@Resource private ModuleService moduleService ;
	
	@Resource
	private SystemLogService systemLogService;
	
	private String roleName;
	
	@Resource
	private JdbcUtil jdbcUtil;
	
	public void removePagerAndConditionSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");		
	}
	public void setPagerSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}
	
	public String getRoleByName() {	//jquery��֤��ɫ���Ƿ����
		Role role1 = roleService.getRoleByName(role.getName());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (role1 == null) {
			out.print("success");
		} else {
			out.print("fail");
		}
		return null;
	}
	
	public RoleAction(){
		role = new Role();
	}
	public String save(){	//��ӽ�ɫ
		if (null != roleService.getRoleByName(role.getName())) {
			result = Result.FAIL;
			return add();
		}
		roleService.save(role);
		
		/*Admin admin = this.getCurrentOperator(); 
		//������Ϣд��ϵͳ��־
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û�������ɫ��Ϊ"+role.getName()+"�Ľ�ɫ��Ϣ",
				"ϵͳ����--��ɫ����", "t_park_role");*/
		
		return list();
	}
	@SuppressWarnings("unchecked")
	public String update(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		if(!roleName.equals(role.getName())) {	//�ж��޸Ľ�ɫ����ԭ��ɫ���Ƿ���ͬ
			Role role1 = roleService.getRoleByName(role.getName());
			if(null != role1) {	//�Ƿ���ڸý�ɫ
				result = Result.FAIL;
				return edit();
			}
		}
		List adminList=jdbcUtil.selectForList("select admin from t_park_admin_role where role='"+role.getId()+"'");
		
		//update��ý�ɫ��Ӧ��ԭ�û��Ľ�ɫ������Ӧ���
		roleService.update(role);
		
		//�ý�ɫ��Ӧ��ԭ�û��Ľ�ɫ���¸�ԭֵ
		int adminId;
		for(int i=0;i<adminList.size();i++){
			//System.out.println(adminList.get(i));
			adminId=Integer.parseInt(adminList.get(i).toString().split("=")[1].split("}")[0].trim());
			if(jdbcUtil.select("select admin from t_park_admin_role where admin='"+adminId+"' and role='"+role.getId()+"'")==0){
				jdbcUtil.save("insert into t_park_admin_role values("+adminId+","+role.getId()+")");
			}	
		}
		
		/*Admin admin = this.getCurrentOperator(); 
		//������Ϣд��ϵͳ��־
		systemLogService.save(new Date(), 0, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û��޸Ľ�ɫ��Ϊ"+role.getName()+"�Ľ�ɫ��Ϣ",
				"ϵͳ����--��ɫ����", "t_park_role");*/
		
		list = roleService.findByPager(pager);
		return LIST;
	}
	public String delete(){
		
		role = roleService.get(role.getId());	//ȡ�õ�ǰҪɾ�����û�
		if(null != role) {
			if(role.getAdmins().size() != 0) {	//�����û�
				result = Result.FAIL;
				return list();
			} else {
				/*Admin admin = this.getCurrentOperator(); 
				//������Ϣд��ϵͳ��־
				systemLogService.save(new Date(), 0, admin,
						"["+admin.getId()+"]"+admin.getUsername()+"�û�ɾ����ɫ��Ϊ"+role.getName()+"�Ľ�ɫ��Ϣ",
						"ϵͳ����--��ɫ����", "t_park_role");*/
				
				roleService.deleteRoleById(role.getId());
			}
		}
		result = Result.SUCCESS;
		return list();
	}
	public String add(){
		list = moduleService.findAll();
		return ADD;
	}
	public String edit(){
		this.setPagerSession();
		role = roleService.load(role.getId());
		list = moduleService.findAll();
		return EDIT;
	}
	public String list(){
		this.removePagerAndConditionSession();
		list = roleService.findByPager(pager);
		return LIST;
	}
	public Role getRole() {
		return role;
	}
	
	@SuppressWarnings("unchecked")
	public void setModules(String modules){
		if(modules != null){
			modules = modules.replace("��", ",").replace(" ", "");
			String[] ids = modules.split(",");
			if(ids!=null && ids.length>0){
				for(int i=0;i<ids.length;i++){
					Integer j = new Integer(ids[i]);
					if(j>0){
						Module module = new Module();
						module.setId(j);
						role.getModules().add(module);
					}
				}
			}
		}	
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
}
