/**
 * 
 */
package com.hgsoft.action;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.CarSpaceDynamic;
import com.hgsoft.service.CarSpaceDynamicService;


/**
 * 车位动态信息
 * @author chenfuyuan
 *
 */
@Controller
@Scope("prototype")
public class CarSpaceDynamicAction extends BaseAction{	
	private CarSpaceDynamic carSpaceDynamic;
	
	@Resource
	private CarSpaceDynamicService carSpaceDynamicService;
	public String add(){
		return "add";
	}
	public String queryCarSpaceDynamicToManage() {
		list = carSpaceDynamicService.findByPager(pager);
		return "queryCarSpaceDynamicToManage";
	}
	public String carSpaceDynamicToUpdate(){
		carSpaceDynamic = carSpaceDynamicService.getCarSpaceDynamicByRecNo(carSpaceDynamic.getRecNo());
		return "carSpaceDynamicToUpdate";
	}
	public String updateCarSpaceDynamic(){
		CarSpaceDynamic carSpaceDynamicTemp = carSpaceDynamicService.getCarSpaceDynamicByRecNo(carSpaceDynamic.getRecNo());
		carSpaceDynamicTemp.setParkNo(carSpaceDynamic.getParkNo());
		carSpaceDynamicTemp.setTotalSpace(carSpaceDynamic.getTotalSpace());
		carSpaceDynamicTemp.setMonthlyRentSpace(carSpaceDynamic.getMonthlyRentSpace());
		carSpaceDynamicTemp.setTemporarySpace(carSpaceDynamic.getTemporarySpace());
		carSpaceDynamicTemp.setCurrentEmptySpace(carSpaceDynamic.getCurrentEmptySpace());
		carSpaceDynamicTemp.setOutParkTotal(carSpaceDynamic.getOutParkTotal());
		carSpaceDynamicTemp.setInParkTotal(carSpaceDynamic.getInParkTotal());
		carSpaceDynamicTemp.setMonthlyRentInPark(carSpaceDynamic.getMonthlyRentInPark());
		carSpaceDynamicTemp.setMonthlyRentOutPark(carSpaceDynamic.getMonthlyRentOutPark());
		carSpaceDynamicTemp.setTemporaryInPark(carSpaceDynamic.getTemporaryInPark());
		carSpaceDynamicTemp.setTemporaryOutPark(carSpaceDynamic.getTemporaryOutPark());
		carSpaceDynamicTemp.setModifyTime(new Date());
		carSpaceDynamicService.update(carSpaceDynamicTemp);
		result = Result.SUCCESS;
		return queryCarSpaceDynamicToManage();
		
	}
	//get set
	public CarSpaceDynamic getCarSpaceDynamic() {
		return carSpaceDynamic;
	}
	public void setCarSpaceDynamic(CarSpaceDynamic carSpaceDynamic) {
		this.carSpaceDynamic = carSpaceDynamic;
	}
}
