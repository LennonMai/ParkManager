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
	
	

	public double mul(double d1, double d2) { // ���Ƚ���ת�����������������������磺41070.7(double��)*100�����
		BigDecimal bd1 = null;
		BigDecimal bd2 = null;
		try {
			bd1 = new BigDecimal(Double.toString(d1));
			bd2 = new BigDecimal(Double.toString(d2));
			return bd1.multiply(bd2).doubleValue();
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��mul(double d1,double d2)�������Ƚ���ת��ʱ�������쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
			e.printStackTrace();

			return 0;
		}

	}

	public String deleteFirstZero(String s) {// ȥ������ǰ���0
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
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��deleteFirstZero(String s)ȥ������ǰ���0ʱ�����쳣", e.getMessage(), "StringIndexOutOfBoundsException���ַ�Խ���쳣��");
			e.printStackTrace();
		}

		return s;

	}

	public UserCarAccountAction() {
		updateAccountLog = new UpdateAccountLog();
		accountTrade = new AccountTrade();
	}

	public String queryList() {// ������ѯҳ��
		list = accountService.findByPager(pager);
		listPark = parkInformationService.getAllParkInformation();
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction��queryList()����card_type����ʱset������get��������ʱ���쳣", admin);
		return "queryToAdd";
	}

	public String queryAccountToAdd() {// ��ѯ�˻�
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()&& null == account.getParkNo()) {
			return queryList();
		} else {
			admin = adminService.get(getCurrentOperator().getId());
			// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction��queryList()����card_type����ʱset������get��������ʱ���쳣", admin);
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),account.getParkNo());
			listPark = parkInformationService.getAllParkInformation();
			return "queryToAdd";
		}
	}

	public String add() {// �ӡ�����ϵͳ��������ó�ʼֵ
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction��add()����card_type����ʱset������get��������ʱ���쳣", admin);

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
		//���ÿ��ų���
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "�ɷѿ��˻�����ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9����", "UserCarAction��add()����accountCardNoLength����ʱ���쳣", admin);
		
		account = new Account();

		try {
			value = mul(Double.valueOf(param_addAccount_LowestBalanceAfterConsume.getPvalue()), 100.0);
			account.setLowestBalanceAfterConsume(value.intValue());// �����˻���������
		} catch (Exception e) {
			account.setLowestBalanceAfterConsume(0);
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��add()����addAccount_LowestBalanceAfterConsume����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}
		try {
			value = mul(Double.valueOf(param_addAccount_TollyLowestBalanceAC.getPvalue()), 100.0);
			account.setTollyLowestBalanceAC(value.intValue());// �����˻��м���������
		} catch (Exception e) {
			account.setTollyLowestBalanceAC(0);
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��add()����addAccount_TollyLowestBalanceAC����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_NoEntryBalance.getPvalue()), 100.0);
			account.setNoEntryBalance(value.intValue());// �����˻��н�ֹʻ��������
		} catch (Exception e) {
			account.setNoEntryBalance(1500);
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCaAccountrAction��add()����addAccount_NoEntryBalance����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_LowBalanceNotice.getPvalue()), 100.0);
			account.setLowBalanceNotice(value.intValue());// �����˻�����ʾ�û�ȥ���ѵ�������
		} catch (Exception e) {
			account.setLowBalanceNotice(5000);
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��add()����addAccount_LowBalanceNotice����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}

		try {
			value = mul(Double.valueOf(param_addAccount_Cost.getPvalue()), 100.0);
			account.setCost(value.intValue());// �����˻��й�����
		} catch (Exception e) {
			account.setCost(0);
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��add()����addAccount_Cost����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��add()����param_accountCardNoLength����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
		}
		list = parkInformationService.getAllParkInformation();
		return ADD;
	}

	public String save() {// ������������ݿ⣬user car accountһ��������ݿ�
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction��save()����card_type����ʱset������get��������ʱ���쳣", admin);
	//	if (null != carService.getCar(car.getVehPlate().trim())) {// ���ܲ��������ݿ����κ�һ����ͬ�ĳ��ƺţ������ĳ��⣩
		//	result = Result.FAIL;
		//	return add();
		//}
	//	if (null != accountService.getAccount(this.deleteFirstZero(account.getCardNo().trim())) || null != userCardInfoService.getUserCardInfoByCardNo(this.deleteFirstZero(account.getCardNo().trim()))) {// ���ܲ��������ݿ����κ�һ����ͬ�Ŀ��ţ������ĳ��⣩
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
		// ���ݳ�ֵ���ͷ�Ϊ��ֵ��д��ʱ�����˻�������������������ֹʻ���������ʾ�û�ȥ���ѵ�������
		if ("1".equals(param_card_type.getPvalue())) {
			accountTemp.setLowestBalanceAfterConsume(0);
			accountTemp.setTollyLowestBalanceAC(0);
			accountTemp.setNoEntryBalance(0);
			accountTemp.setLowBalanceNotice(0);

		} else {// ���ݳ�ֵ���ͷ�Ϊ��ֵ�ǲ�д��ʱ�����˻�������������������ֹʻ���������ʾ�û�ȥ���ѵ�������
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
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��save����������ʱ��1����ʱ�������쳣", e.getMessage(), "Exception");
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
		int sys_id = accountService.getUserSysid();// �û�������ڵ�ǰ����ż�1����һ���˻��û����Ϊ1
		try {
			userService.insertUser(sys_id, userTemp.getUserName(), userTemp.getCredentialsType(), userTemp.getCredentialsNo(), userTemp.getPhone(), userTemp.getMobileNumber(), userTemp.getAddress());
		} catch (DataIntegrityViolationException e) {// sys_id��ͻ�������»��һ��sys_id��
			sys_id = accountService.getUserSysid();// �û�������ڵ�ǰ����ż�1����һ���˻��û����Ϊ1
			user.setSys_id(sys_id);
			userService.insertUser(sys_id, user.getUserName(), user.getCredentialsType(), user.getCredentialsNo(), user.getPhone(), user.getMobileNumber(), user.getAddress());
		}
		userTemp = userService.get(sys_id);
		// �������
		accountTransactionService.saveTransaction(userTemp, carTemp, accountTemp, accountTrade, updateAccountLog, getCurrentOperator(), admin);
		Account accountTest=accountService.getAccountByUserID(sys_id);//���⵱�û���Ϣ�������ݿ���������ɹ���account��Ϣû����ɹ���ʱɾ���û���Ϣ�������û�������������
		if(accountTest==null){
			userService.deleteById(sys_id);
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û�����ʱ���񿪻����ɹ�ʱɾ���û�["+sys_id+"]��Ϣ�ɹ����Է���������",
					"�ɷѿ��˻�����--����", "t_park_user");
		}
		// ���ݳ�ֵ����Ϊ��д��ʱС���˻���Ϣ�·�����
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		if(account.getParkNo()!=null && !account.getParkNo().equals("")){
			parkInformation = parkInformationService.getParkInformationByParkNo(account.getParkNo().shortValue());	
		}		
		return "printAddAccount";

	}

	// -----------------------------------------����Ϊ����������Ϊ�����˻���Ϣ----------------------------------------

	public String query() {
		list = accountService.findByPager(pager);
		listPark = parkInformationService.getAllParkInformation();
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction��query()����card_type����ʱset������get��������ʱ���쳣", admin);
		return "queryToUpdate";
	}

	public String queryAccountToUpdate() {
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()&& null == account.getParkNo()) {
			return query();
		} else {
			admin = adminService.get(getCurrentOperator().getId());
			// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
			param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCaAccountrAction��query()����card_type����ʱset������get��������ʱ���쳣", admin);
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),account.getParkNo());
			listPark = parkInformationService.getAllParkInformation();
			return "queryToUpdate";
		}
	}

	public String accountList() {
		admin = adminService.get(getCurrentOperator().getId());
		// ���ÿ��˻�����
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction��accountList()����card_type����ʱset������get��������ʱ���쳣", admin);
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "�ɷѿ��˻�����ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9����", "UserCarAction��add()����accountCardNoLength����ʱ���쳣", admin);
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue().trim());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��add()����param_accountCardNoLength����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
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

	public String updateAccountAndSaveLog() {// ����user car
												// account��Ϣ��ͬʱҲ���޸ĺ��user car
												// account��Ϣ���뵽�����˻���־����
		accountTemp = accountService.get(account.getSys_id());
		carTemp = accountTemp.getCar();
		userTemp = accountTemp.getUser();
		// car = accountTemp.getCar();

		// ���ĺ�ĳ��Ʋ��������ݿ��еĳ�����ͬ�������ĳ��⣩
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
		 * } } // ���ĺ�Ŀ��Ų��������ݿ��еĿ�����ͬ�������ĳ��⣩
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
		// ���ÿ��˻����ͣ�0Ϊ���ݳ�ֵ��Ϊ��д����1Ϊд��
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction��updateAccountAndSaveLog()����card_type����ʱset������get��������ʱ���쳣", admin);
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
		if ("0".equals(param_card_type.getPvalue())) {// ������Ϊ��д��ʱ
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
		} else {// ������Ϊд��ʱ
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
		// ���ݳ�ֵ����Ϊ��д��ʱС���˻���Ϣ�·�����
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		return "printUpdateAccount";
	}

	public String blackList() {// �ƽ�������
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻������ͣ�0Ϊ���ݳ�ֵ��Ϊ��д����1Ϊд��
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction��blackList()����card_type����ʱset������get��������ʱ���쳣", admin);
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "�ɷѿ��˻�����ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9����", "UserCarAction��add()����accountCardNoLength����ʱ���쳣", admin);
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue().trim());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��blackList()����param_accountCardNoLength����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
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
		// ���ݳ�ֵ����Ϊ��д��ʱС���˻���Ϣ�·�����
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}

		result = Result.FAIL2;

		return "edit";
	}

	public String blackOut() {// �Ƴ������������޸�ҳ���Ƴ�������
		account = accountService.get(sys_id);
		user = account.getUser();
		car = account.getCar();
		if (account.getStatus() != 7) {
			result = Result.FAIL3;
			return "edit";
		}
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻������ͣ�0Ϊ���ݳ�ֵ��Ϊ��д����1Ϊд��
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction��blackOut()����card_type����ʱset������get��������ʱ���쳣", admin);
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "�ɷѿ��˻�����ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9����", "UserCarAction��add()����accountCardNoLength����ʱ���쳣", admin);
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue().trim());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��blackOut()����param_accountCardNoLength����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
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
		// ���ݳ�ֵ����Ϊ��д��ʱС���˻���Ϣ�·�����
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		result = Result.FAIL4;
		return "edit";
	}

	public String blackOutOne() {// �Ƴ����������ڲ�ѯҳ���Ƴ���������������ķ��ز�ͬ��
		accountTemp = accountService.get(sys_id);
		userTemp = accountTemp.getUser();
		carTemp = accountTemp.getCar();
		if (accountTemp.getStatus() != 7) {
			result = Result.FAIL3;
			return "edit";
		}
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻������ͣ�0Ϊ���ݳ�ֵ��Ϊ��д����1Ϊд��
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UserCarAccountAction��blackOutOne()����card_type����ʱset������get��������ʱ���쳣", admin);
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "�ɷѿ��˻�����ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9����", "UserCarAction��add()����accountCardNoLength����ʱ���쳣", admin);
		try {
			int length = Integer.valueOf(param_accountCardNoLength.getPvalue().trim());
			if(length<=0 || length>10){
				param_accountCardNoLength.setPvalue("10");
			}
		} catch (Exception e) {
			param_accountCardNoLength.setPvalue("10");
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "UserCarAction��blackOutOne()����param_accountCardNoLength����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
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
		// ���ݳ�ֵ����Ϊ��д��ʱС���˻���Ϣ�·�����
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		result = Result.FAIL4;
		return queryAccountToUpdate();
	}

	public String getCarByVehPlate() {// jquery��֤�����Ƿ����
		Car car1 = carService.getCar(car.getVehPlate().trim());
		UserCardInfo userCardInfo = userCardInfoService.getUserCardInfoByVehPlate(car.getVehPlate().trim());
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
		if (car1 == null && userCardInfo==null) {
			out.println("success");

		} else {
			out.print("fail");

		}
		return null;
	}

	public String getAccountByCardNo() {// jquery��֤�����Ƿ����

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
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��getAccountByCardNo������֤�����Ƿ������ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (account1 != null || idCardInfo!=null || userCardInfo!=null) {
			out.print("fail1");
		} else if (cardInfo != null && storeCardBlackList == null) {
			if (cardInfo.getStatus() != 0) {
				out.print("statusNoUse");// ������ʾ�ÿ��ڿ���Ϣ�в�������������������
			} else {
				out.println("success1");
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

	public String printAdd() {// ��ӡ������Ϣ
		 accountTemp = accountService.get(accountTemp.getSys_id());
	     if(accountTemp.getParkNo()!=null && !accountTemp.getParkNo().equals("")){
		    parkInformation = parkInformationService.getParkInformationByParkNo(accountTemp.getParkNo().shortValue());	
		 }
	     carTemp = accountTemp.getCar();
	     userTemp = accountTemp.getUser();
		return "printAdd";

	}

	public String printUpdate() {// ��ӡ�����˻���Ϣ
	    accountTemp = accountService.get(accountTemp.getSys_id());
	    if(accountTemp.getParkNo()!=null && !accountTemp.getParkNo().equals("")){
		   parkInformation = parkInformationService.getParkInformationByParkNo(accountTemp.getParkNo().shortValue());	
	    }
	    carTemp = accountTemp.getCar();
	    userTemp = accountTemp.getUser();
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(accountTemp.getSys_id());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);
		updateAccountLogService.update(updateAccountLog);// ��ӡ������1
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
