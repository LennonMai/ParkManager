package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.OutList;
import com.hgsoft.util.Pager;

/**
 * 出口流水DAO
 * @author caijunhua
 *
 */

@Repository 
public class OutListDao extends BaseDao<OutList> {
	/**
	 * 根据查询条件查询出口流水
	 * @param pager
	 * @param cardNo 卡号
	 * @param vehPlate 车牌号
	 * @param listNo 流水号
	 * @param vehClass 车种
	 * @param startTime1 开始时间
	 * @param endTime1 结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<OutList> findAllOutListByHql(Pager pager,
			String cardNo, String vehPlate, String listNo, Short vehClass,Date startTime1,Date endTime1) {
		
		StringBuffer sf = new StringBuffer("from OutList outlist where");
		List<Object> obj = new ArrayList<Object>();
		if (cardNo != null) {
			sf.append(" outlist.cardNo=? and");
			obj.add(cardNo);
		}
		if (!vehPlate.equals("")) {
			sf.append(" outlist.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!listNo.equals("")) {
			sf.append(" outlist.listNo like ? and");
			obj.add("%" + listNo + "%");
		}
		if (vehClass != null) {
			sf.append(" outlist.vehClass=? and");
			obj.add(vehClass);
		}
		if (startTime1 != null) {
			sf.append(" outlist.opTime>=? and");
			obj.add(startTime1);
		}
		if (endTime1 != null) {
			sf.append(" outlist.opTime<=? and");
			obj.add(endTime1);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//按时间降序查出记录返回
		return this.executeQuery(pager, sf.toString() + " order by opTime desc", obj.toArray());
	}
}
