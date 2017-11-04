package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.SpVehHandle;
import com.hgsoft.entity.SpecialType;
import com.hgsoft.entity.SpecialVeh;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.SpVehHandleService;
import com.hgsoft.service.SpecialTypeService;
import com.hgsoft.service.SpecialVehService;
import com.hgsoft.service.SystemLogService;

/**
 * 特殊车辆管理
 * @author qinzuohai
 *
 */
@Controller
@Scope("prototype")
public class SpecialVehAction extends BaseAction{

	private SpecialVeh specialVeh;
	private SpVehHandle spVehHandle;
    private List<SpecialType> stList;
    private List<SpVehHandle> spList;
    
    
    private List<GatewayInformation> stationList;
    private String station;
    private List<LaneInformation> roadList;
    private String road;
    @SuppressWarnings("unchecked")
	private List deviceList;
    @SuppressWarnings("unchecked")
	private List deviceErrorList;
    private String device;
    private String status;
    private String systemType;
	private String gateNo;

	

	@Resource
	private SpecialVehService specialVehService;
	@Resource
	private SpecialTypeService specialTypeService;
	@Resource
	private SystemLogService systemLogService; 
	@Resource
	private SpVehHandleService spVehHandleService;
	@Resource 
	private GatewayInformationService gatewayInformationService;
	@Resource 
	private LaneInformationService laneInformationService;
	
	public String list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("vehPlate");
		session.removeAttribute("cardNo");
		session.removeAttribute("specialType");
		session.removeAttribute("lanetype");
		
		stList=specialTypeService.findSpecialType();
		list=specialVehService.findByPager(pager);
		
