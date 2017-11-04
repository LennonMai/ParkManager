package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.IDCardInfoDao;
import com.hgsoft.entity.IdcardInfo;
import com.hgsoft.util.Pager;

@Service
public class IDCardInfoService extends BaseService<IdcardInfo> {

	@Autowired
	public void setDao(IDCardInfoDao dao) {
		super.setDao(dao);
	}

	private IDCardInfoDao getIDCardInfoDao() {
		return (IDCardInfoDao) this.getDao();
	}

	public IdcardInfo getIDCardInfoByCardNo(String cardNo) {
		return getIDCardInfoDao().getIDCardInfoByCardNo(cardNo);
	}

	public List<IdcardInfo> getAllIDCardInfo(Pager pager) {
		return getIDCardInfoDao().getAllIDCardInfo(pager);
	}

	public List<IdcardInfo> findAllItemByHql(Pager pager, String idcardNo, String userName) {
		return getIDCardInfoDao().findAllItemByHql(pager, idcardNo, userName);
	}

	public void updateIdcardInfo(String idCardInfo, String idCardInfoTemp, String userName) {
		getIDCardInfoDao().updateIdcardInfo(idCardInfo, idCardInfoTemp, userName);
	}

}
