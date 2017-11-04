package com.hgsoft.action;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.Account;
import com.hgsoft.entity.AccountTrade;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.CardInfo;
import com.hgsoft.entity.StoreCardBlackList;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.UpdateAccountLog;
import com.hgsoft.entity.User;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.service.AccountSendParaService;
import com.hgsoft.service.AccountService;
import com.hgsoft.service.AccountTradeService;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CarService;
import com.hgsoft.service.CardInfoService;
import com.hgsoft.service.StoreCardBlackListService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UpdateAccountLogService;
import com.hgsoft.service.UserCardInfoService;
import com.hgsoft.service.UserService;
import com.hgsoft.util.HashUtil;

@Controller
@Scope("prototype")
public class AccountAction extends BaseAction {
	private int cardType1;
	private String cardNo1;
	private User user;
	private User userTemp;
	private Car car;
	private Car carTemp;
	private Admin admin;
	private Account account;
	private Account accountTemp;
	private CardInfo cardInfo;
	private UserCardInfo userCardInfo;
	private UpdateAccountLog updateAccountLog;
	private Sysparamconf param_cardRechargeSystem_path;
	private Sysparamconf param_endAccount_amongTime;
	private Sysparamconf param_card_type;
	private Sysparamconf param_accountCardNoLength;
	private AccountTrade accountTrade;
	private StoreCardBlackList storeCardBlackList;
	private Integer addAccount_NoEntryBalance;
	private Integer addAccount_LowBalanceNotice;
	private Double cost;
	private Double fee;
	private int sys_id;
	private String card_type = "card_type";
	private String card_type_remark = "卡类型参数（0就是根据充值类型为不写卡，1为写卡,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	@Resource
	private UserService userService;
	@Resource
	private CarService carService;
	@Resource
	private AccountService accountService;
	@Resource
	private UpdateAccountLogService updateAccountLogService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private AccountTradeService accountTradeService;
	@Resource
	private StoreCardBlackListService storeCardBlackListService;
	@Resource
	private AccountSendParaService accountSendParaService;
	@Resource
	private AdminService adminService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private CardInfoService cardInfoService;
	@Resource
	private UserCardInfoService userCardInfoService;
	private String CardRechargeSystem_path = "CardRechargeSystem_path";
	private String CardRechargeSystem_remark = "充值类型为写卡时充值和冲正软件路径，没设置是初始化为C:/充值和冲正/CardRechargeSystem.exe";

	public double mul(double d1, double d2) { // 精度结算转换，不用这个函数会出错，比如：41070.7(double型)*100会出错
		BigDecimal bd1 = null;
		BigDecimal bd2 = null;
		try {
			bd1 = new BigDecimal(Double.toString(d1));
			bd2 = new BigDecimal(Double.toString(d2));
			return bd1.multiply(bd2).doubleValue();
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "AccountAction中mul(double d1,double d2)精度结算转换时发生的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
			e.printStackTrace();
			return 0;
		}

	}

	public String deleteFirstZero(String s) {// 去掉卡号前面的0
		int j = s.length();
		int i;
		int k = 0;
		try {
			for (i = 0; i < j; i++) {
				if (s.charAt(0) == '0') {
					s = s.substring(1, s.length());
					k = k + 1;
					if (k == j) {
						s = "";
					}
				} else {
					break;
				}
			}
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "AccountAction中deleteFirstZero(String s)去掉卡号前面的0时发生异常", e.getMessage(), "StringIndexOutOfBoundsException（字符越界异常）");
			e.printStackTrace();
		}

