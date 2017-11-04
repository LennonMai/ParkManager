package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.InList;
import com.hgsoft.util.Pager;

/**
 * 入口流水DAO
 * @author caijunhua
 *
 */

@Repository 
public class InListDao extends BaseDao<InList> {
	/**
	 * 根据查询条件查询入口流水
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
	public List<InList> findAllInListByHql(Pager pager,
			String cardNo, String vehPlate, String listNo, Short vehClass,Date startTime1,Date endTime1) {

		StringBuffer sf = new StringBuffer("from InList inlist where");
		List<Object> obj = new ArrayList<Object>();
		if (cardNo != null) {
			sf.append(" inlist.cardNo=? and");
			obj.add(cardNo);
		}
		if (!vehPlate.equals("")) {
			sf.append(" inlist.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!listNo.equals("")) {
			sf.append(" inlist.listNo like ? and");
			obj.add("%" + listNo + "%");
		}
		if (vehClass != null) {
			sf.append(" inlist.vehClass=? and");
			obj.add(vehClass);
		}
		if (startTime1 != null) {
			sf.append(" inlist.opTime>=? and");
			obj.add(startTime1);
		}
		if (endTime1 != null) {
			sf.append(" inlist.opTime<=? and");
			obj.add(endTime1);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//System.out.println(sf.toString()+"--------------"+obj.get(1));
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//按时间降序查出记录返回
		return this.executeQuery(pager, sf.toString() + " order by opTime desc", obj.toArray());
	}
}
