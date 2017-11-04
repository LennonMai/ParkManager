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
	private String card_type_remark = "�����Ͳ�����0���Ǹ��ݳ�ֵ����Ϊ��д����1Ϊд��,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)";
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
	private String CardRechargeSystem_remark = "��ֵ����Ϊд��ʱ��ֵ�ͳ������·����û�����ǳ�ʼ��ΪC:/��ֵ�ͳ���/CardRechargeSystem.exe";

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
			systemLogService.save(new Date(), 2, admin, "AccountAction��mul(double d1,double d2)���Ƚ���ת��ʱ�������쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
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
			systemLogService.save(new Date(), 2, admin, "AccountAction��deleteFirstZero(String s)ȥ������ǰ���0ʱ�����쳣", e.getMessage(), "StringIndexOutOfBoundsException���ַ�Խ���쳣��");
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

	public String queryAccountToBalanceQuery() {// ��ѯ�˻�
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return balanceQuery();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), null, user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
			return "balanceQuery";

		}
	}

	public String queryToPayment() {// ��ҳ��ѯ���е��˻�
		list = accountService.findByPager(pager);
		return "queryToPayment";

	}

	public String queryAccountToPayment() {// ����������ѯ�˻�
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return queryToPayment();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
		}

		return "queryToPayment";

	}

	public String payment() {
		// ���ó�ֵ�������ⲿ�����·��
		param_cardRechargeSystem_path = sysparamconfService.queryOrSave(CardRechargeSystem_path, "C:/��ֵ�ͳ���/CardRechargeSystem.exe", CardRechargeSystem_remark, "AccountTradeAction��correct()����CardRechargeSystem_path����ʱset������get��������ʱ���쳣", admin);
		try {
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
		} catch (Exception e) {
			param_cardRechargeSystem_path.setPvalue("C:/��ֵ�ͳ���/CardRechargeSystem.exe");
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
			admin = adminService.get(getCurrentOperator().getId());
			// �����쳣����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "AccountAction��payment()����CardRechargeSystem_path����ʱset������get��������ʱ���쳣", e.getMessage(), "Exception");

		}
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��payment()����card_type����ʱset������get��������ʱ���쳣", admin);
		account = accountService.get(account.getSys_id());
		return "payment";

	}

	public String paymentEdit() {// �˻������ͣ�0Ϊ���ݳ�ֵ��Ϊ��д��ʱ��ֵ�����뽻����ˮ��
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
			// ��12����ˮ��ˮ���и����·ݲ�ѯ����һ�����Ի�ø��ʺŵĽ�����ˮ���
			seqNo = accountTradeService.getSeqNoByTwelveAccountTrade(calendar.get(Calendar.MONTH) + 1, account.getSys_id());
		} catch (Exception e) {
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "AccountAction��paymentEdit����ʱ��ý�����ˮ�����ʱ�������쳣", e.getMessage(), "Exception");
			e.printStackTrace();
		}
		accountTrade.setSeqNo(seqNo);
		accountTrade.setTradeType(1);
		accountTrade.setCardNo(account.getCardNo());
		accountTrade.setCardType(account.getCardType());
		accountTrade.setTradeTime(nowdate);
		Double fee1 = mul(fee, 100.0);// ע�⾫�����⣬����mul(fee,100.0)double*100���Ȳ��ԣ�����41070.7*100
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
			// ���ý�����ˮ�ţ���ʽΪTyyyyMMddHHmmssSSS_����Ա���
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String nowdate1 = sdf1.format(new Date());
			s = "T" + nowdate1 + "_" + getCurrentOperator().getId().toString();
		} catch (Exception e) {
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "AccountAction��paymentEdit����ʱ��ý�����ˮ��ʱ�������쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
			e.printStackTrace();
		}
		accountTrade.setListNo(s);
		// ȥ��null
		String yanzheng = accountTradeService.deleteNull(account.getSys_id(), accountTrade.getSeqNo(), accountTrade.getTradeType(), accountTrade.getFee(), accountTrade.getBalance(), accountTrade.getCardNo().trim(), accountTrade.getCardType(), accountTrade.getVehPlate().trim(), accountTrade.getListNo().trim(), getCurrentOperator().getId(), getCurrentOperator().getPassword().trim(), accountTrade.getTradeTime(), accountTrade.getOpTime());
		String yanzhengTemp = HashUtil.getMD5String(yanzheng);// md5�ܳף�Ŀ���ǲ�ѯ��û���޸Ĺ�����������Ϣ
		accountTrade.setVerify(yanzhengTemp);
		accountTradeService.save(accountTrade);
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û���ֵ�ɹ�����ˮ��Ϊ��"+accountTrade.getListNo(),
				"�ɷѿ��˻�����--��ֵ", "t_park_accountTrade");
		// �˻���Ϣ�·�����
		accountSendParaService.SendPara();
		return "printPaymentAccount";

	}

	public String printPayment() {

		return "printPayment";

	}

	// ===================================����Ϊ��ʧ����=====================================================================
	public String queryToLoss() {// ��ʧ��ѯ����ҳ��ѯ��������е���Ϣ
		list = accountService.findByPager(pager);
		return "queryToLoss";
	}

	public String queryAccountToLoss() {// �������Ҫ��ʧ���˻�
		if (null == account.getSys_id() && "".equals(account.getCardNo().trim()) && "".equals(user.getUserName().trim()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo().trim()) && "".equals(car.getVehPlate().trim()) && null == account.getStatus()) {
			return queryToLoss();
		} else {
			list = accountService.findAllItemByHql(pager, account.getSys_id(), account.getCardNo().trim(), user.getUserName().trim(), user.getCredentialsType(), user.getCredentialsNo().trim(), car.getVehPlate().trim(), account.getStatus(),null);
			return "queryToLoss";
		}
	}

	public String loss() {// ��ʧ���������˻�״̬�޸�Ϊ����ʧ��״̬�Ͳ�������˻���־����
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
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��loss()����card_type����ʱset������get��������ʱ���쳣", admin);
		if ("1".equals(param_card_type.getPvalue())) {// �˻�������Ϊд��ʱ��ʧҪ�鴢ֵ��������(tb_StoreCardBlackList)�������˻���Ϣ��ɾ������ӣ�û�������
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

		// System.out.println(sysparamconf.getPvalue());
		// ������Ϊ��д��ʱ���˻���Ϣ�·�����
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

	// ===================================����Ϊ��ʧ����������Ϊ��Ҳ���=====================================================================
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

	public String removeLoss() {// ��Ҳ��������˻�״̬�޸�Ϊ����Ч��״̬�Ͳ�������˻���־����
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��removeLoss()����card_type����ʱset������get��������ʱ���쳣", admin);
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
		// ������Ϊ��д��ʱ�˻���Ϣ�·�����
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		if ("1".equals(param_card_type.getPvalue())) {// ������Ϊд��ʱ���Ҫ�鴢ֵ��������(tb_StoreCardBlackList)�������˻���Ϣ��ɾ��
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

	// =============================����Ϊ��Ҳ���������Ϊ��������=========================================================
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
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��exchangeCard()����card_type����ʱset������get��������ʱ���쳣", admin);
		param_cardRechargeSystem_path = sysparamconfService.queryOrSave(CardRechargeSystem_path, "C:/��ֵ�ͳ���/CardRechargeSystem.exe", CardRechargeSystem_remark, "AccountAction��exchangeCard()����CardRechargeSystem_path����ʱset������get��������ʱ���쳣", admin);
		try {
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
		} catch (Exception e) {
			param_cardRechargeSystem_path.setPvalue("C:/��ֵ�ͳ���/CardRechargeSystem.exe");
			param_cardRechargeSystem_path.setPvalue(param_cardRechargeSystem_path.getPvalue().replace("\\", "\\\\"));
			admin = adminService.get(getCurrentOperator().getId());
			// �����쳣����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "AccountTradeAction��exchangeCard()����CardRechargeSystem_path����ʱset������get��������ʱ���쳣", e.getMessage(), "Exception");

		}
		param_accountCardNoLength = sysparamconfService.queryOrSave("accountCardNoLength", "10", "�ɷѿ��˻�����ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9����", "AccountAction��exchangeCard()����accountCardNoLength����ʱ���쳣", admin);		
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
			return "exchangeCard";
		} else {
			return queryToExchangeCard();
		}

	}

	public String updateAccountOrSavaLog() {// ������������������˻���־����
		Double costDouble = mul(cost, 100.0);// ע�⾫�����⣬����mul(fee,100.0)double*100���Ȳ��ԣ�����41070.7*100
		int costTemp = costDouble.intValue();
		if (!cardNo1.equals(this.deleteFirstZero(account.getCardNo().trim()))) {// �޸Ŀ��Ų��������ݿ��е��κ�һ��������ͬ�������ĳ��⣩
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
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��updateAccountOrSavaLog()����card_type����ʱset������get��������ʱ���쳣", admin);
		// System.out.println(sysparamconf.getPvalue());
		// ������Ϊ��д��ʱ�˻���Ϣ�·�����
		if (param_card_type.getPvalue().equals("0")) {
			accountSendParaService.SendPara();
		}
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û����û����Ϊ"+accountTemp.getSys_id()+"���л����ɹ���֮ǰ�˻����Ϊ��"+accountTemp.getBalance()/100+"Ԫ",
				"�ɷѿ��˻�����--����", "t_park_account");
		return "printExchangeCardAccount";
	}

	public String printExchangeCard() {
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(updateAccountLog.getAccountNo());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);
		updateAccountLogService.update(updateAccountLog);
		return "printExchangeCard";
	}

	// =============================����Ϊ��������������Ϊ������������=========================================================
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

	public String requestEndAccount() { // ��������
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
		// ��������������������ʱ������С��ʱ������������
		param_endAccount_amongTime = sysparamconfService.queryOrSave("endAccount_amongTime", "0", "����������������ʱ��������ֵҪ�����֣�����ϵͳ��ʼ��Ϊ0�죨û��endAccount_amongTime����ϵͳҲ��ʼ��Ϊ0��) ", "AccountAction��requestEndAccount()����endAccount_amongTime����ʱset������get��������ʱ���쳣", admin);
		try {
			Long pvalue = Long.parseLong(param_endAccount_amongTime.getPvalue());
			param_endAccount_amongTime.setPvalue(pvalue.toString());
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "AccountAction��requestEndAccount()����eddAccount_amongTime����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
			param_endAccount_amongTime.setPvalue("0");
		}
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��requestEndAccount()����card_type����ʱset������get��������ʱ���쳣", admin);
		// �˻�������Ϊд����������ʱҪ�鴢ֵ��������(tb_ StoreCardBlackList)�������˻���Ϣ��ɾ������ӣ�û�������
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
					systemLogService.save(new Date(), 2, admin, "AccountAction��requstEndAccount()��ʱ��1����ʱ�������쳣", e.getMessage(), "Exception");
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
					systemLogService.save(new Date(), 2, admin, "AccountAction��requstEndAccount()��ʱ��2����ʱ�������쳣", e.getMessage(), "Exception");
				}

				storeCardBlackListService.save(storeCardBlackList2);
			}
		}
		// ������Ϊ��д��ʱ�˻���Ϣ�·�����
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
		// ��������������������ʱ������С��ʱ������������
		param_endAccount_amongTime = sysparamconfService.queryOrSave("endAccount_amongTime", "0", "����������������ʱ��������ֵҪ�����֣�����ϵͳ��ʼ��Ϊ0�죨û��endAccount_amongTime����ϵͳҲ��ʼ��Ϊ0��) ", "AccountAction��requestEndAccount()����endAccount_amongTime����ʱset������get��������ʱ���쳣", admin);
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNo(account.getSys_id());
		updateAccountLog.setPrintNumber(updateAccountLog.getPrintNumber() + 1);// ���ô�ӡ����
		updateAccountLogService.update(updateAccountLog);
		return "printRequestEnd";
	}

	// =============================����Ϊ������������������Ϊ��������=========================================================
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

	public String endAccount() {// ���� �˻�״̬�޸�Ϊ��������������������˻���־��Ͳ��뽻����ˮ���������Ϊ0.
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
			systemLogService.save(new Date(), 2, admin, "AccountAction��endAccount()����������ʱ�������쳣", e.getMessage(), "Exception");
		}
		// ��������
		// ��������������������ʱ������С��ʱ������������
		param_endAccount_amongTime = sysparamconfService.queryOrSave("endAccount_amongTime", "0", "����������������ʱ��������ֵҪ�����֣�����ϵͳ��ʼ��Ϊ0�죨û��endAccount_amongTime����ϵͳҲ��ʼ��Ϊ0��) ", "AccountAction��requestEndAccount()����endAccount_amongTime����ʱset������get��������ʱ���쳣", admin);
		try {
			endAccount_amongTime = Long.parseLong(param_endAccount_amongTime.getPvalue());
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "AccountAction��endAccount()����eddAccount_amongTime����ʱ���쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
			endAccount_amongTime = 0;
		}
		// System.out.print("��ϵͳ������ʱ������ǵ�endAccount_amlongTime:-------------------"+endAccount_amongTime);}
		if (amongTime < endAccount_amongTime) {
			result = Result.FAIL5;
			return queryAccountToEndAccount();
		}// ����ϵͳ�����õ�����ʱ��ʾ˵��
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
			// ��12����ˮ��ˮ���и����·ݲ�ѯ����һ�����Ի�ø��ʺŵĽ�����ˮ���
			seqNo = accountTradeService.getSeqNoByTwelveAccountTrade(calendar.get(Calendar.MONTH) + 1, accountTemp.getSys_id());
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			// �����쳣ʱ����ϵͳ��־��
			systemLogService.save(new Date(), 2, admin, "AccountAction��endAccount����ʱ��ý�����ˮ�������ʱ�������쳣", e.getMessage(), "Exception");
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
			systemLogService.save(new Date(), 2, admin, "AccountAction��endAccount����ʱ��ý�����ˮ��ʱ�������쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
			e.printStackTrace();
		}
		accountTrade.setListNo(s1);
		// ȥ��null
		String yanzheng = accountTradeService.deleteNull(accountTemp.getSys_id(), accountTrade.getSeqNo(), accountTrade.getTradeType(), accountTrade.getFee(), accountTrade.getBalance(), accountTrade.getCardNo(), accountTrade.getCardType(), accountTrade.getVehPlate(), accountTrade.getListNo(), getCurrentOperator().getId(), getCurrentOperator().getPassword(), accountTrade.getTradeTime(), accountTrade.getOpTime());
		String yanzhengTemp = HashUtil.getMD5String(yanzheng);// md5�ܳף�Ŀ���ǲ�ѯ��û���޸Ĺ�����������Ϣ
		accountTrade.setVerify(yanzhengTemp);
		accountTradeService.save(accountTrade);
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻�������,0Ϊ��ֵʱ��д�����ͣ�1Ϊ��ֵʱд������
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "AccountAction��endAccount()����card_type����ʱset������get��������ʱ���쳣", admin);
		// ������С���˻���Ϣ�·�����
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
