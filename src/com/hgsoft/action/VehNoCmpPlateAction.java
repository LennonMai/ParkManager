package com.hgsoft.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.VehNoCmpPlate;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.VehNoCmpPlateService;

@Controller
@Scope("prototype")
public class VehNoCmpPlateAction extends BaseAction {

	private VehNoCmpPlate vehNoCmpPlate;
	@Resource
	private VehNoCmpPlateService vehNoCmpPlateService;
	@Resource
	private SystemLogService systemLogService; 
	
	public String list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("vehPlate");
		
		list=vehNoCmpPlateService.findByPager(pager);
		
		return LIST;
	}
	
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("vehPlate");
		
		if (!vehNoCmpPlate.getVehPlate().equals("")) {
			session.setAttribute("vehPlate", vehNoCmpPlate.getVehPlate());

			list=vehNoCmpPlateService.findVehNoCmpPlateByCondition(pager, vehNoCmpPlate.getVehPlate());
			return LIST;
		}else{
			return list();
		}

	}
	
	public String add(){
		return ADD;
	}
	
	public String save(){
		if(vehNoCmpPlateService.findVehNoCmpPlate(vehNoCmpPlate.getVehPlate())){
			message="exitVehNoCmpPlate";
			return ADD;
		}
		
		VehNoCmpPlate vncpTemp=new VehNoCmpPlate();
		vncpTemp.setVehPlate(vehNoCmpPlate.getVehPlate().trim());
		
		vehNoCmpPlateService.save(vncpTemp);
		vncpTemp=null;
		result=Result.SUCCESS;
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加车牌号为["+vehNoCmpPlate.getVehPlate()+"]的无需比较识别车牌车辆信息成功", "添加", "tb_VehNoCmpPlate");
		vehNoCmpPlate=null;
		return list();
	}
	
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	
		session.setAttribute("updateVehPlate", vehNoCmpPlate.getVehPlate());
		vehNoCmpPlate=vehNoCmpPlateService.load(vehNoCmpPlate.getVehPlate());
		return EDIT;
	}
	
	public String update(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());

		VehNoCmpPlate vncpTemp=new VehNoCmpPlate();
		vncpTemp.setVehPlate(vehNoCmpPlate.getVehPlate().trim());
		
		if(!session.getAttribute("updateVehPlate").toString().trim().equals(vncpTemp.getVehPlate())){
			
			if(vehNoCmpPlateService.findVehNoCmpPlate(vncpTemp.getVehPlate())){
				message="exitVehNoCmpPlate";
				return EDIT;
			}else{
				vehNoCmpPlateService._update(session.getAttribute("updateVehPlate").toString().trim(),vncpTemp);
				vncpTemp=null;
				message="updateSuccess";
				systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改车牌号为["+vehNoCmpPlate.getVehPlate()+"]的无需比较识别车牌车辆信息成功", "修改", "tb_VehNoCmpPlate");
				
			}
			
		}else{
			vehNoCmpPlateService._update(session.getAttribute("updateVehPlate").toString().trim(),vncpTemp);
			vncpTemp=null;
			message="updateSuccess";
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改车牌号为["+vehNoCmpPlate.getVehPlate()+"]的无需比较识别车牌车辆信息成功", "修改", "tb_VehNoCmpPlate");
			
		}

		session.removeAttribute("updateVehPlate");
		
		if(session.getAttribute("vehPlate")!=null){
			vehNoCmpPlate.setVehPlate((String)session.getAttribute("vehPlate"));
			
			list=vehNoCmpPlateService.findVehNoCmpPlateByCondition(pager, vehNoCmpPlate.getVehPlate());
			return  LIST;
		}else {
			list=vehNoCmpPlateService.findByPager(pager);
			vehNoCmpPlate=null;
			return LIST;
		}
	}
	
	public String delete(){
		vehNoCmpPlateService.delete(vehNoCmpPlate.getVehPlate());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除车牌号为["+vehNoCmpPlate.getVehPlate()+"]的无需比较识别车牌车辆信息成功", "删除", "tb_VehNoCmpPlate");
		vehNoCmpPlate=null;
		return list();
	}
	
	
	
	//Getter/Setter
	public VehNoCmpPlate getVehNoCmpPlate() {
		return vehNoCmpPlate;
	}

	public void setVehNoCmpPlate(VehNoCmpPlate vehNoCmpPlate) {
		this.vehNoCmpPlate = vehNoCmpPlate;
	}
	
}
