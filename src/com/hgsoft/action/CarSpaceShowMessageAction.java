package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.CarSpaceShowMessage;
import com.hgsoft.service.CarSpaceDynamicService;
import com.hgsoft.service.CarSpaceShowMessageService;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.SendParaService;

@Controller
@Scope("prototype")
public class CarSpaceShowMessageAction extends BaseAction {
	@Resource
	private CarSpaceShowMessageService carSpaceShowMessageService;
	@Resource
	private ParkInformationService parkInformationService;
	@Resource
	private GatewayInformationService gatewayInformationService;
	@Resource
	private LaneInformationService laneInformationService;
	@Resource
	private SendParaService sendParaService;
	@Resource
	private CarSpaceDynamicService carSpaceDynamicService;
	@SuppressWarnings("unchecked")
	private List parkList;
	@SuppressWarnings("unchecked")
	private List gateList;
	@SuppressWarnings("unchecked")
	private List laneList;
	private CarSpaceShowMessage carSpaceShowMessage;

	public String list() {
		list = carSpaceShowMessageService.getAllCarSpaceShowMessage();
		parkList = parkInformationService.getAllParkInformation();
		gateList = gatewayInformationService.getAllGatewayInformation();
		return "list";
	}

	public String newList() {
		// 验收新增
		list = carSpaceDynamicService.findByPager(pager);
		return "newList";
	}

	public String toSave() {
		parkList = parkInformationService.getAllParkInformation();
		return "add";

	}

	public String save() {
		carSpaceShowMessageService.save(carSpaceShowMessage);
		result = Result.SUCCESS;
		sendParaService.sendParaToLane("v_ShowInfo");
		return list();
	}

	public String display() {// 设置为可显示
		CarSpaceShowMessage carSpaceShowMessageTemp = carSpaceShowMessageService.getCarSpaceShowMessageByPGL(
				carSpaceShowMessage.getParkNo(), carSpaceShowMessage.getGateNo(), carSpaceShowMessage.getLaneNo());
		if (carSpaceShowMessageTemp != null) {
			carSpaceShowMessageTemp.setIsShowPosition("0");
			carSpaceShowMessageService.update(carSpaceShowMessageTemp);
			result = Result.SUCCESS;
			sendParaService.sendParaToLane("v_ShowInfo");
		} else {
			result = Result.FAIL;
		}
		return list();
	}

	public String noDisplay() {// 设置为可显示
		CarSpaceShowMessage carSpaceShowMessageTemp = carSpaceShowMessageService.getCarSpaceShowMessageByPGL(
				carSpaceShowMessage.getParkNo(), carSpaceShowMessage.getGateNo(), carSpaceShowMessage.getLaneNo());
		if (carSpaceShowMessageTemp != null) {
			carSpaceShowMessageTemp.setIsShowPosition("1");
			carSpaceShowMessageService.update(carSpaceShowMessageTemp);
			result = Result.SUCCESS;
			sendParaService.sendParaToLane("v_ShowInfo");
		} else {
			result = Result.FAIL;
		}
		return list();
	}

	public String deleteCarSpaceShowMessage() {
		CarSpaceShowMessage carSpaceShowMessageTemp = carSpaceShowMessageService.getCarSpaceShowMessageByPGL(
				carSpaceShowMessage.getParkNo(), carSpaceShowMessage.getGateNo(), carSpaceShowMessage.getLaneNo());
		if (carSpaceShowMessageTemp != null) {
			carSpaceShowMessageService.delete(carSpaceShowMessageTemp);
			result = Result.SUCCESS;
			sendParaService.sendParaToLane("v_ShowInfo");
		} else {
			result = Result.FAIL;
		}
		return list();
	}

	public String toUpdate() {
		carSpaceShowMessage = carSpaceShowMessageService.getCarSpaceShowMessageByPGL(carSpaceShowMessage.getParkNo(),
				carSpaceShowMessage.getGateNo(), carSpaceShowMessage.getLaneNo());
		parkList = parkInformationService.getAllParkInformation();
		gateList = gatewayInformationService.getGatewayInformationByParkNo(carSpaceShowMessage.getParkNo());
		laneList = laneInformationService.getAllLaneInformationByGateNo(carSpaceShowMessage.getGateNo());
		return "update";
	}

	public String update() {
		carSpaceShowMessageService.update(carSpaceShowMessage);
		result = Result.SUCCESS;
		sendParaService.sendParaToLane("v_ShowInfo");
		return list();
	}

	public String ajaxExist() {// jquery验证此车道车位信息是否已存在
		// userCardInfoTemp =
		// userCardInfoService.getUserCardInfoByVehPlate(userCardInfo.getVehPlate().trim());
		CarSpaceShowMessage carSpaceShowMessageTemp = carSpaceShowMessageService.getCarSpaceShowMessageByPGL(
				carSpaceShowMessage.getParkNo(), carSpaceShowMessage.getGateNo(), carSpaceShowMessage.getLaneNo());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (carSpaceShowMessageTemp == null) {
			out.println("success");

		} else {
			out.print("fail");

		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List getParkList() {
		return parkList;
	}

	@SuppressWarnings("unchecked")
	public void setParkList(List parkList) {
		this.parkList = parkList;
	}

	@SuppressWarnings("unchecked")
	public List getGateList() {
		return gateList;
	}

	@SuppressWarnings("unchecked")
	public void setGateList(List gateList) {
		this.gateList = gateList;
	}

	@SuppressWarnings("unchecked")
	public List getLaneList() {
		return laneList;
	}

	@SuppressWarnings("unchecked")
	public void setLaneList(List laneList) {
		this.laneList = laneList;
	}

	public CarSpaceShowMessage getCarSpaceShowMessage() {
		return carSpaceShowMessage;
	}

	public void setCarSpaceShowMessage(CarSpaceShowMessage carSpaceShowMessage) {
		this.carSpaceShowMessage = carSpaceShowMessage;
	}

}
