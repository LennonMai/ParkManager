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
	// zenggenbao(图片上传)
	private File myFile;
	// 隐藏属性
	@SuppressWarnings("unused")
	private String contentType;
	// 隐藏属性
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
	private String card_type_remark = "卡类型参数（0就是根据充值类型为不写卡，1为写卡,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	private String whtherPayType = "whtherPayType";// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
	private String whtherPayType_remark = "是否有收费类型参数（0表示有收费类型，1表示没有收费类型,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	private String parkjsp = "parkjsp";
	private String parkjsp_remark = "用parkCard那个校区的jsp文件，值为hg，就是用parkCard文件下的hg文件夹中的jsp。初始值为hg。";
	// 获取图片路径使用的属性(startTime,endTime,vehPlate)
	private String vehPlate;
	private String srcPath;
	
	//白名单
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
	
	public void getSomeObjec() {// 避免代码重复，写成一个函数
		listCarType = carTypeService.getAllCarType();
		listCardType = cardTypeService.getAllCardType();
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		// cardTypeTemp = cardTypeService.getCardTypeByCardType((short) 15);//
		// 查询tb_CardType获得CardType为15的对象，以显示真实用户类型为15时的类型名字（车位车）
		//listCardTypeThree = cardTypeService.getCardTypeByThreeCardType((short) 13, (short) 14, (short) 15);// 查询tb_CardType获得CardType为13,14或者15的对象，以在查询条件中用户类型显示
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//查询userCardType不等于0，1，2的用户类型
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
	public String  deleteBlankSpace(String values){//值不为null时删除空格
		if(values!=null){
			return values.trim();
		}else{
			return null;
		}
	}

	// -----------------------------------------------------------下面为小区卡注册------------------------------------------------------------------------

	public String queryParkCardToManage() {// 进入注册首界面
		this.removePagerAndConditionSession();
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToManage()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		listUserCardInfo = userCardInfoService.findByPager(pager);
		this.getSomeObjec();
		userCardInfo = null;
		return "queryParkCardToManage";
	}

	public String queryParkCard() {// 查询用户卡信息
		
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRegister()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		this.removePagerAndConditionSession();		
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		this.setConditionSession();
		// 需要param_whtherPayType.getPvalue()传值，有缴费卡类型和没有缴费卡类型查询不一样
		listUserCardInfo = userCardInfoService.findAllItemByHql(pager, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue().trim(), null, deleteBlankSpace(userCardInfo.getMobileNumber()),userCardInfo.getCarType(),deleteBlankSpace(userCardInfo.getParkingSpace()),userCardInfo.getOwnerIdentity());
		this.getSomeObjec();
		return "queryParkCardToManage";
	}

	public String register() {
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRegister()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		param_isDis = sysparamconfService.queryOrSave("isDis", "0", "月租卡是否区分为业主月租卡和非业主月租卡 0不区分 1区分", "ParkCardAction中queryParkCardToManage()设置isDis参数时set（），get（）参数时的异常", admin);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//查询userCardType不等于0，1，2的用户类型
		param_userCardInfoCardNoLength = sysparamconfService.queryOrSave("userCardInfoCardNoLength", "10", "校园卡管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值，例如：值为9则卡号长度只能为9）", "ParkCardAction中register()设置userCardInfoCardNoLength参数时的异常", admin);
		try {
			int length = Integer.valueOf(param_userCardInfoCardNoLength.getPvalue().trim());
			if (length <= 0 || length > 10) {
				param_userCardInfoCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_userCardInfoCardNoLength.setPvalue("10");
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中register()设置param_userCardInfoCardNoLength参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}
		listCardType=cardTypeService.getAllCardType();
		listCarType = carTypeService.getAllCarType();
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		return "register";
	}

	public String save() {// 保存用户卡信息和当卡信息表中没有此卡号信息时插入
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRegister()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
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
		if (userCardInfo.getUserCardType() !=13) {// 13是免费车，状态为0（正常） 378，446
			userCardInfoTemp.setStatus((short) 9);// 不是免费车时状态为9（未缴费）
			
		} else {
			userCardInfoTemp.setStatus((short) 0);
		}
		if (!userCardInfo.getVehPlateImagePath().equals("")) {

			try {
				userCardInfoTemp.setVehPlateImage(Hibernate.createBlob(new FileInputStream(myFile)));// 根据图片的路径转换成流保存进数据库
			} catch (Exception e) {
				admin = adminService.get(getCurrentOperator().getId());
				// 出现异常插入系统日志表
				systemLogService.save(new Date(), 2, admin, "ParkCardAction中save()获得图片输入流的时候发生异常", e.getMessage(), "Exception");
				e.printStackTrace();
			} finally {
			}
		}

		if (!param_whtherPayType.getPvalue().equals("1")) {// whtherPayType的值为0时，就是有缴费类型时
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
		// 修改卡信息表中的用户类型
		cardInfo = cardInfoService.getCardInfoByCardNo(userCardInfo.getCardNo());
		if (cardInfo != null) {// 当卡信息表中有此卡号信息时更新用户类型
			cardInfo.setUserCardType(userCardInfo.getUserCardType());
			cardInfoService.update(cardInfo);
		}
		// deleteImage();
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户小区卡注册操作成功，用户车牌号为[" + userCardInfo.getVehPlate() + "]", "卡票管理--小区卡管理--小区卡信息管理--注册", "tb_UserCardInfo");
		//if(userCardInfoTemp.getUserCardType()==14){
		if (userCardInfoTemp.getUserCardType() !=13) {// 13是免费车，状态为0（正常） 378，446
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

	public String setImage() {// 异步设置图片
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
				userCardInfoTemp.setVehPlateImage(Hibernate.createBlob(new FileInputStream(userCardInfo.getVehPlateImagePath())));// 根据图片的路径转换成流保存进数据
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
				// 出现异常插入系统日志表
				systemLogService.save(new Date(), 2, admin, "ParkCardAction中setImage()获得异步图片输入流的时候发生异常", e.getMessage(), "Exception");
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
				systemLogService.save(new Date(), 2, admin, "ParkCardAction中getUserCardInfoByVehPlate（）验证车牌是否存在是时发生的异常", e.getMessage(), "IOException");
				e.printStackTrace();
			}

			outTemp.println(path);

		}
		return null;
	}

	public String deleteImage() {// 删除图片
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

	// -----------------------------------------------------------上面为小区卡注册，下面为小区卡信息修改--------------------------------------------------
	public String userCardInfoList() {// 显示用户卡信息以修改
		this.setPagerSession();
		String savePath = null;
		InputStream in = null;
		String path = null;
		BufferedOutputStream out = null;
		Random r = new Random();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowdate = sdf.format(new Date());
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRegister()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		param_isDis = sysparamconfService.queryOrSave("isDis", "0", "月租卡是否区分为业主月租卡和非业主月租卡 0不区分 1区分", "ParkCardAction中queryParkCardToManage()设置isDis参数时set（），get（）参数时的异常", admin);
		param_userCardInfoCardNoLength = sysparamconfService.queryOrSave("userCardInfoCardNoLength", "10", "校园卡管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值，例如：值为9则卡号长度只能为9）", "ParkCardAction中register()设置userCardInfoCardNoLength参数时的异常", admin);
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
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中register()设置param_userCardInfoCardNoLength参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}
		userCardInfo = userCardInfoService.getUserCardInfoByRecNO(userCardInfo.getRecNO());
		staff = staffService.get(userCardInfo.getCardNo());
		listCarSmallType = carSmallTypeService.findSmallTypeByCarType(userCardInfo.getCarType());
		if (userCardInfo.getVehPlateImage() != null) {// 根据数据库中的流把图像读到C:/VehPlateImage.jpg
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
				// 出现异常插入系统日志表
				systemLogService.save(new Date(), 2, admin, "ParkCardAction中setImage()获得异步图片输入流的时候发生异常", e.getMessage(), "Exception");
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
			listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//查询userCardType不等于0，1，2的用户类型
		return "update";
	}

	public String update() {// 更改用户卡信息
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRegister()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		cardInfo = cardInfoService.getCardInfoByCardNo(userCardInfo.getCardNo());
		if (cardInfo != null) {// 当卡信息表中有此卡号信息时更新用户类型
			cardInfo.setUserCardType(userCardInfo.getUserCardType());
			cardInfoService.update(cardInfo);
		}
		userCardInfoTemp = userCardInfoService.getUserCardInfoByRecNO(userCardInfo.getRecNO());// 根据用户编号获得其用户卡信息对象
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
			userCardBillTemp = userCardBillService.getUserCardBillMaxEndTimeByRecNO(userCardInfo.getRecNO());// 查找出当前用户编号用户缴费中最大endTime的对象
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
		if (!param_whtherPayType.getPvalue().equals("1")) {// whtherPayType的值为0时，就是有缴费类型时
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
						// 出现异常插入系统日志表
						systemLogService.save(new Date(), 2, admin, "ParkCardAction中update()获得图片输入流的时候发生异常", e.getMessage(), "Exception");
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
					// 出现异常插入系统日志表
					systemLogService.save(new Date(), 2, admin, "ParkCardAction中update()获得图片输入流的时候发生异常", e.getMessage(), "Exception");
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

		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		result = Result.SUCCESS1;
		cardNo = userCardInfoTemp.getCardNo();
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户修改用户编号[" + userCardInfo.getRecNO() + "]小区卡信息成功", "卡票管理--小区卡管理--小区卡信息管理--修改", "tb_UserCardInfo");

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

	// -----------------------------------------------------------上面为小区卡信息修改，下面为小区卡挂失--------------------------------------------------
	public String queryToLossAndRemoveLoss() {// 查询界面以进行挂失或者解挂
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		listUserCardInfo = userCardInfoService.findByPager(pager);
		this.getSomeObjec();
		userCardInfo = null;
		return "queryToLossAndRLoss";
	}

	public String queryToLossAndRLoss() {// 查询用户卡信息以挂失获得解挂
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		// 需要param_whtherPayType.getPvalue()传值，有缴费卡类型和没有缴费卡类型查询不一样
		listUserCardInfo = userCardInfoService.findAllItemByHql(pager, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue(), null, deleteBlankSpace(userCardInfo.getMobileNumber()),userCardInfo.getCarType(),deleteBlankSpace(userCardInfo.getParkingSpace()),userCardInfo.getOwnerIdentity());
		this.getSomeObjec();
		return "queryToLossAndRLoss";
	}

	public String parkCardLoss() {// 挂失操作，修改状态和保存信息到CardOperation (卡业务操作流水)
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
			// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中loss()设置card_type参数时set（），get（）参数时的异常", admin);
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
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户挂失卡号[" + userCardInfo.getCardNo().trim() + "]成功", "卡票管理--小区卡管理--小区卡挂失/解挂--挂失", "tb_UserCardInfo;tb_CardInfo");
		return queryToLossAndRemoveLoss();
	}

	public void InsertStoreCardBlackList(Sysparamconf param_card_type) {
		if ("1".equals(param_card_type.getPvalue())) {// 账户卡类型为写卡时挂失要查储值卡黑名单(tb_StoreCardBlackList)表，有其账户信息先删除再添加，没有则添加
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
					systemLogService.save(new Date(), 2, admin, "AccountAction中loss()对时间1操作时发生的异常", e.getMessage(), "Exception");
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
					systemLogService.save(new Date(), 2, admin, "AccountAction中loss()对时间2操作时发生的异常", e.getMessage(), "Exception");
				}

				storeCardBlackListService.save(storeCardBlackListTemp);
			}
		}
	}

	// -----------------------------------------------------------上面为小区卡挂失，下面为小区卡解挂--------------------------------------------------------
	public String parkCardRemoveLoss() {// 解挂操作，修改状态和保存信息到CardOperation
		// (卡业务操作流水)
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
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中loss()设置card_type参数时set（），get（）参数时的异常", admin);
			if ("1".equals(param_card_type.getPvalue())) {// 卡类型为写卡时解挂要查储值卡黑名单(tb_StoreCardBlackList)表，有其账户信息就删除
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
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		result = Result.SUCCESS1;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户解挂卡号[" + userCardInfo.getCardNo().trim() + "]成功", "卡票管理--小区卡管理--小区卡挂失/解挂--解挂", "tb_UserCardInfo;tb_CardInfo");
		return queryToLossAndRemoveLoss();
	}

	// -----------------------------------------------------------上面为小区卡解挂，下面为小区卡注销--------------------------------------------------------
	public String parkCardCancel() {
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(userCardInfo.getCardNo().trim());
		if (userCardInfo != null) {
			cardGroupService.deleteByCardNo(userCardInfo.getCardNo());// 如果卡号在车位卡分组表中存在，删除其信息。
			securityUserInfoService.deleteByCardNo(userCardInfo.getCardNo());
			securityCommandService.deleteByCardNo(userCardInfo.getCardNo());
			userCardInfoService.delete(userCardInfo);
			if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
				cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
			} else {// 没有缴费类型
				cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
			}
			systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户注销用户编号[" + userCardInfo.getRecNO() + "]小区卡信息成功", "卡票管理--小区卡管理--小区卡信息管理--注销", "tb_UserCardInfo");
		}
		result = Result.SUCCESS2;
		return queryParkCardToManage();
	}

	// -----------------------------------------------------------上面为小区卡注销，下面为小区卡缴费--------------------------------------------------------
	public String queryToPayment() {
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRemoveLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
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
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToRemoveLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
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
		userCardBillTemp = userCardBillService.getUserCardBillMaxEndTimeByRecNO(userCardInfo.getRecNO());// 查找出当前用户编号用户缴费中最大endTime的对象
		// 初始化值
		if (userCardBillTemp == null) {
			userCardBill.setStartTime(Timestamp.valueOf(getDateFristDay(new Date())));// 设置当前系统日期月份的第一天
			//userCardBill.setEndTime(Timestamp.valueOf(getDateAddMonthEndDay(userCardBill.getStartTime().toString(), 0)));// 开始时间加上0个月后的月份最后一天
			userCardBill.setEndTime(Timestamp.valueOf(getAddMountMonthFirstDay(userCardBill.getStartTime().toString(), 1)));// 开始时间加上1个月后的月份的第一天
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			// String timePattern=sdf.format(new Date());
			Date dateTemp;
			Date date;
			Date systemDate = new Date();
			try {
				dateTemp = sdf.parse(sdf.format(systemDate));
				date = sdf.parse(sdf.format(userCardBillTemp.getEndTime()));
				if (dateTemp.compareTo(date) > 0) {// 如果系统的时间大于数据库中费用终止时间那么就用系统时间作为费用启动时间。
					userCardBill.setStartTime(Timestamp.valueOf(getDateFristDay(systemDate)));// 设置当前系统日期月份的第一天
					userCardBill.setEndTime(Timestamp.valueOf(getAddMountMonthFirstDay(userCardBill.getStartTime().toString(), 1)));// 开始时间加上1个月后的月份的第一天
				} else {
					userCardBill.setStartTime(userCardBillTemp.getEndTime());// 最大endTime为启用时间
					userCardBill.setEndTime(Timestamp.valueOf(getAddMountMonthFirstDay(userCardBill.getStartTime().toString(), 1)));// 开始时间加上1个月数后的月份第一天
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
		userCardBill.setAmount((short) 1);// 初始化缴费月份为1
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
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		result = Result.SUCCESS;
		cardNo = userCardInfoTemp.getCardNo();
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户收费编号[" + userCardInfo.getRecNO() + "]用户[" + userCardBill.getMoney() + "]元成功", "卡票管理--小区卡管理--小区卡缴费", "tb_UserCardBill");
		return payment();
	}

	public String deleteByNoAndOptime() {// 删除一条缴费记录
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
				userCardInfoTemp.setPayEndTime(ts);// 没有此账户的缴费记录时设置缴费期限为当前系统的前一天,有记录时等于记录中最大时间
				if (ts.getTime() < stamp.getTime()) {// 记录中最大时间小区当前时间时要设置账户状态为为缴费
					userCardInfoTemp.setStatus((short) 9);
				}
				userCardInfoService.update(userCardInfoTemp);
			}			
			systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户删除用户编号为[" + userCardBill.getUserRecNo() + "]的一条缴费信息", "卡票管理--小区卡管理--小区卡缴费--删除", "tb_UserCardBill");
		}		
		userCardInfo = new UserCardInfo();
		userCardInfo.setRecNO(userCardBill.getUserRecNo());
		return payment();
	}

	public String deleteAllByuserRecNo() {// 删除此用户编号的所有缴费记录
		admin = adminService.get(getCurrentOperator().getId());
		userCardBillService.deleteByUserRecNo(userCardBill.getUserRecNo());
		UserCardInfo userCardInfoTemp = userCardInfoService.getUserCardInfoByRecNO(userCardBill.getUserRecNo());
		if (userCardInfoTemp != null) {
			userCardInfoTemp.setPayEndTime(userCardBillService.getMaxPayEndTimeByRecNO(userCardBill.getUserRecNo()));// 没有此账户的缴费记录时设置缴费期限为当前系统的前一天,有记录时等于记录中最大时间
			userCardInfoTemp.setStatus((short) 9);
			userCardInfoService.update(userCardInfoTemp);
		}
		userCardInfo = new UserCardInfo();
		userCardInfo.setRecNO(userCardBill.getUserRecNo());
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户删除用户编号为[" + userCardBill.getUserRecNo() + "]的所有缴费信息", "卡票管理--小区卡管理--小区卡缴费--删除此用户全部缴费记录", "tb_UserCardBill");
		return payment();
	}

	public String getMoneyAndEndTime() {// 异步设置金额和结束时间
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
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中getCarByVehPlate（）验证车牌是否存在是时发生的异常", e.getMessage(), "IOException");
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
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToRemoveLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);				
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
			if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
				cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
			} else {// 没有缴费类型
				cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
			}						
			result = Result.SUCCESS;
		}	
		this.getSomeObjec();
		listUserCardInfo = userCardInfoService.findAllItemByHqlToPayment(pager, userCardInfo.getCardNo().trim(), userCardInfo.getStatus(), userCardInfo.getUserCardType(), userCardInfo.getVehPlate().trim(), userCardInfo.getOwner().trim(), userCardInfo.getIdcard().trim(), userCardInfo.getFeeRuleType(), param_whtherPayType.getPvalue().trim(),payEndTimeStartstamp, payEndTimestamp, null,userCardInfo.getCarType(), userCardInfo.getParkingSpace(), userCardInfo.getOwnerIdentity());
		return "queryPCToPayment";				
	}

// -----------------------------------------------------------上面为小区卡缴费，下面为车位卡分组管理--------------------------------------------------------
	public String queryToGroup() {// 查询用户卡信息于分组管理
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
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
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToRemoveLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		listUserCardInfo = userCardInfoService.findItemByHql(pager, userCardInfo.getCardNo().trim(), userCardInfo.getVehPlate().trim(), cardGroupInfo.getGroupName().trim(), isGroup, userCardInfo.getUserCardType(), param_whtherPayType.getPvalue());
		this.getSomeObjec();
		return "queryPCToGroup";
	}

	public String queryCGInfoToGroup() {// 按页查询组信息以分组
		userCardInfoTemp = new UserCardInfo();
		userCardInfoTemp.setRecNO(userCardInfo.getRecNO());
		list = cardGroupInfoService.getAllCardGroupInfoByPager(pager);
		return "queryCGInfoToGroup";

	}

	public String queryCGInfo() {// 根据查询条件查询组信息以分组
		if ("".equals(cardGroupInfo.getGroupName().trim()) && null == cardGroupInfo.getGroupNo()) {
			return queryCGInfoToGroup();
		} else {
			userCardInfoTemp = new UserCardInfo();
			userCardInfoTemp.setRecNO(userCardInfo.getRecNO());
			list = cardGroupInfoService.findAllItemByHql(pager, cardGroupInfo.getGroupNo(), cardGroupInfo.getGroupName().trim());
			return "queryCGInfoToGroup";
		}
	}

	public String group() {// 添加进组
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		cardGroupService.deleteByRecNO(userCardInfo.getRecNO());// 先删除，在添加
		userCardInfoTemp = userCardInfoService.getUserCardInfoByRecNO(userCardInfo.getRecNO());
		cardGroup = new CardGroup();
		cardGroup.setRecNo(userCardInfoTemp.getRecNO());
		cardGroup.setCardNo(userCardInfoTemp.getCardNo().trim());
		cardGroup.setVehPlate(userCardInfoTemp.getVehPlate().trim());
		cardGroup.setGroupNo(cardGroupInfo.getGroupNo());
		cardGroup.setFirstInOut(1);
		cardGroup.setOptime(date);
		cardGroup.setLaneGroupNo(1);// 不需要添加车道组编号为2，数据库中有触发器处理
		cardGroupService.save(cardGroup);
		list = cardGroupService.getUserCardInfoAndCardGroupByGroupNoAndLaneGroupNo(pager, cardGroupInfo.getGroupNo(), 1);
		cardGroupInfo = cardGroupInfoService.getCardGroupInfoByGroupNo(cardGroupInfo.getGroupNo());
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户将编号为[" + userCardInfo.getRecNO() + "]的用户添加进组编号[" + cardGroupInfo.getGroupNo() + "]成功", "卡票管理--小区卡管理--车位卡分组管理", "tb_CardGroup");
		return "group";
	}

	public String queryCardGroupInfo() {// 按页查询组信息以进行组信息的增，删，改
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

	public String queryCGInfoToManage() {// 根据输入条件查询组信息以进行组信息的增，删，改
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

	public String addCardGroupInfo() {// 新增组信息界面
		return "addCardGroupInfo";
	}

	public String addCardGroupInfoEdit() {// 新增组信息保存进数据库的操作
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
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户新增组名[" + cardGroupInfoTemp.getGroupName() + "]成功", "卡票管理--小区卡管理--车位卡分组管理--组信息管理", "tb_CardGroupInfo");
		return queryCardGroupInfo();
	}

	public String updateCardGroupInfo() {// 修改组信息界面
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		cardGroupInfo = cardGroupInfoService.getCardGroupInfoByGroupNo(cardGroupInfo.getGroupNo());
		return "updateCardGroupInfo";
	}

	public String updateCardGroupInfoEdit() {// 修改组信息属性的操作
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
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		result = Result.SUCCESS1;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户修改组编号[" + cardGroupInfo.getGroupNo() + "]信息成功", "卡票管理--小区卡管理--车位卡分组管理--组信息管理", "tb_CardGroupInfo");

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

	public String deleteCardGroupInfo() {// 删除组信息
		admin = adminService.get(getCurrentOperator().getId());
		cardGroupInfoService.deleteByGroupNo(cardGroupInfo.getGroupNo());
		cardGroupService.deleteByGroupNo(cardGroupInfo.getGroupNo());// 如果组号在车位卡分组表中存在，删除其信息，以防数据冗余。
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		result = Result.SUCCESS2;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户删除组编号[" + cardGroupInfo.getGroupNo() + "]信息成功", "卡票管理--小区卡管理--车位卡分组管理--组信息管理", "tb_CardGroupInfo");
		return queryCardGroupInfo();
	}

	public String deleteGroupMember() {// 按页显示组信息以删除某组中的组成员
		list = cardGroupInfoService.getAllCardGroupInfoByPager(pager);
		return "deleteGroupMember";
	}

	public String queryPCInfoToDeleteGroupMeber() {// 按条件查询组信息以删除某组中的组成员
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

	public String deleteCardGroup() {// 删除组成员
		admin = adminService.get(getCurrentOperator().getId());
		cardGroupInfo = cardGroupInfoService.getCardGroupInfoByGroupNo(cardGroupInfo.getGroupNo());
		cardGroupService.deleteByRecNO(userCardInfo.getRecNO());
		list = cardGroupService.getUserCardInfoAndCardGroupByGroupNoAndLaneGroupNo(pager, cardGroupInfo.getGroupNo(), 1);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// 有缴费类型时
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else {// 没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "用户删除组编号[" + cardGroupInfo.getGroupNo() + "]中组成员用户编号为[" + userCardInfo.getRecNO() + "]的用户卡成功", "卡票管理--小区卡管理--车位卡分组管理--组信息管理--删除组成员", "tb_CardGroup");
		return "group";
	}

	// -----------------------------------------------------------上面为车位卡分组管理，下面为校区卡历史记录查询--------------------------------------------------------
	public String queryUserCardInfoHistoryToCheck() {
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRemoveLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//查询userCardType不等于0，1，2的用户类型
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		listCarType = carTypeService.getAllCarType();
		listIdentity = ownerIdentityService.getAllOwnerIdentity();
		listCarSmallType = carSmallTypeService.findAllCarSmallType();
		listUserCardInfoHistory = userCardInfoService.findAllUserCardInfoHistoryBySql(pager, null, null, null, null, null, null, null, null, null, null, null, null, null);
		return "queryUserCardInfoHistory";
	}

	public String queryUserCardInfoHistory() {
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp modifyTimestamp = null;// 查询是修改时间modifyTime;//修改时间;
		if (!"".equals(modifyTime) && null != modifyTime) {
			String modifyTimestampTemp = modifyTime + " 23:59:59";
			modifyTimestamp = Timestamp.valueOf(modifyTimestampTemp);
		}
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRemoveLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//查询userCardType不等于0，1，2的用户类型
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
		Timestamp modifyTimestamp = null;// 查询是修改时间modifyTime;//修改时间;
		if (!"".equals(modifyTime) && null != modifyTime) {
			// String modifyTimestampTemp = modifyTime + " 23:59:59";
			modifyTimestamp = Timestamp.valueOf(modifyTime);
		}
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToRemoveLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		param_parkjsp = sysparamconfService.queryOrSave(parkjsp, "hg", parkjsp_remark, "ParkCardAction中queryParkCardToManage()设置parkjsp参数时set（），get（）参数时的异常", admin);
		//listUserCardFeeRuleType = userCardFeeRuleTypeService.getUserCardFeeRuleTypeAndTypeName();
		//listUserCardType =  userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		listUserCardType = userCardTypeService.getUserCardTypeByNotEqualUserCardType((short) 0, (short) 1, (short) 2);//查询userCardType不等于0，1，2的用户类型
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

	// -----------------------------------------------------------上面为校区卡历史记录查询，下面为ajax验证后台函数--------------------------------------------------------
	public String getUserCardInfoByVehPlate() {// jquery验证车牌是否已被注册
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
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中getUserCardInfoByVehPlate（）验证车牌是否存在是时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (userCardInfoTemp == null&& account==null) {
			out.println("success");

		} else {
			out.print("fail");

		}
		return null;
	}

	public String getUserCardInfoByCardNo() {// jquery验证卡号是否已被利用
		userCardInfoTemp = userCardInfoService.getUserCardInfoByCardNo(userCardInfo.getCardNo().trim());
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToRemoveLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
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
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中getUserCardInfoByCardNo（）验证卡号是否存在是时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (userCardInfoTemp != null || idCardInfoTemp != null || account!=null ) {
			out.print("fail");// 此卡已被运用。
		} else if (cardInfo != null && storeCardBlackList == null) {
			if (cardInfo.getStatus() != 0) {
				out.print("statusNoUse");// 界面显示该卡在卡信息中不是正常卡，不能运用
			} else {
				out.println("success");
			}
		} else if (cardInfo != null && storeCardBlackList != null) {
			if (cardInfo.getStatus() == 0) {
				out.print("secondUse");// 界面显示该卡之前已被运用过，不能再被运用
			} else {
				out.print("statusNoUse");// 界面显示该卡在卡信息中不是正常卡，不能运用
			}
		} else if (cardInfo == null && storeCardBlackList != null) {
			out.print("secondUse");// 界面显示该卡之前已被运用过，不能再被运用
		} else if (cardInfo == null && storeCardBlackList == null) {
			out.print("NoRegister");// 界面显示还没进行登记过
		} else {
			out.println("success");
		}
		return null;
	}

	public String getCardInfoByCardNo() {// jquery验证卡号是否在卡信息表中登记过
		cardInfo = cardInfoService.getCardInfoByCardNo(cardInfo.getCardNo().trim());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中getCardInfoByCardNo（）验证卡号是否存在是时发生的异常", e.getMessage(), "IOException");
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
	public String ajaxFeeRuleTypeDefByUserCardType() {// 根据parkNo异步获取tb_FeeRuleTypeDef（收费类型定义表）表中的信息
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

	public String getDateFristDay(Date date) {// 没有缴费信息时当前系统时间月份的第一天
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
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中getDateFristDay（）设置日期第一天时发生的异常", e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
			// TODO Auto-generated catch block

		}
	}

	public String changeDateFormat(Timestamp dateFormat) {// Date的格式"yyyy-MM-dd HH:mm:ss"转换成"yyyy-MM-dd"
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
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中changeDateFormat（Timestamp）date格式转换时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowdate = sdf.format(new Date(0));
			return nowdate;
		}

	}

	/*public String getDateAddMonthFristDay(String date, int mount) {// 有缴费信息时获得数据库中最大endTime月份加mount后的第一天
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
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中getDateAddMonthFristDay（）设置日期第一天时发生的异常", e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
			// TODO Auto-generated catch block

		}
	}

	public String getDateAddMonthEndDay(String date, int mount) {// 日期转换成字符串后加mount个月后的最后一天
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
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中getDateAddMonthEndDay（）设置日期最后一天时发生的异常", e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
			// TODO Auto-generated catch block

		}
	}*/
	public String getAddMountMonthFirstDay(String date,int mount){//日期转换成字符串后加mount个月后的第一天，mount》=1，20110701号加上1个月后的日期是20110801
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
			systemLogService.save(new Date(), 2, admin, "ParkCardAction中getMountMonthFirstDay（）设置日期最后一天时发生的异常", e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
			// TODO Auto-generated catch block

		}
	}

	public boolean find(File f, String name) {// 判断文件是否存在
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
	 * 异步获取图片路径
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
			Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "为查询车道捉拍图片提供路径", "LostCardAction中queryByOpTimeAndVehPlate()设置vehPlate参数时set（），get（）参数时的异常", admin);
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
	 * 查询白名单 jdbc  曾
	 */
	public String queryWhite(){
		userCardTypeList = userCardTypeService.getAllUserCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		list = cardInfoService.queryWhite(pager,cardNo,vehplate,obuId,cardType,status,ownerName,isImage,feeRuleType);
		return "queryWhite";
	}
	/**
	 * 根据条件导出白名单 曾
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
	  	  	response.setContentType("octets/stream");//简单可以设置为信息流
	  	  	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	  	  	String title = "whites"+format.format(new Date())+".xls";
		    response.addHeader("Content-Disposition", "attachment;filename="+title);	      
		    //客户端不缓存
		    response.addHeader("Pragma","no-cache");
		    response.addHeader("Cache-Control","no-cache");
		    ExcelUtil<Object[]> _excelUtil = new ExcelUtil<Object[]>();
		    String[] headers = {"卡表面号","车牌号", "车主姓名", "obu号", "启用时间", "结束时间", "用户卡类型","帐号状态","是否有车辆图片","费率类型"};
	        OutputStream out = response.getOutputStream();
	        //_excelUtil.exportExcel(headers, list, out);
	        _excelUtil.exportExcel("白名单", headers, list, out, "yyyy-MM-dd", 5000, mapUserCard, mapRuleType);
	        systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户导出白名单文件成功", "白名单查询-导出", "白名单"+format.format(new Date())+".xls");
	        out.close();
		    response.reset();
		}catch (IOException e) {
	    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将白名单导出到Excel时抛出的IO异常", "白名单查询-导出", "IOException");
			  e.printStackTrace();
	      }
		return null;
	}
	
	/**
	 * 根据条件导出白名单
	 * 按照用户选择的字段导出
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
		for(int i=0; i<fileds.length; i++){//获取用户选择的字段
			String str = fileds[i].trim();
			if(str.equals("CardNO")){
				headers[count] = "卡表面号";
				count ++;
			}
			else if(str.equals("Status")){
				headers[count] = "卡状态";
				count ++;
			}
			else if(str.equals("Owner")){
				headers[count] = "车主姓名";
				count ++;
			}
			else if(str.equals("OwnerIdentity")){
				headers[count] = "车主身份";
				count ++;
			}
			else if(str.equals("IDCard")){
				headers[count] = "身份证号码";
				count ++;
			}
			else if(str.equals("MobileNumber")){
				headers[count] = "移动电话";
				count ++;
			}
			else if(str.equals("VehPlate")){
				headers[count] = "车牌号";
				count ++;
			}
			
			else if(str.equals("OBU")){
				headers[count] = "obu号";
				count ++;
			}
			else if(str.equals("UserCardType")){
				headers[count] = "用户类型";
				count ++;
			}
			else if(str.equals("PayEndTime")){
				headers[count] = "缴费期限";
				count ++;
			}
			else if(str.equals("carType")){
				headers[count] = "车辆类型";
				count ++;
			}
			else if(str.equals("ParkingSpace")){
				headers[count] = "停车位";
				count ++;
			}
			else if(str.equals("ParkingSpaceNo")){
				headers[count] = "停车位编号";
				count ++;
			}
			else if(str.equals("FeeRuleType")){
				headers[count] = "收费类型";
				count ++;
			}
			else if(str.equals("RegisterTime")){
				headers[count] = "注册时间";
				count ++;
			}
			else if(str.equals("Address")){
				headers[count] = "用户地址";
				count ++;
			}
		}
		Map map = new HashMap();//将查询条件放到map中，方便传参
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
		for(int i=0; i<size; i++){//将车主身份、用户类型、车辆类型、停车场等枚举转化为对应的值
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
					m.put("Status", "正常");
				}else if("1".equals(Status.toString())){
					m.put("Status", "挂失");
				}else if("9".equals(Status.toString())){
					m.put("Status", "未缴费");
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
				//车辆类型存在的时候，才可能存在停车场
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
	  	  	response.setContentType("octets/stream");//简单可以设置为信息流
	  	  	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	  	  	String title = "whites"+format.format(new Date())+".xls";
		    response.addHeader("Content-Disposition", "attachment;filename="+title);	      
		    //客户端不缓存
		    response.addHeader("Pragma","no-cache");
		    response.addHeader("Cache-Control","no-cache");
		    ExcelUtil<Object[]> _excelUtil = new ExcelUtil<Object[]>();
	        OutputStream out = response.getOutputStream();
	        _excelUtil.expExcel("白名单", headers, list, out, 5000, mapUserCard, mapRuleType);
	        systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户导出白名单文件成功", "白名单查询-导出", "白名单"+format.format(new Date())+".xls");
	        out.close();
		}catch (IOException e) {
	    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将白名单导出到Excel时抛出的IO异常", "白名单查询-导出", "IOException");
			  e.printStackTrace();
	      }
		return null;
	}
	
	/**
	 * 打印白名单 曾
	 */
	public String printsWhite(){
		userCardTypeList = userCardTypeService.getAllUserCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		list = cardInfoService.exportWhite(cardNo, vehplate, obuId, cardType, status, ownerName, isImage, feeRuleType);
		return "printsWhite";
	}
	
	
	/**
	 * 组合大门号和车道号的长度
	 */
	public String gateNoAndLaneNo(String temp) {
		String str = "";
		String[] ss = { "0000", "000", "00", "0", "" };
		str = ss[temp.length()] + temp;
		return str;
	}
	
	/**
	 * 打印userCardInfo
	 */
	public String printsUserCardInfo() {
		userCardTypeList = userCardTypeService.getAllUserCardType();
		listFeeRuleTypeDef = feeRuleTypeDefService.getAllFeeRuleTypeDef();
		list = cardInfoService.printUserCardInfo(userCardInfo.getCardNo().trim());
		return "printsUserCardInfo";
	}
	
	/**
	 * 组合月份或日期
	 */
	public String monthAndDay(String temp) {
		String str = "";
		String[] ss = { "00", "0", "" };
		str = ss[temp.length()] + temp;
		return str;
	}
	
	
	/**
	 * 根据车辆类型异步查询车辆类型小分类
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
