package com.hgsoft.integration.testAction;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.ICCardAction;
import com.hgsoft.action.UserCarAccountAction;
import com.hgsoft.entity.Account;
import com.hgsoft.entity.AccountTrade;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.UpdateAccountLog;
import com.hgsoft.entity.User;
import com.hgsoft.service.AccountSendParaService;
import com.hgsoft.service.AccountService;
import com.hgsoft.service.AccountTransactionService;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CarService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UpdateAccountLogService;
import com.hgsoft.service.UserService;
import com.hgsoft.util.Pager;
import com.opensymphony.xwork2.ActionContext;


public class TestUserCarAccountAction extends AbstractActionTransactionalTests {
	private static ApplicationContext context;
	private UserCarAccountAction userCarAccountAction;
	private Sysparamconf param_card_type;
	private Sysparamconf param_addAccount_LowestBalanceAfterConsume;
	private Sysparamconf param_addAccount_TollyLowestBalanceAC;
	private Sysparamconf param_addAccount_NoEntryBalance;
	private Sysparamconf param_addAccount_LowBalanceNotice;
	private Sysparamconf param_addAccount_Cost;
	private Admin admin;
	private Account account;
	private User user;
	private Car car;
	private User userTemp;

	private Car carTemp;
	// private User user1;
	// private Car car1;

	private Account accountTemp;
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
	public void onSetUpBeforeTransaction(){
		if(null == context){
			context = this.getApplicationContext();
		}
		userCarAccountAction = (UserCarAccountAction) context.getBean("userCarAccountAction");
		//ActionContext.getContext().getSession().put("operator", admin);
		
		assertNotNull("iCCardAction为空", userCarAccountAction);
		
	}
	public void testMul(){
		double test=userCarAccountAction.mul(11.1, 100);
		assertEquals(test,1110.0);
	}
	public void testDeleteFirstZero(){
		String test=userCarAccountAction.deleteFirstZero("00001234560789");
		assertEquals(test,"1234560789");
	}
	/*public double mul(double d1, double d2) { // 精度结算转换，不用这个函数会出错，比如：41070.7(double型)*100会出错
		Admin admin = adminService.get(900000001);
		BigDecimal bd1 = null;
		BigDecimal bd2 = null;
		try {
			bd1 = new BigDecimal(Double.toString(d1));
			bd2 = new BigDecimal(Double.toString(d2));
			return bd1.multiply(bd2).doubleValue();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "UserCarAction中mul(double d1,double d2)方法精度结算转换时发生的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
			e.printStackTrace();

			return 0;
		}

	}

	public String deleteFirstZero(String s) {// 去掉卡号前面的0
		Admin admin = adminService.get(900000001);
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
			systemLogService.save(new Date(), 2, admin, "UserCarAction中deleteFirstZero(String s)去掉卡号前面的0时发生异常", e.getMessage(), "StringIndexOutOfBoundsException（字符越界异常）");
			e.printStackTrace();
		}

		return s;

	}*/

