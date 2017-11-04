/**
 * 
 */
package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.PassCardBlackListDao;
import com.hgsoft.entity.PassCardBlackList;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Service
public class PassCardBlackListService extends BaseService<PassCardBlackList> {

	@Autowired
	public void setDao(@Qualifier("passCardBlackListDao") PassCardBlackListDao dao) {
		super.setDao(dao);
	}

	private PassCardBlackListDao getPassCardBlackListDao() {
		return (PassCardBlackListDao) this.getDao();
	}

	public List<PassCardBlackList> ishasPassCardBlackList(Object cardNo) {
		return getPassCardBlackListDao().ishasPassCardBlackList(cardNo);
	}

	public List<PassCardBlackList> LoadPassCardBlackList(Object cardNo) {
		return getPassCardBlackListDao().LoadPassCardBlackList(cardNo);
	}

	public List<PassCardBlackList> findByCondition(Pager pager, String cardNo, Short inValidTypeNo, Date opTime) {
		return getPassCardBlackListDao().findByCondition(pager, cardNo, inValidTypeNo, opTime);
	}

	public void delete(String cardNo) {
		if (this.ishasPassCardBlackList(cardNo) != null) {
			this.deleteById(cardNo);
		}
	}
}
