package com.hgsoft.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.CardType;
import com.hgsoft.entity.SecurityUserInfo;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.CardInfoSendParaService;
import com.hgsoft.service.CardTypeService;
import com.hgsoft.service.FeeRuleTypeDefService;
import com.hgsoft.service.SecurityUserInfoService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardFeeRuleTypeService;
import com.hgsoft.util.Base64;


@Controller
@Scope("prototype")
public class SecurityUserInfoAction extends BaseAction {
	
	
	//安全信息管理查询条件（用户姓名，身份证号码，车牌号，OBU号，卡类型，卡表面号，卡状态，收费类型）
	private String owner;//用户姓名
	private String IDCard;//身份证号码
	private String vehPlate;//车牌号
	private String OBU;//OBU号
	private String userType;//卡类型
	private String cardNO;//卡表面号
	private String status;//卡状态
	private String feeRuleType;//收费类型
	private String whtherRegister;//是否已注册过安全信息，0表示已注册过，1表示没注册过，null或者“”表示查询全部

	//安全信息管理注册
	private String cardNo;
	
	//安全信息管理注册、修改
	private String password;
	private String	callNum;
	
	//安全信息管理删除、修改
	private String regId;
	
	//安全信息管理修改
	private SecurityUserInfo securityUserInfo;
	@SuppressWarnings("unchecked")
	private List listCardType;
	@SuppressWarnings("unchecked")
	private List listFeeRuleTypeDef;
	@SuppressWarnings({ "unused", "unchecked" })
	private List listUserCardFeeRuleType;
	private Sysparamconf param_whtherPayType;
	private CardType cardTypeTemp;
	@SuppressWarnings("unchecked")
	private List listCardTypeThree;
	private String whtherPayType = "whtherPayType";// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
	private String whtherPayType_remark = "是否有缴费类型参数（0表示有缴费类型，1表示没有缴费类型,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	@Resource
	private CardTypeService cardTypeService;
	@Resource
	private FeeRuleTypeDefService feeRuleTypeDefService;
	@Resource
	private  UserCardFeeRuleTypeService userCardFeeRuleTypeService;
	@Resource
	private SysparamconfService sysparamconfService;
	