	@SuppressWarnings("unchecked")
	@Test
	@Rollback
	public void testQueryAccountToAdd() {
		/*System.out.println("------------------testQueryAccountToAdd()---------");
		@SuppressWarnings("unused")
		List list;
		Pager pager = new Pager();
		pager.setPageSize("15");
		User user = new User();
		user.setSys_id(100);
		user.setUserName("");
		user.setCredentialsNo("");
		userService.save(user);
		Car car = new Car();
		car.setVehPlate("");
		carService.save(car);
		Account account = new Account();
		account.setUser(user);
		account.setCar(car);
		account.setStatus(7);
		account.setCardType(1);
		account.setParkNo(1);
		account.setLowestBalanceAfterConsume(0);
		account.setTollyLowestBalanceAC(0);
		account.setNoEntryBalance(0);
		account.setLowBalanceNotice(0);
		account.setCost(10);
		account.setBalance(0);
		account.setCardNo("cardNo");
		Date date = new Date();
		account.setOpenAccountTime(date);
		account.setStatusUpdateTime(date);
		account.setRemark("chenfuyuanRemarkTest");
		accountService.save(account);

		User userTemp = new User();
		userTemp.setSys_id(101);
		userTemp.setUserName("");
		userTemp.setCredentialsNo("");
		userService.save(userTemp);
		Car carTemp = new Car();
		carTemp.setVehPlate("");
		carService.save(carTemp);
		Account accountTemp = new Account();
		accountTemp.setUser(userTemp);
		accountTemp.setCar(carTemp);
		accountTemp.setStatus(7);
		accountTemp.setCardType(1);
		accountTemp.setParkNo(1);
		accountTemp.setLowestBalanceAfterConsume(0);
		accountTemp.setTollyLowestBalanceAC(0);
		accountTemp.setNoEntryBalance(0);
		accountTemp.setLowBalanceNotice(0);
		accountTemp.setCost(10);
		accountTemp.setBalance(0);
		accountTemp.setCardNo("cardNoTemp");
		Date dateTemp = new Date();
		accountTemp.setOpenAccountTime(dateTemp);
		accountTemp.setStatusUpdateTime(dateTemp);
		accountTemp.setRemark("chenfuyuanRemarkTestTemp");
		accountService.save(accountTemp);

		if (null == account.getSys_id() && "".equals(account.getCardNo()) && "".equals(user.getUserName()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo()) && "".equals(car.getVehPlate()) && null == account.getStatus()) {
			System.out.println("queryList()");
		} else {
			list = accountService.findAllItemByHql(pager, null, "", "", null, "", "", 7);
			System.out.println("queryToAdd");
		}
		int size = accountService.findAllItemByHql(pager, null, "", "", null, "", "", 7).size();
		String remark = accountService.findAllItemByHql(pager, null, "", "", null, "", "", 7).get(0).getRemark();
		// System.out.println("accountService.findAllItemByHql().size()---------"+size);
		// System.out.println("account.getRemark()---------------"+remark);
		assertEquals(2, size);
		assertEquals("chenfuyuanRemarkTest", remark);*/

	}

	@Test
	@Rollback
	public void testAdd() {
		/*System.out.println("-----------------------------testAdd()-------------------------------------------");
		Double value;
		admin = adminService.get(900000001);
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction中add()设置card_type参数时set（），get（）参数时的异常", admin);

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
		Account account = new Account();

		try {
			value = mul(Double.valueOf(param_addAccount_LowestBalanceAfterConsume.getPvalue()), 100.0);
			account.setLowestBalanceAfterConsume(value.intValue());// 设置账户中最低余额
			System.out.println("account.getLowestBalanceAfterConsume():" + account.getLowestBalanceAfterConsume());
		} catch (Exception e) {
			account.setLowestBalanceAfterConsume(0);
			System.out.println("account.setLowestBalanceAfterConsume()异常，其初始化值为:" + account.getLowestBalanceAfterConsume());
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中add()设置addAccount_LowestBalanceAfterConsume参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}
		try {
			value = mul(Double.valueOf(param_addAccount_TollyLowestBalanceAC.getPvalue()), 100.0);
			account.setTollyLowestBalanceAC(value.intValue());// 设置账户中记账最低余额
			System.out.println("account.getTollyLowestBalanceAC()):" + account.getTollyLowestBalanceAC());
		} catch (Exception e) {
			account.setTollyLowestBalanceAC(0);
			System.out.println("account.setTollyLowestBalanceAC())异常，其初始化值为:" + account.getTollyLowestBalanceAC());
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中add()设置addAccount_TollyLowestBalanceAC参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_NoEntryBalance.getPvalue()), 100.0);
			account.setNoEntryBalance(value.intValue());// 设置账户中禁止驶入最低余额
			System.out.println("account.getNoEntryBalance():" + account.getNoEntryBalance());
		} catch (Exception e) {
			account.setNoEntryBalance(1500);
			System.out.println("account.setNoEntryBalance()异常，其初始化值为:" + account.getNoEntryBalance());
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中add()设置addAccount_NoEntryBalance参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_LowBalanceNotice.getPvalue()), 100.0);
			account.setLowBalanceNotice(value.intValue());// 设置账户中提示用户去续费的最低余额
			System.out.println("account.getLowBalanceNotice():" + account.getLowBalanceNotice());
		} catch (Exception e) {
			account.setLowBalanceNotice(5000);
			System.out.println("account.setLowBalanceNotice()异常，其初始化值为:" + account.getLowBalanceNotice());
			// 出现异常时插入系统日志表
			systemLogService.save(new Date(), 2, admin, "UserCarAction中add()设置addAccount_LowBalanceNotice参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_Cost.getPvalue()), 100.0);
			account.setCost(value.intValue());// 设置账户中工本费
			System.out.println("account.getCost():" + account.getCost());
		} catch (Exception e) {
			account.setCost(0);
			// 出现异常时插入系统日志表
			System.out.println("account.setCost()异常，其初始化值为:" + account.getCost());
			systemLogService.save(new Date(), 2, admin, "UserCarAction中add()设置addAccount_Cost参数时的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
		}
		System.out.println("param_card_type.getPname():" + param_card_type.getPname() + "---------param_card_type.getPvalue():" + param_card_type.getPvalue());
		System.out.println("----------------------------------测试成功-------------------------------------------------");
*/
	}

