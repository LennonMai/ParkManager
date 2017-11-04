package com.hgsoft.action;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Hibernate;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Account;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.CarSmallType;
import com.hgsoft.entity.CarType;
import com.hgsoft.entity.CardGroup;
import com.hgsoft.entity.CardGroupInfo;
import com.hgsoft.entity.CardInfo;
import com.hgsoft.entity.CardOperation;
import com.hgsoft.entity.CardType;
import com.hgsoft.entity.FeeRuleTypeDef;
import com.hgsoft.entity.IdcardInfo;
import com.hgsoft.entity.OwnerIdentity;
import com.hgsoft.entity.Staff;
import com.hgsoft.entity.StoreCardBlackList;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.UserCardBill;
import com.hgsoft.entity.UserCardFeeRuleType;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.entity.UserCardRate;
import com.hgsoft.entity.UserCardType;
import com.hgsoft.service.AccountService;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CarSmallTypeService;
import com.hgsoft.service.CarTypeService;
import com.hgsoft.service.CardDynamicService;
import com.hgsoft.service.CardGroupInfoService;
import com.hgsoft.service.CardGroupService;
import com.hgsoft.service.CardInfoSendParaService;
import com.hgsoft.service.CardInfoService;
import com.hgsoft.service.CardOperationService;
import com.hgsoft.service.CardTypeService;
import com.hgsoft.service.FeeRuleTypeDefService;
import com.hgsoft.service.IDCardInfoService;
import com.hgsoft.service.OwnerIdentityService;
import com.hgsoft.service.SecurityCommandService;
import com.hgsoft.service.SecurityUserInfoService;
import com.hgsoft.service.StaffService;
import com.hgsoft.service.StoreCardBlackListService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardBillService;
import com.hgsoft.service.UserCardFeeRuleTypeService;
import com.hgsoft.service.UserCardInfoService;
import com.hgsoft.service.UserCardRateService;
import com.hgsoft.service.UserCardTypeService;
import com.hgsoft.util.ExcelUtil;

@Controller
@Scope("prototype")
public class ParkCardAction extends BaseAction {
	@SuppressWarnings("unchecked")
	private List listUserCardInfo;
	@SuppressWarnings("unchecked")
	private List listUserCardInfoHistory;
	@SuppressWarnings("unchecked")
	private List listCardType;
	@SuppressWarnings("unchecked")
	private List listFeeRuleTypeDef;
	private Sysparamconf param_whtherPayType;
	private Sysparamconf param_parkjsp;
	private Sysparamconf param_userCardInfoCardNoLength;
	private CardType cardTypeTemp;
	@SuppressWarnings("unchecked")
	private List listCardTypeThree;
	private UserCardInfo userCardInfo;
	private UserCardInfo userCardInfoTemp;
	private IdcardInfo idCardInfoTemp;
	private CardInfo cardInfo;
	private CardOperation cardOperation;
	private Admin admin;
	@SuppressWarnings("unchecked")
	private List listuserCardRate;
	@SuppressWarnings( { "unchecked" })
	private List listuserCardRateTemp;
	@SuppressWarnings("unchecked")
	private List listAdmin;
	@SuppressWarnings("unchecked")
	private List listUserCardFeeRuleType;
	@SuppressWarnings("unchecked")
	private List listUserCardType;
	@SuppressWarnings("unchecked")
	private List listCarType;
	private List listIdentity;
	private List listCarSmallType;
	private List listCarSmallTypeInCarType;
	private UserCardBill userCardBill;
	private UserCardBill userCardBillTemp;
	private UserCardRate userCardRate;
	private CardGroupInfo cardGroupInfo;
	private CardGroupInfo cardGroupInfoTemp;
	private Account account;
	private Staff staff;
	private Staff staffTemp;
	private String startTime = null;
	private int a;
	private String pathTemp;
	private Long sumMoney;
	private String payEndTime = "";
	private String modifyTime = "";
	private String payEndTimeStart = "";
	private int extendPayEndTime;
	private String isUseImage;
	private int carType;
	// zenggenbao(ͼƬ�ϴ�)
	private File myFile;
	// ��������
	@SuppressWarnings("unused")
	private String contentType;
	// ��������
	@SuppressWarnings("unused")
	private String fileName;
	private String imageFileName;
	@SuppressWarnings("unused")
	private String caption;
	private String endTime = null;
	private String startTimeTemp = null;
	private String endTimeTemp = null;
	private Short amount = null;
	private Integer money = null;
	private String opTime;
	private String isGroup;
	private String versionAndRecNo;
	private UserCardRate userCardRateTemp;
	private Sysparamconf param_card_type;
	private Sysparamconf param_isDis;

	private CardGroup cardGroup;
	private String card_type = "card_type";
	private String card_type_remark = "�����Ͳ�����0���Ǹ��ݳ�ֵ����Ϊ��д����1Ϊд��,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)";
	private String whtherPayType = "whtherPayType";// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
	private String whtherPayType_remark = "�Ƿ����շ����Ͳ�����0��ʾ���շ����ͣ�1��ʾû���շ�����,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)";
	private String parkjsp = "parkjsp";
	private String parkjsp_remark = "��parkCard�Ǹ�У����jsp�ļ���ֵΪhg��������parkCard�ļ��µ�hg�ļ����е�jsp����ʼֵΪhg��";
	// ��ȡͼƬ·��ʹ�õ�����(startTime,endTime,vehPlate)
	private String vehPlate;
	private String srcPath;
	
	//������
	private String cardNo;
	private String vehplate;
	private String obuId;
	private String cardType;
	private String status;
	private String ownerName;
	private String isImage;
	private String feeRuleType;
	@SuppressWarnings("unchecked")
	private List userCardTypeList;
	
	private String filed;
	@Resource
	private FeeRuleTypeDefService feeRuleTypeDefService;
	@Resource
	private UserCardInfoService userCardInfoService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private AdminService adminService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private IDCardInfoService iDCardInfoService;
	@Resource
	private CardInfoService cardInfoService;
	@Resource
	private CardInfoSendParaService cardInfoSendParaService;
	@Resource
	private CardOperationService cardOperationService;
	@Resource
	private UserCardBillService userCardBillService;
	@Resource
	private UserCardRateService userCardRateService;
	@Resource
	private CardGroupInfoService cardGroupInfoService;
	@Resource
	private CardGroupService cardGroupService;
	@Resource
	private UserCardFeeRuleTypeService userCardFeeRuleTypeService;
	@Resource
	private StaffService staffService;
	@Resource
	private AccountService accountService;
	@Resource
	private CardDynamicService cardDynamicService;

	@Resource
	private StoreCardBlackListService storeCardBlackListService;
	@Resource
	private SecurityUserInfoService securityUserInfoService;
	@Resource
	private SecurityCommandService securityCommandService;
	@Resource
	private CardTypeService cardTypeService;
	@Resource
	private CarTypeService carTypeService;
	@Resource
	private UserCardTypeService userCardTypeService;
	@Resource
	private OwnerIdentityService ownerIdentityService;
	@Resource
	private CarSmallTypeService carSmallTypeService;
	
	public void getSomeObjec() {// ��������ظ���д��һ������
		listCarType = carTypeService.getAllCarType();
		listCardType = cardTypeService.getAllCardType();
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		// cardTypeTemp = cardTypeService.getCardTypeByCardType((short) 15);//
		// ��ѯtb_CardType���CardTypeΪ15�Ķ�������ʾ��ʵ�û�����Ϊ15ʱ���������֣���λ����
		//listCardTypeThree = cardTypeService.getCardTypeByThreeCardType((short) 13, (short) 14, (short) 15);// ��ѯtb_CardType���CardTypeΪ13,14����15�Ķ������ڲ�ѯ�������û�������ʾ
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//��ѯuserCardType������0��1��2���û�����
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		listCarSmallType = carSmallTypeService.findAllCarSmallType();
		if(userCardInfo!=null){
			listCarSmallTypeInCarType = carSmallTypeService.findSmallTypeByCarType(userCardInfo.getCarType());
		}
		
	}

