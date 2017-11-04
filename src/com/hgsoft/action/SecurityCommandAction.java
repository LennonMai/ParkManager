package com.hgsoft.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.service.CardInfoSendParaService;
import com.hgsoft.service.SecurityCommandService;
import com.hgsoft.service.SecurityUserInfoService;
import com.hgsoft.service.SystemLogService;



@Controller
@Scope("prototype")
public class SecurityCommandAction extends BaseAction {
	
	
	//指令管理查询条件（指令类型，用户名，卡号，车牌号，有效类型）
	private String type;//指令类型
	private String owner;//用户名
	private String cardNo;//卡号
	private String vehPlate;//车牌号
	private String validType;//有效类型
	
	
	//安全指令
	private SecurityCommand securityCommand;
	//添加安全指令
	private String times;
	private String dayStartTime;
	private String dayEndTime;
	private String vehPlate1;
	
	//删除和修改
	private String commandId;
	private String startTime1;
	private String endTime1;
	
	@Resource
	private SecurityCommandService securityCommandService;
	@Resource
	private SecurityUserInfoService  securityUserInfoService;
	@Resource
	private CardInfoSendParaService cardInfoSendParaService;
	@Resource
	private SystemLogService systemLogService;
	public void removePagerAndConditionSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("owner");
		session.removeAttribute("type");
		session.removeAttribute("cardNo");
		session.removeAttribute("validType");
		session.removeAttribute("vehPlate");
	}
	public void setConditionSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("owner", owner);
		session.setAttribute("type",type);
		session.setAttribute("cardNo", cardNo);
		session.setAttribute("validType",validType);
		session.setAttribute("vehPlate", vehPlate);
		
	}
	public void setPagerSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}
	/**
	 * 查询注册过的安全用户信息
	 * @return
	 */
	public String query(){
		this.removePagerAndConditionSession();
		this.setConditionSession();
		list = 	securityCommandService.querySecurityCommand(pager,owner, cardNo, vehPlate,type,validType);
		return SUCCESS;
	}
	/**
	 * 跳转到指令添加页面
	 * @return
	 */
	public String toAddCommand(){
		return "addCommand";
	}
	/**
	 * 跳转到更新页面
	 */
	public String toUpdateCommand(){
		this.setPagerSession();
		securityCommand = securityCommandService.getByCommandId(commandId);
		return "update";
	}
	/**
	 * 更新安全指令
	 */
	public String updateCommand(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		securityCommand = securityCommandService.getByCommandId(commandId);
		String vt = Short.toString(securityCommand.getValidType());
		if(vt.equals("1")){
			securityCommand.setStartTime(dayStartTime.substring(0, 5).replace(":", ""));
			securityCommand.setEndTime(dayEndTime.substring(0, 5).replace(":", ""));
		}
		if(vt.equals("2")){
			String start = startTime1.replace("-", "");
			start = start.replace(" ","");
			start = start.replace(":", "");
			securityCommand.setStartTime(start.substring(0, 12));
			String end = endTime1.replace("-", "");
			end = end.replace(" ", "");
			end = end.replace(":", "");
			securityCommand.setEndTime(end.substring(0, 12));
		}
		try {
			securityCommandService.update(securityCommand);//更新安全指令
			cardInfoSendParaService.SendCommandAndLost();
		} catch (Exception e) {
			//e.printStackTrace();
			//写日志
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityCommandAction中updateCommand()修改指令时发生异常",e.getMessage(), "Exception");
			message ="6";
			//return query();
		}
		//写日志
		Admin logAdmin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"用户修改"+securityCommand.getCardNo()+"卡的安全指令","车辆安全-安全指令管理-指令管理", "tb_SecurityCommand,tb_SecurityCommandBackup,tb_SecurityCommandOperation");
		message = "7";		
		if(session.getAttribute("owner") != null){
			owner = session.getAttribute("owner").toString();
		} else{
			owner="";
		}
		if(session.getAttribute("type") != null){
			type = session.getAttribute("type").toString();
		} else{
			type="";
		}
		if(session.getAttribute("cardNo") != null){
			cardNo = session.getAttribute("cardNo").toString();
		} else{
			cardNo="";
		}
		if(session.getAttribute("validType") != null){
			validType = session.getAttribute("validType").toString();
		} else{
			validType="";
		}
		if(session.getAttribute("vehPlate") != null){
			vehPlate = session.getAttribute("vehPlate").toString();
		} else{
			vehPlate="";
		}
		System.out.println("");
		list = 	securityCommandService.querySecurityCommand(pager,owner, cardNo, vehPlate,type,validType);
		return SUCCESS;
	}
	/**
	 * 删除安全指令
	 */
	public String delete(){
		securityCommand = securityCommandService.getByCommandId(commandId);
		try {
			securityCommandService.delete(securityCommand);//删除安全指令数据
			cardInfoSendParaService.SendCommandAndLost();

		} catch (Exception e) {
			//e.printStackTrace();
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityCommandAction中delete()删除指令时发生异常",e.getMessage(), "Exception");
			message = "8";
			return query();
		}
		Admin logAdmin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"用户删除"+securityCommand.getCardNo()+"卡的安全指令","车辆安全-安全指令管理-指令管理", "tb_SecurityCommand,tb_SecurityCommandBackup,tb_SecurityCommandOperation");
		message = "9";
		return query();
	}
	/**
	 * 增加安全指令
	 * @return
	 */
	public String addCommand(){
		String vt = Short.toString(securityCommand.getValidType());
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmm");
		if(vt.equals("1")){
			securityCommand.setStartTime(dayStartTime.substring(0, 5).replace(":", ""));
			securityCommand.setEndTime(dayEndTime.substring(0, 5).replace(":", ""));
		}
		if(vt.equals("2")){
			String start = securityCommand.getStartTime().replace("-", "");
			start = start.replace(" ","");
			start = start.replace(":", "");
			securityCommand.setStartTime(start.substring(0, 12));
			String end = securityCommand.getEndTime().replace("-", "");
			end = end.replace(" ", "");
			end = end.replace(":", "");
			securityCommand.setEndTime(end.substring(0, 12));
		}
		if(vt.equals("3")){
			Calendar ca = Calendar.getInstance();
			Date date = ca.getTime();
			String dateStr = format.format(date);
			securityCommand.setStartTime(dateStr);
			securityCommand.setEndTime("");
		}
		if(vt.equals("4")){
			Calendar ca = Calendar.getInstance();
			Date date = ca.getTime();
			String dateStr = format.format(date);
			securityCommand.setStartTime(dateStr);
			securityCommand.setEndTime("");
		}
		if(vt.equals("9")){
			securityCommand.setValidType(Short.valueOf("2"));
			Calendar ca = Calendar.getInstance();
			String start = format.format(ca.getTime());
			ca.add(Calendar.HOUR_OF_DAY, Integer.parseInt(times.substring(0, 2)));
			ca.add(Calendar.MINUTE,Integer.parseInt(times.substring(3, 5)));
			String end = format.format(ca.getTime());
			securityCommand.setStartTime(start);
			securityCommand.setEndTime(end);
		}
		//查询该卡号是否注册了安全用户信息（如果没不给予添加安全指令）
		boolean flag = securityUserInfoService.getByCardNo(securityCommand.getCardNo());
		if(!flag){
			message = "1";//表示该卡还没有注册安全用户信息
			return query();
		}
		//查询卡号和车牌号是否在用户卡信息表中
		boolean flag1 = securityCommandService.getCheckUserCardInfo(securityCommand.getCardNo(),vehPlate1);
		if(!flag1){
			message = "2";//表示该卡号或车牌号有误
			return query();
		}
		//判断不定时时（只允许插日一条记录）
		//if(vt.equals("4")){
		//boolean flag2 = securityCommandService.getByCardNoTypeValidType(securityCommand.getCardNo(),securityCommand.getType(),securityCommand.getValidType() );
		boolean flag2 = securityCommandService.getByVehPlateTypeValidType(securityCommand.getCardNo(),securityCommand.getType(),securityCommand.getValidType(),securityCommand.getStartTime(),securityCommand.getEndTime());
		if(flag2){
			message = "3";//表示存在该条信息
			return query();
		}
		//}
		securityCommand.setUseType(Short.parseShort("3"));
		securityCommand.setOpTime(new Date());
		securityCommand.setStatus(Short.parseShort("1"));
		securityCommand.setAttribute(Short.parseShort("0"));
		securityCommand.setOperatorType(Short.parseShort("1"));
		securityCommand.setOperatorNo(this.getCurrentOperator().getId());
		try {
			securityCommandService.save(securityCommand);//添加到安全指令表中
			cardInfoSendParaService.SendCommandAndLost();
			
		} catch (Exception e) {
			
			e.printStackTrace();
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityCommandAction中addCommand()增加指令时发生异常",e.getMessage(), "Exception");
			message = "4";
			return query();
		}
		Admin logAdmin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"用户新增"+securityCommand.getCardNo()+"卡的安全指令","车辆安全-安全指令管理-指令管理", "tb_SecurityCommand,tb_SecurityCommandBackup,tb_SecurityCommandOperation");
		message = "5";
		return query();
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getVehPlate() {
		return vehPlate;
	}
	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}
	public String getValidType() {
		return validType;
	}
	public void setValidType(String validType) {
		this.validType = validType;
	}
	public SecurityCommand getSecurityCommand() {
		return securityCommand;
	}
	public void setSecurityCommand(SecurityCommand securityCommand) {
		this.securityCommand = securityCommand;
	}
	public String getTimes() {
		return times;
	}
	public void setTimes(String times) {
		this.times = times;
	}
	public String getDayStartTime() {
		return dayStartTime;
	}
	public void setDayStartTime(String dayStartTime) {
		this.dayStartTime = dayStartTime;
	}
	public String getDayEndTime() {
		return dayEndTime;
	}
	public void setDayEndTime(String dayEndTime) {
		this.dayEndTime = dayEndTime;
	}
	public String getVehPlate1() {
		return vehPlate1;
	}
	public void setVehPlate1(String vehPlate1) {
		this.vehPlate1 = vehPlate1;
	}
	public String getCommandId() {
		return commandId;
	}
	public void setCommandId(String commandId) {
		this.commandId = commandId;
	}
	public String getStartTime1() {
		return startTime1;
	}
	public void setStartTime1(String startTime1) {
		this.startTime1 = startTime1;
	}
	public String getEndTime1() {
		return endTime1;
	}
	public void setEndTime1(String endTime1) {
		this.endTime1 = endTime1;
	}
	
}