	@Test
	@Rollback
	public void testSave() {
		/*System.out.println("-----------------------------testSave()--------------------------------------------");
		
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction中add()设置card_type参数时set（），get（）参数时的异常", admin);
		if (null != carService.getCar("111111")) {// 不能插入与数据库中任何一条相同的车牌号（销户的除外）
			// result = Result.FAIL;
			// return "1";
		}
		if (null != accountService.getAccount("cardNo")) {// 不能插入与数据库中任何一条相同的卡号
			// result = Result.FAIL1;
			// return "2";
		}*/
		admin = adminService.get(900000001);
		System.out.println(admin);

		Double lowestBalanceAfterConsume=0.0;
	    Double tollyLowestBalanceAC=0.0;
	    Double noEntryBalance=10.0;
	    Double lowBalanceNotice=50.0;
	    Double cost=0.0;
	    userCarAccountAction.setLowestBalanceAfterConsume(lowestBalanceAfterConsume);
	    userCarAccountAction.setTollyLowestBalanceAC(tollyLowestBalanceAC);
	    userCarAccountAction.setNoEntryBalance(noEntryBalance);
	    userCarAccountAction.setLowBalanceNotice(lowBalanceNotice);
	    userCarAccountAction.setCost(cost);
		user = new User();
		user.setAddress("地址");
		user.setCredentialsNo("身份证号");
		user.setCredentialsType(5);
		user.setMobileNumber("13751841933");
		user.setPhone("02039367936");
		user.setUserName("chengfuyuanTest");
		userCarAccountAction.setUser(user);
		car = new Car();
		car.setCarColour("yanse");
		car.setCarType(1);
		car.setVehPlate("vehPlate");
		userCarAccountAction.setCar(car);
		account = new Account();
		account.setCardNo("cardNO");
		account.setRemark("remark");
		account.setParkNo(1);
		userCarAccountAction.setAccount(account);
		//userCarAccountAction.save();
		
		/*
		 * System.out.println("account"+account); System.out.println("car"+car);
		 * System.out.println("user.sys_id"+account.getUser().getSys_id());
		 * System.out.println("userTemp"+userTemp);
		 */
		/*System.out.println("添加进去的用户名:" + userTemp.getUserName() + "-----------获得的用户名：" + account.getUser().getUserName());
		System.out.println("添加进去的车牌号:" + carTemp.getVehPlate() + "-----------获得的车牌号：" + car.getVehPlate());
		System.out.println("添加进去的备注:" + accountTemp.getRemark() + "-----------获得的备注：" + account.getRemark());
		assertEquals(userTemp.getUserName(), account.getUser().getUserName());
		assertEquals(carTemp.getVehPlate(), car.getVehPlate());
		assertEquals(accountTemp.getRemark(), account.getRemark());*/

		/*
		 * if(userTemp.getUserName().equals(account.getUser().getUserName())&&carTemp
		 * .
		 * getVehPlate().equals(car.getVehPlate())&&accountTemp.getRemark().equals
		 * (account.getRemark())){System.out.println(
		 * "-------------------------------测试成功------------------------------------------"
		 * ); }else {System.out.println(
		 * "-------------------------------测试失败------------------------------------------"
		 * ); }
		 */

	}

