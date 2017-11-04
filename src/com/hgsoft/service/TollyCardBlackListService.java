/**
 * 
 */
package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.TollyCardBlackListDao;
import com.hgsoft.entity.TollyCardBlackList;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Service
public class TollyCardBlackListService extends BaseService<TollyCardBlackList> {

	@Autowired
	public void setDao(@Qualifier("tollyCardBlackListDao") TollyCardBlackListDao dao) {
		super.setDao(dao);
	}

	private TollyCardBlackListDao getTollyCardBlackListDao() {
		return (TollyCardBlackListDao) this.getDao();
	}

	public List<TollyCardBlackList> ishasTollyCardBlackList(Object accode) {
		return getTollyCardBlackListDao().ishasTollyCardBlackList(accode);
	}

	public List<TollyCardBlackList> LoadTollyCardBlackList(Object accode) {
		return getTollyCardBlackListDao().LoadTollyCardBlackList(accode);
	}

	public List<TollyCardBlackList> findByCondition(Pager pager, String accode, String genCau, Date genTime) {
		return getTollyCardBlackListDao().findByCondition(pager, accode, genCau, genTime);
	}

	public void delete(String accode) {
		if (this.ishasTollyCardBlackList(accode) != null) {
			this.deleteById(accode);
		}

	}
}