	public void removePagerAndConditionSession() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("cardNo");
		session.removeAttribute("status");
		session.removeAttribute("userCardType");
		session.removeAttribute("vehPlate");
		session.removeAttribute("owner");
		session.removeAttribute("idcard");
		session.removeAttribute("feeRuleType");
		session.removeAttribute("mobileNumber");
		session.removeAttribute("carType");
		session.removeAttribute("parkingSpace");
		session.removeAttribute("ownerIdentity");
	}

	/*
	 * public void removePConditionSession(){ HttpServletRequest
	 * request=ServletActionContext.getRequest(); HttpSession
	 * session=request.getSession(); session.removeAttribute("cardNo");
	 * session.removeAttribute("status");
	 * session.removeAttribute("userCardType");
	 * session.removeAttribute("vehPlate"); session.removeAttribute("owner");
	 * session.removeAttribute("idcard");
	 * session.removeAttribute("feeRuleType");
	 * session.removeAttribute("mobileNumber"); }
	 */
	public void setConditionSession() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.setAttribute("cardNo", userCardInfo.getCardNo().trim());
		session.setAttribute("status", userCardInfo.getStatus());
		session.setAttribute("userCardType", userCardInfo.getUserCardType());
		session.setAttribute("vehPlate", userCardInfo.getVehPlate().trim());
		session.setAttribute("owner", userCardInfo.getOwner().trim());
		session.setAttribute("idcard", userCardInfo.getIdcard().trim());
		session.setAttribute("feeRuleType", userCardInfo.getFeeRuleType());
		session.setAttribute("mobileNumber", deleteBlankSpace(userCardInfo.getMobileNumber()));
		session.setAttribute("carType", userCardInfo.getCarType());
		session.setAttribute("parkingSpace",deleteBlankSpace(userCardInfo.getParkingSpace()));
		session.setAttribute("ownerIdentity", userCardInfo.getOwnerIdentity());
		
	}

	public void setPagerSession() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}
	public String  deleteBlankSpace(String values){//ֵ��Ϊnullʱɾ���ո�
		if(values!=null){
			return values.trim();
		}else{
			return null;
		}
	}

	// -----------------------------------------------------------����ΪС����ע��------------------------------------------------------------------------

	public String queryParkCardToManage() {// ����ע���׽���
		this.removePagerAndConditionSession();
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToManage()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		listUserCardInfo = userCardInfoService.findByPager(pager);
		this.getSomeObjec();
		userCardInfo = null;
		return "queryParkCardToManage";
	}

	public String queryParkCard() {// ��ѯ�û�����Ϣ
		
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRegister()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		this.removePagerAndConditionSession();		
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		this.setConditionSession();
		// ��Ҫparam_whtherPayType.getPvalue()��ֵ���нɷѿ����ͺ�û�нɷѿ����Ͳ�ѯ��һ��
		listUserCardInfo = userCardInfoService.findAllItemByHql(pager, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue().trim(), null, deleteBlankSpace(userCardInfo.getMobileNumber()),userCardInfo.getCarType(),deleteBlankSpace(userCardInfo.getParkingSpace()),userCardInfo.getOwnerIdentity());
		this.getSomeObjec();
		return "queryParkCardToManage";
	}

	public String register() {
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRegister()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		param_isDis = sysparamconfService.queryOrSave("isDis", "0", "���⿨�Ƿ�����Ϊҵ�����⿨�ͷ�ҵ�����⿨ 0������ 1����", "ParkCardAction��queryParkCardToManage()����isDis����ʱset������get��������ʱ���쳣", admin);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//��ѯuserCardType������0��1��2���û�����
		param_userCardInfoCardNoLength = sysparamconfService.queryOrSave("userCardInfoCardNoLength", "10", "У԰������ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9��", "ParkCardAction��register()����userCardInfoCardNoLength����ʱ���쳣", admin);
		try {
			int length = Integer.valueOf(param_userCardInfoCardNoLength.getPvalue().trim());
			if (length <= 0 || length > 10) {
				param_userCardInfoCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_userCardInfoCardNoLength.setPvalue("10");
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��register()����param_userCardInfoCardNoLength����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}
		listCardType=cardTypeService.getAllCardType();
		listCarType = carTypeService.getAllCarType();
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		return "register";
	}

	public String save() {// �����û�����Ϣ�͵�����Ϣ����û�д˿�����Ϣʱ����
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRegister()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		userCardInfoTemp = new UserCardInfo();
		userCardInfoTemp.setRecNO(userCardInfoService.getMaxRecNO());
		if (userCardInfo.getOwner() != null && !"".equals(userCardInfo.getOwner())) {
			userCardInfoTemp.setOwner(userCardInfo.getOwner().trim());
		} else {
			userCardInfoTemp.setOwner("");
		}
		userCardInfoTemp.setIdcard(userCardInfo.getIdcard().trim());
		userCardInfoTemp.setTelePhone(userCardInfo.getTelePhone().trim());
		userCardInfoTemp.setMobileNumber(userCardInfo.getMobileNumber().trim());
		userCardInfoTemp.setRoomNo(userCardInfo.getRoomNo().trim());
		userCardInfoTemp.setParkingSpace(userCardInfo.getParkingSpace().trim());
		userCardInfoTemp.setFeeCardType(userCardInfo.getFeeCardType());
		userCardInfoTemp.setCarType(userCardInfo.getCarType());
		if (userCardInfo.getLinkMan() != null && !"".equals(userCardInfo.getLinkMan())) {
			userCardInfoTemp.setLinkMan(userCardInfo.getLinkMan().trim());
		} else {
			userCardInfoTemp.setLinkMan("");
		}
		userCardInfoTemp.setDeposit(userCardInfo.getDeposit());
		if (userCardInfo.getAddress() != null && !"".equals(userCardInfo.getAddress())) {
			userCardInfoTemp.setAddress(userCardInfo.getAddress().trim());
		} else {
			userCardInfoTemp.setAddress("");
		}
		if(userCardInfo.getParkingSpaceNo()!=null && !"".equals(userCardInfo.getParkingSpaceNo())){
			userCardInfoTemp.setParkingSpaceNo(userCardInfo.getParkingSpaceNo().trim());
		}else{
			userCardInfoTemp.setParkingSpaceNo("");
		}
		userCardInfoTemp.setCardNo(userCardInfo.getCardNo().trim());
		userCardInfoTemp.setObu(userCardInfo.getObu().trim());
		userCardInfoTemp.setVehPlate(userCardInfo.getVehPlate().trim());
		userCardInfoTemp.setVehBrand(userCardInfo.getVehBrand().trim());
		userCardInfoTemp.setUserCardType(userCardInfo.getUserCardType());
		if (userCardInfoTemp.getUserCardType() != 13) {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			Date dateTemp = new Date();
			cal.setTime(dateTemp);
			cal.add(Calendar.DAY_OF_MONTH, -1);
			String time = df.format(cal.getTime());
			time = time + " 00:00:00";
			Timestamp ts = Timestamp.valueOf(time);
			userCardInfoTemp.setPayEndTime(ts);
		}
		if (userCardInfo.getUserCardType() !=13) {// 13����ѳ���״̬Ϊ0�������� 378��446
			userCardInfoTemp.setStatus((short) 9);// ������ѳ�ʱ״̬Ϊ9��δ�ɷѣ�
			
		} else {
			userCardInfoTemp.setStatus((short) 0);
		}
		if (!userCardInfo.getVehPlateImagePath().equals("")) {

			try {
				userCardInfoTemp.setVehPlateImage(Hibernate.createBlob(new FileInputStream(myFile)));// ����ͼƬ��·��ת��������������ݿ�
			} catch (Exception e) {
				admin = adminService.get(getCurrentOperator().getId());
				// �����쳣����ϵͳ��־��
				systemLogService.save(new Date(), 2, admin, "ParkCardAction��save()���ͼƬ��������ʱ�����쳣", e.getMessage(), "Exception");
				e.printStackTrace();
			} finally {
			}
		}

		if (!param_whtherPayType.getPvalue().equals("1")) {// whtherPayType��ֵΪ0ʱ�������нɷ�����ʱ
			userCardInfoTemp.setFeeRuleType(userCardInfo.getFeeRuleType());
		} else {
			userCardInfoTemp.setFeeRuleType((short) -1);
		}

		userCardInfoTemp.setRegisterTime(date);
		if (userCardInfo.getStaffNo() != null && !"".equals(userCardInfo.getStaffNo())) {
			userCardInfoTemp.setStaffNo(userCardInfo.getStaffNo().trim());
		} else {
			userCardInfoTemp.setStaffNo("");
		}
		userCardInfoTemp.setRemark(userCardInfo.getRemark().trim());
		userCardInfoTemp.setOwnerIdentity(userCardInfo.getOwnerIdentity());
		userCardInfoService.save(userCardInfoTemp);
		if (staff != null) {
			staffService.deleteByCardNo(userCardInfoTemp.getCardNo().trim());
			staffTemp = new Staff();
			staffTemp.setCardNo(userCardInfoTemp.getCardNo().trim());

			if (staff.getStaffName() != null && !"".equals(staff.getStaffName())) {
				staffTemp.setStaffName(staff.getStaffName().trim());
			} else {
				staffTemp.setStaffName("");
			}
			if (staff.getRelation() != null && !"".equals(staff.getRelation())) {
				staffTemp.setRelation(staff.getRelation().trim());
			} else {
				staffTemp.setRelation("");
			}
			if (staff.getStaffAddress() != null && !"".equals(staff.getStaffAddress())) {
				staffTemp.setStaffAddress(staff.getStaffAddress().trim());
			} else {
				staffTemp.setStaffAddress("");
			}
			staffService.save(staffTemp);
		}
		// �޸Ŀ���Ϣ���е��û�����
		cardInfo = cardInfoService.getCardInfoByCardNo(userCardInfo.getCardNo());
		if (cardInfo != null) {// ������Ϣ�����д˿�����Ϣʱ�����û�����
			cardInfo.setUserCardType(userCardInfo.getUserCardType());
			cardInfoService.update(cardInfo);
		}
		// deleteImage();
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û�С����ע������ɹ����û����ƺ�Ϊ[" + userCardInfo.getVehPlate() + "]", "��Ʊ����--С��������--С������Ϣ����--ע��", "tb_UserCardInfo");
		//if(userCardInfoTemp.getUserCardType()==14){
		if (userCardInfoTemp.getUserCardType() !=13) {// 13����ѳ���״̬Ϊ0�������� 378��446
			result = Result.SUCCESS1;	
			userCardInfo = new UserCardInfo();
			userCardInfo = userCardInfoService.getUserCardInfoByCardNo(userCardInfoTemp.getCardNo());
			return  payment();
			
		}else {
			result = Result.SUCCESS;
			cardNo = userCardInfoTemp.getCardNo();
			return queryParkCardToManage();
		}
	}

	public String setImage() {// �첽����ͼƬ
		String savePath = null;
		InputStream in = null;
		String path = null;
		BufferedOutputStream out = null;
		Random r = new Random();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowdate = sdf.format(new Date());
		if (!userCardInfo.getVehPlateImagePath().equals("")) {
			try {
				userCardInfoTemp = new UserCardInfo();
				userCardInfoTemp.setVehPlateImage(Hibernate.createBlob(new FileInputStream(userCardInfo.getVehPlateImagePath())));// ����ͼƬ��·��ת���������������
				if (userCardInfoTemp.getVehPlateImage() != null) {
					String classPath = ParkCardAction.class.getClassLoader().getResource("").getPath();
					String temp = classPath.substring(0, classPath.length() - 1);
					savePath = temp.substring(0, temp.lastIndexOf("/"));
					savePath = savePath.substring(0, savePath.lastIndexOf("/") + 1);
					savePath = savePath + "image/";
					path = nowdate + "_" + r.nextInt(10000) + ".jpg";
					String realPath = savePath + path;
					in = userCardInfoTemp.getVehPlateImage().getBinaryStream();
					out = new BufferedOutputStream(new FileOutputStream(realPath));
					int countTemp = in.read();
					while (countTemp != -1) {
						out.write(countTemp);
						countTemp = in.read();
					}
					out.flush();
					out.close();
					out = null;
					in.close();
					in = null;
				}
			} catch (Exception e) {
				admin = adminService.get(getCurrentOperator().getId());
				// �����쳣����ϵͳ��־��
				systemLogService.save(new Date(), 2, admin, "ParkCardAction��setImage()����첽ͼƬ��������ʱ�����쳣", e.getMessage(), "Exception");
				e.printStackTrace();
			}
			if (pathTemp != null) {
				File f = new File(savePath + pathTemp);
				if (f.exists()) {
					f.delete();
				}
			}
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text;charset=gbk");
			PrintWriter outTemp = null;
			try {
				outTemp = response.getWriter();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				admin = adminService.get(getCurrentOperator().getId());
				systemLogService.save(new Date(), 2, admin, "ParkCardAction��getUserCardInfoByVehPlate������֤�����Ƿ������ʱ�������쳣", e.getMessage(), "IOException");
				e.printStackTrace();
			}

			outTemp.println(path);

		}
		return null;
	}

	public String deleteImage() {// ɾ��ͼƬ
		if (pathTemp != null) {
			String classPath = ParkCardAction.class.getClassLoader().getResource("").getPath();
			String temp = classPath.substring(0, classPath.length() - 1);
			String savePath = temp.substring(0, temp.lastIndexOf("/"));
			savePath = savePath.substring(0, savePath.lastIndexOf("/") + 1);
			savePath = savePath + "image/";
			File f = new File(savePath + pathTemp);
			if (f.exists()) {
				f.delete();
			}
		}
		return null;
	}

	// -----------------------------------------------------------����ΪС����ע�ᣬ����ΪС������Ϣ�޸�--------------------------------------------------
	public String userCardInfoList() {// ��ʾ�û�����Ϣ���޸�
		this.setPagerSession();
		String savePath = null;
		InputStream in = null;
		String path = null;
		BufferedOutputStream out = null;
		Random r = new Random();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowdate = sdf.format(new Date());
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRegister()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		param_isDis = sysparamconfService.queryOrSave("isDis", "0", "���⿨�Ƿ�����Ϊҵ�����⿨�ͷ�ҵ�����⿨ 0������ 1����", "ParkCardAction��queryParkCardToManage()����isDis����ʱset������get��������ʱ���쳣", admin);
		param_userCardInfoCardNoLength = sysparamconfService.queryOrSave("userCardInfoCardNoLength", "10", "У԰������ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9��", "ParkCardAction��register()����userCardInfoCardNoLength����ʱ���쳣", admin);
		listCardType=cardTypeService.getAllCardType();
		listCarType = carTypeService.getAllCarType();
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		try {
			int length = Integer.valueOf(param_userCardInfoCardNoLength.getPvalue().trim());
			if (length <= 0 || length > 10) {
				param_userCardInfoCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_userCardInfoCardNoLength.setPvalue("10");
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��register()����param_userCardInfoCardNoLength����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}
		userCardInfo = userCardInfoService.getUserCardInfoByRecNO(userCardInfo.getRecNO());
		staff = staffService.get(userCardInfo.getCardNo());
		listCarSmallType = carSmallTypeService.findSmallTypeByCarType(userCardInfo.getCarType());
		if (userCardInfo.getVehPlateImage() != null) {// �������ݿ��е�����ͼ�����C:/VehPlateImage.jpg
			try {
				String classPath = ParkCardAction.class.getClassLoader().getResource("").getPath();
				String temp = classPath.substring(0, classPath.length() - 1);
				savePath = temp.substring(0, temp.lastIndexOf("/"));
				savePath = savePath.substring(0, savePath.lastIndexOf("/") + 1);
				savePath = savePath + "image/";
				path = nowdate + "_" + r.nextInt(10000) + ".jpg";
				String realPath = savePath + path;
				userCardInfo.setVehPlateImagePath(path);
				in = userCardInfo.getVehPlateImage().getBinaryStream();
				out = new BufferedOutputStream(new FileOutputStream(realPath));
				int countTemp = in.read();
				while (countTemp != -1) {
					out.write(countTemp);
					countTemp = in.read();
				}
				out.flush();
				out.close();
				out = null;
				in.close();
				in = null;

			} catch (Exception e) {
				admin = adminService.get(getCurrentOperator().getId());
				// �����쳣����ϵͳ��־��
				systemLogService.save(new Date(), 2, admin, "ParkCardAction��setImage()����첽ͼƬ��������ʱ�����쳣", e.getMessage(), "Exception");
				e.printStackTrace();
			}

		}
		//if (!"1".equals(param_whtherPayType.getPvalue().trim())) {
			//listFeeRuleTypeDef = feeRuleTypeDefService.LoadFeeRuleTypeDef(userCardInfo.getFeeRuleType().intValue());
		//} else {
			listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
	//	}
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		// listCardTypeThree =
		// cardTypeService.getCardTypeByThreeCardType((short) 13, (short) 14,
		// (short) 15);
			listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//��ѯuserCardType������0��1��2���û�����
		return "update";
	}

	public String update() {// �����û�����Ϣ
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRegister()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		cardInfo = cardInfoService.getCardInfoByCardNo(userCardInfo.getCardNo());
		if (cardInfo != null) {// ������Ϣ�����д˿�����Ϣʱ�����û�����
			cardInfo.setUserCardType(userCardInfo.getUserCardType());
			cardInfoService.update(cardInfo);
		}
		userCardInfoTemp = userCardInfoService.getUserCardInfoByRecNO(userCardInfo.getRecNO());// �����û���Ż�����û�����Ϣ����
		if (userCardInfo.getOwner() != null && !"".equals(userCardInfo.getOwner())) {
			userCardInfoTemp.setOwner(userCardInfo.getOwner().trim());
		} else {
			userCardInfoTemp.setOwner("");
		}
		userCardInfoTemp.setIdcard(userCardInfo.getIdcard().trim());
		userCardInfoTemp.setTelePhone(userCardInfo.getTelePhone().trim());
		userCardInfoTemp.setMobileNumber(userCardInfo.getMobileNumber().trim());
		userCardInfoTemp.setRoomNo(userCardInfo.getRoomNo().trim());
		userCardInfoTemp.setParkingSpace(userCardInfo.getParkingSpace().trim());
		userCardInfoTemp.setFeeCardType(userCardInfo.getFeeCardType());
		if (userCardInfo.getLinkMan() != null && !"".equals(userCardInfo.getLinkMan())) {
			userCardInfoTemp.setLinkMan(userCardInfo.getLinkMan().trim());
		} else {
			userCardInfoTemp.setLinkMan("");
		}
		userCardInfoTemp.setDeposit(userCardInfo.getDeposit());
		if (userCardInfo.getAddress() != null && !"".equals(userCardInfo.getAddress())) {
			userCardInfoTemp.setAddress(userCardInfo.getAddress().trim());
		} else {
			userCardInfoTemp.setAddress("");
		}
		if(userCardInfo.getParkingSpaceNo()!=null && !"".equals(userCardInfo.getParkingSpaceNo())){
			userCardInfoTemp.setParkingSpaceNo(userCardInfo.getParkingSpaceNo().trim());
		}else{
			userCardInfoTemp.setParkingSpaceNo("");
		}
		userCardInfoTemp.setCardNo(userCardInfo.getCardNo().trim());
		userCardInfoTemp.setObu(userCardInfo.getObu().trim());
		userCardInfoTemp.setVehPlate(userCardInfo.getVehPlate().trim());
		userCardInfoTemp.setVehBrand(userCardInfo.getVehBrand().trim());
		userCardInfoTemp.setUserCardType(userCardInfo.getUserCardType());
		userCardInfoTemp.setCarType(userCardInfo.getCarType());
		if(userCardInfoTemp.getUserCardType()==13){
			userCardInfoTemp.setStatus((short)0);
			userCardInfoTemp.setPayEndTime(null);
		}
		if(userCardInfoTemp.getUserCardType()==14 &&userCardInfoTemp.getPayEndTime()==null ){			
			userCardBill = new UserCardBill();
			userCardBillTemp = userCardBillService.getUserCardBillMaxEndTimeByRecNO(userCardInfo.getRecNO());// ���ҳ���ǰ�û�����û��ɷ������endTime�Ķ���
			if(userCardBillTemp==null){
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				Date dateTemp = new Date();
				cal.setTime(dateTemp);
				cal.add(Calendar.DAY_OF_MONTH, -1);
				String time = df.format(cal.getTime());
				time = time + " 00:00:00";
				Timestamp ts = Timestamp.valueOf(time);
				userCardInfoTemp.setPayEndTime(ts);
			} else{
				userCardInfoTemp.setPayEndTime(userCardBillTemp.getEndTime());
			}			
		}
		if (userCardInfo.getStaffNo() != null && !"".equals(userCardInfo.getStaffNo())) {
			userCardInfoTemp.setStaffNo(userCardInfo.getStaffNo().trim());
		}
		if (!param_whtherPayType.getPvalue().equals("1")) {// whtherPayType��ֵΪ0ʱ�������нɷ�����ʱ
			userCardInfoTemp.setFeeRuleType(userCardInfo.getFeeRuleType());
		}
		userCardInfoTemp.setRemark(userCardInfo.getRemark().trim());
		if ("1".equals(isUseImage)) {
			if (!userCardInfo.getVehPlateImagePath().equals("")) {
				if (null != myFile) {
					try {
						userCardInfoTemp.setVehPlateImage(Hibernate.createBlob(new FileInputStream(myFile)));
					} catch (Exception e) {
						admin = adminService.get(getCurrentOperator().getId());
						// �����쳣����ϵͳ��־��
						systemLogService.save(new Date(), 2, admin, "ParkCardAction��update()���ͼƬ��������ʱ�����쳣", e.getMessage(), "Exception");
						e.printStackTrace();
					} finally {
					}
				}
			} else if (null != srcPath && !"".equals(srcPath)) {
				try {
					File file = new File(srcPath);
					if (file.exists()) {
						userCardInfoTemp.setVehPlateImage(Hibernate.createBlob(new FileInputStream(file)));
					}
				} catch (Exception e) {
					// �����쳣����ϵͳ��־��
					systemLogService.save(new Date(), 2, admin, "ParkCardAction��update()���ͼƬ��������ʱ�����쳣", e.getMessage(), "Exception");
					e.printStackTrace();
				}
			}
		} else {
			userCardInfoTemp.setVehPlateImage(null);
		}
		userCardInfoTemp.setOwnerIdentity(userCardInfo.getOwnerIdentity());
		userCardInfoService.update(userCardInfoTemp);
		if (staff != null) {
			staffService.deleteByCardNo(userCardInfoTemp.getCardNo().trim());
			staffTemp = new Staff();
			staffTemp.setCardNo(userCardInfo.getCardNo().trim());

			if (staff.getStaffName() != null && !"".equals(staff.getStaffName())) {
				staffTemp.setStaffName(staff.getStaffName().trim());
			} else {
				staffTemp.setStaffName("");
			}
			if (staff.getRelation() != null && !"".equals(staff.getRelation())) {
				staffTemp.setRelation(staff.getRelation().trim());
			} else {
				staffTemp.setRelation("");
			}
			if (staff.getStaffAddress() != null && !"".equals(staff.getStaffAddress())) {
				staffTemp.setStaffAddress(staff.getStaffAddress().trim());
			} else {
				staffTemp.setStaffAddress("");
			}
			staffService.save(staffTemp);
		}

		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS1;
		cardNo = userCardInfoTemp.getCardNo();
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û��޸��û����[" + userCardInfo.getRecNO() + "]С������Ϣ�ɹ�", "��Ʊ����--С��������--С������Ϣ����--�޸�", "tb_UserCardInfo");

		if (session.getAttribute("cardNo") != null) {
			userCardInfo.setCardNo(session.getAttribute("cardNo").toString());
		} else {
			userCardInfo.setCardNo("");
		}
		if (session.getAttribute("vehPlate") != null) {
			userCardInfo.setVehPlate(session.getAttribute("vehPlate").toString());
		} else {
			userCardInfo.setVehPlate("");
		}
		if (session.getAttribute("idcard") != null) {
			userCardInfo.setIdcard(session.getAttribute("idcard").toString());
		} else {
			userCardInfo.setIdcard("");
		}
		if (session.getAttribute("owner") != null) {
			userCardInfo.setOwner(session.getAttribute("owner").toString());
		} else {
			userCardInfo.setOwner("");
		}
		if (session.getAttribute("mobileNumber") != null) {
			userCardInfo.setMobileNumber(session.getAttribute("mobileNumber").toString());
		} else {
			userCardInfo.setMobileNumber("");
		}
		if (session.getAttribute("parkingSpace") != null) {
			userCardInfo.setParkingSpace(session.getAttribute("parkingSpace").toString());
		} else {
			userCardInfo.setParkingSpace("");
		}
		if (session.getAttribute("ownerIdentity") != null) {
			userCardInfo.setOwnerIdentity((Integer) session.getAttribute("ownerIdentity"));
		} else {
			userCardInfo.setOwnerIdentity(null);
		}
		userCardInfo.setStatus((Short) session.getAttribute("status"));
		userCardInfo.setUserCardType((Short) session.getAttribute("userCardType"));
		userCardInfo.setFeeRuleType((Short) session.getAttribute("feeRuleType"));
		userCardInfo.setCarType((Integer) session.getAttribute("carType"));
		userCardInfo.setOwnerIdentity((Integer) session.getAttribute("ownerIdentity"));
		this.getSomeObjec();
		listUserCardInfo = userCardInfoService.findAllItemByHql(pager, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue().trim(), null, userCardInfo.getMobileNumber().trim(),userCardInfo.getCarType(),userCardInfo.getParkingSpace().trim(), userCardInfo.getOwnerIdentity());
		return "queryParkCardToManage";
	}

	// -----------------------------------------------------------����ΪС������Ϣ�޸ģ�����ΪС������ʧ--------------------------------------------------
	public String queryToLossAndRemoveLoss() {// ��ѯ�����Խ��й�ʧ���߽��
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		listUserCardInfo = userCardInfoService.findByPager(pager);
		this.getSomeObjec();
		userCardInfo = null;
		return "queryToLossAndRLoss";
	}

	public String queryToLossAndRLoss() {// ��ѯ�û�����Ϣ�Թ�ʧ��ý��
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		// ��Ҫparam_whtherPayType.getPvalue()��ֵ���нɷѿ����ͺ�û�нɷѿ����Ͳ�ѯ��һ��
		listUserCardInfo = userCardInfoService.findAllItemByHql(pager, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue(), null, deleteBlankSpace(userCardInfo.getMobileNumber()),userCardInfo.getCarType(),deleteBlankSpace(userCardInfo.getParkingSpace()),userCardInfo.getOwnerIdentity());
		this.getSomeObjec();
		return "queryToLossAndRLoss";
	}

	public String parkCardLoss() {// ��ʧ�������޸�״̬�ͱ�����Ϣ��CardOperation (��ҵ�������ˮ)
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(userCardInfo.getCardNo().trim());
		userCardInfo.setStatus((short) 1);
		userCardInfoService.update(userCardInfo);
		cardInfo = cardInfoService.get(userCardInfo.getCardNo().trim());
		if (cardInfo != null) {
			cardInfo.setStatus((short) 1);
			cardInfo.setOpTime(date);
			cardInfoService.update(cardInfo);
		}
		account = accountService.getAccount(userCardInfo.getCardNo().trim());
		if (account != null) {
			account.setStatus(1);
			account.setStatusUpdateTime(new Date());
			accountService.update(account);
			// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��loss()����card_type����ʱset������get��������ʱ���쳣", admin);
			this.InsertStoreCardBlackList(param_card_type);
		}
		cardOperation = new CardOperation();
		cardOperation.setCardNO(userCardInfo.getCardNo().trim());
		cardOperation.setCardType(1);
		cardOperation.setCardOperate(1);
		cardOperation.setOpTime(date);
		cardOperation.setOperator(getCurrentOperator().getId());
		cardOperation.setUserCardType(userCardInfo.getUserCardType());
		cardOperationService.save(cardOperation);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û���ʧ����[" + userCardInfo.getCardNo().trim() + "]�ɹ�", "��Ʊ����--С��������--С������ʧ/���--��ʧ", "tb_UserCardInfo;tb_CardInfo");
		return queryToLossAndRemoveLoss();
	}

	public void InsertStoreCardBlackList(Sysparamconf param_card_type) {
		if ("1".equals(param_card_type.getPvalue())) {// �˻�������Ϊд��ʱ��ʧҪ�鴢ֵ��������(tb_StoreCardBlackList)�������˻���Ϣ��ɾ������ӣ�û�������
			StoreCardBlackList storeCardBlackList = storeCardBlackListService.getStoreCardBlackListByCardNo(account.getCardNo());
			if (storeCardBlackList == null) {
				StoreCardBlackList storeCardBlackListTemp = new StoreCardBlackList();
				storeCardBlackListTemp.setScCode(account.getCardNo());
				storeCardBlackListTemp.setGenCau("1");
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String nowdate = sdf.format(new Date());
					storeCardBlackListTemp.setGenTime(java.sql.Date.valueOf(nowdate));
				} catch (Exception e) {
					admin = adminService.get(getCurrentOperator().getId());
					systemLogService.save(new Date(), 2, admin, "AccountAction��loss()��ʱ��1����ʱ�������쳣", e.getMessage(), "Exception");
				}
				storeCardBlackListService.save(storeCardBlackListTemp);
			} else {
				storeCardBlackListService.delete(storeCardBlackList);
				StoreCardBlackList storeCardBlackListTemp = new StoreCardBlackList();
				storeCardBlackListTemp.setScCode(account.getCardNo());
				storeCardBlackListTemp.setGenCau("1");
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String nowdate = sdf.format(new Date());
					storeCardBlackListTemp.setGenTime(java.sql.Date.valueOf(nowdate));
				} catch (Exception e) {
					admin = adminService.get(getCurrentOperator().getId());
					systemLogService.save(new Date(), 2, admin, "AccountAction��loss()��ʱ��2����ʱ�������쳣", e.getMessage(), "Exception");
				}

				storeCardBlackListService.save(storeCardBlackListTemp);
			}
		}
	}

	// -----------------------------------------------------------����ΪС������ʧ������ΪС�������--------------------------------------------------------
	public String parkCardRemoveLoss() {// ��Ҳ������޸�״̬�ͱ�����Ϣ��CardOperation
		// (��ҵ�������ˮ)
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(userCardInfo.getCardNo().trim());
		userCardInfo.setStatus((short) 0);
		userCardInfoService.update(userCardInfo);
		cardInfo = cardInfoService.get(userCardInfo.getCardNo().trim());
		if (cardInfo != null) {
			cardInfo.setStatus((short) 0);
			cardInfo.setOpTime(date);
			cardInfoService.update(cardInfo);
		}
		account = accountService.getAccount(userCardInfo.getCardNo().trim());
		if (account != null) {
			account.setStatus(0);
			account.setStatusUpdateTime(new Date());
			accountService.update(account);
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��loss()����card_type����ʱset������get��������ʱ���쳣", admin);
			if ("1".equals(param_card_type.getPvalue())) {// ������Ϊд��ʱ���Ҫ�鴢ֵ��������(tb_StoreCardBlackList)�������˻���Ϣ��ɾ��
				StoreCardBlackList storeCardBlackList = storeCardBlackListService.getStoreCardBlackListByCardNo(account.getCardNo());
				if (storeCardBlackList == null) {

				} else {
					storeCardBlackListService.delete(storeCardBlackList);
				}
			}
		}
		cardOperation = new CardOperation();
		cardOperation.setCardNO(userCardInfo.getCardNo().trim());
		cardOperation.setCardType(1);
		cardOperation.setCardOperate(2);
		cardOperation.setOpTime(date);
		cardOperation.setOperator(getCurrentOperator().getId());
		cardOperation.setUserCardType(userCardInfo.getUserCardType());
		cardOperationService.save(cardOperation);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS1;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û���ҿ���[" + userCardInfo.getCardNo().trim() + "]�ɹ�", "��Ʊ����--С��������--С������ʧ/���--���", "tb_UserCardInfo;tb_CardInfo");
		return queryToLossAndRemoveLoss();
	}

	// -----------------------------------------------------------����ΪС������ң�����ΪС����ע��--------------------------------------------------------
	public String parkCardCancel() {
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(userCardInfo.getCardNo().trim());
		if (userCardInfo != null) {
			cardGroupService.deleteByCardNo(userCardInfo.getCardNo());// ��������ڳ�λ��������д��ڣ�ɾ������Ϣ��
			securityUserInfoService.deleteByCardNo(userCardInfo.getCardNo());
			securityCommandService.deleteByCardNo(userCardInfo.getCardNo());
			userCardInfoService.delete(userCardInfo);
			if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
				cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
			} else {// û�нɷ�����
				cardInfoSendParaService.SendCardInfoPara();// �·��������
			}
			systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û�ע���û����[" + userCardInfo.getRecNO() + "]С������Ϣ�ɹ�", "��Ʊ����--С��������--С������Ϣ����--ע��", "tb_UserCardInfo");
		}
		result = Result.SUCCESS2;
		return queryParkCardToManage();
	}

	// -----------------------------------------------------------����ΪС����ע��������ΪС�����ɷ�--------------------------------------------------------
	public String queryToPayment() {
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRemoveLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		// listUserCardInfo = userCardInfoService.findByPager(pager);
		userCardInfo = new UserCardInfo();
		userCardInfo.setUserCardType((short) 14);
		listUserCardInfo = userCardInfoService.findAllItemByHqlToPayment(pager, "", null, userCardInfo.getUserCardType(), "", "", "", null, param_whtherPayType.getPvalue().trim(),null,null, null, null, null, null);
		this.getSomeObjec();
		// userCardInfo = null;
		return "queryPCToPayment";
	}

	public String queryParkCardToPayment() {
		Timestamp payEndTimestamp = null;
		Timestamp payEndTimeStartstamp = null;
		admin = adminService.get(getCurrentOperator().getId());
		if (!"".equals(payEndTime) && null != payEndTime) {
			String payEndTimeTemp = payEndTime + " 00:00:00";
			payEndTimestamp = Timestamp.valueOf(payEndTimeTemp);
		}
		if (!"".equals(payEndTimeStart) && null != payEndTimeStart) {
			String payEndTimeStartTemp = payEndTimeStart + " 00:00:00";
			payEndTimeStartstamp = Timestamp.valueOf(payEndTimeStartTemp);
		}
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToRemoveLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		listUserCardInfo = userCardInfoService.findAllItemByHqlToPayment(pager, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue().trim(),payEndTimeStartstamp, payEndTimestamp, null, userCardInfo.getCarType(), userCardInfo.getParkingSpace(), userCardInfo.getOwnerIdentity());
		this.getSomeObjec();
		return "queryPCToPayment";
	}

	@SuppressWarnings("unchecked")
	public String payment() {
		userCardInfo = userCardInfoService.getUserCardInfoByRecNO(userCardInfo.getRecNO());
		list = userCardBillService.getUserCardBillByRecNO(pager, userCardInfo.getRecNO());
		listuserCardRateTemp = userCardRateService.getAllUserCardRate();
		userCardRate = new UserCardRate();
		listuserCardRate = new ArrayList();
		if (listuserCardRateTemp != null) {
			for (int i = 0; i < listuserCardRateTemp.size(); i++) {
				userCardRate = (UserCardRate) listuserCardRateTemp.get(i);
				if (userCardRate.getUserCardType().equals(userCardInfo.getUserCardType())) {
					userCardRate.setVersionAndRecNo(userCardRate.getVersion() + "," + userCardRate.getRecNo());
					listuserCardRate.add(userCardRate);
				}
			}
		}
		listAdmin = userCardBillService.getAllAdmin();
		userCardBill = new UserCardBill();
		//userCardRate = new UserCardRate();
		userCardBillTemp = userCardBillService.getUserCardBillMaxEndTimeByRecNO(userCardInfo.getRecNO());// ���ҳ���ǰ�û�����û��ɷ������endTime�Ķ���
		// ��ʼ��ֵ
		if (userCardBillTemp == null) {
			userCardBill.setStartTime(Timestamp.valueOf(getDateFristDay(new Date())));// ���õ�ǰϵͳ�����·ݵĵ�һ��
			//userCardBill.setEndTime(Timestamp.valueOf(getDateAddMonthEndDay(userCardBill.getStartTime().toString(), 0)));// ��ʼʱ�����0���º���·����һ��
			userCardBill.setEndTime(Timestamp.valueOf(getAddMountMonthFirstDay(userCardBill.getStartTime().toString(), 1)));// ��ʼʱ�����1���º���·ݵĵ�һ��
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			// String timePattern=sdf.format(new Date());
			Date dateTemp;
			Date date;
			Date systemDate = new Date();
			try {
				dateTemp = sdf.parse(sdf.format(systemDate));
				date = sdf.parse(sdf.format(userCardBillTemp.getEndTime()));
				if (dateTemp.compareTo(date) > 0) {// ���ϵͳ��ʱ��������ݿ��з�����ֹʱ����ô����ϵͳʱ����Ϊ��������ʱ�䡣
					userCardBill.setStartTime(Timestamp.valueOf(getDateFristDay(systemDate)));// ���õ�ǰϵͳ�����·ݵĵ�һ��
					userCardBill.setEndTime(Timestamp.valueOf(getAddMountMonthFirstDay(userCardBill.getStartTime().toString(), 1)));// ��ʼʱ�����1���º���·ݵĵ�һ��
				} else {
					userCardBill.setStartTime(userCardBillTemp.getEndTime());// ���endTimeΪ����ʱ��
					userCardBill.setEndTime(Timestamp.valueOf(getAddMountMonthFirstDay(userCardBill.getStartTime().toString(), 1)));// ��ʼʱ�����1����������·ݵ�һ��
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		if (!listuserCardRate.isEmpty()) {
			userCardRateTemp = (UserCardRate) listuserCardRate.get(0);
			// userCardRate.setMoney(userCardRateTemp.getMoney());
			// userCardRate =(UserCardRate)listuserCardRateTemp.get(0);
			versionAndRecNo = userCardRateTemp.getVersion() + "," + userCardRateTemp.getRecNo();
			userCardBill.setMoney(userCardRateTemp.getMoney());
		} else {
			result = Result.FAIL;
			userCardInfo = null;
			return queryToPayment();			
		}
		userCardBill.setAmount((short) 1);// ��ʼ���ɷ��·�Ϊ1
		return "payment";
	}
	
	public boolean checkPaymentEdit(String startTime, String endTime, Short mount){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date end = null;
		Date endT = null;
		try {
			end = sdf.parse(endTime);
			String endTimeTemp = this.getAddMountMonthFirstDay(startTime, mount);
			endT = sdf.parse(endTimeTemp);
		} catch (Exception e) {
			e.printStackTrace();
			this.result = Result.FAIL2;
			return false;
		}
		if(end.equals(endT)){
			return true;
		}else{
			this.result = Result.FAIL;
			return false;
		}
	}

	public String paymentEdit() {
		boolean flag = this.checkPaymentEdit(startTimeTemp, endTimeTemp, userCardBill.getAmount());
		if(!flag){
			return payment();
		}
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		userCardInfoTemp = userCardInfoService.getUserCardInfoByRecNO(userCardInfo.getRecNO());
		userCardInfoTemp.setStatus((short) 0);
		userCardInfoTemp.setPayEndTime(Timestamp.valueOf(endTimeTemp+" 00:00:00"));
		userCardInfoService.update(userCardInfoTemp);
		userCardBillTemp = new UserCardBill();
		userCardBillTemp.setUserRecNo(userCardInfo.getRecNO());
		userCardBillTemp.setOpTime(date);
		userCardBillTemp.setMoney(userCardBill.getMoney());
		userCardBillTemp.setStartTime(Timestamp.valueOf(startTimeTemp+" 00:00:00"));
		userCardBillTemp.setEndTime(Timestamp.valueOf(endTimeTemp+" 00:00:00"));
		userCardBillTemp.setOperator(getCurrentOperator().getId());
		String[] vAndRNo = versionAndRecNo.split(",");
		userCardRate = userCardRateService.getUserCardRateByVersionAndRecNo(Short.valueOf(vAndRNo[0]), Short.valueOf(vAndRNo[1]));
		// userCardRate =
		// userCardRateService.getUserCardRateByMoney(userCardRate.getMoney());
		userCardBillTemp.setVersion(userCardRate.getVersion());
		userCardBillTemp.setRateRecNo(userCardRate.getRecNo());
		userCardBillTemp.setAmount(userCardBill.getAmount());
		userCardBillService.save(userCardBillTemp);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS;
		cardNo = userCardInfoTemp.getCardNo();
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û��շѱ��[" + userCardInfo.getRecNO() + "]�û�[" + userCardBill.getMoney() + "]Ԫ�ɹ�", "��Ʊ����--С��������--С�����ɷ�", "tb_UserCardBill");
		return payment();
	}

	public String deleteByNoAndOptime() {// ɾ��һ���ɷѼ�¼
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date dateTemp = new Date();
		String time = df.format(dateTemp);
		time = time + " 00:00:00";
		Timestamp stamp = Timestamp.valueOf(time);
		admin = adminService.get(getCurrentOperator().getId());
		userCardBillTemp = userCardBillService.getUserCardBillByRecNOAndOptime(userCardBill.getUserRecNo(), Timestamp.valueOf(opTime));
		if(userCardBillTemp!=null){
			userCardBillService.delete(userCardBillTemp);
			UserCardInfo userCardInfoTemp = userCardInfoService.getUserCardInfoByRecNO(userCardBill.getUserRecNo());
			if (userCardInfoTemp != null) {
				Timestamp ts = userCardBillService.getMaxPayEndTimeByRecNO(userCardBill.getUserRecNo());
				userCardInfoTemp.setPayEndTime(ts);// û�д��˻��ĽɷѼ�¼ʱ���ýɷ�����Ϊ��ǰϵͳ��ǰһ��,�м�¼ʱ���ڼ�¼�����ʱ��
				if (ts.getTime() < stamp.getTime()) {// ��¼�����ʱ��С����ǰʱ��ʱҪ�����˻�״̬ΪΪ�ɷ�
					userCardInfoTemp.setStatus((short) 9);
				}
				userCardInfoService.update(userCardInfoTemp);
			}			
			systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û�ɾ���û����Ϊ[" + userCardBill.getUserRecNo() + "]��һ���ɷ���Ϣ", "��Ʊ����--С��������--С�����ɷ�--ɾ��", "tb_UserCardBill");
		}		
		userCardInfo = new UserCardInfo();
		userCardInfo.setRecNO(userCardBill.getUserRecNo());
		return payment();
	}

	public String deleteAllByuserRecNo() {// ɾ�����û���ŵ����нɷѼ�¼
		admin = adminService.get(getCurrentOperator().getId());
		userCardBillService.deleteByUserRecNo(userCardBill.getUserRecNo());
		UserCardInfo userCardInfoTemp = userCardInfoService.getUserCardInfoByRecNO(userCardBill.getUserRecNo());
		if (userCardInfoTemp != null) {
			userCardInfoTemp.setPayEndTime(userCardBillService.getMaxPayEndTimeByRecNO(userCardBill.getUserRecNo()));// û�д��˻��ĽɷѼ�¼ʱ���ýɷ�����Ϊ��ǰϵͳ��ǰһ��,�м�¼ʱ���ڼ�¼�����ʱ��
			userCardInfoTemp.setStatus((short) 9);
			userCardInfoService.update(userCardInfoTemp);
		}
		userCardInfo = new UserCardInfo();
		userCardInfo.setRecNO(userCardBill.getUserRecNo());
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û�ɾ���û����Ϊ[" + userCardBill.getUserRecNo() + "]�����нɷ���Ϣ", "��Ʊ����--С��������--С�����ɷ�--ɾ�����û�ȫ���ɷѼ�¼", "tb_UserCardBill");
		return payment();
	}

	public String getMoneyAndEndTime() {// �첽���ý��ͽ���ʱ��
		String[] vAndRNo = versionAndRecNo.split(",");
		userCardRateTemp = userCardRateService.getUserCardRateByVersionAndRecNo(Short.valueOf(vAndRNo[0]), Short.valueOf(vAndRNo[1]));
		int money = userCardRateTemp.getMoney() * amount;
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��getCarByVehPlate������֤�����Ƿ������ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		//out.println(money + "," + changeDateFormat(Timestamp.valueOf(getDateAddMonthEndDay(startTime, (amount - 1)))) + "," + Timestamp.valueOf(getDateAddMonthEndDay(startTime, (amount - 1))));
		out.println(money + "," + changeDateFormat(Timestamp.valueOf(getAddMountMonthFirstDay(startTime, amount))) + "," + Timestamp.valueOf(getAddMountMonthFirstDay(startTime, amount)));
		return null;
	}

	public String queryUserCardBillToCheck() {
		list = userCardBillService.getAllUserCardBill(pager);
		sumMoney = userCardBillService.getSumMoney();
		return "queryUserCardBillToCheck";
	}

	public String queryUserCardBill() {
		if ("".equals(userCardInfo.getCardNo()) && "".equals(userCardInfo.getVehPlate()) && "".equals(userCardInfo.getOwner())) {
			return queryUserCardBillToCheck();
		} else {
			list = userCardBillService.getAllUserCardBillByHql(pager, userCardInfo.getCardNo(), userCardInfo.getVehPlate(), userCardInfo.getOwner());
			sumMoney = userCardBillService.getSumMoneyByHql(userCardInfo.getCardNo(), userCardInfo.getVehPlate(), userCardInfo.getOwner());
			return "queryUserCardBillToCheck";
		}

	}
	@SuppressWarnings("unchecked")
	public String extendPayEndTimeAffirm(){
		Timestamp payEndTimestamp = null;
		Timestamp payEndTimeStartstamp = null;
		UserCardInfo UserCardInfoTemp = null;
		admin = adminService.get(getCurrentOperator().getId());
		if (!"".equals(payEndTime) && null != payEndTime) {
			String payEndTimeTemp = payEndTime + " 00:00:00";
			payEndTimestamp = Timestamp.valueOf(payEndTimeTemp);
		}
		if (!"".equals(payEndTimeStart) && null != payEndTimeStart) {
			String payEndTimeStartTemp = payEndTimeStart + " 00:00:00";
			payEndTimeStartstamp = Timestamp.valueOf(payEndTimeStartTemp);
		}
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToRemoveLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);				
		long count = userCardInfoService.countFindAllItemByHqlToPayment(userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue().trim(),payEndTimeStartstamp, payEndTimestamp, null,userCardInfo.getCarType(), userCardInfo.getParkingSpace(), userCardInfo.getOwnerIdentity());
		if(count>1500){
			message = "max1500";
		}else{
			List listUserCardInfoTemp = userCardInfoService.findAllItemByHqlToPayment(null, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue().trim(),payEndTimeStartstamp, payEndTimestamp, null, userCardInfo.getCarType(), userCardInfo.getParkingSpace(), userCardInfo.getOwnerIdentity());
			if(!listUserCardInfoTemp.isEmpty()){
				for(int i=0;i<listUserCardInfoTemp.size();i++){
					UserCardInfoTemp = (UserCardInfo)listUserCardInfoTemp.get(i);
					userCardInfoService.updateExtendPayEndTimeAffirm(UserCardInfoTemp.getRecNO(), extendPayEndTime);
				}
			}
			if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
				cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
			} else {// û�нɷ�����
				cardInfoSendParaService.SendCardInfoPara();// �·��������
			}						
			result = Result.SUCCESS;
		}	
		this.getSomeObjec();
		listUserCardInfo = userCardInfoService.findAllItemByHqlToPayment(pager, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue().trim(),payEndTimeStartstamp, payEndTimestamp, null,userCardInfo.getCarType(), userCardInfo.getParkingSpace(), userCardInfo.getOwnerIdentity());
		return "queryPCToPayment";				
	}

// -----------------------------------------------------------����ΪС�����ɷѣ�����Ϊ��λ���������--------------------------------------------------------
	public String queryToGroup() {// ��ѯ�û�����Ϣ�ڷ������
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		this.getSomeObjec();
		userCardInfo = null;
		userCardInfo = new UserCardInfo();
		userCardInfo.setUserCardType((short) 15);
		listUserCardInfo = userCardInfoService.findItemByHql(pager, "", "", "", null, userCardInfo.getUserCardType(), param_whtherPayType.getPvalue());
		this.getSomeObjec();
		return "queryPCToGroup";
	}

	public String queryPCToGroup() {
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToRemoveLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		listUserCardInfo = userCardInfoService.findItemByHql(pager, userCardInfo.getCardNo().trim(), userCardInfo.getVehPlate().trim(), cardGroupInfo.getGroupName().trim(), isGroup, userCardInfo.getUserCardType(), param_whtherPayType.getPvalue());
		this.getSomeObjec();
		return "queryPCToGroup";
	}

	public String queryCGInfoToGroup() {// ��ҳ��ѯ����Ϣ�Է���
		userCardInfoTemp = new UserCardInfo();
		userCardInfoTemp.setRecNO(userCardInfo.getRecNO());
		list = cardGroupInfoService.getAllCardGroupInfoByPager(pager);
		return "queryCGInfoToGroup";

	}

	public String queryCGInfo() {// ���ݲ�ѯ������ѯ����Ϣ�Է���
		if ("".equals(cardGroupInfo.getGroupName().trim()) && null == cardGroupInfo.getGroupNo()) {
			return queryCGInfoToGroup();
		} else {
			userCardInfoTemp = new UserCardInfo();
			userCardInfoTemp.setRecNO(userCardInfo.getRecNO());
			list = cardGroupInfoService.findAllItemByHql(pager, cardGroupInfo.getGroupNo(), cardGroupInfo.getGroupName().trim());
			return "queryCGInfoToGroup";
		}
	}

	public String group() {// ��ӽ���
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		cardGroupService.deleteByRecNO(userCardInfo.getRecNO());// ��ɾ���������
		userCardInfoTemp = userCardInfoService.getUserCardInfoByRecNO(userCardInfo.getRecNO());
		cardGroup = new CardGroup();
		cardGroup.setRecNo(userCardInfoTemp.getRecNO());
		cardGroup.setCardNo(userCardInfoTemp.getCardNo().trim());
		cardGroup.setVehPlate(userCardInfoTemp.getVehPlate().trim());
		cardGroup.setGroupNo(cardGroupInfo.getGroupNo());
		cardGroup.setFirstInOut(1);
		cardGroup.setOptime(date);
		cardGroup.setLaneGroupNo(1);// ����Ҫ��ӳ�������Ϊ2�����ݿ����д���������
		cardGroupService.save(cardGroup);
		list = cardGroupService.getUserCardInfoAndCardGroupByGroupNoAndLaneGroupNo(pager, cardGroupInfo.getGroupNo(), 1);
		cardGroupInfo = cardGroupInfoService.getCardGroupInfoByGroupNo(cardGroupInfo.getGroupNo());
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û������Ϊ[" + userCardInfo.getRecNO() + "]���û���ӽ�����[" + cardGroupInfo.getGroupNo() + "]�ɹ�", "��Ʊ����--С��������--��λ���������", "tb_CardGroup");
		return "group";
	}

	public String queryCardGroupInfo() {// ��ҳ��ѯ����Ϣ�Խ�������Ϣ������ɾ����
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("groupNo");
		session.removeAttribute("groupName");
		list = cardGroupInfoService.getAllCardGroupInfoByPager(pager);
		cardGroupInfo = null;
		return "queryCGInfoToManage";

	}

	public String queryCGInfoToManage() {// ��������������ѯ����Ϣ�Խ�������Ϣ������ɾ����
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("groupNo");
		session.removeAttribute("groupName");
		if ("".equals(cardGroupInfo.getGroupName().trim()) && null == cardGroupInfo.getGroupNo()) {
			return queryCardGroupInfo();
		} else {
			session.setAttribute("groupNo", cardGroupInfo.getGroupNo());
			session.setAttribute("groupName", cardGroupInfo.getGroupName());
			list = cardGroupInfoService.findAllItemByHql(pager, cardGroupInfo.getGroupNo(), cardGroupInfo.getGroupName().trim());
			return "queryCGInfoToManage";
		}

	}

	public String addCardGroupInfo() {// ��������Ϣ����
		return "addCardGroupInfo";
	}

	public String addCardGroupInfoEdit() {// ��������Ϣ��������ݿ�Ĳ���
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		cardGroupInfoTemp = new CardGroupInfo();
		cardGroupInfoTemp.setLaneGroupNo(1);
		cardGroupInfoTemp.setGroupName(cardGroupInfo.getGroupName().trim());
		cardGroupInfoTemp.setParkSum(cardGroupInfo.getParkSum());
		cardGroupInfoTemp.setParkRemant(cardGroupInfo.getParkSum());
		cardGroupInfoTemp.setOptime(date);
		cardGroupInfo = new CardGroupInfo();
		cardGroupInfo.setLaneGroupNo(2);
		cardGroupInfo.setGroupName(cardGroupInfoTemp.getGroupName().trim());
		cardGroupInfo.setParkSum(cardGroupInfoTemp.getParkSum());
		cardGroupInfo.setParkRemant(cardGroupInfoTemp.getParkSum());
		cardGroupInfo.setOptime(date);
		int groupNo = cardGroupInfoService.getMaxGroupNo();
		cardGroupInfo.setGroupNo(groupNo);
		cardGroupInfoTemp.setGroupNo(groupNo);
		cardGroupInfoService.save(cardGroupInfoTemp);
		cardGroupInfoService.save(cardGroupInfo);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û���������[" + cardGroupInfoTemp.getGroupName() + "]�ɹ�", "��Ʊ����--С��������--��λ���������--����Ϣ����", "tb_CardGroupInfo");
		return queryCardGroupInfo();
	}

	public String updateCardGroupInfo() {// �޸�����Ϣ����
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		cardGroupInfo = cardGroupInfoService.getCardGroupInfoByGroupNo(cardGroupInfo.getGroupNo());
		return "updateCardGroupInfo";
	}

	public String updateCardGroupInfoEdit() {// �޸�����Ϣ���ԵĲ���
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		cardGroupInfoTemp = cardGroupInfoService.getCardGroupInfoByGroupNoAndLaneGroupNo(cardGroupInfo.getGroupNo(), 1);
		cardGroupInfoTemp.setGroupName(cardGroupInfo.getGroupName());
		cardGroupInfoTemp.setParkSum(cardGroupInfo.getParkSum());
		cardGroupInfoTemp.setOptime(date);
		cardGroupInfoService.update(cardGroupInfoTemp);
		cardGroupInfoTemp = cardGroupInfoService.getCardGroupInfoByGroupNoAndLaneGroupNo(cardGroupInfo.getGroupNo(), 2);
		cardGroupInfoTemp.setGroupName(cardGroupInfo.getGroupName().trim());
		cardGroupInfoTemp.setParkSum(cardGroupInfo.getParkSum());
		cardGroupInfoTemp.setOptime(date);
		cardGroupInfoService.update(cardGroupInfoTemp);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS1;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û��޸�����[" + cardGroupInfo.getGroupNo() + "]��Ϣ�ɹ�", "��Ʊ����--С��������--��λ���������--����Ϣ����", "tb_CardGroupInfo");

		if (session.getAttribute("groupName") != null) {
			cardGroupInfo.setGroupName(session.getAttribute("groupName").toString());
		} else {
			cardGroupInfo.setGroupName("");
		}
		cardGroupInfo.setGroupNo((Integer) session.getAttribute("groupNo"));
		if ("".equals(cardGroupInfo.getGroupName()) && null == cardGroupInfo.getGroupNo()) {
			list = cardGroupInfoService.getAllCardGroupInfoByPager(pager);
		} else {
			list = cardGroupInfoService.findAllItemByHql(pager, cardGroupInfo.getGroupNo(), cardGroupInfo.getGroupName());
		}
		return "queryCGInfoToManage";
	}

	public String deleteCardGroupInfo() {// ɾ������Ϣ
		admin = adminService.get(getCurrentOperator().getId());
		cardGroupInfoService.deleteByGroupNo(cardGroupInfo.getGroupNo());
		cardGroupService.deleteByGroupNo(cardGroupInfo.getGroupNo());// �������ڳ�λ��������д��ڣ�ɾ������Ϣ���Է��������ࡣ
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS2;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û�ɾ������[" + cardGroupInfo.getGroupNo() + "]��Ϣ�ɹ�", "��Ʊ����--С��������--��λ���������--����Ϣ����", "tb_CardGroupInfo");
		return queryCardGroupInfo();
	}

	public String deleteGroupMember() {// ��ҳ��ʾ����Ϣ��ɾ��ĳ���е����Ա
		list = cardGroupInfoService.getAllCardGroupInfoByPager(pager);
		return "deleteGroupMember";
	}

	public String queryPCInfoToDeleteGroupMeber() {// ��������ѯ����Ϣ��ɾ��ĳ���е����Ա
		if ("".equals(cardGroupInfo.getGroupName().trim()) && null == cardGroupInfo.getGroupNo()) {
			return deleteGroupMember();
		} else {
			list = cardGroupInfoService.findAllItemByHql(pager, cardGroupInfo.getGroupNo(), cardGroupInfo.getGroupName().trim());
			return "deleteGroupMember";
		}
	}

	public String queryPCToDeleteGroupMeber() {
		list = cardGroupService.getUserCardInfoAndCardGroupByGroupNoAndLaneGroupNo(pager, cardGroupInfo.getGroupNo(), 1);
		cardGroupInfo = cardGroupInfoService.getCardGroupInfoByGroupNo(cardGroupInfo.getGroupNo());
		return "group";

	}

	public String deleteCardGroup() {// ɾ�����Ա
		admin = adminService.get(getCurrentOperator().getId());
		cardGroupInfo = cardGroupInfoService.getCardGroupInfoByGroupNo(cardGroupInfo.getGroupNo());
		cardGroupService.deleteByRecNO(userCardInfo.getRecNO());
		list = cardGroupService.getUserCardInfoAndCardGroupByGroupNoAndLaneGroupNo(pager, cardGroupInfo.getGroupNo(), 1);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û�ɾ������[" + cardGroupInfo.getGroupNo() + "]�����Ա�û����Ϊ[" + userCardInfo.getRecNO() + "]���û����ɹ�", "��Ʊ����--С��������--��λ���������--����Ϣ����--ɾ�����Ա", "tb_CardGroup");
		return "group";
	}

	// -----------------------------------------------------------����Ϊ��λ�������������ΪУ������ʷ��¼��ѯ--------------------------------------------------------
	public String queryUserCardInfoHistoryToCheck() {
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRemoveLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//��ѯuserCardType������0��1��2���û�����
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		listCarType = carTypeService.getAllCarType();
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		listCarSmallType = carSmallTypeService.findAllCarSmallType();
		listUserCardInfoHistory = userCardInfoService.findAllUserCardInfoHistoryBySql(pager, null, null, null, null, null, null, null, null, null, null, null, null, null);
		return "queryUserCardInfoHistory";
	}

	public String queryUserCardInfoHistory() {
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp modifyTimestamp = null;// ��ѯ���޸�ʱ��modifyTime;//�޸�ʱ��;
		if (!"".equals(modifyTime) && null != modifyTime) {
			String modifyTimestampTemp = modifyTime + " 23:59:59";
			modifyTimestamp = Timestamp.valueOf(modifyTimestampTemp);
		}
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRemoveLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//��ѯuserCardType������0��1��2���û�����
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		listCarType = carTypeService.getAllCarType();
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		listCarSmallType = carSmallTypeService.findAllCarSmallType();
		if(userCardInfo.getCarType()!=null){
			listCarSmallTypeInCarType = carSmallTypeService.findSmallTypeByCarType(userCardInfo.getCarType());
		}
		listUserCardInfoHistory = userCardInfoService.findAllUserCardInfoHistoryBySql(pager, userCardInfo.getRecNO(), userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), null, userCardInfo.getFeeRuleType(), modifyTimestamp, null,userCardInfo.getCarType(),userCardInfo.getParkingSpace(),userCardInfo.getOwnerIdentity());
		return "queryUserCardInfoHistory";

	}

	public String showUserCardInfoHistory() {
		Timestamp modifyTimestamp = null;// ��ѯ���޸�ʱ��modifyTime;//�޸�ʱ��;
		if (!"".equals(modifyTime) && null != modifyTime) {
			// String modifyTimestampTemp = modifyTime + " 23:59:59";
			modifyTimestamp = Timestamp.valueOf(modifyTime);
		}
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryToRemoveLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction��queryParkCardToManage()����parkjsp����ʱset������get��������ʱ���쳣", admin);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//��ѯuserCardType������0��1��2���û�����
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		listCarType = carTypeService.getAllCarType();
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		listCarSmallType = carSmallTypeService.findAllCarSmallType();
		if(userCardInfo.getCarType()!=null){
			listCarSmallTypeInCarType = carSmallTypeService.findSmallTypeByCarType(userCardInfo.getCarType());
		}
		listUserCardInfoHistory = userCardInfoService.findAllUserCardInfoHistoryBySql(pager, userCardInfo.getRecNO(), null, null, null, null, null, null, null, null, modifyTimestamp, null, null, null);
		if (!listUserCardInfoHistory.isEmpty()) {
			listUserCardInfoHistory = listUserCardInfoHistory.subList(0, 1);
		}
		return "showUserCardInfoHistory";
	}

	// -----------------------------------------------------------����ΪУ������ʷ��¼��ѯ������Ϊajax��֤��̨����--------------------------------------------------------
	public String getUserCardInfoByVehPlate() {// jquery��֤�����Ƿ��ѱ�ע��
		userCardInfoTemp = userCardInfoService.getUserCardInfoByVehPlate(userCardInfo.getVehPlate().trim());
		Account account = accountService.getAccountByVehPlateToAjax(userCardInfo.getVehPlate().trim());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��getUserCardInfoByVehPlate������֤�����Ƿ������ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (userCardInfoTemp == null&& account==null) {
			out.println("success");

		} else {
			out.print("fail");

		}
		return null;
	}

	public String getUserCardInfoByCardNo() {// jquery��֤�����Ƿ��ѱ�����
		userCardInfoTemp = userCardInfoService.getUserCardInfoByCardNo(userCardInfo.getCardNo().trim());
		admin = adminService.get(getCurrentOperator().getId());
		// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToRemoveLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		idCardInfoTemp = iDCardInfoService.getIDCardInfoByCardNo(userCardInfo.getCardNo().trim());
		CardInfo cardInfo = cardInfoService.getCardInfoByCardNo(userCardInfo.getCardNo().trim());
		account = accountService.getAccount(userCardInfo.getCardNo().trim());
		StoreCardBlackList storeCardBlackList = storeCardBlackListService.get(userCardInfo.getCardNo().trim());

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��getUserCardInfoByCardNo������֤�����Ƿ������ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (userCardInfoTemp != null || idCardInfoTemp != null || account!=null ) {
			out.print("fail");// �˿��ѱ����á�
		} else if (cardInfo != null && storeCardBlackList == null) {
			if (cardInfo.getStatus() != 0) {
				out.print("statusNoUse");// ������ʾ�ÿ��ڿ���Ϣ�в�������������������
			} else {
				out.println("success");
			}
		} else if (cardInfo != null && storeCardBlackList != null) {
			if (cardInfo.getStatus() == 0) {
				out.print("secondUse");// ������ʾ�ÿ�֮ǰ�ѱ����ù��������ٱ�����
			} else {
				out.print("statusNoUse");// ������ʾ�ÿ��ڿ���Ϣ�в�������������������
			}
		} else if (cardInfo == null && storeCardBlackList != null) {
			out.print("secondUse");// ������ʾ�ÿ�֮ǰ�ѱ����ù��������ٱ�����
		} else if (cardInfo == null && storeCardBlackList == null) {
			out.print("NoRegister");// ������ʾ��û���еǼǹ�
		} else {
			out.println("success");
		}
		return null;
	}

	public String getCardInfoByCardNo() {// jquery��֤�����Ƿ��ڿ���Ϣ���еǼǹ�
		cardInfo = cardInfoService.getCardInfoByCardNo(cardInfo.getCardNo().trim());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��getCardInfoByCardNo������֤�����Ƿ������ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (cardInfo == null) {
			out.println("success");

		} else {
			out.print("fail");

		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public String ajaxFeeRuleTypeDefByUserCardType() {// ����parkNo�첽��ȡtb_FeeRuleTypeDef���շ����Ͷ�������е���Ϣ
		HttpServletResponse response = ServletActionContext.getResponse();
		UserCardFeeRuleType userCardFeeRuleType = userCardFeeRuleTypeService.get(userCardInfo.getUserCardType());
		if (userCardFeeRuleType != null) {
			List tempList = feeRuleTypeDefService.LoadFeeRuleTypeDef(userCardFeeRuleType.getFeeRuleType());
			response.setContentType("text/xml;charset=gbk");
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}
			pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
			pw.print("<feeRuleTypeDefs>");
			for (int i = 0; i < tempList.size(); i++) {
				FeeRuleTypeDef feeRuleTypeDef = (FeeRuleTypeDef) tempList.get(i);
				pw.print("<feeRuleTypeDef feeRuleType='" + feeRuleTypeDef.getFeeRuleType() + "' name='" + feeRuleTypeDef.getName() + "' />");
			}
			pw.print("</feeRuleTypeDefs>");
		}

		return null;
	}

	public String getDateFristDay(Date date) {// û�нɷ���Ϣʱ��ǰϵͳʱ���·ݵĵ�һ��
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowdate = sdf.format(date);
			Date dateTemp = sdf.parse(nowdate);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(dateTemp);
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH);
			int day = 1;
			calendar.set(year, month, day, 0, 0, 0);
			String nowdateTemp = sdf.format(calendar.getTime());
			return nowdateTemp;
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��getDateFristDay�����������ڵ�һ��ʱ�������쳣", e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
			// TODO Auto-generated catch block

		}
	}

	public String changeDateFormat(Timestamp dateFormat) {// Date�ĸ�ʽ"yyyy-MM-dd HH:mm:ss"ת����"yyyy-MM-dd"
		try {
			String time = dateFormat.toString();
			SimpleDateFormat sdfTemp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dateTemp = sdfTemp.parse(time);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowdateTemp = sdf.format(dateTemp);
			return nowdateTemp;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��changeDateFormat��Timestamp��date��ʽת��ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowdate = sdf.format(new Date(0));
			return nowdate;
		}

	}

	/*public String getDateAddMonthFristDay(String date, int mount) {// �нɷ���Ϣʱ������ݿ������endTime�·ݼ�mount��ĵ�һ��
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dateTemp = sdf.parse(date);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(dateTemp);
			GregorianCalendar gc = new GregorianCalendar();
			gc.setTime(dateTemp);
			gc.add(2, +mount);
			calendar.setTime(gc.getTime());
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH);
			int day = 1;
			calendar.set(year, month, day, 0, 0, 0);
			String nowdateTemp = sdf.format(calendar.getTime());
			return nowdateTemp;
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��getDateAddMonthFristDay�����������ڵ�һ��ʱ�������쳣", e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
			// TODO Auto-generated catch block

		}
	}

	public String getDateAddMonthEndDay(String date, int mount) {// ����ת�����ַ������mount���º�����һ��
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dateTemp = sdf.parse(date);
			Calendar calendar = Calendar.getInstance();
			// calendar.setTime(dateTemp);
			GregorianCalendar gc = new GregorianCalendar();
			gc.setTime(dateTemp);
			gc.add(2, +mount);
			calendar.setTime(gc.getTime());
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH);
			// int day=1;
			// calendar.set(year, month, day,0,0,0);
			int value = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
			calendar.set(year, month, value, 0, 0, 0);
			String nowdateTemp = sdf.format(calendar.getTime());
			return nowdateTemp;
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��getDateAddMonthEndDay���������������һ��ʱ�������쳣", e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
			// TODO Auto-generated catch block

		}
	}*/
	public String getAddMountMonthFirstDay(String date,int mount){//����ת�����ַ������mount���º�ĵ�һ�죬mount��=1��20110701�ż���1���º��������20110801
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if(date.length()<=10){
				date = date+" 00:00:00";
			}
			Date dateTemp = sdf.parse(date);
			Calendar calendar = Calendar.getInstance();
			// calendar.setTime(dateTemp);
			GregorianCalendar gc = new GregorianCalendar();
			gc.setTime(dateTemp);
			gc.add(2, +mount);
			calendar.setTime(gc.getTime());
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH);
			int day=1;			
			calendar.set(year, month, day, 0, 0, 0);
			String nowdateTemp = sdf.format(calendar.getTime());
			return nowdateTemp;
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction��getMountMonthFirstDay���������������һ��ʱ�������쳣", e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
			// TODO Auto-generated catch block

		}
	}

	public boolean find(File f, String name) {// �ж��ļ��Ƿ����
		if (f.isDirectory()) {
			File[] fs = f.listFiles();
			for (int i = 0; i < fs.length; i++) {
				if (find(fs[i], name))
					return true;
			}
			return false;
		} else {
			return name.equalsIgnoreCase(f.getName());
		}
	}

	/**
	 * �첽��ȡͼƬ·��
	 */
	@SuppressWarnings("unchecked")
	public String ajaxQueryImage() {
		try {
			vehPlate = java.net.URLDecoder.decode(vehPlate, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		pager.setPageSize("20");
		list = cardDynamicService.waterQuery(pager, null, vehPlate, null, "1", null, null, null, null, null, null, null, null, null, null, null, null, "2", "1", null,null,startTime + " 00:00:00", endTime + " 59:59:59", null, null,null, null,null, null, null,"1");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<images>");
		if (!list.isEmpty()) {
			Admin admin = adminService.get(getCurrentOperator().getId());
			Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "Ϊ��ѯ����׽��ͼƬ�ṩ·��", "LostCardAction��queryByOpTimeAndVehPlate()����vehPlate����ʱset������get��������ʱ���쳣", admin);
			SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
			for (int i = 0; i < list.size(); i++) {
				Object[] o = (Object[]) (list.get(i));
				String strTime = simple.format((Date) o[9]);
				List tempList = cardDynamicService.getInListByListNo(strTime, o[0].toString());
				String pic = null;
				if (!tempList.isEmpty()) {
					Calendar cal = Calendar.getInstance();
					Map map = (Map) tempList.get(0);
					cal.setTime((Date) o[9]);
					String tempInGateNo = map.get("GateNo").toString();
					String tempInLaneNo = map.get("LaneNo").toString();
					tempInGateNo = gateNoAndLaneNo(tempInGateNo);
					tempInLaneNo = gateNoAndLaneNo(tempInLaneNo);
					String month1 = monthAndDay(String.valueOf((cal.get(Calendar.MONTH) + 1)));
					String day1 = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
					String tempStr = param_vehPlate.getPvalue();
					tempStr = tempStr.replace("\\", "/");
					pic = tempStr + tempInGateNo + tempInLaneNo + "/" + cal.get(Calendar.YEAR) + month1 + "/" + day1 + "/" + map.get("listNo") + ".jpg";
				}
				pw.print("<image imgSrc='" + pic + "'" + " name='" + o[0].toString() + ".jpg'" + " />");
				// System.out.println(pic);
			}
		}
		pw.print("</images>");
		return null;
	}

	/**
	 * ��ѯ������ jdbc  ��
	 */
	public String queryWhite(){
		userCardTypeList = userCardTypeService.getAllUserCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		list = cardInfoService.queryWhite(pager,cardNo,vehplate,obuId,cardType,status,ownerName,isImage,feeRuleType);
		return "queryWhite";
	}
	/**
	 * ������������������ ��
	 */
	@SuppressWarnings("unchecked")
	public String exportWhite(){
		userCardTypeList = userCardTypeService.getAllUserCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		Map<String ,String> mapUserCard = new HashMap<String,String>();
		Map<String ,String> mapRuleType = new HashMap<String,String>();
		if(!userCardTypeList.isEmpty()){
			for(int i=0;i<userCardTypeList.size();i++){
				UserCardType temp = (UserCardType) userCardTypeList.get(i);
				mapUserCard.put(temp.getUserCardType().toString(), temp.getTypeName());
			}
		}
		if(!listFeeRuleTypeDef.isEmpty()){
			for(int i=0;i<listFeeRuleTypeDef.size();i++){
				FeeRuleTypeDef temp = (FeeRuleTypeDef) listFeeRuleTypeDef.get(i);
				mapRuleType.put(temp.getFeeRuleType().toString(), temp.getName());
			}
		}
		list = cardInfoService.exportWhite(cardNo, vehplate, obuId, cardType, status, ownerName, isImage, feeRuleType);
		try{
			HttpServletResponse response = ServletActionContext.getResponse();
	  	  	response.setContentType("octets/stream");//�򵥿�������Ϊ��Ϣ��
	  	  	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	  	  	String title = "whites"+format.format(new Date())+".xls";
		    response.addHeader("Content-Disposition", "attachment;filename="+title);	      
		    //�ͻ��˲�����
		    response.addHeader("Pragma","no-cache");
		    response.addHeader("Cache-Control","no-cache");
		    ExcelUtil<Object[]> _excelUtil = new ExcelUtil<Object[]>();
		    String[] headers = {"�������","���ƺ�", "��������", "obu��", "����ʱ��", "����ʱ��", "�û�������","�ʺ�״̬","�Ƿ��г���ͼƬ","��������"};
	        OutputStream out = response.getOutputStream();
	        //_excelUtil.exportExcel(headers, list, out);
	        _excelUtil.exportExcel("������", headers, list, out, "yyyy-MM-dd", 5000, mapUserCard, mapRuleType);
	        systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û������������ļ��ɹ�", "��������ѯ-����", "������"+format.format(new Date())+".xls");
	        out.close();
		    response.reset();
		}catch (IOException e) {
	    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���������������Excelʱ�׳���IO�쳣", "��������ѯ-����", "IOException");
			  e.printStackTrace();
	      }
		return null;
	}
	
	/**
	 * ������������������
	 * �����û�ѡ����ֶε���
	 * 2013-11-26
	 */
	@SuppressWarnings("unchecked")
	public String expWhite(){
		userCardTypeList = userCardTypeService.getAllUserCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		listCarType = carTypeService.getAllCarType();
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		listCarSmallType = carSmallTypeService.findAllCarSmallType();
		Map<String ,String> mapUserCard = new HashMap<String,String>();
		Map<String ,String> mapRuleType = new HashMap<String,String>();
		Map<String ,String> mapCarType = new HashMap<String,String>();
		Map<String ,String> mapIdentity = new HashMap<String,String>();
		if(!userCardTypeList.isEmpty()){
			for(int i=0;i<userCardTypeList.size();i++){
				UserCardType temp = (UserCardType) userCardTypeList.get(i);
				mapUserCard.put(temp.getUserCardType().toString(), temp.getTypeName());
			}
		}
		if(!listFeeRuleTypeDef.isEmpty()){
			for(int i=0;i<listFeeRuleTypeDef.size();i++){
				FeeRuleTypeDef temp = (FeeRuleTypeDef) listFeeRuleTypeDef.get(i);
				mapRuleType.put(temp.getFeeRuleType().toString(), temp.getName());
			}
		}
		if(!listCarType.isEmpty()){
			for(int i=0;i<listCarType.size();i++){
				CarType temp = (CarType) listCarType.get(i);
				mapCarType.put(temp.getCarType().toString(), temp.getCarTypeName());
			}
		}
		if(!listIdentity.isEmpty()){
			for(int i=0;i<listIdentity.size();i++){
				OwnerIdentity temp = (OwnerIdentity) listIdentity.get(i);
				mapIdentity.put(temp.getIdentityType().toString(), temp.getIdentityName());
			}
		}
		String[] fileds = filed.split(",");
		String[] headers = new String[fileds.length];
		int count = 0;
		for(int i=0; i<fileds.length; i++){//��ȡ�û�ѡ����ֶ�
			String str = fileds[i].trim();
			if(str.equals("CardNO")){
				headers[count] = "�������";
				count ++;
			}
			else if(str.equals("Status")){
				headers[count] = "��״̬";
				count ++;
			}
			else if(str.equals("Owner")){
				headers[count] = "��������";
				count ++;
			}
			else if(str.equals("OwnerIdentity")){
				headers[count] = "�������";
				count ++;
			}
			else if(str.equals("IDCard")){
				headers[count] = "���֤����";
				count ++;
			}
			else if(str.equals("MobileNumber")){
				headers[count] = "�ƶ��绰";
				count ++;
			}
			else if(str.equals("VehPlate")){
				headers[count] = "���ƺ�";
				count ++;
			}
			
			else if(str.equals("OBU")){
				headers[count] = "obu��";
				count ++;
			}
			else if(str.equals("UserCardType")){
				headers[count] = "�û�����";
				count ++;
			}
			else if(str.equals("PayEndTime")){
				headers[count] = "�ɷ�����";
				count ++;
			}
			else if(str.equals("carType")){
				headers[count] = "��������";
				count ++;
			}
			else if(str.equals("ParkingSpace")){
				headers[count] = "ͣ��λ";
				count ++;
			}
			else if(str.equals("ParkingSpaceNo")){
				headers[count] = "ͣ��λ���";
				count ++;
			}
			else if(str.equals("FeeRuleType")){
				headers[count] = "�շ�����";
				count ++;
			}
			else if(str.equals("RegisterTime")){
				headers[count] = "ע��ʱ��";
				count ++;
			}
			else if(str.equals("Address")){
				headers[count] = "�û���ַ";
				count ++;
			}
		}
		Map map = new HashMap();//����ѯ�����ŵ�map�У����㴫��
		map.put("cardNo", userCardInfo.getCardNo());
		map.put("status", userCardInfo.getStatus());
		map.put("userCardType", userCardInfo.getUserCardType());
		map.put("vehPlate", userCardInfo.getVehPlate());
		map.put("owner", userCardInfo.getOwner());
		map.put("idcard", userCardInfo.getIdcard());
		map.put("feeRuleType", userCardInfo.getFeeRuleType());
		map.put("mobileNumber", userCardInfo.getMobileNumber());
		map.put("carType", userCardInfo.getCarType());
		map.put("parkingSpace", userCardInfo.getParkingSpace());
		map.put("ownerIdentity", userCardInfo.getOwnerIdentity());
		list = cardInfoService.exportWhite(filed, map);
		int size = list.size();
		for(int i=0; i<size; i++){//��������ݡ��û����͡��������͡�ͣ������ö��ת��Ϊ��Ӧ��ֵ
			Map m = (Map)list.get(i);
			Integer OwnerIdentity = (Integer)m.get("OwnerIdentity");
			if(OwnerIdentity!=null){
				m.put("OwnerIdentity", mapIdentity.get(OwnerIdentity.toString()));
			}
			
			Short UserCardType = (Short)m.get("UserCardType");
			if(UserCardType!=null){
				m.put("UserCardType", mapUserCard.get(UserCardType.toString()));
			}
			
			Short Status = (Short)m.get("Status");
			if(Status!=null){
				if("0".equals(Status.toString())){
					m.put("Status", "����");
				}else if("1".equals(Status.toString())){
					m.put("Status", "��ʧ");
				}else if("9".equals(Status.toString())){
					m.put("Status", "δ�ɷ�");
				}
			}
			
			Timestamp PayEndTime = (Timestamp) m.get("PayEndTime");
			if(PayEndTime!=null && !"".equals(PayEndTime)){
				m.put("PayEndTime", PayEndTime.toString().substring(0, 10));
			}
			Timestamp RegisterTime = (Timestamp) m.get("RegisterTime");
			if(RegisterTime!=null && !"".equals(RegisterTime)){
				m.put("RegisterTime", RegisterTime.toString().substring(0, 19));
			}
			Integer carType = (Integer)m.get("carType");
			if(carType!=null){
				m.put("carType", mapCarType.get(carType.toString()));
				//�������ʹ��ڵ�ʱ�򣬲ſ��ܴ���ͣ����
				String ParkingSpace= (String) m.get("ParkingSpace");
				if(ParkingSpace!=null && !ParkingSpace.equals("")){
					Integer carSmallType = Integer.parseInt(ParkingSpace);
					if(listCarSmallType!=null&&listCarSmallType.size()>0){
						int s = listCarSmallType.size();
						for(int k=0; k<s; k++){
							CarSmallType carSmall =  (CarSmallType) listCarSmallType.get(k);
							if(carType.equals(carSmall.getCarType())){
								if(carSmallType.equals(carSmall.getCarSmallType())){
									m.put("ParkingSpace", carSmall.getCarSmallName());
									break;
								}
							}
						}
					}
				}
			}
			
			Short FeeRuleType = (Short)m.get("FeeRuleType");
			if(FeeRuleType!=null){
				m.put("FeeRuleType", mapRuleType.get(FeeRuleType.toString()));
			}
		}
		try{
			HttpServletResponse response = ServletActionContext.getResponse();
	  	  	response.setContentType("octets/stream");//�򵥿�������Ϊ��Ϣ��
	  	  	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	  	  	String title = "whites"+format.format(new Date())+".xls";
		    response.addHeader("Content-Disposition", "attachment;filename="+title);	      
		    //�ͻ��˲�����
		    response.addHeader("Pragma","no-cache");
		    response.addHeader("Cache-Control","no-cache");
		    ExcelUtil<Object[]> _excelUtil = new ExcelUtil<Object[]>();
	        OutputStream out = response.getOutputStream();
	        _excelUtil.expExcel("������", headers, list, out, 5000, mapUserCard, mapRuleType);
	        systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û������������ļ��ɹ�", "��������ѯ-����", "������"+format.format(new Date())+".xls");
	        out.close();
		}catch (IOException e) {
	    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���������������Excelʱ�׳���IO�쳣", "��������ѯ-����", "IOException");
			  e.printStackTrace();
	      }
		return null;
	}
	
	/**
	 * ��ӡ������ ��
	 */
	public String printsWhite(){
		userCardTypeList = userCardTypeService.getAllUserCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		list = cardInfoService.exportWhite(cardNo, vehplate, obuId, cardType, status, ownerName, isImage, feeRuleType);
		return "printsWhite";
	}
	
	
	/**
	 * ��ϴ��źźͳ����ŵĳ���
	 */
	public String gateNoAndLaneNo(String temp) {
		String str = "";
		String[] ss = { "0000", "000", "00", "0", "" };
		str = ss[temp.length()] + temp;
		return str;
	}
	
	/**
	 * ��ӡuserCardInfo
	 */
	public String printsUserCardInfo() {
		userCardTypeList = userCardTypeService.getAllUserCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		list = cardInfoService.printUserCardInfo(userCardInfo.getCardNo().trim());
		return "printsUserCardInfo";
	}
	
	/**
	 * ����·ݻ�����
	 */
	public String monthAndDay(String temp) {
		String str = "";
		String[] ss = { "00", "0", "" };
		str = ss[temp.length()] + temp;
		return str;
	}
	
	
	/**
	 * ���ݳ��������첽��ѯ��������С����
	 * */
	public String findCarSmallType(){
		ServletResponse response = ServletActionContext.getResponse();
		List list = carSmallTypeService.findSmallTypeByCarType(carType);
		if(list==null){
			return null;
		}
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw =null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
			pw.print("<CarSmallTypes>");
			for(int i=0; i<list.size(); i++){
				CarSmallType carSmallType = (CarSmallType) list.get(i);
				
				pw.print("<CarSmallType id='" + carSmallType.getCarSmallType() + "' name='" +carSmallType.getCarSmallName() + "' />");
			}
			pw.print("</CarSmallTypes>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	

	@SuppressWarnings("unchecked")
	public List getListUserCardInfo() {
		return listUserCardInfo;
	}

	@SuppressWarnings("unchecked")
	public void setListUserCardInfo(List listUserCardInfo) {
		this.listUserCardInfo = listUserCardInfo;
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

	public void setParam_whtherPayType(Sysparamconf paramWhtherPayType) {
		param_whtherPayType = paramWhtherPayType;
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

	public UserCardInfo getUserCardInfo() {
		return userCardInfo;
	}

	public void setUserCardInfo(UserCardInfo userCardInfo) {
		this.userCardInfo = userCardInfo;
	}

	public UserCardInfo getUserCardInfoTemp() {
		return userCardInfoTemp;
	}

	public void setUserCardInfoTemp(UserCardInfo userCardInfoTemp) {
		this.userCardInfoTemp = userCardInfoTemp;
	}

	public CardInfo getCardInfo() {
		return cardInfo;
	}

	public void setCardInfo(CardInfo cardInfo) {
		this.cardInfo = cardInfo;
	}

	@SuppressWarnings("unchecked")
	public List getListuserCardRate() {
		return listuserCardRate;
	}

	@SuppressWarnings("unchecked")
	public void setListuserCardRate(List listuserCardRate) {
		this.listuserCardRate = listuserCardRate;
	}

	public UserCardBill getUserCardBill() {
		return userCardBill;
	}

	public void setUserCardBill(UserCardBill userCardBill) {
		this.userCardBill = userCardBill;
	}

	public UserCardRate getUserCardRate() {
		return userCardRate;
	}

	public void setUserCardRate(UserCardRate userCardRate) {
		this.userCardRate = userCardRate;
	}

	public Short getAmount() {
		return amount;
	}

	public void setAmount(Short amount) {
		this.amount = amount;
	}

	public Integer getMoney() {
		return money;
	}

	public void setMoney(Integer money) {
		this.money = money;
	}

	@SuppressWarnings("unchecked")
	public List getListAdmin() {
		return listAdmin;
	}

	@SuppressWarnings("unchecked")
	public void setListAdmin(List listAdmin) {
		this.listAdmin = listAdmin;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getStartTimeTemp() {
		return startTimeTemp;
	}

	public void setStartTimeTemp(String startTimeTemp) {
		this.startTimeTemp = startTimeTemp;
	}

	public String getEndTimeTemp() {
		return endTimeTemp;
	}

	public void setEndTimeTemp(String endTimeTemp) {
		this.endTimeTemp = endTimeTemp;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public CardGroupInfo getCardGroupInfo() {
		return cardGroupInfo;
	}

	public void setCardGroupInfo(CardGroupInfo cardGroupInfo) {
		this.cardGroupInfo = cardGroupInfo;
	}

	public String getIsGroup() {
		return isGroup;
	}

	public void setIsGroup(String isGroup) {
		this.isGroup = isGroup;
	}

	public String getVersionAndRecNo() {
		return versionAndRecNo;
	}

	public void setVersionAndRecNo(String versionAndRecNo) {
		this.versionAndRecNo = versionAndRecNo;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public int getA() {
		return a;
	}

	public void setA(int a) {
		this.a = a;
	}

	public String getPathTemp() {
		return pathTemp;
	}

	public void setPathTemp(String pathTemp) {
		this.pathTemp = pathTemp;
	}

	public Long getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(Long sumMoney) {
		this.sumMoney = sumMoney;
	}

	public String getPayEndTime() {
		return payEndTime;
	}

	public void setPayEndTime(String payEndTime) {
		this.payEndTime = payEndTime;
	}

	public Sysparamconf getParam_userCardInfoCardNoLength() {
		return param_userCardInfoCardNoLength;
	}

	public void setParam_userCardInfoCardNoLength(Sysparamconf paramUserCardInfoCardNoLength) {
		param_userCardInfoCardNoLength = paramUserCardInfoCardNoLength;
	}

	public void setMyFileContentType(String contentType) {
		this.contentType = contentType;
	}

	public void setMyFileFileName(String fileName) {
		this.fileName = fileName;
	}

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	@SuppressWarnings("unchecked")
	public List getListUserCardFeeRuleType() {
		return listUserCardFeeRuleType;
	}

	@SuppressWarnings("unchecked")
	public void setListUserCardFeeRuleType(List listUserCardFeeRuleType) {
		this.listUserCardFeeRuleType = listUserCardFeeRuleType;
	}

	public Sysparamconf getParam_parkjsp() {
		return param_parkjsp;
	}

	public void setParam_parkjsp(Sysparamconf paramParkjsp) {
		param_parkjsp = paramParkjsp;
	}

	public Staff getStaff() {
		return staff;
	}

	public void setStaff(Staff staff) {
		this.staff = staff;
	}

	public String getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}

	@SuppressWarnings("unchecked")
	public List getListUserCardInfoHistory() {
		return listUserCardInfoHistory;
	}

	@SuppressWarnings("unchecked")
	public void setListUserCardInfoHistory(List listUserCardInfoHistory) {
		this.listUserCardInfoHistory = listUserCardInfoHistory;
	}

	public String getVehPlate() {
		return vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}

	public String getSrcPath() {
		return srcPath;
	}

	public void setSrcPath(String srcPath) {
		this.srcPath = srcPath;
	}
	@SuppressWarnings("unchecked")
	public List getListUserCardType() {
		return listUserCardType;
	}

	@SuppressWarnings("unchecked")
	public void setListUserCardType(List listUserCardType) {
		this.listUserCardType = listUserCardType;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getVehplate() {
		return vehplate;
	}

	public void setVehplate(String vehplate) {
		this.vehplate = vehplate;
	}

	public String getObuId() {
		return obuId;
	}

	public void setObuId(String obuId) {
		this.obuId = obuId;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOwnerName() {
		return ownerName;
	}

	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

	public String getIsImage() {
		return isImage;
	}

	public void setIsImage(String isImage) {
		this.isImage = isImage;
	}

	public String getFeeRuleType() {
		return feeRuleType;
	}

	public void setFeeRuleType(String feeRuleType) {
		this.feeRuleType = feeRuleType;
	}

	@SuppressWarnings("unchecked")
	public List getUserCardTypeList() {
		return userCardTypeList;
	}

	@SuppressWarnings("unchecked")
	public void setUserCardTypeList(List userCardTypeList) {
		this.userCardTypeList = userCardTypeList;
	}
	public String getPayEndTimeStart() {
		return payEndTimeStart;
	}

	public void setPayEndTimeStart(String payEndTimeStart) {
		this.payEndTimeStart = payEndTimeStart;
	}
	public int getExtendPayEndTime() {
		return extendPayEndTime;
	}

	public void setExtendPayEndTime(int extendPayEndTime) {
		this.extendPayEndTime = extendPayEndTime;
	}
	public String getIsUseImage() {
		return isUseImage;
	}

	public void setIsUseImage(String isUseImage) {
		this.isUseImage = isUseImage;
	}

	public Sysparamconf getParam_isDis() {
		return param_isDis;
	}

	public void setParam_isDis(Sysparamconf param_isDis) {
		this.param_isDis = param_isDis;
	}

	@SuppressWarnings("unchecked")
	public List getListCarType() {
		return listCarType;
	}

	@SuppressWarnings("unchecked")
	public void setListCarType(List listCarType) {
		this.listCarType = listCarType;
	}
	
	public List getListIdentity() {
		return listIdentity;
	}

	public void setListIdentity(List listIdentity) {
		this.listIdentity = listIdentity;
	}

	public int getCarType() {
		return carType;
	}

	public void setCarType(int carType) {
		this.carType = carType;
	}
	
	public List getListCarSmallType() {
		return listCarSmallType;
	}

	public void setListCarSmallType(List listCarSmallType) {
		this.listCarSmallType = listCarSmallType;
	}

	public List getListCarSmallTypeInCarType() {
		return listCarSmallTypeInCarType;
	}

	public void setListCarSmallTypeInCarType(List listCarSmallTypeInCarType) {
		this.listCarSmallTypeInCarType = listCarSmallTypeInCarType;
	}

	public String getFiled() {
		return filed;
	}

	public void setFiled(String filed) {
		this.filed = filed;
	}
	
	
}
