package com.hgsoft.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.FreeDao;

@Service
public class FreeService {
	@Resource
	private FreeDao freeDao;

	public boolean isSysCard(String cardNo) {
		// TODO Auto-generated method stub
		List list = freeDao.isSysCard(cardNo);
		if(list!=null&&list.size()>0)
			return true;
		else return false;
	}

	public boolean isWhiteListCard(String cardNo) {
		// TODO Auto-generated method stub
		List list = freeDao.isWhiteListCard(cardNo);
		if(list!=null&&list.size()>0)
			return true;
		else return false;
	}
}
