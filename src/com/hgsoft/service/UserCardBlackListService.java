package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UserCardBlackListDao;
import com.hgsoft.entity.UserCardBlackList;
import com.hgsoft.util.Pager;

@Service
public class UserCardBlackListService extends BaseService<UserCardBlackList> {

	@Autowired
	public void setDao(@Qualifier("userCardBlackListDao") UserCardBlackListDao dao) {
		super.setDao(dao);
	}

	private UserCardBlackListDao getUserCardBlackListDao() {
		return (UserCardBlackListDao) this.getDao();
	}

	public List<UserCardBlackList> ishasUserCardBlackList(String uccode) {
		return getUserCardBlackListDao().ishasUserCardBlackList(uccode);
	}

	public List<UserCardBlackList> findByCondition(Pager pager, String uccode, String genCau, Date genTime) {
		return getUserCardBlackListDao().findByCondition(pager, uccode, genCau, genTime);
	}

	public void delete(String uccode) {
		if (this.ishasUserCardBlackList(uccode) != null) {
			this.deleteById(uccode);
		}

	}
}
