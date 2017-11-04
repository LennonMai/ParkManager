package com.hgsoft.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Account;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.CardInfo;
import com.hgsoft.entity.CardOperation;
import com.hgsoft.entity.CardType;
import com.hgsoft.entity.ICCardStorage;
import com.hgsoft.entity.ICCardTransfer;
import com.hgsoft.entity.Operator;
import com.hgsoft.entity.StoreCardBlackList;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.entity.UserCardType;
import com.hgsoft.service.AccountService;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CardInfoSendParaService;
import com.hgsoft.service.CardInfoService;
import com.hgsoft.service.CardOperationService;
import com.hgsoft.service.CardTypeService;
import com.hgsoft.service.ICCardStorageService;
import com.hgsoft.service.ICCardTransferService;
import com.hgsoft.service.OperatorService;
import com.hgsoft.service.StoreCardBlackListService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardInfoService;
import com.hgsoft.service.UserCardTypeService;

@Controller
@Scope("prototype")
public class ICCardAction extends BaseAction {
	private ICCardStorage ICCardStorageTemp;
	private ICCardStorage ICCardStorageRight;
	private ICCardStorage ICCardStorageLeft;
	private ICCardStorage ICCardStoragePosition;
	private Sysparamconf param_whtherPayType;
	private Sysparamconf param_cardInit;
	private Admin admin;
	private ICCardTransfer ICCardTransferTemp;
	private ICCardTransfer ICCardTransferTempOne;
	private int amount;
	private int id;
	private CardInfo cardInfo;
	private CardType cardTypeTemp;
	private Sysparamconf param_card_type;
	
	private CardOperation cardOperation;
	private UserCardInfo userCardInfo;
	private Account account;
	@SuppressWarnings("unchecked")
	private List listTemp;
	@SuppressWarnings("unchecked")
	private List listCardType;
	@SuppressWarnings("unchecked")
	private List listUserCardType;
	
	private List<UserCardType> userCardTypeList;
	@SuppressWarnings("unchecked")
	private List listTypeStatistics;
	@SuppressWarnings("unchecked")
	private List listStatusStatistics;
	
	private int passCardAmount;	
	private int yuetongAmount;
	private Operator operatorTemp;
	private String card_type = "card_type";
	private String card_type_remark = "卡类型参数（0就是根据充值类型为不写卡，1为写卡,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	private String whtherPayType = "whtherPayType";// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
	private String whtherPayType_remark = "是否有缴费类型参数（0表示有缴费类型，1表示没有缴费类型,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	private File txtFile; 
	private int countSuccess;
	private int countFail;
	@Resource
	private ICCardStorageService iCCardStorageService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private AdminService adminService;
	@Resource
	private OperatorService operatorService;
	@Resource
	private ICCardTransferService iCCardTransferService;
	@Resource
	private CardInfoService cardInfoService;
	@Resource
	private CardTypeService cardTypeService;
	@Resource
	private UserCardTypeService userCardTypeService;
	@Resource
	private CardOperationService cardOperationService;
	@Resource
	private CardInfoSendParaService cardInfoSendParaService;
	@Resource
	private UserCardInfoService userCardInfoService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private AccountService accountService;
	@Resource
	private StoreCardBlackListService storeCardBlackListService;

	//caijunhua IC卡注册
	public String register() {
		param_cardInit = sysparamconfService.getSysparamconfByQname("CardInit_path");
		if(null == param_cardInit) {
			param_cardInit = new Sysparamconf();
			param_cardInit.setPname("CardInit_path");
			param_cardInit.setPvalue("C:/IC卡登记程序/CardInit.exe");
			param_cardInit.setPtype(0);//业务参数
			param_cardInit.setRemark("IC卡登记程序路径，初始化设置为C:/IC卡登记程序/CardInit.exe");
			sysparamconfService.save(param_cardInit);
		}
		return "register";
	}
	
