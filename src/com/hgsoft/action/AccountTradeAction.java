package com.hgsoft.action;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.Account;
import com.hgsoft.entity.AccountTrade;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.User;
import com.hgsoft.entity.VAccountTrade;
import com.hgsoft.service.AccountSendParaService;
import com.hgsoft.service.AccountService;
import com.hgsoft.service.AccountTradeService;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.util.HashUtil;

/**
 * 
 * 
 */
@Controller
@Scope("prototype")
public class AccountTradeAction extends BaseAction {
	private User user;
	private Car car;
	private Account account;
	private Admin admin;
	private AccountTrade accountTrade;
	private VAccountTrade vAccountTrade;
	private Double fee;
	private Date startTime;
	private Date endTime;
	private String opTime;
	private String unusualAccountTrade;
	private Sysparamconf param_card_type;//卡类型参数对象
	private Sysparamconf param_cardRechargeSystem_path;//充值，冲正外部程序路径参数对象
	private String card_type = "card_type";
	private String card_type_remark = "卡类型参数（0就是充值时写卡，1就是冲正时不写卡,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	private String CardRechargeSystem_path = "CardRechargeSystem_path";
	private String CardRechargeSystem_remark = "充值类型为写卡时充值和冲正软件路径，没设置是初始化为C:/充值和冲正/CardRechargeSystem.exe";
	@Resource
	private AccountTradeService accountTradeService;
	@Resource
	private AccountService accountService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private AdminService adminService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private AccountSendParaService accountSendParaService;
	// 流水效验时间
	private Date verify_startTime;
	private Date verify_endTime;
	// 选择流水显示
	private String validateCheck;
	// 效验流水总记录数
	private final long count = 10000;
	private long overCount;
	private LinkedHashMap<String, VAccountTrade> validateMap;

	public double mul(double d1, double d2) { // 精度结算转换，不用这个函数会出错，比如：41070.7(double型)*100会出错		
		BigDecimal bd1 = null;
		BigDecimal bd2 = null;
		try {
			bd1 = new BigDecimal(Double.toString(d1));
			bd2 = new BigDecimal(Double.toString(d2));
			return bd1.multiply(bd2).doubleValue();
		} catch (Exception e) {
			// 出现异常插入系统日志表
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "AccountTradeAction中mul(double d1,double d2)精度结算转换时发生的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
			e.printStackTrace();
			return 0;
		}

	}

	// ------------------------------------------下面为冲正操作-------------------------------------------------------------

