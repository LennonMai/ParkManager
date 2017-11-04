package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.CarType;
import com.hgsoft.service.CarSmallTypeService;
import com.hgsoft.service.CarTypeService;
import com.hgsoft.service.UserCardInfoService;

@Controller
@Scope("prototype")
public class CarTypeAction extends BaseAction{
	@Resource
	private CarTypeService carTypeService;
	@Resource
	private UserCardInfoService userCardInfoService;
	@Resource
	private CarSmallTypeService carSmallTypeService;
	private CarType carType;

	public CarType getCarType() {
		return carType;
	}

	public void setCarType(CarType carType) {
		this.carType = carType;
	}
	
	public CarTypeAction(){
		carType = new CarType();
	}
	
	public String getCarTypeList(){
		list = carTypeService.getAllCarType(pager);
		return "list";
	}
	
	public String edit(){
		carType = carTypeService.getCarTypeByCarType(carType.getCarType());
		return EDIT;
	}
	
	public String save(){
		carTypeService.saveCarType(carType);
		result = Result.SUCCESS;
		return getCarTypeList();
	}
	
	public String update(){
		carTypeService.updateCarType(carType);
		this.message="updateSuccess";
		return getCarTypeList();
	}
	
	public String delete(){
		carTypeService.deleteCarType(carType.getCarType());
		this.message="deleteSuccess";
		return getCarTypeList();
	}

	/**
	 * 检查车辆类型编码是否已存在
	 * */
	public String isHasCarType(){
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(carTypeService.getCarTypeByCarType(carType.getCarType())==null){
			pw.print("noCarType");
		}else{
			pw.print("hasCarType");
		}
		return null;
	}
	
	/**
	 * 删除车辆类型信息时，
	 * 需要检查该车辆类型是否已在校园卡和停车位信息中被使用，
	 * 若已被使用，则不能删除
	 * */
	public String isCarTypeInUse(){
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		list = userCardInfoService.findUserCarInfoByCarType(carType.getCarType(), null);
		if(userCardInfoService.findUserCarInfoByCarType(carType.getCarType(), null)!=null){
			pw.print("UseInUserCarInfo");
		}else if(carSmallTypeService.findSmallTypeByCarType(carType.getCarType())!=null){
			pw.print("UseInSmallType");
		}
		else{
			pw.print("noUse");
		}
		return null;
	}
	
}
