package com.hgsoft.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.service.SecurityCommandBackupService;

@Controller
@Scope("prototype")
public class SecurityCommandBackupAction extends BaseAction {
	
	
	//安全指令备份查询条件（指令类型，用户名，卡号，车牌号，有效类型）
	private String type;//指令类型
	private String owner;//用户名
	private String cardNo;//卡号
	private String vehPlate;//车牌号
	private String validType;//有效类型
	
	//查询修改历史记录
	private String commandId;
	private String modId;
	
	@Resource
	SecurityCommandBackupService securityCommandBackupService;

	public String query(){
		list = securityCommandBackupService.query(pager,type,validType,owner,cardNo,vehPlate);
		return SUCCESS;
	}
	
	public String show(){
		list = securityCommandBackupService.show(pager,commandId,modId);
		return "show";
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

	public String getCommandId() {
		return commandId;
	}

	public void setCommandId(String commandId) {
		this.commandId = commandId;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}
}