	public String queryToCorrect() {
		//list = vAccountTradeService.findAllItem(pager);
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		endTime = new Date();
		return "queryToCorrect";
	}
	/**
	 * 将list中根据accountNO加上用户名，证件号码，账号状态
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List addProperty(List tempList){
		List list = new ArrayList();
		for(int i=0;i<tempList.size();i++){
			Object[] a =(Object[])(tempList.get(i));
			Object[] b=  new Object[12];
			b[0] = a[0];b[1] = a[1];b[2] = a[2];
			b[3] = a[3];b[4] = a[4];b[5] = a[5];
			b[6] = a[6];b[7] = a[7];b[8] = a[8];			
			int sys_id = Integer.valueOf(a[0].toString());
			Account account = accountService.getAccountBySysID(sys_id);
			if(account!=null){
				b[9] = account.getUser().getUserName();
				b[10] = account.getUser().getCredentialsNo();
				b[11] = account.getStatus();
			} else{
				b[9] = "此账户已不存在";
				b[10] = null;
				b[11] = null;
			}
             list.add(b);
	}
		return list;
	}

	public String queryAccountToCorrect() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startDate = sdf.format(startTime);
		String endDate = sdf.format(endTime);
		list = accountTradeService.findAllItemBySql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), accountTrade.getTradeType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(), startDate, endDate,0);
		list = this.addProperty(list);
		return "queryToCorrect";
	}

	public String correct() {
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型,0为充值时不写卡类型，1为充值时写卡类型
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountTradeAction中save()设置card_type参数时set（），get（）参数时的异常", admin);
		// 设置充值，冲正路径
		param_cardRechargeSystem_path = sysparamconfService.queryOrSave(CardRechargeSystem_path, "C:/充值和冲正/CardRechargeSystem.exe", CardRechargeSystem_remark, "AccountTradeAction中correct()设置CardRechargeSystem_path参数时set（），get（）参数时的异常", admin);
		try {
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
		} catch (Exception e) {
			param_cardRechargeSystem_path.setPvalue("C:/充值和冲正/CardRechargeSystem.exe");
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
			admin = adminService.get(getCurrentOperator().getId());
			// 出现异常插入系统日志表
			systemLogService.save(new Date(), 2, admin, "AccountTradeAction中correct()设置CardRechargeSystem_path参数时set（），get（）参数时的异常", e.getMessage(), "Exception");

		}
		account = accountService.get(account.getSys_id());
		accountTrade.setOpTime(accountTrade.getOpTime());
		accountTrade.setListNo(accountTrade.getListNo().trim());
		accountTrade.setFee(accountTrade.getFee());
		accountTrade.setCardNo(accountTrade.getCardNo());
		return "correct";
	}

	public String correctEdit() {
		admin = adminService.get(getCurrentOperator().getId());
		opTime = accountTrade.getOpTime();// 从页面传被冲正交易流水的opTime，根据opTime中的月份知道此被冲正交易流水处于12个表中的那个表中，以标记为已被冲正
		String listNo = accountTrade.getListNo();// 从页面传过来的被冲正交易流水的listNo，以冲表中把此交易流水查询出来标记为已被冲正
		String cardNo = accountTrade.getCardNo();
		int seqNo = 0;
		int month = 1;
		String s = "";
		Double fee1 = mul(fee, 100.0);
		int fee2 = fee1.intValue();
		account = accountService.get(account.getSys_id());
		if (account.getBalance() < fee2) {// 冲正后余额小于0时不能冲正
			accountTrade.setFee(fee2);
			result = Result.FAIL4;
			return "correct";
		} else if(!account.getCardNo().trim().equals(cardNo.trim())){
			accountTrade.setFee(fee2);
			result = Result.FAIL5;
			return "correct";
		} else {
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
				// 出现异常插入系统日志表
				systemLogService.save(new Date(), 2, admin, "AccountTradeAction中correctEdit（）时获得交易流水表钟序号时发生的异常", e.getMessage(), "Exception");
				e.printStackTrace();
			}
			accountTrade.setSeqNo(seqNo);
			accountTrade.setTradeType(2);
			accountTrade.setBackoutedListNo(accountTrade.getListNo().trim());
			accountTrade.setCardNo(account.getCardNo());
			accountTrade.setCardType(account.getCardType());
			accountTrade.setTradeTime(nowdate);
			accountTrade.setFee(-fee2);
			accountTrade.setBalance(account.getBalance() - fee2);
			accountTrade.setCardBalance(0);
			accountTrade.setBackoutedMark(1);
			accountTrade.setParkNo(account.getParkNo());
			accountTrade.setVehPlate(account.getCar().getVehPlate());
			accountTrade.setOpTime(nowdate);
			accountTrade.setOperatorID(getCurrentOperator().getId());
			accountTrade.setOperatorPassword(getCurrentOperator().getPassword());
			
			try {
				// 设置交易流水号
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				String nowdate1 = sdf2.format(new Date());
				s = "T" + nowdate1 + "_" + getCurrentOperator().getId().toString();
			} catch (Exception e) {
				systemLogService.save(new Date(), 2, admin, "AccountTradeAction中correctEdit（）时获得交易流水号时发生的异常", e.getMessage(), "ClassCastException（类型强制转换异常）");
				e.printStackTrace();
			}
			accountTrade.setListNo(s);
			// 去掉null
			String yanzheng = accountTradeService.deleteNull(account.getSys_id(), accountTrade.getSeqNo(), accountTrade.getTradeType(), accountTrade.getFee(), accountTrade.getBalance(), accountTrade.getCardNo(), accountTrade.getCardType(), accountTrade.getVehPlate(), accountTrade.getListNo(), getCurrentOperator().getId(), getCurrentOperator().getPassword(), accountTrade.getTradeTime(), accountTrade.getOpTime());
			String yanzhengTemp = HashUtil.getMD5String(yanzheng);// md5密匙，目的是查询有没有修改过这条交易信息
			accountTrade.setVerify(yanzhengTemp);
			accountTradeService.save(accountTrade);
			try {
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date1 = sdf1.parse(opTime);
				Calendar calendar1 = Calendar.getInstance();
				calendar1.setTime(date1);
				month = calendar1.get(Calendar.MONTH) + 1;
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 根据月份和交易流水号标识该流水已被冲正过
			accountTradeService.updateBackoutedMark(month, listNo);
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户冲正成功，流水号为："+accountTrade.getListNo(),
					"缴费卡账户管理--冲正", "t_park_accountTrade");
			accountSendParaService.SendPara();
			return "printCorrectAccount";
		}

	}

	public String printCorrect() {

		return "printCorrect";

	}

	// --------------------------上面为冲正操作，下面为交易流水查询操作--------------------------------------------------
	public String queryAccountTrade() {
		endTime = new Date();
		return "queryAccountTrade";
	}

	public String queryAccountToQueryAccountTrde() {
		String startTimeTemp = "";
		String endTimeTemp = "";
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == accountTrade.getTradeType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus() && startTime == null && endTime == null) {
			return queryAccountTrade();
		} else {
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (startTime != null) {

					startTimeTemp = sdf.format(startTime);// 换格式为yyyy-MM-dd HH:mm:ss与数据库中的时间格式相同才能比较大小
				}
				if (endTime != null) {

					endTimeTemp = sdf.format(endTime);
				}

			} catch (Exception e) {

				admin = adminService.get(getCurrentOperator().getId());
				// 出现异常时插入系统日志表
				systemLogService.save(new Date(), 2, admin, "AccountTradeAction中queryAccountToQueryAccountTrde()时间format()时的异常", e.getMessage(), "Exception");
			}
			if(null !=unusualAccountTrade && !"".equals(unusualAccountTrade)){
				list = accountTradeService.findAllUnusualAccountTradeBySql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), accountTrade.getTradeType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(), startTimeTemp, endTimeTemp);
			} else {
				list = accountTradeService.findAllItemBySql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), accountTrade.getTradeType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(), startTimeTemp, endTimeTemp,1);
			}
			
		    list = this.addProperty(list);
		}
		return "queryAccountTrade";

	}

	// 查看该交易流水的详细信息
	public String detail() throws ParseException {
		String listNo = accountTrade.getListNo();// 从页面传过来的交易流水的listNo，以从v_AccountTrade中查出此交易流水
		account = accountService.get(account.getSys_id());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(sdf.parse(accountTrade.getOpTime()));
		//vAccountTrade = vAccountTradeService.getVAccountTradeByAccountNoAndlistNo(listNo,calendar.get(Calendar.MONTH) + 1);
		list = accountTradeService.getAccountTradeByMonthAndListNo(calendar.get(Calendar.MONTH) + 1, listNo);
		return "show";
	}

	/**
	 * qinzuohai 账户最新余额查询
	 * 
	 * public String latestBalance(){
	 * list=accountTradeService.findAllLatestBalance(pager); return
	 * "latestBalance"; } public String queryLatestBalance(){
	 * System.out.println(
	 * "--输入条件：--"+accountTrade.getAccount().getUser().getUserName
	 * ()+" "+accountTrade
	 * .getAccount().getCar().getVehPlate()+" "+accountTrade.getAccount
	 * ().getSys_id());
	 * list=accountTradeService.findLatestAccountBalanceForSingle(pager,
	 * accountTrade.getAccount().getUser().getUserName(),
	 * accountTrade.getAccount().getCar().getVehPlate(),
	 * accountTrade.getAccount().getSys_id(), accountTrade.getCardNo()); return
	 * "queryLatestBalance"; } *
	 */
	// 流水查询
	public String validateVerify() {
		//list = vAccountTradeService.findByPager(pager);
		endTime = new Date();
		return "validateVerify";
	}
	/*public String queryAccountTradeToVerify(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startDate = sdf.format(startTime);
		String endDate = sdf.format(endTime);
		list = accountTradeService.findAllItemBySql(pager, null, account.getCardNo(), user.getUserName(), accountTrade.getTradeType(),null, car.getVehPlate(), null, startDate, endDate,1);
		list = this.addProperty(list);
		return "validateVerify";
	}*/
	// 流水MD5效验
	public String queryvalidateVerify() {
			// 流水密匙
			String TRADE_MD5_ENCRYPT_KEY = "!%$&()&JKGDE0973x][";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String startDate = sdf.format(startTime);
			String endDate = sdf.format(endTime);
			list = accountTradeService.findVerifyAccountTrade(pager, TRADE_MD5_ENCRYPT_KEY,startDate, endDate, user.getUserName().trim(),account.getCardNo().trim(), car.getVehPlate().trim(), accountTrade.getTradeType(),validateCheck);
			/*this.overCount = vAccountTradeService.findAccountTradeStartTimeToEndTime(TRADE_MD5_ENCRYPT_KEY,
					verify_startTime, verify_endTime, accountTrade.getAccount().getUser().getUserName(),
					accountTrade.getCardNo(), accountTrade.getVehPlate(), accountTrade.getTradeType());
			if (this.overCount < count) {*/
				// 效验MD5
				/*if (validateCheck.equals("validateAll")) {
					list = accountTradeService.findVerifyAccountTrade(pager, TRADE_MD5_ENCRYPT_KEY,startDate, endDate, user.getUserName(),account.getCardNo(), car.getVehPlate(), accountTrade.getTradeType(),validateCheck);
				}
				if (validateCheck.equals("correct")) {
					list = vAccountTradeService.findPassValidateAccountTrade(pager, TRADE_MD5_ENCRYPT_KEY,
							verify_startTime, verify_endTime, accountTrade.getAccount().getUser().getUserName(),
							accountTrade.getCardNo(), accountTrade.getVehPlate(), accountTrade.getTradeType());
				}
				if (validateCheck.equals("incorrect")) {
					list = vAccountTradeService.findFailValidateAccountTrade(pager, TRADE_MD5_ENCRYPT_KEY,
							verify_startTime, verify_endTime, accountTrade.getAccount().getUser().getUserName(),
							accountTrade.getCardNo(), accountTrade.getVehPlate(), accountTrade.getTradeType());
				}*/
				return "queryvalidateVerify";
				/*} else {
				return validateVerify();
			}	*/	
	}

