/**
 * 
 */
package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.OpCardBlackListDao;
import com.hgsoft.entity.OpCardBlackList;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Service
public class OpCardBlackListService extends BaseService<OpCardBlackList> {

	@Autowired
	public void setDao(@Qualifier("opCardBlackListDao") OpCardBlackListDao dao) {
		super.setDao(dao);
	}

	private OpCardBlackListDao getOpCardBlackListDao() {
		return (OpCardBlackListDao) this.getDao();
	}

	public List<OpCardBlackList> ishasOpCardBlackList(Object cardNo) {
		return getOpCardBlackListDao().ishasOpCardBlackList(cardNo);
	}

	public List<OpCardBlackList> LoadOpCardBlackList(Object cardNo) {
		return getOpCardBlackListDao().LoadOpCardBlackList(cardNo);
	}

	public List<OpCardBlackList> findByCondition(Pager pager, String cardNo, Short inValidTypeNo, Date opTime) {
		return getOpCardBlackListDao().findByCondition(pager, cardNo, inValidTypeNo, opTime);
	}

	public void delete(String cardNo) {
		if (this.ishasOpCardBlackList(cardNo) != null) {
			this.deleteById(cardNo);
		}
	}

}