		return s;

	}

	public AccountAction() {
		updateAccountLog = new UpdateAccountLog();
		accountTrade = new AccountTrade();

	}

	public String balanceQuery() {
		list = accountService.findByPager(pager);
		return "balanceQuery";

	}

	public String queryAccountToBalanceQuery() {// 查询账户
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return balanceQuery();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), null, user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
			return "balanceQuery";

		}
	}

	public String queryToPayment() {// 分页查询所有的账户
		list = accountService.findByPager(pager);
		return "queryToPayment";

	}

	public String queryAccountToPayment() {// 输入条件查询账户
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return queryToPayment();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
		}

		return "queryToPayment";

	}

	public String payment() {
		// 设置充值，冲正外部程序的路径
		param_cardRechargeSystem_path = sysparamconfService.queryOrSave(CardRechargeSystem_path, "C:/充值和冲正/CardRechargeSystem.exe", CardRechargeSystem_remark, "AccountTradeAction中correct()设置CardRechargeSystem_path参数时set（），get（）参数时的异常", admin);
		try {
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
		} catch (Exception e) {
			param_cardRechargeSystem_path.setPvalue("C:/充值和冲正/CardRechargeSystem.exe");
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
			admin = adminService.get(getCurrentOperator().getId());
			// 出现异常插入系统日志表
			systemLogService.save(new Date(), 2, admin, "AccountAction中payment()设置CardRechargeSystem_path参数时set（），get（）参数时的异常", e.getMessage(), "Exception");

		}
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中payment()设置card_type参数时set（），get（）参数时的异常", admin);
		account = accountService.get(account.getSys_id());
		return "payment";

	}

	public String paymentEdit() {// 账户卡类型，0为根据充值分为不写卡时充值，插入交易流水表
		admin = adminService.get(getCurrentOperator().getId());
		String s = "";
		int seqNo = 0;
		account = accountService.get(account.getSys_id());
		accountTrade.setAccount(account);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		String nowdate = sdf.format(date);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		try {
			// 从12个流水流水表中根据月份查询其中一个，以获得该帐号的交易流水序号
			seqNo = accountTradeService.getSeqNoByTwelveAccountTrade(calendar.get(Calendar.MONTH) + 1, account.getSys_id());
		} catch (Exception e) {
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "AccountAction中paymentEdit（）时获得交易流水表序号时发生的异常", e.getMessage(), "Exception");
			e.printStackTrace();
		}
		accountTrade.setSeqNo(seqNo);
		accountTrade.setTradeType(1);
		accountTrade.setCardNo(account.getCardNo());
		accountTrade.setCardType(account.getCardType());
		accountTrade.setTradeTime(nowdate);
		Double fee1 = mul(fee, 100.0);// 注意精度问题，不用mul(fee,100.0)double*100精度不对，例如41070.7*100
		int fee2 = fee1.intValue();
		accountTrade.setFee(fee2);
		accountTrade.setBalance(account.getBalance() + fee2);
		accountTrade.setCardBalance(0);
		accountTrade.setBackoutedMark(1);
		accountTrade.setParkNo(account.getParkNo());
		accountTrade.setVehPlate(account.getCar().getVehPlate());
		accountTrade.setOpTime(nowdate);
		accountTrade.setOperatorID(getCurrentOperator().getId());
		accountTrade.setOperatorPassword(getCurrentOperator().getPassword());
		
		try {
			// 设置交易流水号，格式为TyyyyMMddHHmmssSSS_操作员编号
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String nowdate1 = sdf1.format(new Date());
			s = "T" + nowdate1 + "_" + getCurrentOperator().getId().toString();
		} catch (Exception e) {
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "AccountAction中paymentEdit（）时获得交易流水号时发生的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
			e.printStackTrace();
		}
		accountTrade.setListNo(s);
		// 去掉null
		String yanzheng = accountTradeService.deleteNull(account.getSys_id(), accountTrade.getSeqNo(), accountTrade.getTradeType(), accountTrade.getFee(), accountTrade.getBalance(), accountTrade.getCardNo().trim(), accountTrade.getCardType(), accountTrade.getVehPlate().trim(), accountTrade.getListNo().trim(), getCurrentOperator().getId(), getCurrentOperator().getPassword().trim(), accountTrade.getTradeTime(), accountTrade.getOpTime());
		String yanzhengTemp = HashUtil.getMD5String(yanzheng);// md5密匙，目的是查询有没有修改过这条交易信息
		accountTrade.setVerify(yanzhengTemp);
		accountTradeService.save(accountTrade);
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户充值成功，流水号为："+accountTrade.getListNo(),
				"缴费卡账户管理--充值", "t_park_accountTrade");
		// 账户信息下发车道
		accountSendParaService.SendPara();
		return "printPaymentAccount";

	}

	public String printPayment() {

		return "printPayment";

	}

	// ===================================下面为挂失操作=====================================================================
	public String queryToLoss() {// 挂失查询，分页查询，查出所有的信息
		list = accountService.findByPager(pager);
		return "queryToLoss";
	}

	public String queryAccountToLoss() {// 查出你所要挂失的账户
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return queryToLoss();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
			return "queryToLoss";
		}
	}

	public String loss() {// 挂失操作，把账户状态修改为”挂失“状态和插入更改账户日志表中
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		account = accountService.get(account.getSys_id());
		user = account.getUser();
		car = account.getCar();
		account.setStatus(1);
		account.setStatusUpdateTime(new Date());
		accountService.update(account);
		cardInfo = cardInfoService.get(account.getCardNo().trim());
		if (cardInfo != null) {
			cardInfo.setStatus((short) 1);
			cardInfo.setOpTime(date);
			cardInfoService.update(cardInfo);
		}
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(account.getCardNo().trim());
		if (userCardInfo != null) {
			userCardInfo.setStatus((short) 1);
			userCardInfoService.update(userCardInfo);
		}
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(account.getSys_id());
		updateAccountLog.setAccountNo(account.getSys_id());
		updateAccountLog.setSeqNo(seqNo);
		updateAccountLog.setStatus(account.getStatus());
		updateAccountLog.setCardNo(account.getCardNo());
		updateAccountLog.setCost(account.getCost());
		updateAccountLog.setLowestBalanceAfterConsume(account.getLowestBalanceAfterConsume());
		updateAccountLog.setTollyLowestBalanceAC(account.getTollyLowestBalanceAC());
		updateAccountLog.setNoEntryBalance(account.getNoEntryBalance());
		updateAccountLog.setLowBalanceNotice(account.getLowBalanceNotice());
		updateAccountLog.setOpenAccountTime(account.getOpenAccountTime());
		updateAccountLog.setStatusUpdateTime(account.getStatusUpdateTime());
		updateAccountLog.setRemark(account.getRemark());
		updateAccountLog.setUser_id(user.getSys_id());
		updateAccountLog.setUserName(user.getUserName());
		updateAccountLog.setCredentialsType(user.getCredentialsType());
		updateAccountLog.setCredentialsNo(user.getCredentialsNo());
		updateAccountLog.setPhone(user.getPhone());
		updateAccountLog.setMobileNumber(user.getMobileNumber());
		updateAccountLog.setAddress(user.getAddress());
		updateAccountLog.setCar_id(car.getSys_id());
		updateAccountLog.setVehPlate(car.getVehPlate());
		updateAccountLog.setCarType(car.getCarType());
		updateAccountLog.setCarColour(car.getCarColour());
		updateAccountLog.setUpdateTime(new Date());
		updateAccountLog.setOperator_id(getCurrentOperator().getId());
		updateAccountLog.setOperatorName(getCurrentOperator().getName());
		updateAccountLog.setPrintNumber(0);
		updateAccountLogService.save(updateAccountLog);
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中loss()设置card_type参数时set（），get（）参数时的异常", admin);
		if ("1".equals(param_card_type.getPvalue())) {// 账户卡类型为写卡时挂失要查储值卡黑名单(tb_StoreCardBlackList)表，有其账户信息先删除再添加，没有则添加
			storeCardBlackList = storeCardBlackListService.getStoreCardBlackListByCardNo(account.getCardNo());
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

		// System.out.println(sysparamconf.getPvalue());
		// 卡类型为不写卡时区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}

		return "printLossAccount";

	}

	public String printLoss() {
		account = accountService.get(account.getSys_id());
		user = account.getUser();
		car = account.getCar();
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(account.getSys_id());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);
		updateAccountLogService.update(updateAccountLog);
		return "printLoss";
	}

	// ===================================上面为挂失操作，下面为解挂操作=====================================================================
	public String queryToRemoveLoss() {
		list = accountService.findByPager(pager);
		return "queryToRemoveLoss";
	}

	public String queryAccountToRemoveLoss() {
		if (null == account.getSys_id() && "".equals(account.getCardNo()) && null == user.getSys_id() && "".equals(user.getUserName()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo()) && null == car.getSys_id() && "".equals(car.getVehPlate()) && null == account.getStatus()) {
			return queryToRemoveLoss();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo(), user.getUserName(), user.getCredentialsType(), user.getCredentialsNo(), car.getVehPlate(), account.getStatus(),null);
			// if(list.isEmpty()){result = Result.FAIL4;}
			return "queryToRemoveLoss";
		}
	}

	public String removeLoss() {// 解挂操作，把账户状态修改为”有效“状态和插入更改账户日志表中
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中removeLoss()设置card_type参数时set（），get（）参数时的异常", admin);
		account = accountService.get(account.getSys_id());
		user = account.getUser();
		car = account.getCar();
		account.setStatus(0);
		account.setStatusUpdateTime(new Date());
		accountService.update(account);
		cardInfo = cardInfoService.get(account.getCardNo().trim());
		if (cardInfo != null) {
			cardInfo.setStatus((short) 0);
			cardInfo.setOpTime(date);
			cardInfoService.update(cardInfo);
		}
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(account.getCardNo().trim());
		if (userCardInfo != null) {
			userCardInfo.setStatus((short) 0);
			userCardInfoService.update(userCardInfo);
		}
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(account.getSys_id());
		updateAccountLog.setAccountNo(account.getSys_id());
		updateAccountLog.setSeqNo(seqNo);
		updateAccountLog.setStatus(account.getStatus());
		updateAccountLog.setCardNo(account.getCardNo());
		updateAccountLog.setCost(account.getCost());
		updateAccountLog.setLowestBalanceAfterConsume(account.getLowestBalanceAfterConsume());
		updateAccountLog.setTollyLowestBalanceAC(account.getTollyLowestBalanceAC());
		updateAccountLog.setNoEntryBalance(account.getNoEntryBalance());
		updateAccountLog.setLowBalanceNotice(account.getLowBalanceNotice());
		updateAccountLog.setOpenAccountTime(account.getOpenAccountTime());
		updateAccountLog.setStatusUpdateTime(account.getStatusUpdateTime());
		updateAccountLog.setRemark(account.getRemark());
		updateAccountLog.setUser_id(user.getSys_id());
		updateAccountLog.setUserName(user.getUserName());
		updateAccountLog.setCredentialsType(user.getCredentialsType());
		updateAccountLog.setCredentialsNo(user.getCredentialsNo());
		updateAccountLog.setPhone(user.getPhone());
		updateAccountLog.setMobileNumber(user.getMobileNumber());
		updateAccountLog.setAddress(user.getAddress());
		updateAccountLog.setCar_id(car.getSys_id());
		updateAccountLog.setVehPlate(car.getVehPlate());
		updateAccountLog.setCarType(car.getCarType());
		updateAccountLog.setCarColour(car.getCarColour());
		updateAccountLog.setUpdateTime(new Date());
		updateAccountLog.setOperator_id(getCurrentOperator().getId());
		updateAccountLog.setOperatorName(getCurrentOperator().getName());
		updateAccountLog.setPrintNumber(0);
		updateAccountLogService.save(updateAccountLog);
		// System.out.println(sysparamconf6.getPvalue());
		// 卡类型为不写卡时账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		if ("1".equals(param_card_type.getPvalue())) {// 卡类型为写卡时解挂要查储值卡黑名单(tb_StoreCardBlackList)表，有其账户信息就删除
			storeCardBlackList = storeCardBlackListService.getStoreCardBlackListByCardNo(account.getCardNo());
			if (storeCardBlackList == null) {

			} else {
				storeCardBlackListService.delete(storeCardBlackList);
			}
		}
		return "printRemoveLossAccount";
	}

	public String printRemoveLoss() {
		account = accountService.get(account.getSys_id());
		user = account.getUser();
		car = account.getCar();
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(account.getSys_id());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);
		updateAccountLogService.update(updateAccountLog);
		return "printRemoveLoss";
	}

	// =============================上面为解挂操作，下面为换卡操作=========================================================
	public String queryToExchangeCard() {
		list = accountService.findByPager(pager);
		return "queryToExchangeCard";
	}

	public String queryAccountToExchangeCard() {
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return queryToExchangeCard();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
			// if(list.isEmpty()){result = Result.FAIL4;}
			return "queryToExchangeCard";
		}
	}

	public String exchangeCard() {
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中exchangeCard()设置card_type参数时set（），get（）参数时的异常", admin);
		param_cardRechargeSystem_path = sysparamconfService.queryOrSave(CardRechargeSystem_path, "C:/充值和冲正/CardRechargeSystem.exe", CardRechargeSystem_remark, "AccountAction中exchangeCard()设置CardRechargeSystem_path参数时set（），get（）参数时的异常", admin);
		try {
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
		} catch (Exception e) {
			param_cardRechargeSystem_path.setPvalue("C:/充值和冲正/CardRechargeSystem.exe");
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
			admin = adminService.get(getCurrentOperator().getId());
			// 出现异常插入系统日志表
			systemLogService.save(new Date(), 2, admin, "AccountTradeAction中exchangeCard()设置CardRechargeSystem_path参数时set（），get（）参数时的异常", e.getMessage(), "Exception");

		}
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "缴费卡账户管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值。例如：值为9则卡号长度只能为9）。", "AccountAction中exchangeCard()设置accountCardNoLength参数时的异常", admin);		
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue().trim());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中add()设置param_accountCardNoLength参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}	
		if (accountService.get(account.getSys_id()) != null) {
			account = accountService.get(account.getSys_id());
			return "exchangeCard";
		} else {
			return queryToExchangeCard();
		}

	}

	public String updateAccountOrSavaLog() {// 换卡操作并插入更改账户日志表中
		Double costDouble = mul(cost, 100.0);// 注意精度问题，不用mul(fee,100.0)double*100精度不对，例如41070.7*100
		int costTemp = costDouble.intValue();
		if (!cardNo1.equals(this.deleteFirstZero(account.getCardNo().trim()))) {// 修改卡号不能与数据库中的任何一个卡号相同（销户的除外）
			accountTemp = accountService.getAccount(this.deleteFirstZero(account.getCardNo().trim()));
			if (null != accountTemp) {
				result = Result.FAIL;
				return exchangeCard();
			}
		}
		accountTemp = accountService.getAccount(cardNo1.trim());
		String cardNo = this.deleteFirstZero(account.getCardNo().trim());
		accountTemp.setCardNo(cardNo.trim());
		accountTemp.setCost(costTemp);
		accountService.update(accountTemp);
		updateAccountLog.setAccountNo(accountTemp.getSys_id());
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(accountTemp.getSys_id());
		updateAccountLog.setSeqNo(seqNo);
		updateAccountLog.setStatus(accountTemp.getStatus());
		updateAccountLog.setCardNo(accountTemp.getCardNo());
		updateAccountLog.setCost(costTemp);
		updateAccountLog.setLowestBalanceAfterConsume(accountTemp.getLowestBalanceAfterConsume());
		updateAccountLog.setTollyLowestBalanceAC(accountTemp.getTollyLowestBalanceAC());
		updateAccountLog.setNoEntryBalance(accountTemp.getNoEntryBalance());
		updateAccountLog.setLowBalanceNotice(accountTemp.getLowBalanceNotice());
		updateAccountLog.setOpenAccountTime(accountTemp.getOpenAccountTime());
		updateAccountLog.setStatusUpdateTime(accountTemp.getStatusUpdateTime());
		updateAccountLog.setRemark(accountTemp.getRemark());
		updateAccountLog.setUser_id(accountTemp.getUser().getSys_id());
		updateAccountLog.setUserName(accountTemp.getUser().getUserName());
		updateAccountLog.setCredentialsType(accountTemp.getUser().getCredentialsType());
		updateAccountLog.setCredentialsNo(accountTemp.getUser().getCredentialsNo());
		updateAccountLog.setPhone(accountTemp.getUser().getPhone());
		updateAccountLog.setMobileNumber(accountTemp.getUser().getMobileNumber());
		updateAccountLog.setAddress(accountTemp.getUser().getAddress());
		updateAccountLog.setCar_id(accountTemp.getCar().getSys_id());
		updateAccountLog.setVehPlate(accountTemp.getCar().getVehPlate());
		updateAccountLog.setCarType(accountTemp.getCar().getCarType());
		updateAccountLog.setCarColour(accountTemp.getCar().getCarColour());
		updateAccountLog.setUpdateTime(new Date());
		updateAccountLog.setOperator_id(getCurrentOperator().getId());
		updateAccountLog.setOperatorName(getCurrentOperator().getName());
		updateAccountLog.setPrintNumber(0);
		updateAccountLogService.save(updateAccountLog);
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中updateAccountOrSavaLog()设置card_type参数时set（），get（）参数时的异常", admin);
		// System.out.println(sysparamconf.getPvalue());
		// 卡类型为不写卡时账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户对用户编号为"+accountTemp.getSys_id()+"进行换卡成功，之前账户余额为："+accountTemp.getBalance()/100+"元",
				"缴费卡账户管理--换卡", "t_park_account");
		return "printExchangeCardAccount";
	}

	public String printExchangeCard() {
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(updateAccountLog.getAccountNo());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);
		updateAccountLogService.update(updateAccountLog);
		return "printExchangeCard";
	}

	// =============================上面为换卡操作，下面为申请销户操作=========================================================
	public String queryToRequestEndAccount() {
		list = accountService.findByPager(pager);
		return "queryToRequestEndAccount";
	}

	public String queryAccountToRequestEndAccount() {
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return queryToRequestEndAccount();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
			// if(list.isEmpty()){result = Result.FAIL4;}
			return "queryToRequestEndAccount";
		}
	}

	public String requestEndAccount() { // 申请销户
		account = accountService.get(account.getSys_id());
		user = userService.get(account.getUser().getSys_id());
		car = carService.get(account.getCar().getSys_id());
		account.setStatus(2);
		account.setStatusUpdateTime(new Date());
		accountService.update(account);
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(account.getSys_id());
		updateAccountLog.setAccountNo(account.getSys_id());
		updateAccountLog.setSeqNo(seqNo);
		updateAccountLog.setStatus(account.getStatus());
		updateAccountLog.setCardNo(account.getCardNo());
		updateAccountLog.setCost(account.getCost());
		updateAccountLog.setLowestBalanceAfterConsume(account.getLowestBalanceAfterConsume());
		updateAccountLog.setTollyLowestBalanceAC(account.getTollyLowestBalanceAC());
		updateAccountLog.setNoEntryBalance(account.getNoEntryBalance());
		updateAccountLog.setLowBalanceNotice(account.getLowBalanceNotice());
		updateAccountLog.setOpenAccountTime(account.getOpenAccountTime());
		updateAccountLog.setStatusUpdateTime(account.getStatusUpdateTime());
		updateAccountLog.setRemark(account.getRemark());
		updateAccountLog.setUser_id(user.getSys_id());
		updateAccountLog.setUserName(user.getUserName());
		updateAccountLog.setCredentialsType(user.getCredentialsType());
		updateAccountLog.setCredentialsNo(user.getCredentialsNo());
		updateAccountLog.setPhone(user.getPhone());
		updateAccountLog.setMobileNumber(user.getMobileNumber());
		updateAccountLog.setAddress(user.getAddress());
		updateAccountLog.setCar_id(car.getSys_id());
		updateAccountLog.setVehPlate(car.getVehPlate());
		updateAccountLog.setCarType(car.getCarType());
		updateAccountLog.setCarColour(car.getCarColour());
		updateAccountLog.setUpdateTime(new Date());
		updateAccountLog.setOperator_id(getCurrentOperator().getId());
		updateAccountLog.setOperatorName(getCurrentOperator().getName());
		updateAccountLog.setPrintNumber(0);
		updateAccountLogService.save(updateAccountLog);
		admin = adminService.get(getCurrentOperator().getId());
		// 设置申请销户到销户的时间间隔，小于时间间隔不能销户
		param_endAccount_amongTime = sysparamconfService.queryOrSave("endAccount_amongTime", "0", "申请销户到销户的时间间隔参数值要是数字，否则系统初始化为0天（没设endAccount_amongTime参数系统也初始化为0天) ", "AccountAction中requestEndAccount()设置endAccount_amongTime参数时set（），get（）参数时的异常", admin);
		try {
			Long pvalue = Long.parseLong(param_endAccount_amongTime.getPvalue());
			param_endAccount_amongTime.setPvalue(pvalue.toString());
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "AccountAction中requestEndAccount()设置eddAccount_amongTime参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
			param_endAccount_amongTime.setPvalue("0");
		}
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中requestEndAccount()设置card_type参数时set（），get（）参数时的异常", admin);
		// 账户卡类型为写卡申请销户时要查储值卡黑名单(tb_ StoreCardBlackList)表，有其账户信息先删除再添加，没有则添加
		if ("1".equals(param_card_type.getPvalue())) {
			storeCardBlackList = storeCardBlackListService.getStoreCardBlackListByCardNo(account.getCardNo());
			if (storeCardBlackList == null) {
				StoreCardBlackList storeCardBlackList1 = new StoreCardBlackList();
				storeCardBlackList1.setScCode(account.getCardNo());
				storeCardBlackList1.setGenCau("2");
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String nowdate = sdf.format(new Date());
					storeCardBlackList1.setGenTime(java.sql.Date.valueOf(nowdate));
				} catch (Exception e) {
					admin = adminService.get(getCurrentOperator().getId());
					systemLogService.save(new Date(), 2, admin, "AccountAction中requstEndAccount()对时间1操作时发生的异常", e.getMessage(), "Exception");
				}

				storeCardBlackListService.save(storeCardBlackList1);
			} else {
				storeCardBlackListService.delete(storeCardBlackList);
				StoreCardBlackList storeCardBlackList2 = new StoreCardBlackList();
				storeCardBlackList2.setScCode(account.getCardNo());
				storeCardBlackList2.setGenCau("2");
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String nowdate = sdf.format(new Date());
					storeCardBlackList2.setGenTime(java.sql.Date.valueOf(nowdate));
				} catch (Exception e) {
					admin = adminService.get(getCurrentOperator().getId());
					systemLogService.save(new Date(), 2, admin, "AccountAction中requstEndAccount()对时间2操作时发生的异常", e.getMessage(), "Exception");
				}

				storeCardBlackListService.save(storeCardBlackList2);
			}
		}
		// 卡类型为不写卡时账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		return "printRequestEndAccount";

	}

	public String printRequestEnd() {
		account = accountService.get(account.getSys_id());
		user = userService.get(account.getUser().getSys_id());
		car = carService.get(account.getCar().getSys_id());
		admin = adminService.get(getCurrentOperator().getId());
		// 设置申请销户到销户的时间间隔，小于时间间隔不能销户
		param_endAccount_amongTime = sysparamconfService.queryOrSave("endAccount_amongTime", "0", "申请销户到销户的时间间隔参数值要是数字，否则系统初始化为0天（没设endAccount_amongTime参数系统也初始化为0天) ", "AccountAction中requestEndAccount()设置endAccount_amongTime参数时set（），get（）参数时的异常", admin);
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(account.getSys_id());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);// 设置打印次数
		updateAccountLogService.update(updateAccountLog);
		return "printRequestEnd";
	}

	// =============================上面为申请销户操作，下面为销户操作=========================================================
	public String queryToEndAccount() {
		list = accountService.findByPager(pager);
		return "queryToEndAccount";
	}

	public String queryAccountToEndAccount() {
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return queryToEndAccount();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
			// if(list.isEmpty()){result = Result.FAIL4;}
			return "queryToEndAccount";
		}
	}

	public String endAccount() {// 销户 账户状态修改为”已销户“，插入更改账户日志表和插入交易流水表并设置余额为0.
		String s1 = "";
		long endAccount_amongTime = 0;
		long amongTime = 0;
		accountTemp = accountService.get(sys_id);
		userTemp = accountTemp.getUser();
		carTemp = accountTemp.getCar();
		try {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(accountTemp.getStatusUpdateTime());
			long time1 = calendar.getTimeInMillis();
			calendar.setTime(new Date());
			long time2 = calendar.getTimeInMillis();
			amongTime = (time2 - time1) / (1000 * 60 * 60 * 24);
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "AccountAction中endAccount()对日历操作时发生的异常", e.getMessage(), "Exception");
		}
		// 结算相差几天
		// 设置申请销户到销户的时间间隔，小于时间间隔不能销户
		param_endAccount_amongTime = sysparamconfService.queryOrSave("endAccount_amongTime", "0", "申请销户到销户的时间间隔参数值要是数字，否则系统初始化为0天（没设endAccount_amongTime参数系统也初始化为0天) ", "AccountAction中requestEndAccount()设置endAccount_amongTime参数时set（），get（）参数时的异常", admin);
		try {
			endAccount_amongTime = Long.parseLong(param_endAccount_amongTime.getPvalue());
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "AccountAction中endAccount()设置eddAccount_amongTime参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
			endAccount_amongTime = 0;
		}
		// System.out.print("当系统有设置时间参数是的endAccount_amlongTime:-------------------"+endAccount_amongTime);}
		if (amongTime < endAccount_amongTime) {
			result = Result.FAIL5;
			return queryAccountToEndAccount();
		}// 少于系统所设置的天数时提示说明
		accountTemp.setStatus(5);
		accountTemp.setStatusUpdateTime(new Date());
		accountService.update(accountTemp);
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(accountTemp.getSys_id());
		updateAccountLog.setAccountNo(accountTemp.getSys_id());
		updateAccountLog.setSeqNo(seqNo);
		updateAccountLog.setStatus(accountTemp.getStatus());
		updateAccountLog.setCardNo(accountTemp.getCardNo());
		updateAccountLog.setCost(accountTemp.getCost());
		updateAccountLog.setLowestBalanceAfterConsume(accountTemp.getLowestBalanceAfterConsume());
		updateAccountLog.setTollyLowestBalanceAC(accountTemp.getTollyLowestBalanceAC());
		updateAccountLog.setNoEntryBalance(accountTemp.getNoEntryBalance());
		updateAccountLog.setLowBalanceNotice(accountTemp.getLowBalanceNotice());
		updateAccountLog.setOpenAccountTime(accountTemp.getOpenAccountTime());
		updateAccountLog.setStatusUpdateTime(accountTemp.getStatusUpdateTime());
		updateAccountLog.setRemark(accountTemp.getRemark());
		updateAccountLog.setUser_id(userTemp.getSys_id());
		updateAccountLog.setUserName(userTemp.getUserName());
		updateAccountLog.setCredentialsType(userTemp.getCredentialsType());
		updateAccountLog.setCredentialsNo(userTemp.getCredentialsNo());
		updateAccountLog.setPhone(userTemp.getPhone());
		updateAccountLog.setMobileNumber(userTemp.getMobileNumber());
		updateAccountLog.setAddress(userTemp.getAddress());
		updateAccountLog.setCar_id(carTemp.getSys_id());
		updateAccountLog.setVehPlate(carTemp.getVehPlate());
		updateAccountLog.setCarType(carTemp.getCarType());
		updateAccountLog.setCarColour(carTemp.getCarColour());
		updateAccountLog.setUpdateTime(new Date());
		updateAccountLog.setOperator_id(getCurrentOperator().getId());
		updateAccountLog.setOperatorName(getCurrentOperator().getName());
		updateAccountLog.setPrintNumber(0);
		updateAccountLogService.save(updateAccountLog);
		seqNo = 0;
		accountTrade.setAccount(accountTemp);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		String nowdate = sdf.format(date);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		try {
			// 从12个流水流水表中根据月份查询其中一个，以获得该帐号的交易流水序号
			seqNo = accountTradeService.getSeqNoByTwelveAccountTrade(calendar.get(Calendar.MONTH) + 1, accountTemp.getSys_id());
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "AccountAction中endAccount（）时获得交易流水表钟序号时发生的异常", e.getMessage(), "Exception");
			e.printStackTrace();
		}
		accountTrade.setSeqNo(seqNo);
		accountTrade.setTradeType(3);
		accountTrade.setCardNo(accountTemp.getCardNo());
		accountTrade.setCardType(accountTemp.getCardType());
		accountTrade.setTradeTime(nowdate);
		accountTrade.setFee(-accountTemp.getBalance());
		accountTrade.setBalance(0);
		accountTrade.setCardBalance(0);
		accountTrade.setBackoutedMark(1);
		accountTrade.setParkNo(accountTemp.getParkNo());
		accountTrade.setVehPlate(accountTemp.getCar().getVehPlate());
		accountTrade.setOpTime(nowdate);
		accountTrade.setOperatorID(getCurrentOperator().getId());
		accountTrade.setOperatorPassword(getCurrentOperator().getPassword());
		
		try {
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String nowdate1 = sdf1.format(new Date());
			s1 = "T" + nowdate1 + "_" + getCurrentOperator().getId().toString();
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "AccountAction中endAccount（）时获得交易流水号时发生的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
			e.printStackTrace();
		}
		accountTrade.setListNo(s1);
		// 去掉null
		String yanzheng = accountTradeService.deleteNull(accountTemp.getSys_id(), accountTrade.getSeqNo(), accountTrade.getTradeType(), accountTrade.getFee(), accountTrade.getBalance(), accountTrade.getCardNo(), accountTrade.getCardType(), accountTrade.getVehPlate(), accountTrade.getListNo(), getCurrentOperator().getId(), getCurrentOperator().getPassword(), accountTrade.getTradeTime(), accountTrade.getOpTime());
		String yanzhengTemp = HashUtil.getMD5String(yanzheng);// md5密匙，目的是查询有没有修改过这条交易信息
		accountTrade.setVerify(yanzhengTemp);
		accountTradeService.save(accountTrade);
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction中endAccount()设置card_type参数时set（），get（）参数时的异常", admin);
		// 富力城小区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}

		return "printEndAccount";

	}

	public String printEnd() {
		accountTemp = accountService.get(accountTemp.getSys_id());
		userTemp = accountTemp.getUser();
		carTemp = accountTemp.getCar();
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(accountTemp.getSys_id());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);
		updateAccountLogService.update(updateAccountLog);
		return "printEnd";
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public Sysparamconf getParam_cardRechargeSystem_path() {
		return param_cardRechargeSystem_path;
	}

	public void setParam_cardRechargeSystem_path(Sysparamconf paramCardRechargeSystemPath) {
		param_cardRechargeSystem_path = paramCardRechargeSystemPath;
	}

	public UpdateAccountLog getUpdateAccountLog() {
		return updateAccountLog;
	}

	public void setUpdateAccountLog(UpdateAccountLog updateAccountLog) {
		this.updateAccountLog = updateAccountLog;
	}

	public int getCardType1() {
		return cardType1;
	}

	public void setCardType1(int cardType1) {
		this.cardType1 = cardType1;
	}

	public String getCardNo1() {
		return cardNo1;
	}

	public void setCardNo1(String cardNo1) {
		this.cardNo1 = cardNo1;
	}

	public AccountTrade getAccountTrade() {
		return accountTrade;
	}

	public void setAccountTrade(AccountTrade accountTrade) {
		this.accountTrade = accountTrade;
	}

	public StoreCardBlackList getStoreCardBlackList() {
		return storeCardBlackList;
	}

	public void setStoreCardBlackList(StoreCardBlackList storeCardBlackList) {
		this.storeCardBlackList = storeCardBlackList;
	}

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
		this.cost = cost;
	}

	public Double getFee() {
		return fee;
	}

	public void setFee(Double fee) {
		this.fee = fee;
	}

	public Integer getAddAccount_NoEntryBalance() {
		return addAccount_NoEntryBalance;
	}

	public void setAddAccount_NoEntryBalance(Integer addAccount_NoEntryBalance) {
		this.addAccount_NoEntryBalance = addAccount_NoEntryBalance;
	}

	public Integer getAddAccount_LowBalanceNotice() {
		return addAccount_LowBalanceNotice;
	}

	public void setAddAccount_LowBalanceNotice(Integer addAccount_LowBalanceNotice) {
		this.addAccount_LowBalanceNotice = addAccount_LowBalanceNotice;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public Sysparamconf getParam_card_type() {
		return param_card_type;
	}

	public void setParam_card_type(Sysparamconf paramCardType) {
		param_card_type = paramCardType;
	}

	public Sysparamconf getParam_endAccount_amongTime() {
		return param_endAccount_amongTime;
	}

	public void setParam_endAccount_amongTime(Sysparamconf paramEndAccountAmongTime) {
		param_endAccount_amongTime = paramEndAccountAmongTime;
	}

	public User getUserTemp() {
		return userTemp;
	}

	public void setUserTemp(User userTemp) {
		this.userTemp = userTemp;
	}

	public Car getCarTemp() {
		return carTemp;
	}

	public void setCarTemp(Car carTemp) {
		this.carTemp = carTemp;
	}

	public Account getAccountTemp() {
		return accountTemp;
	}

	public void setAccountTemp(Account accountTemp) {
		this.accountTemp = accountTemp;
	}

	public int getSys_id() {
		return sys_id;
	}

	public void setSys_id(int sysId) {
		sys_id = sysId;
	}
	public Sysparamconf getParam_accountCardNoLength() {
		return param_accountCardNoLength;
	}

	public void setParam_accountCardNoLength(Sysparamconf paramAccountCardNoLength) {
		param_accountCardNoLength = paramAccountCardNoLength;
	}

}
