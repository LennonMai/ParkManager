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
	private String card_type = "card_type";// �����ͣ�0Ϊ���˿���1Ϊ��ֵ��
	private String card_type_remark = "�˻����Ͳ�����0���ǳ�ֵ��д����1���ǳ�ֵд��,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)";
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
		
		assertNotNull("iCCardActionΪ��", userCarAccountAction);
		
	}
	public void testMul(){
		double test=userCarAccountAction.mul(11.1, 100);
		assertEquals(test,1110.0);
	}
	public void testDeleteFirstZero(){
		String test=userCarAccountAction.deleteFirstZero("00001234560789");
		assertEquals(test,"1234560789");
	}
	/*public double mul(double d1, double d2) { // ���Ƚ���ת�����������������������磺41070.7(double��)*100�����
		Admin admin = adminService.get(900000001);
		BigDecimal bd1 = null;
		BigDecimal bd2 = null;
		try {
			bd1 = new BigDecimal(Double.toString(d1));
			bd2 = new BigDecimal(Double.toString(d2));
			return bd1.multiply(bd2).doubleValue();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "UserCarAction��mul(double d1,double d2)�������Ƚ���ת��ʱ�������쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
			e.printStackTrace();

			return 0;
		}

	}

	public String deleteFirstZero(String s) {// ȥ������ǰ���0
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
			systemLogService.save(new Date(), 2, admin, "UserCarAction��deleteFirstZero(String s)ȥ������ǰ���0ʱ�����쳣", e.getMessage(), "StringIndexOutOfBoundsException���ַ�Խ���쳣��");
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
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction��add()����card_type����ʱset������get��������ʱ���쳣", admin);

		// �����˻���������
		param_addAccount_LowestBalanceAfterConsume = sysparamconfService.queryOrSave("addAccount_LowestBalanceAfterConsume", "0", "�����е��������λ��Ԫ��������ֵҪ����������0" + "�����磺10��С�������Ϊ2λ��" + "������λʱ��ֱ�ӰѺ����С����ȥ�㣩�������ʼ��Ϊ0��", "UserCarAction��add()����addAccount_LowestBalanceAfterConsume����ʱ���쳣", admin);

		// �����˻��м���������
		param_addAccount_TollyLowestBalanceAC = sysparamconfService.queryOrSave("addAccount_TollyLowestBalanceAC", "0", "�����еļ����������λ��Ԫ��������ֵҪ����������0��" + "���磺10��С�������Ϊ2λ��" + "������λʱ��ֱ�ӰѺ����С����ȥ�㣩�������ʼ��Ϊ0��", "UserCarAction��add()����addAccount_TollyLowestBalanceAC����ʱ���쳣", admin);

		// �����˻��н�ֹʻ��������
		param_addAccount_NoEntryBalance = sysparamconfService.queryOrSave("addAccount_NoEntryBalance", "15", "�����еĽ�ֹʻ���������λ��Ԫ��������ֵҪ����������0" + "�����磺15��С�������Ϊ2λ��" + "������λʱ��ֱ�ӰѺ����С����ȥ�㣩������ϵͳ��ʼ��Ϊ15��", "UserCarAction��add()����addAccount_NoEntryBalance����ʱ���쳣", admin);

		// �����˻�����ʾ�û�ȥ���ѵ�������
		param_addAccount_LowBalanceNotice = sysparamconfService.queryOrSave("addAccount_LowBalanceNotice", "50", "�����е���ʾ�û�ȥ���ѵ��������λ��Ԫ��������ֵҪ����������0" + "��С�������Ϊ2λ��" + "������λʱ��ֱ�ӰѺ����С����ȥ�㣩������ϵͳ��ʼ��Ϊ50��", "UserCarAction��add()����addAccount_LowBalanceNotice����ʱ���쳣", admin);

		// �����˻��й�����
		param_addAccount_Cost = sysparamconfService.queryOrSave("addAccount_Cost", "0", "���������ѣ���λ��Ԫ��������ֵҪ����������0�����磺10��С�������Ϊ2λ��" + "������λʱ��ֱ�ӰѺ����С����ȥ�㣩�������ʼ��Ϊ0��", "UserCarAction��add()����addAccount_Cost����ʱ���쳣", admin);
		Account account = new Account();

		try {
			value = mul(Double.valueOf(param_addAccount_LowestBalanceAfterConsume.getPvalue()), 100.0);
			account.setLowestBalanceAfterConsume(value.intValue());// �����˻���������
			System.out.println("account.getLowestBalanceAfterConsume():" + account.getLowestBalanceAfterConsume());
		} catch (Exception e) {
			account.setLowestBalanceAfterConsume(0);
			System.out.println("account.setLowestBalanceAfterConsume()�쳣�����ʼ��ֵΪ:" + account.getLowestBalanceAfterConsume());
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��add()����addAccount_LowestBalanceAfterConsume����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}
		try {
			value = mul(Double.valueOf(param_addAccount_TollyLowestBalanceAC.getPvalue()), 100.0);
			account.setTollyLowestBalanceAC(value.intValue());// �����˻��м���������
			System.out.println("account.getTollyLowestBalanceAC()):" + account.getTollyLowestBalanceAC());
		} catch (Exception e) {
			account.setTollyLowestBalanceAC(0);
			System.out.println("account.setTollyLowestBalanceAC())�쳣�����ʼ��ֵΪ:" + account.getTollyLowestBalanceAC());
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��add()����addAccount_TollyLowestBalanceAC����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_NoEntryBalance.getPvalue()), 100.0);
			account.setNoEntryBalance(value.intValue());// �����˻��н�ֹʻ��������
			System.out.println("account.getNoEntryBalance():" + account.getNoEntryBalance());
		} catch (Exception e) {
			account.setNoEntryBalance(1500);
			System.out.println("account.setNoEntryBalance()�쳣�����ʼ��ֵΪ:" + account.getNoEntryBalance());
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��add()����addAccount_NoEntryBalance����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_LowBalanceNotice.getPvalue()), 100.0);
			account.setLowBalanceNotice(value.intValue());// �����˻�����ʾ�û�ȥ���ѵ�������
			System.out.println("account.getLowBalanceNotice():" + account.getLowBalanceNotice());
		} catch (Exception e) {
			account.setLowBalanceNotice(5000);
			System.out.println("account.setLowBalanceNotice()�쳣�����ʼ��ֵΪ:" + account.getLowBalanceNotice());
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��add()����addAccount_LowBalanceNotice����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_Cost.getPvalue()), 100.0);
			account.setCost(value.intValue());// �����˻��й�����
			System.out.println("account.getCost():" + account.getCost());
		} catch (Exception e) {
			account.setCost(0);
			// �����쳣ʱ����ϵͳ��־��
			System.out.println("account.setCost()�쳣�����ʼ��ֵΪ:" + account.getCost());
			systemLogService.save(new Date(), 2, admin, "UserCarAction��add()����addAccount_Cost����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}
		System.out.println("param_card_type.getPname():" + param_card_type.getPname() + "---------param_card_type.getPvalue():" + param_card_type.getPvalue());
		System.out.println("----------------------------------���Գɹ�-------------------------------------------------");
*/
	}

	@Test
	@Rollback
	public void testSave() {
		/*System.out.println("-----------------------------testSave()--------------------------------------------");
		
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction��add()����card_type����ʱset������get��������ʱ���쳣", admin);
		if (null != carService.getCar("111111")) {// ���ܲ��������ݿ����κ�һ����ͬ�ĳ��ƺţ������ĳ��⣩
			// result = Result.FAIL;
			// return "1";
		}
		if (null != accountService.getAccount("cardNo")) {// ���ܲ��������ݿ����κ�һ����ͬ�Ŀ���
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
		user.setAddress("��ַ");
		user.setCredentialsNo("���֤��");
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
		/*System.out.println("��ӽ�ȥ���û���:" + userTemp.getUserName() + "-----------��õ��û�����" + account.getUser().getUserName());
		System.out.println("��ӽ�ȥ�ĳ��ƺ�:" + carTemp.getVehPlate() + "-----------��õĳ��ƺţ�" + car.getVehPlate());
		System.out.println("��ӽ�ȥ�ı�ע:" + accountTemp.getRemark() + "-----------��õı�ע��" + account.getRemark());
		assertEquals(userTemp.getUserName(), account.getUser().getUserName());
		assertEquals(carTemp.getVehPlate(), car.getVehPlate());
		assertEquals(accountTemp.getRemark(), account.getRemark());*/

		/*
		 * if(userTemp.getUserName().equals(account.getUser().getUserName())&&carTemp
		 * .
		 * getVehPlate().equals(car.getVehPlate())&&accountTemp.getRemark().equals
		 * (account.getRemark())){System.out.println(
		 * "-------------------------------���Գɹ�------------------------------------------"
		 * ); }else {System.out.println(
		 * "-------------------------------����ʧ��------------------------------------------"
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

		
		 * //���ĺ�ĳ��Ʋ��������ݿ��еĳ�����ͬ�������ĳ��⣩ if
		 * (!vehPlate.trim().equals(car.getVehPlate().trim())) { car =
		 * carService.getCar(car.getVehPlate().trim()); if (null != car) {
		 * carTemp.setVehPlate(vehPlate.trim()); result = Result.FAIL;
		 * 
		 * return accountList();
		 * 
		 * } } //���ĺ�Ŀ��Ų��������ݿ��еĿ�����ͬ�������ĳ��⣩ if
		 * (!cardNo.trim().equals(this.deleteFirstZero
		 * (accountTemp.getCardNo().trim()))) { account =
		 * accountService.getAccount
		 * (this.deleteFirstZero(account.getCardNo().trim())); if (null !=
		 * account) { accountTemp.setCardNo(cardNo.trim()); result =
		 * Result.FAIL1; return accountList();
		 * 
		 * } }
		 

		admin = adminService.get(900000001);
		// ���ÿ��˻����ͣ�0Ϊ���ݳ�ֵ��Ϊ��д����1Ϊд��
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction��add()����card_type����ʱset������get��������ʱ���쳣", admin);
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
		
		 * System.out.println("���½�ȥ���û���:"+userTemp.getUserName()+"-----------��õ��û�����"
		 * +account.getUser().getUserName());
		 * System.out.println("���½�ȥ�ĳ��ƺ�:"+carTemp
		 * .getVehPlate()+"-----------��õĳ��ƺţ�"+car.getVehPlate());
		 * System.out.println
		 * ("���½�ȥ�ı�ע:"+accountTemp.getRemark()+"-----------��õı�ע��"
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
		 * "-------------------------------���Գɹ�------------------------------------------"
		 * ); }else {System.out.println(
		 * "-------------------------------����ʧ��------------------------------------------"
		 * ); }
		 
*/
	}

	@Test
	@Rollback
	public void testBlackList() {
		/*admin = adminService.get(900000001);
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction��add()����card_type����ʱset������get��������ʱ���쳣", admin);
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
		// ���ݳ�ֵ����Ϊ��д��ʱС���˻���Ϣ�·�����
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
		 
		// �����˻������ͣ�0Ϊ���ݳ�ֵ��Ϊ��д����1Ϊд��
		admin = adminService.get(900000001);
		// �����˻������ͣ�0Ϊ���ݳ�ֵ��Ϊ��д����1Ϊд��
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAction��add()����card_type����ʱset������get��������ʱ���쳣", admin);
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
		// ���ݳ�ֵ����Ϊ��д��ʱС���˻���Ϣ�·�����
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