	@Test
	@Rollback
	public void testUpdateAccountAndSaveLog() {
		/*System.out.println("-----------------------------testUpdateAccountAndSaveLog()--------------------------------------------");
		accountTemp = accountService.get(1);
		carTemp = accountTemp.getCar();
		userTemp = accountTemp.getUser();
		car = accountTemp.getCar();

		
		 * //更改后的车牌不能与数据库中的车牌相同（销户的除外） if
		 * (!vehPlate.trim().equals(car.getVehPlate().trim())) { car =
		 * carService.getCar(car.getVehPlate().trim()); if (null != car) {
		 * carTemp.setVehPlate(vehPlate.trim()); result = Result.FAIL;
		 * 
		 * return accountList();
		 * 
		 * } } //更改后的卡号不能与数据库中的卡号相同（销户的除外） if
		 * (!cardNo.trim().equals(this.deleteFirstZero
		 * (accountTemp.getCardNo().trim()))) { account =
		 * accountService.getAccount
		 * (this.deleteFirstZero(account.getCardNo().trim())); if (null !=
		 * account) { accountTemp.setCardNo(cardNo.trim()); result =
		 * Result.FAIL1; return accountList();
		 * 
		 * } }
		 

		admin = adminService.get(900000001);
		// 设置卡账户类型，0为根据充值分为不写卡，1为写卡
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction中add()设置card_type参数时set（），get（）参数时的异常", admin);
		String cardNo1 = this.deleteFirstZero("222233");
		accountTemp.setCardNo(cardNo1);
		accountTemp.setRemark("updateRemark");
		userTemp.setUserName("updatename");
		userTemp.setCredentialsType(1);
		userTemp.setCredentialsNo("12334");
		userTemp.setPhone("123");
		userTemp.setMobileNumber("123");
		userTemp.setAddress("123");
		carTemp.setVehPlate("123v");
		carTemp.setCarType(5);
		carTemp.setCarColour("123");
		userService.update(userTemp);
		carService.update(carTemp);
		accountTemp.setUser(userTemp);
		accountTemp.setCar(carTemp);
		if ("0".equals(param_card_type.getPvalue())) {
			Double lba = mul(10, 100.0);
			Double tl = mul(10, 100.0);
			Double ne = mul(10, 100.0);
			Double lbn = mul(10, 100.0);
			accountTemp.setLowestBalanceAfterConsume(lba.intValue());
			accountTemp.setTollyLowestBalanceAC(tl.intValue());
			accountTemp.setNoEntryBalance(ne.intValue());
			accountTemp.setLowBalanceNotice(lbn.intValue());
		} else {
			accountTemp.setLowestBalanceAfterConsume(0);
			accountTemp.setTollyLowestBalanceAC(0);
			accountTemp.setNoEntryBalance(0);
			accountTemp.setLowBalanceNotice(0);
		}
		Double c = mul(10, 100.0);
		accountTemp.setCost(c.intValue());
		accountService.update(accountTemp);
		UpdateAccountLog updateAccountLog = new UpdateAccountLog();
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
		updateAccountLog.setOperatorName("123");
		updateAccountLog.setPrintNumber(0);
		updateAccountLogService.save(updateAccountLog);
		Account accountTemp = accountService.get(1);
		System.out.println("accountTemp" + accountTemp);
		account = accountService.getAccount("222233");
		car = carService.getCar("123v");
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(accountTemp.getSys_id());
		assertEquals(userTemp.getUserName(), account.getUser().getUserName());
		
		 * System.out.println("更新进去的用户名:"+userTemp.getUserName()+"-----------获得的用户名："
		 * +account.getUser().getUserName());
		 * System.out.println("更新进去的车牌号:"+carTemp
		 * .getVehPlate()+"-----------获得的车牌号："+car.getVehPlate());
		 * System.out.println
		 * ("更新进去的备注:"+accountTemp.getRemark()+"-----------获得的备注："
		 * +account.getRemark());
		 
		assertEquals(userTemp.getUserName(), account.getUser().getUserName());
		assertEquals(carTemp.getVehPlate(), car.getVehPlate());
		assertEquals(accountTemp.getRemark(), account.getRemark());
		assertEquals(accountTemp.getRemark(), updateAccountLog.getRemark());
		
		 * if(userTemp.getUserName().equals(account.getUser().getUserName())&&carTemp
		 * .
		 * getVehPlate().equals(car.getVehPlate())&&accountTemp.getRemark().equals
		 * (
		 * account.getRemark())&&accountTemp.getRemark().equals(updateAccountLog
		 * .getRemark())){System.out.println(
		 * "-------------------------------测试成功------------------------------------------"
		 * ); }else {System.out.println(
		 * "-------------------------------测试失败------------------------------------------"
		 * ); }
		 
*/
	}

