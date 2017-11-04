package com.hgsoft.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.CarBrandCode;
import com.hgsoft.entity.CarClassCode;
import com.hgsoft.entity.CarTypeTrans;
import com.hgsoft.entity.DeviceActionCode;
import com.hgsoft.entity.DeviceCode;
import com.hgsoft.entity.DeviceErrorCode;
import com.hgsoft.entity.FunctionKey;
import com.hgsoft.entity.LaneType;
import com.hgsoft.entity.SpEventCode;
import com.hgsoft.entity.TicketTypeCode;
import com.hgsoft.entity.VehClassCode;
import com.hgsoft.entity.VehTypeCode;
import com.hgsoft.service.CarBrandCodeService;
import com.hgsoft.service.CarClassCodeService;
import com.hgsoft.service.CarTypeTransService;
import com.hgsoft.service.DeviceActionCodeService;
import com.hgsoft.service.DeviceCodeService;
import com.hgsoft.service.DeviceErrorCodeService;
import com.hgsoft.service.FunctionKeyService;
import com.hgsoft.service.LaneTypeService;
import com.hgsoft.service.SpEventCodeService;
import com.hgsoft.service.TicketTypeCodeService;
import com.hgsoft.service.VehClassCodeService;
import com.hgsoft.service.VehTypeCodeService;

@Controller
@Scope("prototype")
public class OperateParameterAction extends BaseAction {

	private VehTypeCode vehTypeCode;
	@Resource
	private VehTypeCodeService vehTypeCodeService;

	private VehClassCode vehClassCode;
	@Resource
	private VehClassCodeService vehClassCodeService; 

	private DeviceCode deviceCode;
	@Resource
	private DeviceCodeService deviceCodeService; 
	
	private FunctionKey functionKey;
	@Resource
	private FunctionKeyService functionKeyService;
	
	private CarClassCode carClassCode;
	@Resource
	private CarClassCodeService carClassCodeService;
	
	private CarBrandCode carBrandCode;
	@Resource
	private CarBrandCodeService carBrandCodeService;
	
	private CarTypeTrans carTypeTrans;
	@Resource
	private CarTypeTransService carTypeTransService; 
	
	private LaneType laneType;
	@Resource
	private LaneTypeService laneTypeService;
	
	private SpEventCode spEventCode;
	@Resource
	private SpEventCodeService spEventCodeService;
	
	private DeviceActionCode deviceActionCode; 
	@Resource
	private DeviceActionCodeService deviceActionCodeService;
	
	private DeviceErrorCode deviceErrorCode; 
	@Resource
	private DeviceErrorCodeService deviceErrorCodeService;
	
	private TicketTypeCode ticketTypeCode;
	@Resource TicketTypeCodeService ticketTypeCodeService;
	
	
	
