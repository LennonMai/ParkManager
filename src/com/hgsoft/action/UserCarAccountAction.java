package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Account;
import com.hgsoft.entity.AccountTrade;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.CardInfo;
import com.hgsoft.entity.IdcardInfo;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.entity.StoreCardBlackList;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.UpdateAccountLog;
import com.hgsoft.entity.User;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.service.AccountService;
import com.hgsoft.service.AccountSendParaService;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CarService;
import com.hgsoft.service.AccountTransactionService;
import com.hgsoft.service.CardInfoService;
import com.hgsoft.service.IDCardInfoService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.StoreCardBlackListService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardInfoService;

import com.hgsoft.service.UpdateAccountLogService;
import com.hgsoft.service.UserService;

@Controller
@Scope("prototype")
public class UserCarAccountAction extends BaseAction {
	private String vehPlate;
	private int cardType;
	private String cardNo;
	private Double value;
	private int sys_id;
	private User user;
	private User userTemp;
	private Car car;
	private Car carTemp;
	private Admin admin;
	private Account account;
	private Account accountTemp;
	private UpdateAccountLog updateAccountLog;
	private AccountTrade accountTrade;
	@SuppressWarnings("unchecked")
	private List listPark;	
	private Sysparamconf param_card_type;
	private Sysparamconf param_addAccount_LowestBalanceAfterConsume;
	private Sysparamconf param_addAccount_TollyLowestBalanceAC;
	private Sysparamconf param_addAccount_NoEntryBalance;
	private Sysparamconf param_addAccount_LowBalanceNotice;
	private Sysparamconf param_addAccount_Cost;
	private Sysparamconf param_accountCardNoLength;
	

