package com.hgsoft.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.entity.Account;
import com.hgsoft.entity.AccountTrade;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.UpdateAccountLog;
import com.hgsoft.entity.User;
import com.hgsoft.util.HashUtil;
@Service
public class AccountTransactionService {
	@Resource
	private CarService carService;
	@Resource
	private AccountService accountService;
	@Resource
	private AccountTradeService accountTradeService;
	@Resource
	private UpdateAccountLogService updateAccountLogService;
	@Resource
	private SystemLogService systemLogService;
	
	public AccountTransactionService(){
	
		
	}
	public void saveTransaction(User user,Car car,Account account,AccountTrade accountTrade,UpdateAccountLog updateAccountLog,Admin operator,Admin admin){

		//System.out.println("====================================");
		//try{
			
			//userService.save(user);
		//} catch (TemplateModelException e){
		//	System.out.println("---------------------�쳣---------------");
			//user.setSys_id(sys_id);
			//userService.save(user);
		//}
		/*try{				
		userService.insertUser(9150, user.getUserName(), user.getCredentialsType(), user.getCredentialsNo(), user.getPhone(), user.getMobileNumber(), user.getAddress());
		}catch(DataIntegrityViolationException e){
			System.out.println("---------------------�쳣---------------");
			sys_id = accountService.getUserSysid() + 1;// �û�������ڵ�ǰ����ż�1����һ���˻��û����Ϊ1
			user.setSys_id(sys_id);
			userService.insertUser(sys_id, user.getUserName(), user.getCredentialsType(), user.getCredentialsNo(), user.getPhone(), user.getMobileNumber(), user.getAddress());
		}*/
		carService.save(car);
		account.setUser(user);
		account.setCar(car);
		accountService.save(account);
		accountTrade.setAccount(account);
		try{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String nowdate = sdf.format(new Date());
			String s1 = "T"+nowdate+ "_" + operator.getId().toString();	
			accountTrade.setListNo(s1);
		}catch(Exception e){
			 systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��save��������ʱ��ý�����ˮ��ʱ�������쳣", e.getMessage(), "ClassCastException������ǿ��ת���쳣��");
			 e.printStackTrace();
		}			
		String yanzheng=accountTradeService.deleteNull(account.getSys_id(), accountTrade.getSeqNo(), accountTrade.getTradeType(), accountTrade.getFee(), accountTrade.getBalance(), accountTrade.getCardNo(), accountTrade.getCardType(), accountTrade.getVehPlate(), accountTrade.getListNo(), operator.getId(), operator.getPassword(), accountTrade.getTradeTime(), accountTrade.getOpTime());	
		String yanzheng1=HashUtil.getMD5String(yanzheng);//md5�ܳף�Ŀ���ǲ�ѯ��û���޸Ĺ�����������Ϣ
		accountTrade.setVerify(yanzheng1);
		accountTradeService.save(accountTrade);
		updateAccountLog.setAccountNo(account.getSys_id());
		int seqNo = updateAccountLogService.getSeqNoByAccountNo(account.getSys_id());
		updateAccountLog.setSeqNo(seqNo);
		updateAccountLog.setUser_id(user.getSys_id());
		updateAccountLog.setCar_id(car.getSys_id());
		updateAccountLogService.save(updateAccountLog);
		
		
	}

	
}