		return LIST;
	}
	
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("vehPlate");
		session.removeAttribute("cardNo");
		session.removeAttribute("specialType");
		session.removeAttribute("lanetype");
		
		if (!specialVeh.getVehPlate().equals("")
				|| !specialVeh.getCardNo().equals("")
				|| specialVeh.getSpecialType()!=null
				|| specialVeh.getLanetype()!=null) {
			
			session.setAttribute("vehPlate", specialVeh.getVehPlate());
			session.setAttribute("cardNo", specialVeh.getCardNo());
			session.setAttribute("specialType", specialVeh.getSpecialType());
			session.setAttribute("lanetype", specialVeh.getLanetype());

			stList=specialTypeService.findSpecialType();
			list=specialVehService.findSpecialVehByCondition(pager, specialVeh.getVehPlate(), specialVeh.getCardNo(), specialVeh.getSpecialType(), specialVeh.getLanetype());
			return LIST;
		}else{
			return list();
		}

	}
	
	public String add(){
		stList=specialTypeService.findSpecialType();
		return ADD;
	}
	
	public String save(){
		if(specialVehService.findSpecialVehByVehPlateCardNo(specialVeh.getVehPlate())){
			message="exitSpecialVeh";
			stList=specialTypeService.findSpecialType();
			return ADD;
		}
		
		SpecialVeh svTemp=new SpecialVeh();
		svTemp.setCardNo(specialVeh.getCardNo().trim());
		svTemp.setInfo(specialVeh.getInfo().trim());
		svTemp.setLanetype(specialVeh.getLanetype());
		svTemp.setVehPlate(specialVeh.getVehPlate().trim());
		svTemp.setSpecialType(specialVeh.getSpecialType());
		
		specialVehService.save(svTemp);
		svTemp=null;
		result=Result.SUCCESS;
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加车牌号为["+specialVeh.getVehPlate()+"]的特殊车辆信息成功", "特殊车辆管理-添加", "tb_specialveh");
		specialVeh=null;
		return list();
	}
	
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		stList=specialTypeService.findSpecialType();
		specialVeh=specialVehService.LoadSpecialVeh(specialVeh.getVehPlate(), specialVeh.getCardNo()).get(0);
		return EDIT;
	}
	
	public String update(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());

		SpecialVeh svTemp=new SpecialVeh();
		svTemp.setCardNo(specialVeh.getCardNo().trim());
		svTemp.setInfo(specialVeh.getInfo().trim());
		svTemp.setLanetype(specialVeh.getLanetype());
		svTemp.setVehPlate(specialVeh.getVehPlate().trim());
		svTemp.setSpecialType(specialVeh.getSpecialType());
		
		specialVehService.update(svTemp);
		svTemp=null;
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改车牌号为["+specialVeh.getVehPlate()+"]的特殊车辆信息成功", "特殊车辆管理-修改", "tb_specialveh");
		
		stList=specialTypeService.findSpecialType();
		
		if(session.getAttribute("vehPlate")!=null
				||session.getAttribute("cardNo")!=null
				||session.getAttribute("specialType")!=null
				||session.getAttribute("lanetype")!=null){

			specialVeh.setVehPlate((String)session.getAttribute("vehPlate"));
			specialVeh.setCardNo((String)session.getAttribute("cardNo"));
			specialVeh.setSpecialType((Integer)session.getAttribute("specialType"));
			specialVeh.setLanetype((Short)session.getAttribute("lanetype"));
			
			list=specialVehService.findSpecialVehByCondition(pager, specialVeh.getVehPlate(), specialVeh.getCardNo(), specialVeh.getSpecialType(), specialVeh.getLanetype());
//			specialVeh=null;
			return  LIST;
		}else {
			list=specialVehService.findByPager(pager);
			specialVeh=null;
			return LIST;
		}
	}
	
	public String delete(){
		specialVehService.deleteBycompositeID(specialVeh.getVehPlate(), specialVeh.getCardNo());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除车牌号为["+specialVeh.getVehPlate()+"]的特殊车辆信息成功", "特殊车辆管理-删除", "tb_specialveh");
		specialVeh=null;
		return list();
	}
	
	//caijunhua 特殊车辆处理信息列表
	public String handleMsgList() {
		spList = spVehHandleService.findSpVehHandleByHql(pager, null, null, null, null);
		return "handleMsg";
	}
	//caijunhua 特殊车辆处理信息查询
	public String handleMsgQuery() {
		if(null != spVehHandle.getLaneType() || null != spVehHandle.getTableName()
				|| null != spVehHandle.getStatus() || null != spVehHandle.getHandleType()) {
			spList = spVehHandleService.findSpVehHandleByHql(pager, spVehHandle.getLaneType(), spVehHandle.getTableName(),
					spVehHandle.getStatus(), spVehHandle.getHandleType());
		} else {
			spList = spVehHandleService.findSpVehHandleByHql(pager, null, null, null, null);
		}
		return "handleMsg";
	}
	/**
	 * 设备监控
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String queryMonitoring(){
		stationList = gatewayInformationService.getAllGatewayInformation();
		if(null != station && !station.equals("")){
			roadList =  laneInformationService.getAllLaneInformationByGateNo(Short.valueOf(station));
		}
		deviceList = specialVehService.allDevice();
		deviceErrorList = specialVehService.allDeviceError();
		List temp = specialVehService.queryMonitoring(pager,station, road, status, systemType,device);
		Map<Integer, String> errorMap = new HashMap<Integer, String>();
		if(!deviceErrorList.isEmpty()){
			for(int i=0;i<deviceErrorList.size();i++){
				Map map = (Map) deviceErrorList.get(i);
				errorMap.put(Integer.valueOf(map.get("DeviceErrorNo").toString()), map.get("DeviceErrorName").toString());
			}
		}
		if(!temp.isEmpty()){
			if(null == list){
				list = new ArrayList();
			}
			for(int i=0;i<temp.size();i++){
				Object[] obj = (Object[])temp.get(i);
				String objStr = errorMap.get(obj[4]);
				if(null == objStr || "".equals(objStr)){
					obj[4] = "正常";
				}else{
					obj[4] = objStr;
				}
				list.add(obj);
			}
		}
		return "monitoring";
	}
	/**
	 * 异步获得大门车道信息
	 */
	@SuppressWarnings("unchecked")
	public String ajaxLane(){
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = laneInformationService.getAllLaneInformationByGateNo(Short.parseShort(gateNo));
		//sdfsd
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<lanes>");
		for (int i = 0; i < tempList.size(); i++) {
			LaneInformation information = (LaneInformation) tempList.get(i);
			pw.print("<lane id='" + information.getLaneNo() + "' name='" + information.getLaneNo() + "' />");
		}
		pw.print("</lanes>");
		return null;
	}
	//Getter/Setter
	public SpecialVeh getSpecialVeh() {
		return specialVeh;
	}
	public void setSpecialVeh(SpecialVeh specialVeh) {
		this.specialVeh = specialVeh;
	}
	public SpVehHandle getSpVehHandle() {
		return spVehHandle;
	}
	public void setSpVehHandle(SpVehHandle spVehHandle) {
		this.spVehHandle = spVehHandle;
	}
	public List<SpecialType> getStList() {
		return stList;
	}
	public void setStList(List<SpecialType> stList) {
		this.stList = stList;
	}
	public List<SpVehHandle> getSpList() {
		return spList;
	}
	public void setSpList(List<SpVehHandle> spList) {
		this.spList = spList;
	}
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSystemType() {
		return systemType;
	}

	public void setSystemType(String systemType) {
		this.systemType = systemType;
	}

	public List<GatewayInformation> getStationList() {
		return stationList;
	}

	public void setStationList(List<GatewayInformation> stationList) {
		this.stationList = stationList;
	}

	public List<LaneInformation> getRoadList() {
		return roadList;
	}

	public void setRoadList(List<LaneInformation> roadList) {
		this.roadList = roadList;
	}

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station;
	}

	public String getRoad() {
		return road;
	}

	public void setRoad(String road) {
		this.road = road;
	}

	@SuppressWarnings("unchecked")
	public List getDeviceList() {
		return deviceList;
	}

	@SuppressWarnings("unchecked")
	public void setDeviceList(List deviceList) {
		this.deviceList = deviceList;
	}

	public String getDevice() {
		return device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	@SuppressWarnings("unchecked")
	public List getDeviceErrorList() {
		return deviceErrorList;
	}

	@SuppressWarnings("unchecked")
	public void setDeviceErrorList(List deviceErrorList) {
		this.deviceErrorList = deviceErrorList;
	}
	public String getGateNo() {
		return gateNo;
	}

	public void setGateNo(String gateNo) {
		this.gateNo = gateNo;
	}
	
}
