package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.OwnerIncomeSum;
import com.hgsoft.util.Pager;


/**
 * 业主收支金额汇总DAO
 * @author caijunhua
 *
 */

@Repository
public class OwnerIncomeSumDao extends BaseDao<OwnerIncomeSum> {
	/**
	 * 根据查询条件查询业主收支金额
	 * @param pager
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<OwnerIncomeSum> findOwnerIncomeSumByHql(Pager pager,
			String startTime, String endTime) {

		StringBuffer sf = new StringBuffer("from OwnerIncomeSum ownerIncomeSum where");
		List<Object> list = new ArrayList<Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (null != startTime && !"".equals(startTime)) {
			sf.append(" ownerIncomeSum.genDate >= ? and");
			try {
				list.add(sdf.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (null != endTime && !"".equals(endTime)) {
			sf.append(" ownerIncomeSum.genDate <= ? and");
			try {
				list.add(sdf.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(list.size() != 0 ) {
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		} else {
			sf = sf.replace(sf.length() - 6, sf.length(), "");
		}
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), list.toArray());
		pager.setTotalSize(count);
		//按时间降序查出记录返回
		return this.executeQuery(pager, sf.toString() + " order by genDate desc", list.toArray());
	}
	
}
