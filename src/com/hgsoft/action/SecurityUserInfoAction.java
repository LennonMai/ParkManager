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
	
	
	//��ȫ��Ϣ�����ѯ�������û����������֤���룬���ƺţ�OBU�ţ������ͣ�������ţ���״̬���շ����ͣ�
	private String owner;//�û�����
	private String IDCard;//���֤����
	private String vehPlate;//���ƺ�
	private String OBU;//OBU��
	private String userType;//������
	private String cardNO;//�������
	private String status;//��״̬
	private String feeRuleType;//�շ�����
	private String whtherRegister;//�Ƿ���ע�����ȫ��Ϣ��0��ʾ��ע�����1��ʾûע�����null���ߡ�����ʾ��ѯȫ��

	//��ȫ��Ϣ����ע��
	private String cardNo;
	
	//��ȫ��Ϣ����ע�ᡢ�޸�
	private String password;
	private String	callNum;
	
	//��ȫ��Ϣ����ɾ�����޸�
	private String regId;
	
	//��ȫ��Ϣ�����޸�
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
	private String whtherPayType = "whtherPayType";// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
	private String whtherPayType_remark = "�Ƿ��нɷ����Ͳ�����0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)";
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
	 * ����������ѯ��ȫ�û���Ϣ
	 * @return
	 */
	public String querySecurityUserInfo(){
		this.removePagerAndConditionSession();
		this.setConditionSession();
		Admin logAdmin = this.getCurrentOperator();
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "SecurityUserInfoAction��querySecurityUserInfo()����whtherPayType����ʱset������get��������ʱ���쳣", logAdmin);
		listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		list = securityUserInfoService.querySecurityUserInfo(pager, owner, IDCard, vehPlate, OBU, userType, cardNO, status, feeRuleType, param_whtherPayType.getPvalue(),whtherRegister);
		return SUCCESS;
	}
	
	
	/**
	 * ��ת��ע��ҳ��
	 * @return
	 */
	public String toRegister(){
		//�������Ҫ�û�����Ϣ����ֱ��������Ӧ��ҳ��
		return "toRegister";
	}
	
	
	/**
	 * �ύ��ȫ�û�ע����Ϣ
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
				//д��־
				Admin logAdmin = this.getCurrentOperator();
				systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"�û�Ϊ"+cardNo+"����ע�ᰲȫ�û�","������ȫ-��ȫ��Ϣ����", "tb_SecurityUserInfo");
			}else{
				message = "0";
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityUserInfoAciong��register()ע�ᰲȫ�û�ʱ�����쳣",e.getMessage(), "Exception");
			message = "0";
			return querySecurityUserInfo();
		}
		return querySecurityUserInfo();
	}
	
	
	/**
	 * ��ȡҪ�޸İ�ȫ�û���Ϣ
	 * @return
	 */
	public String toUpdate(){
		this.setPagerSession();
		securityUserInfo = securityUserInfoService.toUpdate(regId);
		securityUserInfo.setCallNum(securityUserInfo.getCallNum().trim());
		return "toUpdate";
	}
	
	
	/**
	 * �ύ�޸��û���ȫ��Ϣ
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
				//String PASSWORD_MD5_ENCRYPT_KEY = "~(Gb,.|[]HA*NT";	//��Կ      ��������Ҫ��ֱ��md5
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
			//�������쳣ʱ����ʾ����ʧ�ܣ�����Ļ������³ɹ�
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityUserInfoAciong��update()�޸İ�ȫ�û�ʱ�����쳣",e.getMessage(), "Exception");
			message = "3";
			//return querySecurityUserInfo();
		}
		cardInfoSendParaService.SendCommandAndLost();
		//д��־
		Admin logAdmin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"�û�Ϊ"+securityUserInfo.getCardNo()+"�����޸İ�ȫ�û���Ϣ","������ȫ-��ȫ��Ϣ����", "tb_SecurityUserInfo");
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
		
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "SecurityUserInfoAction��update()����whtherPayType����ʱset������get��������ʱ���쳣", logAdmin);
		listCardType = cardTypeService.getAllCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		cardTypeTemp = cardTypeService.getCardTypeByCardType((short) 15);// ��ѯtb_CardType���CardTypeΪ15�Ķ�������ʾ��ʵ�û�����Ϊ15ʱ���������֣���λ����
		listCardTypeThree = cardTypeService.getCardTypeByThreeCardType((short) 13, (short) 14, (short) 15);// ��ѯtb_CardType���CardTypeΪ13,14����15�Ķ������ڲ�ѯ�������û�������ʾ
		list = securityUserInfoService.querySecurityUserInfo(pager, owner, IDCard, vehPlate, OBU, userType, cardNO, status, feeRuleType, param_whtherPayType.getPvalue(),whtherRegister);
		return SUCCESS;
	}
	
	
	
	/**
	 * ɾ����ȫ�û���Ϣ
	 * @return
	 */
	public String delete(){	
		try {
			securityUserInfoService.delete(regId);
		} catch (Exception e) {
			//e.printStackTrace();
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]SecurityUserInfoAciong��delete()ɾ����ȫ�û�ʱ�����쳣",e.getMessage(), "Exception");
			message = "5";
			return querySecurityUserInfo();
		}
		cardInfoSendParaService.SendCommandAndLost();
		//д��־
		Admin logAdmin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"�û�ɾ����ȫ�û�IdΪ��"+regId+"����Ϣ","������ȫ-��ȫ��Ϣ����", "tb_SecurityUserInfo");
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
