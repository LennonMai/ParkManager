package com.hgsoft.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;

/**
 * 
 * @author qinzuohai 
 *  
 */
@Controller
@Scope("prototype")
public class SystemLogTaskAction extends BaseAction {
	
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private SysparamconfService sysparamconfService;

	private File file;
	private HttpSession session;

	//备份盘符
	private String position;
	private String disk=null;
	//备份目录
	private String backupDir;
	//时间间隔
	private String intervalTime;
	//开始日期
	private Date startDate;
	
	private String hour="00";
	private String minute="00";
	private String second="00";
	
	//备份目录路径在其它参数里的对应的参数名
	private String filePath="filePath_sysLogBackupTask";
	
	// 创建目录
	private void mdir() {
		String path = this.position.trim()+":/"+this.backupDir.trim();
		//System.out.println("path:"+path);
		file = new File(path);
		file.mkdir();
		//System.out.println("file.mkdir():"+file.mkdir());
		//if(file.getParentFile().exists()){ System.out.println("目录已经存在");}	
	}
	public String timeTask(){return "timeTask";}
	
	public String updateTask() {
		HttpServletRequest request=ServletActionContext.getRequest();
		session =request.getSession();
		if(session.getAttribute("_disk")!=null){
			disk=session.getAttribute("_disk").toString();
		}
		//当输入的盘符存在时，用该盘符创建目录
		if(disk==null){
			this.mdir();
		}
		//当输入的盘符不存在时重置为D盘创建目录
		else{
			String path = this.disk.trim()+":/"+this.backupDir.trim();
			file = new File(path);
			file.mkdir();
		}
		
		String pname = null, pvalue = null, remark = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Sysparamconf _sysparamconf = new Sysparamconf();
		_sysparamconf.setPname(filePath);
		_sysparamconf.setPtype(0);
		_sysparamconf.setPvalue(file.getPath());
		_sysparamconf.setRemark("日志数据备份路径");
		
		if (sysparamconfService.checkPnameByPname(filePath) == null) {
			sysparamconfService.save(_sysparamconf);
		} else sysparamconfService._update(sysparamconfService.findSysparamconfByPname(filePath).get(0).getSys_id(),_sysparamconf);

		Sysparamconf sysparamconf = new Sysparamconf();
		
		pname = "TIME_sysLogBackupTask";
		pvalue = this.getIntervalTime() + "_" + dateFormat.format(this.getStartDate()).toString() + "_"+ this.getHour() + ":" + this.getMinute() + ":"+ this.getSecond();
		remark = "[" + "日志数据备份任务" + "]：" + "从 " + dateFormat.format(this.getStartDate()).toString() + "_"+ this.hour + ":" + this.minute + ":" + this.second + " 开始,每隔 "+ this.getIntervalTime() + " 个月备份一次 ";
		sysparamconf.setPname(pname);
		sysparamconf.setPtype(0);
		sysparamconf.setPvalue(pvalue);
		sysparamconf.setRemark(remark);
		
		if (sysparamconfService.checkPnameByPname(pname) == null) {
			sysparamconfService.save(sysparamconf);
		} else sysparamconfService._update(sysparamconfService.findSysparamconfByPname(pname).get(0).getSys_id(),sysparamconf);

		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+ this.getCurrentOperator().getId() + "]"+ this.getCurrentOperator().getUsername() + "用户更新" + remark,
				"日志数据备份任务", "t_park_systemLog");

		message = "SUCCESS";
		session.removeAttribute("_disk");
		return "timeTask";
	}
	
	public String delSystemLog() {
		systemLogService.deleteSystemLog();
		return "timeTask";
	}
	
	// 验证输入的盘符是否存在
	public void ishasPosition() {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String path = this.position.trim()+":/";
		File _file = new File(path);
		if(!_file.exists()) {
			resetPosition();
			out.print("noPosition");
		} else {
			out.print("hasPosition");
		}
	}

	// 异步验证不存在盘符时，重置为D盘
	public void resetPosition() {
		HttpServletRequest request=ServletActionContext.getRequest();
		session =request.getSession();
		session.setAttribute("_disk", "D");
	}
	
	//Getter/Setter
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getBackupDir() {
		return backupDir;
	}

	public void setBackupDir(String backupDir) {
		this.backupDir = backupDir;
	}

	public String getIntervalTime() {
		return intervalTime;
	}

	public void setIntervalTime(String intervalTime) {
		this.intervalTime = intervalTime;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public String getHour() {
		return hour;
	}

	public void setHour(String hour) {
		this.hour = hour;
	}

	public String getMinute() {
		return minute;
	}

	public void setMinute(String minute) {
		this.minute = minute;
	}

	public String getSecond() {
		return second;
	}

	public void setSecond(String second) {
		this.second = second;
	}
}
