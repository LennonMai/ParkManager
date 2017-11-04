package com.hgsoft.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.AccountDao;
import com.hgsoft.entity.Account;
import com.hgsoft.util.Order;
import com.hgsoft.util.Pager;

@Service
public class AccountService extends BaseService<Account> {
	@Resource
	private UserService userService;

	@Autowired
	public void setDao(@Qualifier("accountDao") AccountDao dao) {
		super.setDao(dao);
	}

	private AccountDao getAccountDao() {
		return (AccountDao) this.getDao();
	}

	public Account getAccount(String cardNo) {
		return getAccountDao().getAccount(cardNo);
	}

	public Account getAccountBySysID(int sys_id) {// 通过账号查询账户
		return getAccountDao().getAccountBySysID(sys_id);
	}

	public List<Account> getAccountByIdOrCardNo(Integer sys_id, String cardNo) {

		return getAccountDao().getAccountByIdOrCardNo(sys_id, cardNo);
	}

	public List<Account> getAccountByVehPlate(String vehPlate) {
		return getAccountDao().getAccountByVehPlate(vehPlate);
	}

	public Account getAccountByVehPlateToAjax(String vehPlate) {// 通过卡号查询账户
		return getAccountDao().getAccountByVehPlateToAjax(vehPlate);
	}

	public Account getAccountByUserID(Integer user_id) {// 通过用户编号查询账户
		return getAccountDao().getAccountByUserID(user_id);
	}

	@Override
	public List<Account> findAll() {
		// TODO Auto-generated method stub
		return getAccountDao().findAll(Order.asc("sys_id"));
	}

	public List<Account> findAllItemByHql(Pager pager, Integer sys_id, String cardNo, String userName,
			Integer credentialsType, String credentialsNo, String vehPlate, Integer status, Integer parkNo) {
		return getAccountDao().findAllItemByHql(pager, sys_id, cardNo, userName, credentialsType, credentialsNo,
				vehPlate, status, parkNo);
	}

	/*
	 * public List<Object[]> findAllItemByHql1(Pager pager,Integer sys_id,String
	 * cardNo,String userName,Integer credentialsType,String
	 * credentialsNo,String vehPlate,Integer status){ return
	 * ((AccountDao)getDao()).findAllItemByHql1(pager, sys_id, cardNo, userName,
	 * credentialsType, credentialsNo, vehPlate,status); } public List<Object[]>
	 * findAllItemByHql2(Pager pager,Integer sys_id,String cardNo,String
	 * userName,Integer credentialsType,String credentialsNo,String
	 * vehPlate,Integer status){ return
	 * ((AccountDao)getDao()).findAllItemByHql2(pager, sys_id, cardNo, userName,
	 * credentialsType, credentialsNo, vehPlate,status); }
	 */
	public List<Account> findAll1() {
		// TODO Auto-generated method stub
		return getAccountDao().findAll(Order.desc("sys_id"));
	}

	/*
	 * public List<Object[]> findAllItemToPayment(Pager pager){ return
	 * ((AccountDao)getDao()).findAllItemToPayment(pager); } public
	 * List<Object[]> findAllItemToPayment1(Pager pager){ return
	 * ((AccountDao)getDao()).findAllItemToPayment1(pager); }
	 */
	public int getUserSysid() {
		int sys_id = userService.getMaxSysID();
		return sys_id;

	}
}