	private ParkInformation parkInformation;
	private Double lowestBalanceAfterConsume;
	private Double tollyLowestBalanceAC;
	private Double noEntryBalance;
	private Double lowBalanceNotice;
	private Double cost;
	private String card_type = "card_type";// 卡类型，0为记账卡，1为储值卡
	private String card_type_remark = "账户类型参数（0就是充值不写卡，1就是充值写卡,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";

	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private UserService userService;
	@Resource
	private CarService carService;
	@Resource
	private AccountService accountService;
	@Resource
	private UpdateAccountLogService updateAccountLogService;
	@Resource
	private AdminService adminService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private AccountSendParaService accountSendParaService;
	@Resource
	private AccountTransactionService accountTransactionService;
	@Resource
	private ParkInformationService parkInformationService;
	@Resource
	private CardInfoService cardInfoService;
	@Resource
	private StoreCardBlackListService storeCardBlackListService;
	@Resource
	private UserCardInfoService userCardInfoService;
	@Resource
	private IDCardInfoService iDCardInfoService;
	
	

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
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中mul(double d1,double d2)方法精度结算转换时发生的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
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
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中deleteFirstZero(String s)去掉卡号前面的0时发生异常", e.getMessage(), "StringIndexOutOfBoundsException（字符越界异常）");
			e.printStackTrace();
		}

		return s;

	}

	public UserCarAccountAction() {
		updateAccountLog = new UpdateAccountLog();
		accountTrade = new AccountTrade();
	}

	public String queryList() {// 开户查询页面
		list = accountService.findByPager(pager);
		listPark = parkInformationService.getAllParkInformation();
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction中queryList()设置card_type参数时set（），get（）参数时的异常", admin);
		return "queryToAdd";
	}

	public String queryAccountToAdd() {// 查询账户
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()&& null == account.getParkNo()) {
			return queryList();
		} else {
			admin = adminService.get(getCurrentOperator().getId());
			// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction中queryList()设置card_type参数时set（），get（）参数时的异常", admin);
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),account.getParkNo());
			listPark = parkInformationService.getAllParkInformation();
			return "queryToAdd";
		}
	}

	public String add() {// 从”其它系统参数“获得初始值
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction中add()设置card_type参数时set（），get（）参数时的异常", admin);

		// 设置账户中最低余额
		param_addAccount_LowestBalanceAfterConsume = sysparamconfService.queryOrSave("addAccount_LowestBalanceAfterConsume", "0", "开户中的最低余额（单位：元）（参数值要是正数或者0" + "（例如：10。小数点最多为2位，" + "超过两位时就直接把后面的小数点去点），否则初始化为0）", "UserCarAction中add()设置addAccount_LowestBalanceAfterConsume参数时的异常", admin);

		// 设置账户中记账最低余额
		param_addAccount_TollyLowestBalanceAC = sysparamconfService.queryOrSave("addAccount_TollyLowestBalanceAC", "0", "开户中的记账最低余额（单位：元）（参数值要是正数或者0（" + "例如：10。小数点最多为2位，" + "超过两位时就直接把后面的小数点去点），否则初始化为0）", "UserCarAction中add()设置addAccount_TollyLowestBalanceAC参数时的异常", admin);

		// 设置账户中禁止驶入最低余额
		param_addAccount_NoEntryBalance = sysparamconfService.queryOrSave("addAccount_NoEntryBalance", "15", "开户中的禁止驶入最低余额（单位：元）（参数值要是正数或者0" + "（例如：15。小数点最多为2位，" + "超过两位时就直接把后面的小数点去点），否则系统初始化为15）", "UserCarAction中add()设置addAccount_NoEntryBalance参数时的异常", admin);

		// 设置账户中提示用户去续费的最低余额
		param_addAccount_LowBalanceNotice = sysparamconfService.queryOrSave("addAccount_LowBalanceNotice", "50", "开户中的提示用户去续费的最低余额（单位：元）（参数值要是正数或者0" + "（小数点最多为2位，" + "超过两位时就直接把后面的小数点去点），否则系统初始化为50）", "UserCarAction中add()设置addAccount_LowBalanceNotice参数时的异常", admin);

		// 设置账户中工本费
		param_addAccount_Cost = sysparamconfService.queryOrSave("addAccount_Cost", "0", "开户工本费（单位：元）（参数值要是正数或者0（例如：10。小数点最多为2位，" + "超过两位时就直接把后面的小数点去点），否则初始化为0）", "UserCarAction中add()设置addAccount_Cost参数时的异常", admin);
		//设置卡号长度
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "缴费卡账户管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值。例如：值为9则卡号长度只能为9）。", "UserCarAction中add()设置accountCardNoLength参数时的异常", admin);
		
		account = new Account();

		try {
			value = mul(Double.valueOf(param_addAccount_LowestBalanceAfterConsume.getPvalue()), 100.0);
			account.setLowestBalanceAfterConsume(value.intValue());// 设置账户中最低余额
		} catch (Exception e) {
			account.setLowestBalanceAfterConsume(0);
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中add()设置addAccount_LowestBalanceAfterConsume参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}
		try {
			value = mul(Double.valueOf(param_addAccount_TollyLowestBalanceAC.getPvalue()), 100.0);
			account.setTollyLowestBalanceAC(value.intValue());// 设置账户中记账最低余额
		} catch (Exception e) {
			account.setTollyLowestBalanceAC(0);
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中add()设置addAccount_TollyLowestBalanceAC参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_NoEntryBalance.getPvalue()), 100.0);
			account.setNoEntryBalance(value.intValue());// 设置账户中禁止驶入最低余额
		} catch (Exception e) {
			account.setNoEntryBalance(1500);
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCaAccountrAction中add()设置addAccount_NoEntryBalance参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_LowBalanceNotice.getPvalue()), 100.0);
			account.setLowBalanceNotice(value.intValue());// 设置账户中提示用户去续费的最低余额
		} catch (Exception e) {
			account.setLowBalanceNotice(5000);
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中add()设置addAccount_LowBalanceNotice参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_Cost.getPvalue()), 100.0);
			account.setCost(value.intValue());// 设置账户中工本费
		} catch (Exception e) {
			account.setCost(0);
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中add()设置addAccount_Cost参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中add()设置param_accountCardNoLength参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}
		list = parkInformationService.getAllParkInformation();
		return ADD;
	}

	public String save() {// 开户保存进数据库，user car account一起插入数据库
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction中save()设置card_type参数时set（），get（）参数时的异常", admin);
	//	if (null != carService.getCar(car.getVehPlate().trim())) {// 不能插入与数据库中任何一条相同的车牌号（销户的除外）
		//	result = Result.FAIL;
		//	return add();
		//}
	//	if (null != accountService.getAccount(this.deleteFirstZero(account.getCardNo().trim())) || null != userCardInfoService.getUserCardInfoByCardNo(this.deleteFirstZero(account.getCardNo().trim()))) {// 不能插入与数据库中任何一条相同的卡号（销户的除外）
			//result = Result.FAIL1;
			//return add();
		//}
		userTemp = new User();
		userTemp.setAddress(user.getAddress().trim());
		userTemp.setCredentialsNo(user.getCredentialsNo().trim());
		userTemp.setCredentialsType(user.getCredentialsType());
		userTemp.setMobileNumber(user.getMobileNumber().trim());
		userTemp.setPhone(user.getPhone().trim());
		userTemp.setUserName(user.getUserName().trim());
		carTemp = new Car();
		carTemp.setCarColour(car.getCarColour().trim());
		carTemp.setCarType(car.getCarType());
		carTemp.setVehPlate(car.getVehPlate().trim());
		accountTemp = new Account();
		accountTemp.setStatus(0);
		accountTemp.setCardType(1);
		accountTemp.setParkNo(account.getParkNo());
		// 根据充值类型分为充值是写卡时设置账户中最低余额，记账最低余额，禁止驶入最低余额，提示用户去续费的最低余额
		if ("1".equals(param_card_type.getPvalue())) {
			accountTemp.setLowestBalanceAfterConsume(0);
			accountTemp.setTollyLowestBalanceAC(0);
			accountTemp.setNoEntryBalance(0);
			accountTemp.setLowBalanceNotice(0);

		} else {// 根据充值类型分为充值是不写卡时设置账户中最低余额，记账最低余额，禁止驶入最低余额，提示用户去续费的最低余额
			Double lba = mul(lowestBalanceAfterConsume, 100.0);
			Double tl = mul(tollyLowestBalanceAC, 100.0);
			if(noEntryBalance!=null && !noEntryBalance.equals("")){
				Double ne = mul(noEntryBalance, 100.0);
				accountTemp.setNoEntryBalance(ne.intValue());
			}else{
				accountTemp.setNoEntryBalance(0);
			}
			if(lowBalanceNotice!=null && !lowBalanceNotice.equals("")){
				Double lbn = mul(lowBalanceNotice, 100.0);
				accountTemp.setLowBalanceNotice(lbn.intValue());
			}else{
				accountTemp.setLowBalanceNotice(0);
			}
			accountTemp.setLowestBalanceAfterConsume(lba.intValue());
			accountTemp.setTollyLowestBalanceAC(tl.intValue());
		
			
		}
		Double c = mul(cost, 100.0);
		accountTemp.setCost(c.intValue());
		accountTemp.setBalance(0);
		String cardNo = this.deleteFirstZero(account.getCardNo().trim());
		accountTemp.setCardNo(cardNo);
		Date date = new Date();
		accountTemp.setOpenAccountTime(date);
		accountTemp.setStatusUpdateTime(date);
		accountTemp.setRemark(account.getRemark().trim());
		accountTrade.setSeqNo(0);
		accountTrade.setFee(0);
		accountTrade.setTradeType(4);
		accountTrade.setParkNo(account.getParkNo());
		accountTrade.setCardNo(accountTemp.getCardNo());
		accountTrade.setCardType(accountTemp.getCardType());
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowdate = sdf.format(new Date());
			accountTrade.setTradeTime(nowdate);
			accountTrade.setOpTime(nowdate);
		} catch (Exception e) {
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中save（）开户对时间1操作时发生的异常", e.getMessage(), "Exception");
		}
		accountTrade.setBalance(0);
		accountTrade.setCardBalance(0);
		accountTrade.setBackoutedMark(1);
		accountTrade.setVehPlate(carTemp.getVehPlate());
		accountTrade.setOperatorID(getCurrentOperator().getId());
		accountTrade.setOperatorPassword(getCurrentOperator().getPassword());
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
		updateAccountLog.setUserName(userTemp.getUserName());
		updateAccountLog.setCredentialsType(userTemp.getCredentialsType());
		updateAccountLog.setCredentialsNo(userTemp.getCredentialsNo());
		updateAccountLog.setPhone(userTemp.getPhone());
		updateAccountLog.setMobileNumber(userTemp.getMobileNumber());
		updateAccountLog.setAddress(userTemp.getAddress());
		updateAccountLog.setVehPlate(carTemp.getVehPlate());
		updateAccountLog.setCarType(carTemp.getCarType());
		updateAccountLog.setCarColour(carTemp.getCarColour());
		updateAccountLog.setUpdateTime(new Date());
		updateAccountLog.setOperator_id(getCurrentOperator().getId());
		updateAccountLog.setOperatorName(getCurrentOperator().getName());
		updateAccountLog.setPrintNumber(0);
		int sys_id = accountService.getUserSysid();// 用户编号是在当前最大编号加1，第一个账户用户编号为1
		try {
			userService.insertUser(sys_id, userTemp.getUserName(), userTemp.getCredentialsType(), userTemp.getCredentialsNo(), userTemp.getPhone(), userTemp.getMobileNumber(), userTemp.getAddress());
		} catch (DataIntegrityViolationException e) {// sys_id冲突后再重新获得一此sys_id。
			sys_id = accountService.getUserSysid();// 用户编号是在当前最大编号加1，第一个账户用户编号为1
			user.setSys_id(sys_id);
			userService.insertUser(sys_id, user.getUserName(), user.getCredentialsType(), user.getCredentialsNo(), user.getPhone(), user.getMobileNumber(), user.getAddress());
		}
		userTemp = userService.get(sys_id);
		// 事务管理
		accountTransactionService.saveTransaction(userTemp, carTemp, accountTemp, accountTrade, updateAccountLog, getCurrentOperator(), admin);
		Account accountTest=accountService.getAccountByUserID(sys_id);//避免当用户信息插入数据库而开户不成功（account信息没保存成功）时删除用户信息，避免用户表中数据冗余
		if(accountTest==null){
			userService.deleteById(sys_id);
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户开户时事务开户不成功时删除用户["+sys_id+"]信息成功，以防数据冗余",
					"缴费卡账户管理--开户", "t_park_user");
		}
		// 根据充值类型为不写卡时小区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		if(account.getParkNo()!=null && !account.getParkNo().equals("")){
			parkInformation = parkInformationService.getParkInformationByParkNo(account.getParkNo().shortValue());	
		}		
		return "printAddAccount";

	}

	// -----------------------------------------上面为开户，下面为更改账户信息----------------------------------------

	public String query() {
		list = accountService.findByPager(pager);
		listPark = parkInformationService.getAllParkInformation();
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction中query()设置card_type参数时set（），get（）参数时的异常", admin);
		return "queryToUpdate";
	}

	public String queryAccountToUpdate() {
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()&& null == account.getParkNo()) {
			return query();
		} else {
			admin = adminService.get(getCurrentOperator().getId());
			// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction中query()设置card_type参数时set（），get（）参数时的异常", admin);
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),account.getParkNo());
			listPark = parkInformationService.getAllParkInformation();
			return "queryToUpdate";
		}
	}

	public String accountList() {
		admin = adminService.get(getCurrentOperator().getId());
		// 设置卡账户类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction中accountList()设置card_type参数时set（），get（）参数时的异常", admin);
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "缴费卡账户管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值。例如：值为9则卡号长度只能为9）。", "UserCarAction中add()设置accountCardNoLength参数时的异常", admin);
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
			user = userService.get(account.getUser().getSys_id());
			car = carService.get(account.getCar().getSys_id());
			listPark = parkInformationService.getAllParkInformation();
			return "edit";
		} else {
			result = Result.FAIL;
			return "queryToUpdate";
		}

	}

	public String updateAccountAndSaveLog() {// 更改user car
												// account信息，同时也将修改后的user car
												// account信息插入到更改账户日志表中
		accountTemp = accountService.get(account.getSys_id());
		carTemp = accountTemp.getCar();
		userTemp = accountTemp.getUser();
		// car = accountTemp.getCar();

		// 更改后的车牌不能与数据库中的车牌相同（销户的除外）
		/*
		 * System.out.println("vehPlate.trim()-----------:"+vehPlate.trim());
		 * System
		 * .out.println("car.getVehPlate().trim()-----------:"+car.getVehPlate
		 * ().trim()); if (!vehPlate.trim().equals(car.getVehPlate().trim())) {
		 * car = carService.getCar(car.getVehPlate().trim()); if (null != car) {
		 * carTemp.setVehPlate(vehPlate.trim()); result = Result.FAIL;
		 * 
		 * return accountList();
		 * 
		 * } } // 更改后的卡号不能与数据库中的卡号相同（销户的除外）
		 * System.out.println("cardNo.trim()-----------:"+cardNo.trim());
		 * System.out.println(
		 * "this.deleteFirstZero(accountTemp.getCardNo().trim()))-----------:"
		 * +this.deleteFirstZero(accountTemp.getCardNo().trim())); if
		 * (!cardNo.trim
		 * ().equals(this.deleteFirstZero(accountTemp.getCardNo().trim()))) {
		 * account =
		 * accountService.getAccount(this.deleteFirstZero(account.getCardNo
		 * ().trim())); if (null != account) {
		 * accountTemp.setCardNo(cardNo.trim()); result = Result.FAIL1; return
		 * accountList();
		 * 
		 * } }
		 */
		admin = adminService.get(getCurrentOperator().getId());
		// 设置卡账户类型，0为根据充值分为不写卡，1为写卡
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction中updateAccountAndSaveLog()设置card_type参数时set（），get（）参数时的异常", admin);
		String cardNo1 = this.deleteFirstZero(account.getCardNo().trim());
		accountTemp.setCardNo(cardNo1);
		userTemp.setUserName(user.getUserName().trim());
		userTemp.setCredentialsType(user.getCredentialsType());
		userTemp.setCredentialsNo(user.getCredentialsNo().trim());
		userTemp.setPhone(user.getPhone().trim());
		userTemp.setMobileNumber(user.getMobileNumber().trim());
		userTemp.setAddress(user.getAddress().trim());
		carTemp.setVehPlate(car.getVehPlate().trim());
		carTemp.setCarType(car.getCarType());
		carTemp.setCarColour(car.getCarColour().trim());
		userService.update(userTemp);
		carService.update(carTemp);
		accountTemp.setUser(userTemp);
		accountTemp.setCar(carTemp);
		if ("0".equals(param_card_type.getPvalue())) {// 卡类型为不写卡时
			Double lba = mul(lowestBalanceAfterConsume, 100.0);
			Double tl = mul(tollyLowestBalanceAC, 100.0);
			accountTemp.setLowestBalanceAfterConsume(lba.intValue());
			accountTemp.setTollyLowestBalanceAC(tl.intValue());
			if(noEntryBalance!=null && !noEntryBalance.equals("")){
				Double ne = mul(noEntryBalance, 100.0);
				accountTemp.setNoEntryBalance(ne.intValue());
			} else{
				accountTemp.setNoEntryBalance(0);
			}
			if(lowBalanceNotice!=null && !lowBalanceNotice.equals("")){
				Double lbn = mul(lowBalanceNotice, 100.0);
				accountTemp.setLowBalanceNotice(lbn.intValue());
			}else{
				accountTemp.setLowBalanceNotice(0);
			}
		} else {// 卡类型为写卡时
			accountTemp.setLowestBalanceAfterConsume(0);
			accountTemp.setTollyLowestBalanceAC(0);
			accountTemp.setNoEntryBalance(0);
			accountTemp.setLowBalanceNotice(0);
		}
		Double c = mul(cost, 100.0);
		accountTemp.setCost(c.intValue());
		accountTemp.setParkNo(account.getParkNo());
		accountTemp.setRemark(account.getRemark().trim());
		accountService.update(accountTemp);
		updateAccountLog.setAccountNo(accountTemp.getSys_id());
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(accountTemp.getSys_id());
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
		// 根据充值类型为不写卡时小区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		return "printUpdateAccount";
	}

	public String blackList() {// 移进黑名单
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型，0为根据充值分为不写卡，1为写卡
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction中blackList()设置card_type参数时set（），get（）参数时的异常", admin);
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "缴费卡账户管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值。例如：值为9则卡号长度只能为9）。", "UserCarAction中add()设置accountCardNoLength参数时的异常", admin);
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue().trim());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中blackList()设置param_accountCardNoLength参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}		
		account = accountService.get(account.getSys_id());
		user = account.getUser();
		car = account.getCar();
		account.setStatus(7);
		account.setStatusUpdateTime(new Date());
		accountService.update(account);
		updateAccountLog.setAccountNo(account.getSys_id());
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(account.getSys_id());
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
		// 根据充值类型为不写卡时小区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}

		result = Result.FAIL2;

		return "edit";
	}

	public String blackOut() {// 移出黑名单，在修改页面移出黑名单
		account = accountService.get(sys_id);
		user = account.getUser();
		car = account.getCar();
		if (account.getStatus() != 7) {
			result = Result.FAIL3;
			return "edit";
		}
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型，0为根据充值分为不写卡，1为写卡
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction中blackOut()设置card_type参数时set（），get（）参数时的异常", admin);
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "缴费卡账户管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值。例如：值为9则卡号长度只能为9）。", "UserCarAction中add()设置accountCardNoLength参数时的异常", admin);
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue().trim());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中blackOut()设置param_accountCardNoLength参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}		
		account.setStatus(0);
		accountService.update(account);
		updateAccountLog.setAccountNo(account.getSys_id());
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(account.getSys_id());
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
		// 根据充值类型为不写卡时小区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		result = Result.FAIL4;
		return "edit";
	}

	public String blackOutOne() {// 移出黑名单，在查询页面移出黑名单（与上面的返回不同）
		accountTemp = accountService.get(sys_id);
		userTemp = accountTemp.getUser();
		carTemp = accountTemp.getCar();
		if (accountTemp.getStatus() != 7) {
			result = Result.FAIL3;
			return "edit";
		}
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型，0为根据充值分为不写卡，1为写卡
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction中blackOutOne()设置card_type参数时set（），get（）参数时的异常", admin);
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "缴费卡账户管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值。例如：值为9则卡号长度只能为9）。", "UserCarAction中add()设置accountCardNoLength参数时的异常", admin);
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue().trim());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中blackOutOne()设置param_accountCardNoLength参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}		
		accountTemp.setStatus(0);
		accountService.update(accountTemp);
		updateAccountLog.setAccountNo(accountTemp.getSys_id());
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(accountTemp.getSys_id());
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
		// System.out.println(sysparamconf6.getPvalue());
		// 根据充值类型为不写卡时小区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		result = Result.FAIL4;
		return queryAccountToUpdate();
	}

	public String getCarByVehPlate() {// jquery验证车牌是否存在
		Car car1 = carService.getCar(car.getVehPlate().trim());
		UserCardInfo userCardInfo = userCardInfoService.getUserCardInfoByVehPlate(car.getVehPlate().trim());
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
		if (car1 == null && userCardInfo==null) {
			out.println("success");

		} else {
			out.print("fail");

		}
		return null;
	}

	public String getAccountByCardNo() {// jquery验证卡号是否存在

		String cardNo = this.deleteFirstZero(account.getCardNo().trim());
		Account account1 = accountService.getAccount(cardNo);
		CardInfo cardInfo = cardInfoService.getCardInfoByCardNo(cardNo);
		UserCardInfo userCardInfo = userCardInfoService.getUserCardInfoByCardNo(cardNo);
		IdcardInfo idCardInfo = iDCardInfoService.getIDCardInfoByCardNo(cardNo);
		StoreCardBlackList storeCardBlackList = storeCardBlackListService.get(cardNo);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中getAccountByCardNo（）验证卡号是否存在是时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (account1 != null || idCardInfo!=null || userCardInfo!=null) {
			out.print("fail1");
		} else if (cardInfo != null && storeCardBlackList == null) {
			if (cardInfo.getStatus() != 0) {
				out.print("statusNoUse");// 界面显示该卡在卡信息中不是正常卡，不能运用
			} else {
				out.println("success1");
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
			out.println("success1");
		}
		/*
		 * if (account1 == null) { out.println("success1");
		 * 
		 * } else { out.print("fail1");
		 * 
		 * }
		 */
		return null;
	}

	// ----------------------------------

	public String printAdd() {// 打印开户信息
		 accountTemp = accountService.get(accountTemp.getSys_id());
	     if(accountTemp.getParkNo()!=null && !accountTemp.getParkNo().equals("")){
		    parkInformation = parkInformationService.getParkInformationByParkNo(accountTemp.getParkNo().shortValue());	
		 }
	     carTemp = accountTemp.getCar();
	     userTemp = accountTemp.getUser();
		return "printAdd";

	}

	public String printUpdate() {// 打印更改账户信息
	    accountTemp = accountService.get(accountTemp.getSys_id());
	    if(accountTemp.getParkNo()!=null && !accountTemp.getParkNo().equals("")){
		   parkInformation = parkInformationService.getParkInformationByParkNo(accountTemp.getParkNo().shortValue());	
	    }
	    carTemp = accountTemp.getCar();
	    userTemp = accountTemp.getUser();
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(accountTemp.getSys_id());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);
		updateAccountLogService.update(updateAccountLog);// 打印次数加1
		return "printUpdate";
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

	public UpdateAccountLog getUpdateAccountLog() {
		return updateAccountLog;
	}

	public void setUpdateAccountLog(UpdateAccountLog updateAccountLog) {
		this.updateAccountLog = updateAccountLog;
	}

	public AccountTrade getAccountTrade() {
		return accountTrade;
	}

	public void setAccountTrade(AccountTrade accountTrade) {
		this.accountTrade = accountTrade;
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

	public Sysparamconf getParam_addAccount_LowestBalanceAfterConsume() {
		return param_addAccount_LowestBalanceAfterConsume;
	}

	public void setParam_addAccount_LowestBalanceAfterConsume(Sysparamconf paramAddAccountLowestBalanceAfterConsume) {
		param_addAccount_LowestBalanceAfterConsume = paramAddAccountLowestBalanceAfterConsume;
	}

	public Sysparamconf getParam_addAccount_TollyLowestBalanceAC() {
		return param_addAccount_TollyLowestBalanceAC;
	}

	public void setParam_addAccount_TollyLowestBalanceAC(Sysparamconf paramAddAccountTollyLowestBalanceAC) {
		param_addAccount_TollyLowestBalanceAC = paramAddAccountTollyLowestBalanceAC;
	}

	public Sysparamconf getParam_addAccount_NoEntryBalance() {
		return param_addAccount_NoEntryBalance;
	}

	public void setParam_addAccount_NoEntryBalance(Sysparamconf paramAddAccountNoEntryBalance) {
		param_addAccount_NoEntryBalance = paramAddAccountNoEntryBalance;
	}

	public Sysparamconf getParam_addAccount_LowBalanceNotice() {
		return param_addAccount_LowBalanceNotice;
	}

	public void setParam_addAccount_LowBalanceNotice(Sysparamconf paramAddAccountLowBalanceNotice) {
		param_addAccount_LowBalanceNotice = paramAddAccountLowBalanceNotice;
	}

	public Sysparamconf getParam_addAccount_Cost() {
		return param_addAccount_Cost;
	}

	public void setParam_addAccount_Cost(Sysparamconf paramAddAccountCost) {
		param_addAccount_Cost = paramAddAccountCost;
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

	public Double getLowestBalanceAfterConsume() {
		return lowestBalanceAfterConsume;
	}

	public void setLowestBalanceAfterConsume(Double lowestBalanceAfterConsume) {
		this.lowestBalanceAfterConsume = lowestBalanceAfterConsume;
	}

	public Double getTollyLowestBalanceAC() {
		return tollyLowestBalanceAC;
	}

	public void setTollyLowestBalanceAC(Double tollyLowestBalanceAC) {
		this.tollyLowestBalanceAC = tollyLowestBalanceAC;
	}

	public Double getNoEntryBalance() {
		return noEntryBalance;
	}

	public void setNoEntryBalance(Double noEntryBalance) {
		this.noEntryBalance = noEntryBalance;
	}

	public Double getLowBalanceNotice() {
		return lowBalanceNotice;
	}

	public void setLowBalanceNotice(Double lowBalanceNotice) {
		this.lowBalanceNotice = lowBalanceNotice;
	}

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
		this.cost = cost;
	}

	public String getVehPlate() {
		return vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}

	public int getCardType() {
		return cardType;
	}

	public void setCardType(int cardType) {
		this.cardType = cardType;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public int getSys_id() {
		return sys_id;
	}

	public void setSys_id(int sysId) {
		sys_id = sysId;
	}

	public ParkInformation getParkInformation() {
		return parkInformation;
	}

	public void setParkInformation(ParkInformation parkInformation) {
		this.parkInformation = parkInformation;
	}
	@SuppressWarnings("unchecked")
	public List getListPark() {
		return listPark;
	}

	@SuppressWarnings("unchecked")
	public void setListPark(List listPark) {
		this.listPark = listPark;
	}
	public Sysparamconf getParam_accountCardNoLength() {
		return param_accountCardNoLength;
	}

	public void setParam_accountCardNoLength(Sysparamconf paramAccountCardNoLength) {
		param_accountCardNoLength = paramAccountCardNoLength;
	}
}