	@Resource
	private SecurityUserInfoService securityUserInfoService;
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
		session.removeAttribute("IDCard");
		session.removeAttribute("vehPlate");
		session.removeAttribute("OBU");
		session.removeAttribute("userType");
		session.removeAttribute("cardNO");
		session.removeAttribute("status");
		session.removeAttribute("feeRuleType");
		session.removeAttribute("whtherRegister");
		
	}
	public void setConditionSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("owner", owner);
		session.setAttribute("IDCard",IDCard);
		session.setAttribute("vehPlate", vehPlate);
		session.setAttribute("OBU",OBU);
		session.setAttribute("userType",userType);
		session.setAttribute("cardNO",cardNO);
		session.setAttribute("status", status);
		session.setAttribute("feeRuleType", feeRuleType);
		session.setAttribute("whtherRegister", whtherRegister);
		
	}
	public void setPagerSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}
	
	/**
	 * 根据条件查询安全用户信息
	 * @return
	 */
	public String querySecurityUserInfo(){
		this.removePagerAndConditionSession();
		this.setConditionSession();
		Admin logAdmin = this.getCurrentOperator();
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "SecurityUserInfoAction中querySecurityUserInfo()设置whtherPayType参数时set（），get（）参数时的异常", logAdmin);
		listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		list = securityUserInfoService.querySecurityUserInfo(pager, owner, IDCard, vehPlate, OBU, userType, cardNO, status, feeRuleType, param_whtherPayType.getPvalue(),whtherRegister);
		return SUCCESS;
	}
	
	
	/**
	 * 跳转到注册页面
	 * @return
	 */
	public String toRegister(){
		//如果不需要用户卡信息表，就直接跳到对应的页面
		return "toRegister";
	}
	
	
	/**
	 * 提交安全用户注册信息
	 * @return
	 */
	public String register(){
		//byte[] result  = Base64.encode(HashUtil.getMD5String(password).getBytes());
		//System.out.println("======="+result.toString()+"===================");
		String s = Base64.md5AndBase64(password);
		try {
			SecurityUserInfo sui= securityUserInfoService.register(callNum, s, cardNo);
			if(null != sui){
				message = "1";
				cardInfoSendParaService.SendCommandAndLost();
				//写日志
				Admin logAdmin = this.getCurrentOperator();
				systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"用户为"+cardNo+"卡号注册安全用户","车辆安全-安全信息管理", "tb_SecurityUserInfo");
			}else{
				message = "0";
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityUserInfoAciong中register()注册安全用户时发生异常",e.getMessage(), "Exception");
			message = "0";
			return querySecurityUserInfo();
		}
		return querySecurityUserInfo();
	}
	
	
	/**
	 * 获取要修改安全用户信息
	 * @return
	 */
	public String toUpdate(){
		this.setPagerSession();
		securityUserInfo = securityUserInfoService.toUpdate(regId);
		securityUserInfo.setCallNum(securityUserInfo.getCallNum().trim());
		return "toUpdate";
	}
	
	
	/**
	 * 提交修改用户安全信息
	 * @return
	 */
	public String update(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		securityUserInfo = securityUserInfoService.toUpdate(regId);
		try {
			if(null != password && !password.equals("")){
				//String PASSWORD_MD5_ENCRYPT_KEY = "~(Gb,.|[]HA*NT";	//密钥      华工不需要，直接md5
				//String s = HashUtil.getMD5String(password+"_"+PASSWORD_MD5_ENCRYPT_KEY);
				String s = Base64.md5AndBase64(password);
				securityUserInfo.setCallNum(callNum);
				securityUserInfo.setPassword(s);
				securityUserInfoService.update(securityUserInfo);
			}else{
				securityUserInfo.setCallNum(callNum);
				securityUserInfoService.update(securityUserInfo);
			}
		} catch (Exception e) {
			//e.printStackTrace();
			//当出现异常时，提示更新失败，否则的话，更新成功
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityUserInfoAciong中update()修改安全用户时发生异常",e.getMessage(), "Exception");
			message = "3";
			//return querySecurityUserInfo();
		}
		cardInfoSendParaService.SendCommandAndLost();
		//写日志
		Admin logAdmin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"用户为"+securityUserInfo.getCardNo()+"卡号修改安全用户信息","车辆安全-安全信息管理", "tb_SecurityUserInfo");
		message = "4";
				
		if(session.getAttribute("owner") != null){
			owner = session.getAttribute("owner").toString();
		} else{
			owner="";
		}
		if(session.getAttribute("IDCard") != null){
			IDCard = session.getAttribute("IDCard").toString();
		} else{
			IDCard="";
		}
		if(session.getAttribute("vehPlate") != null){
			vehPlate = session.getAttribute("vehPlate").toString();
		} else{
			vehPlate="";
		}
		if(session.getAttribute("OBU") != null){
			OBU = session.getAttribute("OBU").toString();
		} else{
			OBU="";
		}		
		if(session.getAttribute("userType") != null){
			userType = session.getAttribute("userType").toString();
		} else{
			userType = "";
		}
		if(session.getAttribute("cardNO") != null){
			cardNO = session.getAttribute("cardNO").toString();
		} else{
			cardNO = "";
		}		
		if(session.getAttribute("status") != null){
			status = session.getAttribute("status").toString();
		} else{
			status = "";
		}
		if(session.getAttribute("feeRuleType") != null){
			feeRuleType = session.getAttribute("feeRuleType").toString();
		} else{
			feeRuleType = "";
		}	
		if(session.getAttribute("whtherRegister") != null){
			whtherRegister = session.getAttribute("whtherRegister").toString();
		} else{
			whtherRegister = "";
		}
		
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "SecurityUserInfoAction中update()设置whtherPayType参数时set（），get（）参数时的异常", logAdmin);
		listCardType = cardTypeService.getAllCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		cardTypeTemp = cardTypeService.getCardTypeByCardType((short) 15);// 查询tb_CardType获得CardType为15的对象，以显示真实用户类型为15时的类型名字（车位车）
		listCardTypeThree = cardTypeService.getCardTypeByThreeCardType((short) 13, (short) 14, (short) 15);// 查询tb_CardType获得CardType为13,14或者15的对象，以在查询条件中用户类型显示
		list = securityUserInfoService.querySecurityUserInfo(pager, owner, IDCard, vehPlate, OBU, userType, cardNO, status, feeRuleType, param_whtherPayType.getPvalue(),whtherRegister);
		return SUCCESS;
	}
	
	
	
	/**
	 * 删除安全用户信息
	 * @return
	 */
	public String delete(){	
		try {
			securityUserInfoService.delete(regId);
		} catch (Exception e) {
			//e.printStackTrace();
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityUserInfoAciong中delete()删除安全用户时发生异常",e.getMessage(), "Exception");
			message = "5";
			return querySecurityUserInfo();
		}
		cardInfoSendParaService.SendCommandAndLost();
		//写日志
		Admin logAdmin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"用户删除安全用户Id为："+regId+"的信息","车辆安全-安全信息管理", "tb_SecurityUserInfo");
		message = "6";
		return querySecurityUserInfo();
	}

	public String getOwner() {
		return owner;
	}


	public void setOwner(String owner) {
		this.owner = owner;
	}


	public String getIDCard() {
		return IDCard;
	}


	public void setIDCard(String card) {
		IDCard = card;
	}


	public String getVehPlate() {
		return vehPlate;
	}


	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}


	public String getOBU() {
		return OBU;
	}


	public void setOBU(String obu) {
		OBU = obu;
	}


	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getCardNO() {
		return cardNO;
	}
	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFeeRuleType() {
		return feeRuleType;
	}
	public void setFeeRuleType(String feeRuleType) {
		this.feeRuleType = feeRuleType;
	}

	public SecurityUserInfoService getSecurityUserInfoService() {
		return securityUserInfoService;
	}
	public void setSecurityUserInfoService(
			SecurityUserInfoService securityUserInfoService) {
		this.securityUserInfoService = securityUserInfoService;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCallNum() {
		return callNum;
	}

	public void setCallNum(String callNum) {
		this.callNum = callNum;
	}


	public String getRegId() {
		return regId;
	}


	public void setRegId(String regId) {
		this.regId = regId;
	}


	public SecurityUserInfo getSecurityUserInfo() {
		return securityUserInfo;
	}


	public void setSecurityUserInfo(SecurityUserInfo securityUserInfo) {
		this.securityUserInfo = securityUserInfo;
	}


	@SuppressWarnings("unchecked")
	public List getListCardType() {
		return listCardType;
	}


	@SuppressWarnings("unchecked")
	public void setListCardType(List listCardType) {
		this.listCardType = listCardType;
	}


	@SuppressWarnings("unchecked")
	public List getListFeeRuleTypeDef() {
		return listFeeRuleTypeDef;
	}


	@SuppressWarnings("unchecked")
	public void setListFeeRuleTypeDef(List listFeeRuleTypeDef) {
		this.listFeeRuleTypeDef = listFeeRuleTypeDef;
	}


	public Sysparamconf getParam_whtherPayType() {
		return param_whtherPayType;
	}


	public void setParam_whtherPayType(Sysparamconf param_whtherPayType) {
		this.param_whtherPayType = param_whtherPayType;
	}


	public CardType getCardTypeTemp() {
		return cardTypeTemp;
	}


	public void setCardTypeTemp(CardType cardTypeTemp) {
		this.cardTypeTemp = cardTypeTemp;
	}


	@SuppressWarnings("unchecked")
	public List getListCardTypeThree() {
		return listCardTypeThree;
	}


	@SuppressWarnings("unchecked")
	public void setListCardTypeThree(List listCardTypeThree) {
		this.listCardTypeThree = listCardTypeThree;
	}
	
	public String getWhtherRegister() {
		return whtherRegister;
	}


	public void setWhtherRegister(String whtherRegister) {
		this.whtherRegister = whtherRegister;
	}
	@SuppressWarnings("unchecked")
	public List getListUserCardFeeRuleType() {
		return listUserCardFeeRuleType;
	}
	@SuppressWarnings("unchecked")
	public void setListUserCardFeeRuleType(List listUserCardFeeRuleType) {
		this.listUserCardFeeRuleType = listUserCardFeeRuleType;
	}


	
}