	/**
	 * 车型编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String vehTypeCode_list(){
		list=vehTypeCodeService.findByPager(pager);
		return "vehTypeCode_list";
	}
	public String vehTypeCode_query(){
		if(vehTypeCode.getVehTypeNo()!=null||
				!vehTypeCode.getVehTypeName().equals("")||
				vehTypeCode.getKeyCode()!=null){
			list=vehTypeCodeService.findByCondition(pager, vehTypeCode.getVehTypeNo(), vehTypeCode.getVehTypeName().trim(), vehTypeCode.getKeyCode());
			return "vehTypeCode_list";
		}else{
			return vehTypeCode_list();
		}
		
	}
	
	
	/**
	 * 车种编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String vehClassCode_list(){
		list=vehClassCodeService.findByPager(pager);
		return "vehClassCode_list";
	}
	public String vehClassCode_query(){
		if(vehClassCode.getVehClassNo()!=null||
				!vehClassCode.getVehClassName().equals("")||
				vehClassCode.getKeyCode()!=null){
			list=vehClassCodeService.findByCondition(pager, vehClassCode.getVehClassNo(), vehClassCode.getVehClassName().trim(), vehClassCode.getKeyCode());
			return "vehClassCode_list";
		}else{
			return vehClassCode_list();
		}
		
	}
	
	/**
	 * 设备编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String deviceCode_list(){
		list=deviceCodeService.findByPager(pager);
		return "deviceCode_list";
	}
	
	public String deviceCode_query(){
		if(deviceCode.getDeviceNo()!=null||
				!deviceCode.getDeviceName().equals("")){
			list=deviceCodeService.findByCondition(pager, deviceCode.getDeviceNo(), deviceCode.getDeviceName().trim());
			return "deviceCode_list";
		}else{
			return deviceCode_list();
		}
		
	}
	
	/**
	 * 功能键编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String functionKey_list(){
		list=functionKeyService.findByPager(pager);
		return "functionKey_list";
	}
	
	public String functionKey_query(){
		if(functionKey.getFunctionNo()!=null||
				!functionKey.getFunctionName().equals("")||
				functionKey.getKeyCode()!=null){
			list=functionKeyService.findByCondition(pager, functionKey.getFunctionNo(), functionKey.getFunctionName().trim(), functionKey.getKeyCode());
			return "functionKey_list";
		}else{
			return functionKey_list();
		}
	}
	
	
	/**
	 * 车分类编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String carClassCode_list(){
		list=carClassCodeService.findByPager(pager);
		return "carClassCode_list";
	}
	public String carClassCode_query(){
		if(carClassCode.getClassNo()!=null||
				!carClassCode.getClassName().equals("")){
			list=carClassCodeService.findByCondition(pager, carClassCode.getClassNo(), carClassCode.getClassName().trim());
			return "carClassCode_list";
		}else{
			return  carClassCode_list();
		}
		
	}
	
	/**
	 *车品牌编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String carBrandCode_list(){
		list=carBrandCodeService.findByPager(pager);
		return "carBrandCode_list";
	}
	public String carBrandCode_query(){
		if(carBrandCode.getBrandNo()!=null||
				!carBrandCode.getBrandName().equals("")){
			list=carBrandCodeService.findByCondition(pager, carBrandCode.getBrandNo(), carBrandCode.getBrandName().trim());
			return "carBrandCode_list";
		}else{
			return carBrandCode_list();
		}
	}
	
	/**
	 *车型转换编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String carTypeTrans_list(){
		list=carTypeTransService.findByPager(pager);
		return "carTypeTrans_list";
	}
	public String carTypeTrans_query(){
		if(!carTypeTrans.getStartDate().equals("")||
				!carTypeTrans.getClass_().equals("")||
				carTypeTrans.getWeight()!=null||
				!carTypeTrans.getVehType().equals("")){
			list=carTypeTransService.findByCondition(pager, carTypeTrans.getStartDate().trim(), carTypeTrans.getClass_().trim(), carTypeTrans.getWeight(), carTypeTrans.getVehType().trim());
			return "carTypeTrans_list";
		}else{
			return carTypeTrans_list();
		}
			
	}
	
	/**
	 *车道类型编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String laneType_list(){
		list=laneTypeService.findByPager(pager);
		return "laneType_list";
	}
	public String laneType_query(){
		if(laneType.getLaneTypeNo()!=null||
				!laneType.getLaneTypeName().equals("")){
			list=laneTypeService.findByCondition(pager, laneType.getLaneTypeNo(), laneType.getLaneTypeName().trim());
			return "laneType_list";
			
		}else{
			return laneType_list();
		}
	}
	
	/**
	 *特殊事件编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String spEventCode_list(){
		list=spEventCodeService.findByPager(pager);
		return "spEventCode_list";
	}
	public String spEventCode_query(){
		if(spEventCode.getSpEventNo()!=null||
				!spEventCode.getSpEventName().equals("")){
			list=spEventCodeService.findByCondition(pager, spEventCode.getSpEventNo(), spEventCode.getSpEventName().trim());
			return "spEventCode_list";
			
		}else{
			return spEventCode_list();
		}
	}
	
	/**
	 *设备动作编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String deviceActionCode_list(){
		list=deviceActionCodeService.findByPager(pager);
		return "deviceActionCode_list";
	}
	public String deviceActionCode_query(){
		if(deviceActionCode.getDeviceActionNo()!=null||
				!deviceActionCode.getDeviceActionName().equals("")||
				deviceActionCode.getDeviceNo()!=null){
			list=deviceActionCodeService.findByCondition(pager, deviceActionCode.getDeviceActionNo(), deviceActionCode.getDeviceActionName().trim(),deviceActionCode.getDeviceNo());
			return "deviceActionCode_list";
			
		}else{
			return deviceActionCode_list();
		}
	}
	
	/**
	 *设备错误编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String deviceErrorCode_list(){
		list=deviceErrorCodeService.findByPager(pager);
		return "deviceErrorCode_list";
	}
	public String deviceErrorCode_query(){
		if(deviceErrorCode.getDeviceErrorNo()!=null||
				!deviceErrorCode.getDeviceErrorName().equals("")||
				deviceErrorCode.getDeviceNo()!=null){
			list=deviceErrorCodeService.findByCondition(pager, deviceErrorCode.getDeviceErrorNo(), deviceErrorCode.getDeviceErrorName().trim(),deviceErrorCode.getDeviceNo());
			return "deviceErrorCode_list";
			
		}else{
			return deviceErrorCode_list();
		}
	}
	
	/**
	 *通行券类型编码
	 * ---------------------------------------------------------------------------------------------
	 * @return
	 */
	public String ticketTypeCode_list(){
		list=ticketTypeCodeService.findByPager(pager);
		return "ticketTypeCode_list";
	}
	public String ticketTypeCode_query(){
		if(ticketTypeCode.getTicketTypeNo()!=null||
				!ticketTypeCode.getTicketTypeName().equals("")){
			list=ticketTypeCodeService.findByCondition(pager, ticketTypeCode.getTicketTypeNo(), ticketTypeCode.getTicketTypeName().trim());
			return "ticketTypeCode_list";
			
		}else{
			return ticketTypeCode_list();
		}
	}
	
