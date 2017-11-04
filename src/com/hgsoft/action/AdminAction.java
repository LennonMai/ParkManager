package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Role;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.RoleService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.util.HashUtil;
import com.opensymphony.xwork2.ActionContext;

/**
 * @author caijunhua
 * @date July 19, 2010
 * @Description 系统用户管理
 */

@Controller
@Scope("prototype")
public class AdminAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private String checkCode = "";
	private Admin admin;
	@Resource
	private AdminService adminService;
	@Resource
	private RoleService roleService;

	@Resource
	private SystemLogService systemLogService;

	private String adminUsername;

	public void removePagerAndConditionSession() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
	}

	public void setPagerSession() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}

	public AdminAction() {
		admin = new Admin();
	}

	public String save() { // 添加系统用户
		if (null != adminService.getAdminByUsername(admin.getUsername())) {
			result = Result.FAIL;
			return add();
		}
		// 取得管理员号，900000001开始
		int id = adminService.getAdminId() + 1;
		admin.setId(id);
		admin.setCreateTime(new Date());
		String PASSWORD_MD5_ENCRYPT_KEY = "~(Gb,.|[]HA*NT"; // 密钥
		String s = HashUtil.getMD5String(admin.getPassword() + "_" + PASSWORD_MD5_ENCRYPT_KEY);
		admin.setPassword(s);
		adminService.save(admin);

		// 操作信息写入系统日志
		/*
		 * systemLogService.save(new Date(), 1, getCurrentOperator(),
		 * "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().
		 * getUsername()+"用户添加用户名为"+admin.getUsername()+"的用户信息", "系统管理--用户管理",
		 * "t_park_admin");
		 */

		return list();
	}

	public void getAdminByUsername() { // jquery验证用户登录名是否存在
		Admin admin1 = adminService.getAdminByUsername(admin.getUsername());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (admin1 == null) {
			out.print("success");
		} else {
			out.print("fail");
		}
	}

	// 修改用户信息
	public String update() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		// 判断修改用户名与原用户名是否相同，或者是否存在
		if (null != adminService.getAdminByUsername(admin.getUsername())
				&& !adminUsername.equals(admin.getUsername())) {
			result = Result.FAIL;
			return edit();
		}
		Admin temp = adminService.get(admin.getId());
		temp.setUsername(admin.getUsername());
		temp.setName(admin.getName());
		if (admin.getPassword().length() > 0) {
			String PASSWORD_MD5_ENCRYPT_KEY = "~(Gb,.|[]HA*NT"; // 密钥
			String s = HashUtil.getMD5String(admin.getPassword() + "_" + PASSWORD_MD5_ENCRYPT_KEY);
			if (s.length() == 32) {
				temp.setPassword(s);
			} else {
				message = "设置密码失败";
				return ERROR;
			}
		}
		temp.setSex(admin.getSex());
		temp.setEmail(admin.getEmail());
		temp.setPhone(admin.getPhone());
		temp.setValid(admin.getValid());
		temp.setRoles(admin.getRoles());
		adminService.update(temp);

		// 操作信息写入系统日志
		/*
		 * systemLogService.save(new Date(), 1, getCurrentOperator(),
		 * "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().
		 * getUsername()+"用户修改用户名为"+temp.getUsername()+"的用户信息", "系统管理--用户管理",
		 * "t_park_admin");
		 */

		list = adminService.findByPager(pager);
		return LIST;
	}

	// 删除用户
	public String delete() {
		Admin tempAdmin = null;
		int nowOperId = getCurrentOperator().getId(); // 取当前用户Id
		if (nowOperId == admin.getId()) {
			result = Result.FAIL;
		} else {
			tempAdmin = adminService.getAdminById(admin.getId());
			// String userName = tempAdmin.getUsername();
			if (null != tempAdmin) {
				adminService.deleteAdminById(admin.getId());
				// 操作信息写入系统日志
				/*
				 * systemLogService.save(new Date(), 1, getCurrentOperator(),
				 * "["+this.getCurrentOperator().getId()+"]"+this.
				 * getCurrentOperator().getUsername()+"用户删除登录名为"+userName+
				 * "的用户信息", "系统管理--用户管理", "t_park_admin");
				 */
			}
			result = Result.SUCCESS;
		}

		return list();
	}

	public String edit() {
		this.setPagerSession();
		admin = adminService.load(admin.getId());
		return EDIT;
	}

	public String list() {
		this.removePagerAndConditionSession();
		list = adminService.findByPager(pager);
		return LIST;
	}

	public String login() {
		if (admin != null && admin.getUsername() != null && admin.getUsername().length() > 0) {
			// if(!checkCode.equals(ActionContext.getContext().getSession().get("randomCode"))){
			// message = "验证码错误，请重新输入";
			// }else{
			String PASSWORD_MD5_ENCRYPT_KEY = "~(Gb,.|[]HA*NT"; // 密钥
			// 比较MD5的（密码_密钥）
			admin = adminService.check(admin.getUsername(),
					HashUtil.getMD5String(admin.getPassword() + "_" + PASSWORD_MD5_ENCRYPT_KEY));
			if (admin != null) {
				// 获取登录的Ip地址
				String ip = ServletActionContext.getRequest().getHeader("x-forwarded-for");
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = ServletActionContext.getRequest().getHeader("Proxy-Client-IP");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = ServletActionContext.getRequest().getHeader("WL-Proxy-Client-IP");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = ServletActionContext.getRequest().getHeader("HTTP_CLIENT_IP");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = ServletActionContext.getRequest().getHeader("HTTP_X_FORWARDED_FOR");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = ServletActionContext.getRequest().getRemoteAddr();
				}
				admin.setLastIp(ip);
				// admin.setLastIp(ServletActionContext.getRequest().getRemoteAddr());
				// System.out.println(ServletActionContext.getRequest().getHeader("x-forwarded-for"));
				// System.out.println(ServletActionContext.getRequest().getRemoteHost());
				admin.setLastTime(new Date());
				adminService.update(admin);

				ActionContext.getContext().getSession().put("operator", admin);
				ActionContext.getContext().getSession().put("functions", adminService.getFunctions(admin));
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(new Date());
				ActionContext.getContext().getSession().put(admin.getId() + "time", calendar.getTimeInMillis());

				// 登录信息写入系统日志
				systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户登录",
						"系统用户登录", "登录操作");

				return SUCCESS;
			} else {
				message = "用户名或密码错误，请重新输入";
			}
			// }
		}

		return LOGIN;
	}

	public String logout() {
		// 登出信息写入系统日志
		admin = adminService.get(getCurrentOperator().getId());
		systemLogService.save(new Date(), 0, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户登出", "系统用户登出",
				"登出操作");
		ActionContext.getContext().getSession().put(admin.getId() + "time", null);
		ActionContext.getContext().getSession().put("operator", null);
		result = Result.RELOAD;
		return LOGIN;
	}

	public String info() {
		admin = adminService.load(getCurrentOperator().getId());
		return "info";
	}

	public String updateInfo() {
		Admin temp = adminService.load(getCurrentOperator().getId());
		temp.setName(admin.getName());
		if (admin.getPassword().length() > 0) {
			String PASSWORD_MD5_ENCRYPT_KEY = "~(Gb,.|[]HA*NT"; // 密钥
			String s = HashUtil.getMD5String(admin.getPassword() + "_" + PASSWORD_MD5_ENCRYPT_KEY);
			if (s.length() == 32) {
				temp.setPassword(s);
			} else {
				message = "设置密码失败";
				return ERROR;
			}
		}
		// if(admin.getPassword().length()>0){
		// temp.setPassword(admin.getPassword());
		// }
		temp.setSex(admin.getSex());
		temp.setEmail(admin.getEmail());
		temp.setPhone(admin.getPhone());
		adminService.update(temp);
		ActionContext.getContext().getSession().put("operator", temp);
		result = Result.SUCCESS;
		return "info";
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	@SuppressWarnings("unchecked")
	public void setRoles(String roles) {
		if (roles != null) {
			roles = roles.replace("，", ",").replace(" ", "");
			String[] ids = roles.split(",");

			if (ids != null && ids.length > 0) {
				for (int i = 0; i < ids.length; i++) {
					Role role = new Role();
					role.setId(new Integer(ids[i]));
					admin.getRoles().add(role);
				}
			}
		}
	}

	public List<Role> getRoleList() {
		return roleService.findAll();
	}

	public String getAdminUsername() {
		return adminUsername;
	}

	public void setAdminUsername(String adminUsername) {
		this.adminUsername = adminUsername;
	}

}
