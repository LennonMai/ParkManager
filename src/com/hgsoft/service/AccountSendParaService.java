package com.hgsoft.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.AccountSendParaDao;

/**
 * �˻���Ϣ�·�����Service
 * 
 * @author caijunhua
 *
 */

@Service
public class AccountSendParaService {

	@Resource
	private AccountSendParaDao accountSendParaDao;

	public void SendPara() {
		accountSendParaDao.SendPara();
	}

}