	//caijunhua IC卡信息导入数据库
	public String insertTxtData() {
		try {
			String content;
			String cardNo;
			String cardId;
			Short cardType;
			Short status;
			Timestamp opTime;
			countSuccess = 0;
			countFail = 0;
			
			FileReader reader = new FileReader(txtFile);
			BufferedReader br = new BufferedReader(reader);
			
			String title = br.readLine();	//读第一行
			String[] arr = new String[3];
			arr = title.split("\t");
			
			//判断格式
			if(arr[0].equals("CARDNO") && arr[1].equals("CARDID") && arr[2].equals("CARDTYPE")) {
				while((content = br.readLine()) != null) {
					//读内容
					arr = content.split("\t");
					cardNo = arr[0];
					cardId = arr[1];
					cardType = Short.valueOf(arr[2]);
					status = 0;
					opTime = new java.sql.Timestamp(new java.util.Date().getTime());
					countFail = countFail + 1;
					
					//cardNo不存在时插入
					if(null == cardInfoService.getCardInfoByCardNo(cardNo)) {
						cardInfo = new CardInfo();
						cardInfo.setCardNo(cardNo);
						cardInfo.setCardId(cardId);
						cardInfo.setCardType(cardType);
						cardInfo.setStatus(status);
						cardInfo.setOpTime(opTime);
						cardInfo.setUserCardType((short)0);
						try {
							cardInfoService.save(cardInfo);
							countSuccess = countSuccess + 1;
						} catch (Exception e) {
							e.printStackTrace();
						}
						
					}
				}
				countFail = countFail - countSuccess;
			} else {
				result = Result.FAIL;
//				message = "txt文件内容格式不正确，请重新选择！";
				return register();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//修改tb_iCCardStorage
		updateStorage(countSuccess);
		
		result = Result.SUCCESS;
		return register();
	}
	
	//caijunhua IC卡登记后修改tb_iCCardStorage
	public void updateStorage(int success) {
		ICCardStorageTemp = iCCardStorageService.getICCardStorageByPosition(99);
		if(ICCardStorageTemp!=null){
			int amount = ICCardStorageTemp.getAmount() + success;
			ICCardStorageTemp.setAmount(amount);
			iCCardStorageService.update(ICCardStorageTemp);
		}		
	}
	
	//caijunhua IC卡库存统计
	@SuppressWarnings("unchecked")
	public String statistics() {
		//按用户卡类型统计
		listTypeStatistics = new ArrayList();
		//按用户卡状态统计
		listStatusStatistics = new ArrayList();
		//取得所有用户卡类型
		userCardTypeList = userCardTypeService.getAllUserCardType();
		if(userCardTypeList!=null){
			int temp = 0;
			for(int i=0; i<userCardTypeList.size(); i++) {	
				int type = userCardTypeList.get(i).getUserCardType();
				temp = cardInfoService.getTypeStatistics(type);
				listTypeStatistics.add(temp);
			}
			for(int j=0; j<4; j++) {	//4种状态：0正常卡，1挂失，2丢卡，3损坏
				int status = j;
				temp = cardInfoService.getStatusStatistics(status);
				listStatusStatistics.add(temp);
			}
		}		
		return "statistics";
	}
	
	// ---------------------------------------------------------下面为IC卡调拨-------------------------------------------------------------------------
	public String allot() {// IC卡调拨
		list = iCCardStorageService.getICCardStorageAndGatewayInformation();// 获得IC卡库存
		ICCardStoragePosition = iCCardStorageService.getICCardStorageByPosition(99);// 管理中心位置为99
		listTemp = operatorService.getAllOperator();
		return "allot";

	}

	public String getAmount() {// 判断调拨的数量是否大于库存数量
		int amount = ICCardStorageTemp.getAmount();// 从页面传过来的调拨数量。
		ICCardStorageTemp = iCCardStorageService.get(ICCardStorageLeft.getPosition());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			admin = adminService.get(operator.getId());
			systemLogService.save(new Date(), 2, admin, "ICCardActionn中getAmount()判断调拨的数量是否大于库存数量时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (amount <= ICCardStorageTemp.getAmount()) {
			out.println("success");

		} else {
			out.print("fail");

		}
		return null;
	}

	public String allotEdit() {// 调拨提交，修改tb_ICCardStorage(IC卡库存表)中的数量和插入信息到tb_ICCardTransfer(IC卡调拨）
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		amount = ICCardStorageTemp.getAmount();// 从页面传过来的调拨数量。
		ICCardStorageTemp = iCCardStorageService.get(ICCardStorageLeft.getPosition());
		ICCardStorageTemp.setAmount(ICCardStorageTemp.getAmount() - amount);
		iCCardStorageService.update(ICCardStorageTemp);
		ICCardStorageTemp = iCCardStorageService.get(ICCardStorageRight.getPosition());
		ICCardStorageTemp.setAmount(ICCardStorageTemp.getAmount() + amount);
		iCCardStorageService.update(ICCardStorageTemp);
		ICCardTransferTempOne = new ICCardTransfer();
		if (ICCardStorageLeft.getPosition() == 99) {
			ICCardTransferTempOne.setTransferType(2);// 出库
		} else if (ICCardStorageRight.getPosition() == 99) {
			ICCardTransferTempOne.setTransferType(1);// 入库
		} else {
			ICCardTransferTempOne.setTransferType(0);// 车道之间相互调拨
		}
		ICCardTransferTempOne.setAmount(amount);
		ICCardTransferTempOne.setOutPosition(ICCardStorageLeft.getPosition());
		ICCardTransferTempOne.setInPosition(ICCardStorageRight.getPosition());
		ICCardTransferTempOne.setTransactor(id);
		ICCardTransferTempOne.setOperator(getCurrentOperator().getId());
		ICCardTransferTempOne.setOpTime(new Date());
		ICCardTransferTempOne.setRemark(ICCardTransferTemp.getRemark().trim());
		ICCardTransferTempOne.setRecNO(iCCardTransferService.getICCardTransferRecNo());
		iCCardTransferService.save(ICCardTransferTempOne);
		if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else{//没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}		
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户从位置["+ICCardStorageLeft.getPosition()+"]调拨数量["+amount+"]张IC卡到位置["+ICCardStorageRight.getPosition()+"]",
				"卡票管理--IC卡管理--IC卡调拨", "tb_ICCardStorage;tb_ICCardTransfer");
		return allot();
	}

	// ---------------------------------------------------------上面为IC卡调拨，下面为IC卡挂失---------------------------------------------------------

	public String queryToLoss() {
		list = cardInfoService.getAllCardInfoAndCardType(pager);
		listUserCardType = userCardTypeService.getAllUserCardType();
		listTemp = cardTypeService.getAllCardType();
		cardInfo=null;
		return "queryICCardToLoss";
	}

	public String queryICCardToLoss() {		
			list = cardInfoService.findAllItemByHql(pager, cardInfo.getCardNo().trim(), cardInfo.getCardType(), cardInfo.getStatus(),cardInfo.getUserCardType());
			listTemp = cardTypeService.getAllCardType();
			listUserCardType = userCardTypeService.getAllUserCardType();
			return "queryICCardToLoss";
	}

	public String loss() {
		cardInfo = cardInfoService.get(cardInfo.getCardNo().trim());
		cardTypeTemp = cardTypeService.get(cardInfo.getCardType());
		return "loss";
	}

	public String lossEdit() {// 修改卡信息表中的状态和插入一条数据到卡业务操作流水表
		admin = adminService.get(getCurrentOperator().getId());
		// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		cardInfo = cardInfoService.get(cardInfo.getCardNo().trim());
		cardInfo.setStatus((short) 1);
		cardInfo.setOpTime(date);
		cardInfoService.update(cardInfo);
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(cardInfo.getCardNo());
		if (userCardInfo != null) {
			userCardInfo.setStatus((short) 1);
			userCardInfoService.update(userCardInfo);
		}
		account = accountService.getAccount(cardInfo.getCardNo().trim());
		if(account!=null){;
			account.setStatus(1);
			account.setStatusUpdateTime(new Date());
			accountService.update(account);
			// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中loss()设置card_type参数时set（），get（）参数时的异常", admin);
			this.InsertStoreCardBlackList(param_card_type);
		}	
		String remark = cardOperation.getRemark();// 从界面传过来的挂失原因
		cardOperation = new CardOperation();
		cardOperation.setCardNO(cardInfo.getCardNo());
		cardOperation.setCardType(cardInfo.getCardType().intValue());
		cardOperation.setCardOperate(1);
		cardOperation.setOpTime(date);
		cardOperation.setOperator(getCurrentOperator().getId());
		cardOperation.setRemark(remark);
		cardOperation.setUserCardType(cardInfo.getUserCardType());
		cardOperationService.save(cardOperation);
		if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else{//没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}		
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户挂失卡号["+cardInfo.getCardNo()+"]成功",
				"卡票管理--IC卡管理--IC卡挂失", "tb_CardInfo;tb_UserCardInfo ");
		return queryToLoss();
	}

	// ---------------------------------------------------------上面为IC卡挂失，下面为IC卡解挂---------------------------------------------------------

	public String queryToRemoveLoss() {
		list = cardInfoService.getAllCardInfoAndCardType(pager);
		listUserCardType = userCardTypeService.getAllUserCardType();
		listTemp = cardTypeService.getAllCardType();
		cardInfo=null;
		return "queryICToRemoveLoss";
	}

	public String queryICToRemoveLoss() {
			list = cardInfoService.findAllItemByHql(pager, cardInfo.getCardNo().trim(), cardInfo.getCardType(), cardInfo.getStatus(),cardInfo.getUserCardType());
			listUserCardType = userCardTypeService.getAllUserCardType();
			listTemp = cardTypeService.getAllCardType();
			return "queryICToRemoveLoss";
	}

	public String removeLoss() {// 修改卡信息表中的状态和插入一条数据到卡业务操作流水表
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		cardInfo = cardInfoService.get(cardInfo.getCardNo());
		cardInfo.setStatus((short) 0);
		cardInfo.setOpTime(date);
		cardInfoService.update(cardInfo);
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(cardInfo.getCardNo().trim());
		if (userCardInfo != null) {
			userCardInfo.setStatus((short) 0);
			userCardInfoService.update(userCardInfo);
		}
		account = accountService.getAccount(cardInfo.getCardNo().trim());
		if(account!=null){
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
		cardOperation.setCardNO(cardInfo.getCardNo());
		cardOperation.setCardType(cardInfo.getCardType().intValue());
		cardOperation.setCardOperate(2);
		cardOperation.setOpTime(date);
		cardOperation.setOperator(getCurrentOperator().getId());
		cardOperation.setUserCardType(cardInfo.getUserCardType());
		cardOperationService.save(cardOperation);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else{//没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}	
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户解挂卡号["+cardInfo.getCardNo()+"]成功",
				"卡票管理--IC卡管理--IC卡解挂", "tb_CardInfo;tb_UserCardInfo ");
		return queryToRemoveLoss();
	}
	// ---------------------------------------------------------上面为IC卡解挂，下面为IC卡查询---------------------------------------------------------
	public String queryICCard(){
		list = cardInfoService.getAllCardInfoAndCardType(pager);
		listTemp = iCCardStorageService.getICCardStorageAndGatewayInformation();// 获得IC卡库存
		listCardType = cardTypeService.getAllCardType();
		listUserCardType = userCardTypeService.getAllUserCardType();
		ICCardStoragePosition = iCCardStorageService.getICCardStorageByPosition(99);// 管理中心位置为99
		passCardAmount=cardInfoService.getCardAmountByTypeName("通行卡");
		yuetongAmount=cardInfoService.getCardAmountByTypeName("粤通卡");
		return "queryICCard";
	}
	public String queryICCardToCheck(){		
			list = cardInfoService.findAllItemByHql(pager, cardInfo.getCardNo().trim(), cardInfo.getCardType(), cardInfo.getStatus(),cardInfo.getUserCardType());
			listTemp = iCCardStorageService.getICCardStorageAndGatewayInformation();// 获得IC卡库存
			listCardType = cardTypeService.getAllCardType();
			listUserCardType = userCardTypeService.getAllUserCardType();
			ICCardStoragePosition = iCCardStorageService.getICCardStorageByPosition(99);// 管理中心位置为99
			passCardAmount=cardInfoService.getCardAmountByTypeName("通行卡");
			yuetongAmount=cardInfoService.getCardAmountByTypeName("粤通卡");
			return "queryICCard";
	}
   public void InsertStoreCardBlackList(Sysparamconf param_card_type){
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

	public String ajaxgetStoreCardBlackListByCardNoToLoss() {// jquery验证卡号是否已被利用
		StoreCardBlackList storeCardBlackList = storeCardBlackListService.get(cardInfo.getCardNo().trim());
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
		if (storeCardBlackList != null) {			
			out.print("secondUse");// 该卡处于储值卡黑名单中，不能再运用
		} else {
			out.println("success");
		}
		return null;
	}
	public String ajaxgetStoreCardBlackListByCardNoToReMoveLoss() {// jquery验证卡号是否已被利用
		StoreCardBlackList storeCardBlackList = storeCardBlackListService.get(cardInfo.getCardNo().trim());
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
		if (storeCardBlackList != null) {
			if("2".equals(storeCardBlackList.getGenCau().trim())){
				out.print("secondUseTwo");// 该卡之前已被运用过，不能再运用
			} else{
				out.println("success");
			}
			
		} else {
			out.println("success");
		}
		return null;
	}
	// get,set函数
	public ICCardStorage getICCardStorageTemp() {
		return ICCardStorageTemp;
	}

	public void setICCardStorageTemp(ICCardStorage iCCardStorageTemp) {
		ICCardStorageTemp = iCCardStorageTemp;
	}

	public ICCardStorage getICCardStorageLeft() {
		return ICCardStorageLeft;
	}

	public void setICCardStorageLeft(ICCardStorage iCCardStorageLeft) {
		ICCardStorageLeft = iCCardStorageLeft;
	}

	public ICCardStorage getICCardStorageRight() {
		return ICCardStorageRight;
	}

	public void setICCardStorageRight(ICCardStorage iCCardStorageRight) {
		ICCardStorageRight = iCCardStorageRight;
	}

	public ICCardTransfer getICCardTransferTemp() {
		return ICCardTransferTemp;
	}

	public void setICCardTransferTemp(ICCardTransfer iCCardTransferTemp) {
		ICCardTransferTemp = iCCardTransferTemp;
	}

	public ICCardTransfer getICCardTransferTempOne() {
		return ICCardTransferTempOne;
	}

	public void setICCardTransferTempOne(ICCardTransfer iCCardTransferTempOne) {
		ICCardTransferTempOne = iCCardTransferTempOne;
	}

	@SuppressWarnings("unchecked")
	public List getListTemp() {
		return listTemp;
	}

	@SuppressWarnings("unchecked")
	public void setListTemp(List listTemp) {
		this.listTemp = listTemp;
	}

	public Operator getOperatorTemp() {
		return operatorTemp;
	}

	public void setOperatorTemp(Operator operatorTemp) {
		this.operatorTemp = operatorTemp;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public ICCardStorageService getiCCardStorageService() {
		return iCCardStorageService;
	}

	public void setiCCardStorageService(ICCardStorageService iCCardStorageService) {
		this.iCCardStorageService = iCCardStorageService;
	}

	public SystemLogService getSystemLogService() {
		return systemLogService;
	}

	public void setSystemLogService(SystemLogService systemLogService) {
		this.systemLogService = systemLogService;
	}

	public AdminService getAdminService() {
		return adminService;
	}

	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}

	public OperatorService getOperatorService() {
		return operatorService;
	}

	public void setOperatorService(OperatorService operatorService) {
		this.operatorService = operatorService;
	}

	public ICCardTransferService getiCCardTransferService() {
		return iCCardTransferService;
	}

	public void setiCCardTransferService(ICCardTransferService iCCardTransferService) {
		this.iCCardTransferService = iCCardTransferService;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public ICCardStorage getICCardStoragePosition() {
		return ICCardStoragePosition;
	}

	public void setICCardStoragePosition(ICCardStorage iCCardStoragePosition) {
		ICCardStoragePosition = iCCardStoragePosition;
	}

	public CardInfo getCardInfo() {
		return cardInfo;
	}

	public void setCardInfo(CardInfo cardInfo) {
		this.cardInfo = cardInfo;
	}

	public CardType getCardTypeTemp() {
		return cardTypeTemp;
	}

	public void setCardTypeTemp(CardType cardTypeTemp) {
		this.cardTypeTemp = cardTypeTemp;
	}

	public CardOperation getCardOperation() {
		return cardOperation;
	}

	public void setCardOperation(CardOperation cardOperation) {
		this.cardOperation = cardOperation;
	}

	public UserCardInfo getUserCardInfo() {
		return userCardInfo;
	}

	public void setUserCardInfo(UserCardInfo userCardInfo) {
		this.userCardInfo = userCardInfo;
	}
	@SuppressWarnings("unchecked")
	public List getListCardType() {
		return listCardType;
	}

	@SuppressWarnings("unchecked")
	public void setListCardType(List listCardType) {
		this.listCardType = listCardType;
	}
	public int getPassCardAmount() {
		return passCardAmount;
	}

	public void setPassCardAmount(int passCardAmount) {
		this.passCardAmount = passCardAmount;
	}

	public int getYuetongAmount() {
		return yuetongAmount;
	}

	public void setYuetongAmount(int yuetongAmount) {
		this.yuetongAmount = yuetongAmount;
	}
	
	@SuppressWarnings("unchecked")
	public List getListUserCardType() {
		return listUserCardType;
	}
	@SuppressWarnings("unchecked")
	public void setListUserCardType(List listUserCardType) {
		this.listUserCardType = listUserCardType;
	}

	public Sysparamconf getParam_cardInit() {
		return param_cardInit;
	}
	public void setParam_cardInit(Sysparamconf param_cardInit) {
		this.param_cardInit = param_cardInit;
	}

	public File getTxtFile() {
		return txtFile;
	}

	public void setTxtFile(File txtFile) {
		this.txtFile = txtFile;
	}

	public int getCountSuccess() {
		return countSuccess;
	}

	public void setCountSuccess(int countSuccess) {
		this.countSuccess = countSuccess;
	}

	public int getCountFail() {
		return countFail;
	}

	public void setCountFail(int countFail) {
		this.countFail = countFail;
	}

	@SuppressWarnings("unchecked")
	public List getListTypeStatistics() {
		return listTypeStatistics;
	}
	@SuppressWarnings("unchecked")
	public void setListTypeStatistics(List listTypeStatistics) {
		this.listTypeStatistics = listTypeStatistics;
	}
	
	@SuppressWarnings("unchecked")
	public List getListStatusStatistics() {
		return listStatusStatistics;
	}
	@SuppressWarnings("unchecked")
	public void setListStatusStatistics(List listStatusStatistics) {
		this.listStatusStatistics = listStatusStatistics;
	}

	public List<UserCardType> getUserCardTypeList() {
		return userCardTypeList;
	}
	public void setUserCardTypeList(List<UserCardType> userCardTypeList) {
		this.userCardTypeList = userCardTypeList;
	}

}
