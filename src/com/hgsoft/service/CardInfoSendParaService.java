package com.hgsoft.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.CardInfoSendParaDao;

@Service
public class CardInfoSendParaService {
	@Resource
	private CardInfoSendParaDao cardinfoSendParaDao;

	public void SendCardInfoPara() {
		cardinfoSendParaDao.SendCardInfoPara();
	}

	public void SendCardInfoParaHavaPayType() {
		cardinfoSendParaDao.SendCardInfoParaHavaPayType();
	}

	public void SendCommandAndLost() {
		cardinfoSendParaDao.SendCommandAndLost();
	}
}
