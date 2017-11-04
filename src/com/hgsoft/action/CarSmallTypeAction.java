package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.CarSmallType;
import com.hgsoft.service.CarSmallTypeService;
import com.hgsoft.service.CarTypeService;
import com.hgsoft.service.UserCardInfoService;
import com.hgsoft.util.Pager;
import com.sun.org.apache.bcel.internal.generic.GETSTATIC;

@Controller
@Scope("prototype")
public class CarSmallTypeAction extends BaseAction{
	@Resource
	private CarSmallTypeService carSmallTypeService;
	@Resource
	private CarTypeService carTypeService;
	@Resource
	private UserCardInfoService userCardInfoService;
	private List carTypelist;
	private CarSmallType carSmallType;

	public CarSmallType getCarSmallType() {
		return carSmallType;
	}

	public void setCarSmallType(CarSmallType carSmallType) {
		this.carSmallType = carSmallType;
	}
	
	public CarSmallTypeAction(){
		this.carSmallType = new CarSmallType();
	}
	
	public List getCarTypelist() {
		return carTypelist;
	}

	public void setCarTypelist(List carTypelist) {
		this.carTypelist = carTypelist;
	}

	public String getCarSmallTypeList(){
		list = carSmallTypeService.findAllCarSmallType(pager);
		carTypelist = carTypeService.getAllCarType();
		return "list";
	}
	
	public String save(){
		carSmallTypeService.saveCarSmallType(carSmallType);
		this.result=Result.SUCCESS;
		return getCarSmallTypeList();
	}
	
	public String update(){
		carSmallTypeService.updateCarSmallType(carSmallType);
		this.message="updateSuccess";
		return getCarSmallTypeList();
	}
	
	public String delete(){
		carSmallTypeService.deleteCarSmallType(carSmallType);
		this.message="deleteSuccess";
		return getCarSmallTypeList();
	} 
	
	public String edit(){
		carTypelist = carTypeService.getAllCarType();
		carSmallType = carSmallTypeService.findCarSmallTypeById(carSmallType.getCarType(), carSmallType.getCarSmallType());
		return EDIT;
	}
	
	public String add(){
		carTypelist = carTypeService.getAllCarType();
		return ADD;
	}
	
	/**
	 * ͣ��λ�����Ƿ��ѱ�ʹ��
	 * 2013-12-02
	 * */
	public String isHasCarSmallType(){
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(carSmallTypeService.findCarSmallTypeById(carSmallType.getCarType(), carSmallType.getCarSmallType())==null){
			pw.print("noCarSmallType");
		}else{
			pw.print("hasCarSmallType");
		}
		return null;
	}
	
	/**
	 * ɾ��ͣ��λ��Ϣʱ��
	 * ���Ҫɾ������Ϣ�Ƿ�����У԰��ע����Ϣ��ʹ��
	 * ���ѱ�ʹ�ã�����ɾ��
	 * */
	public String isCarSmallTypeInUse(){
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(userCardInfoService.findUserCarInfoByCarType(carSmallType.getCarType(), carSmallType.getCarSmallType())==null){
			pw.print("noInUse");
		}else{
			pw.print("InUse");
		}
		return null;
	}
	
	
	
}