	//Getter/Setter
	public VehTypeCode getVehTypeCode() {
		return vehTypeCode;
	}
	public void setVehTypeCode(VehTypeCode vehTypeCode) {
		this.vehTypeCode = vehTypeCode;
	}
	public VehClassCode getVehClassCode() {
		return vehClassCode;
	}
	public void setVehClassCode(VehClassCode vehClassCode) {
		this.vehClassCode = vehClassCode;
	}
	public DeviceCode getDeviceCode() {
		return deviceCode;
	}
	public void setDeviceCode(DeviceCode deviceCode) {
		this.deviceCode = deviceCode;
	}
	public FunctionKey getFunctionKey() {
		return functionKey;
	}
	public void setFunctionKey(FunctionKey functionKey) {
		this.functionKey = functionKey;
	}
	public CarClassCode getCarClassCode() {
		return carClassCode;
	}
	public void setCarClassCode(CarClassCode carClassCode) {
		this.carClassCode = carClassCode;
	}
	public CarBrandCode getCarBrandCode() {
		return carBrandCode;
	}
	public void setCarBrandCode(CarBrandCode carBrandCode) {
		this.carBrandCode = carBrandCode;
	}
	public CarTypeTrans getCarTypeTrans() {
		return carTypeTrans;
	}
	public void setCarTypeTrans(CarTypeTrans carTypeTrans) {
		this.carTypeTrans = carTypeTrans;
	}
	public LaneType getLaneType() {
		return laneType;
	}
	public void setLaneType(LaneType laneType) {
		this.laneType = laneType;
	}
	public SpEventCode getSpEventCode() {
		return spEventCode;
	}
	public void setSpEventCode(SpEventCode spEventCode) {
		this.spEventCode = spEventCode;
	}
	public DeviceActionCode getDeviceActionCode() {
		return deviceActionCode;
	}
	public void setDeviceActionCode(DeviceActionCode deviceActionCode) {
		this.deviceActionCode = deviceActionCode;
	}
	public DeviceErrorCode getDeviceErrorCode() {
		return deviceErrorCode;
	}
	public void setDeviceErrorCode(DeviceErrorCode deviceErrorCode) {
		this.deviceErrorCode = deviceErrorCode;
	}
	public TicketTypeCode getTicketTypeCode() {
		return ticketTypeCode;
	}
	public void setTicketTypeCode(TicketTypeCode ticketTypeCode) {
		this.ticketTypeCode = ticketTypeCode;
	}
	
	
}