	// Getters/Setters方法
	public Sysparamconf getParam_card_type() {
		return param_card_type;
	}

	public void setParam_card_type(Sysparamconf paramCardType) {
		param_card_type = paramCardType;
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

	public AccountTrade getAccountTrade() {
		return accountTrade;
	}

	public void setAccountTrade(AccountTrade accountTrade) {
		this.accountTrade = accountTrade;
	}

	public VAccountTrade getVAccountTrade() {
		return vAccountTrade;
	}

	public void setVAccountTrade(VAccountTrade vAccountTrade) {
		this.vAccountTrade = vAccountTrade;
	}

	public long getCount() {
		return count;
	}

	public Sysparamconf getParam_cardRechargeSystem_path() {
		return param_cardRechargeSystem_path;
	}

	public void setParam_cardRechargeSystem_path(Sysparamconf paramCardRechargeSystemPath) {
		param_cardRechargeSystem_path = paramCardRechargeSystemPath;
	}

	public Double getFee() {
		return fee;
	}

	public void setFee(Double fee) {
		this.fee = fee;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Date getVerify_startTime() {
		return verify_startTime;
	}

	public void setVerify_startTime(Date verifyStartTime) {
		verify_startTime = verifyStartTime;
	}

	public Date getVerify_endTime() {
		return verify_endTime;
	}

	public void setVerify_endTime(Date verifyEndTime) {
		verify_endTime = verifyEndTime;
	}

	public String getValidateCheck() {
		return validateCheck;
	}

	public void setValidateCheck(String validateCheck) {
		this.validateCheck = validateCheck;
	}

	public long getOverCount() {
		return overCount;
	}

	public void setOverCount(long overCount) {
		this.overCount = overCount;
	}

	public LinkedHashMap<String, VAccountTrade> getValidateMap() {
		return validateMap;
	}

	public void setValidateMap(LinkedHashMap<String, VAccountTrade> validateMap) {
		this.validateMap = validateMap;
	}
	public String getUnusualAccountTrade() {
		return unusualAccountTrade;
	}

	public void setUnusualAccountTrade(String unusualAccountTrade) {
		this.unusualAccountTrade = unusualAccountTrade;
	}

	

}
