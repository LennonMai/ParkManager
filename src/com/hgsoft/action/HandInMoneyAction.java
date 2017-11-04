package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.AreaInformation;
import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.HandInMoney;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.service.AreaInformationService;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.HandInMoneyService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.OperatorService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date October 22, 2010
 * @Description 交接班管理
 */

@Controller
@Scope("prototype")
public class HandInMoneyAction extends BaseAction {
	@Resource
	private HandInMoneyService handInMoneyService;
	@Resource
	private OperatorService operatorService;
	@Resource
	private AreaInformationService areaInformationService;
	@Resource
	private ParkInformationService parkInformationService;
	@Resource
	private GatewayInformationService gatewayInformationService;
	@Resource
	private LaneInformationService laneInformationService;
	@Resource
	private SquadInformationService squadInformationService;
	@Resource
	private SystemLogService systemLogService;
	
	private HandInMoney handInMoney;
	private AreaInformation areaInformation;
	private ParkInformation parkInformation;
	private GatewayInformation gatewayInformation;
	
	@SuppressWarnings("unchecked")
	public List listArea;
	@SuppressWarnings("unchecked")
	public List listPark;
	@SuppressWarnings("unchecked")
	public List listGate;
	@SuppressWarnings("unchecked")
	public List listLane;
	@SuppressWarnings("unchecked")
	public List listSquad;
	
	
	
	//跳转到交接班管理列表页面
	public String list() {
		list = handInMoneyService.findBySquadDatePager(pager);
		listArea = areaInformationService.getAllAreaInformation();	//区域
		listPark = parkInformationService.getAllParkInformation();	//小区
		listGate = gatewayInformationService.getAllGatewayInformation();	//大门
//		if(null != handInMoney.getGateNo()){
//			listLane = laneInformationService.getLaneInformationByGateNo(handInMoney.getGateNo());//车道
//		}
		listSquad = squadInformationService.getAllSquadInformation();	//工班
//		System.out.println(list.size());
		return "list";
	}
	
	//查询交接班
	public String queryHandInMoney() {
		if(handInMoney.getGateNo() != null || handInMoney.getLaneNo() != null 
				|| handInMoney.getSquadDate() != null || handInMoney.getSquadNo() != null) {//查询条件不为空
			list = handInMoneyService.findAllHandInMoneyByHql(pager, handInMoney.getGateNo(), 
					handInMoney.getLaneNo(), handInMoney.getSquadDate(), handInMoney.getSquadNo());
			listArea = areaInformationService.getAllAreaInformation();	//区域
			listPark = parkInformationService.getAllParkInformation();	//小区
			listGate = gatewayInformationService.getAllGatewayInformation();	//大门
			if(null != handInMoney.getGateNo()) {
				listLane = laneInformationService.getLaneInformationByGateNo(handInMoney.getGateNo());//车道
			}
			listSquad = squadInformationService.getAllSquadInformation();	//工班
			
			return "list";
		} else {
			return list();	//查询条件为空
		}
	}
	
	//跳转到修改交接班信息页面
	public String edit() {
		list = operatorService.getAllOperator();	//车道操作员
		areaInformation = areaInformationService.get(handInMoney.getAreaNo());
		parkInformation = parkInformationService.LoadParkInfo(handInMoney.getParkNo()).get(0);
		gatewayInformation = gatewayInformationService.LoadGatewayInfo(handInMoney.getAreaNo(), handInMoney.getParkNo(), handInMoney.getGateNo()).get(0);
//		listArea = areaInformationService.getAllAreaInformation();	//区域
//		listPark = parkInformationService.getAllParkInformation();	//小区
//		listGate = gatewayInformationService.getAllGatewayInformation();	//大门
//		listSquad = squadInformationService.getAllSquadInformation();	//工班
		List<HandInMoney> handInMoneyList = handInMoneyService.loadHandInMoney(handInMoney.getAreaNo(), 
				handInMoney.getParkNo(), handInMoney.getGateNo(), handInMoney.getLaneNo(), 
				handInMoney.getSquadDate(), handInMoney.getSquadNo());
		handInMoney = handInMoneyList.get(0);
		return EDIT;
	}
	
	//修改交接班信息
	public String update() {
		handInMoney.setLaneOperatorName(operatorService.get(handInMoney.getLaneOperatorNo()).getOperatorName());
//		System.out.println(operatorService.get(handInMoney.getLaneOperatorNo()).getOperatorName());
		handInMoney.setOpTime(new Date());	//操作时间
		handInMoney.setOperatorNo((getCurrentOperator().getId()).toString());	//操作员编码
		handInMoney.setOperatorName(getCurrentOperator().getName());	//操作员名称
		handInMoneyService.update(handInMoney);
		
		//插入系统日志
//		admin = adminService.get(getCurrentOperator().getId());
		Admin admin = this.getCurrentOperator(); 
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户修改工班日期为"+format.format(handInMoney.getSquadDate())+"的交接班信息",
				"报表管理--业务处理--交接班管理", "tb_HandInMoney");
		
		//去除查询条件显示
		handInMoney = null;
		
		return list();
	}
	//删除交接班信息
	public String delete() {
		handInMoneyService.deleteHandInMoney(handInMoney.getAreaNo(), 
				handInMoney.getParkNo(), handInMoney.getGateNo(), handInMoney.getLaneNo(), 
				handInMoney.getSquadDate(), handInMoney.getSquadNo());
		
		//插入系统日志
		Admin admin = this.getCurrentOperator();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户删除工班日期为"+format.format(handInMoney.getSquadDate())+"的交接班信息",
				"报表管理--业务处理--交接班管理", "tb_HandInMoney");
		
		//去除查询条件显示
		handInMoney = null;
		
		return list();
	}
	
	/**
	 * 异步获得大门 出口 车道信息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String ajaxLane() {
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = laneInformationService.getLaneInformationByGateNo(handInMoney.getGateNo());
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<lanes>");
		for(int i = 0; i < tempList.size(); i++) {
			LaneInformation information = (LaneInformation)tempList.get(i);
			pw.print("<lane id='" + information.getLaneNo() + "' name='" + information.getLaneNo() + "' /> ");
		}
		pw.print("</lanes>");
		return null;
	}

	
	// Getters/Setters方法
	public HandInMoney getHandInMoney() {
		return handInMoney;
	}
	public void setHandInMoney(HandInMoney handInMoney) {
		this.handInMoney = handInMoney;
	}
	
	public AreaInformation getAreaInformation() {
		return areaInformation;
	}
	public void setAreaInformation(AreaInformation areaInformation) {
		this.areaInformation = areaInformation;
	}

	public ParkInformation getParkInformation() {
		return parkInformation;
	}
	public void setParkInformation(ParkInformation parkInformation) {
		this.parkInformation = parkInformation;
	}

	public GatewayInformation getGatewayInformation() {
		return gatewayInformation;
	}
	public void setGatewayInformation(GatewayInformation gatewayInformation) {
		this.gatewayInformation = gatewayInformation;
	}
	
	
	@SuppressWarnings("unchecked")
	public List getListArea() {
		return listArea;
	}
	@SuppressWarnings("unchecked")
	public List getListPark() {
		return listPark;
	}
	@SuppressWarnings("unchecked")
	public List getListGate() {
		return listGate;
	}
	@SuppressWarnings("unchecked")
	public List getListLane() {
		return listLane;
	}
	@SuppressWarnings("unchecked")
	public List getListSquad() {
		return listSquad;
	}


	
	

}