	@Test
	@Rollback
	public void testBlackList() {
		/*admin = adminService.get(900000001);
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction中add()设置card_type参数时set（），get（）参数时的异常", admin);
		account = accountService.get(1);
		user = account.getUser();
		car = account.getCar();
		account.setStatus(7);
		account.setStatusUpdateTime(new Date());
		accountService.update(account);
		UpdateAccountLog updateAccountLog = new UpdateAccountLog();
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
		updateAccountLog.setOperatorName("122");
		updateAccountLog.setPrintNumber(0);
		updateAccountLogService.save(updateAccountLog);
		// 根据充值类型为不写卡时小区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		account = accountService.get(1);
		int status = account.getStatus();
		int seqNoTemp = updateAccountLogService.getSeqNoByAccountNo(1);
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNoAndSeqNo(1, seqNoTemp - 1);
		int statusTemp = updateAccountLog.getStatus();
		assertEquals(status, 7);
		assertEquals(statusTemp, 7);
*/
	}

	@Test
	@Rollback
	public void testBlackOut() {
		/*account = accountService.get(1);
		user = account.getUser();
		car = account.getCar();
		
		 * if (account.getStatus() != 7) { result = Result.FAIL3; return "edit";
		 * }
		 
		// 设置账户卡类型，0为根据充值分为不写卡，1为写卡
		admin = adminService.get(900000001);
		// 设置账户卡类型，0为根据充值分为不写卡，1为写卡
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction中add()设置card_type参数时set（），get（）参数时的异常", admin);
		account.setStatus(0);
		accountService.update(account);
		UpdateAccountLog updateAccountLog = new UpdateAccountLog();
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
		updateAccountLog.setOperatorName("123456");
		updateAccountLog.setPrintNumber(0);
		updateAccountLogService.save(updateAccountLog);
		// System.out.println(sysparamconf6.getPvalue());
		// 根据充值类型为不写卡时小区账户信息下发车道
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		account = accountService.get(1);
		int status = account.getStatus();
		int seqNoTemp = updateAccountLogService.getSeqNoByAccountNo(1);
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNoAndSeqNo(1, seqNoTemp - 1);
		int statusTemp = updateAccountLog.getStatus();
		assertEquals(status, 0);
		assertEquals(statusTemp, 0);*/
	}

	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[] { applicationContextFile };
	}

}
