package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.AllOutList;
import com.hgsoft.entity.LoseCardHis;
import com.hgsoft.util.Pager;
@Repository
public class LoseCardHisDao extends BaseDao<LoseCardHis>{
	/**
	 *查询丢卡历史记录
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager,String startTime,String endTime,String cardNo,String vehPlate,String owner){
		String hql = "from LoseCardHis his where ";
		List list = new ArrayList();
		List resultList = new ArrayList();
		StringBuffer sb = new StringBuffer(0);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(null != startTime && !startTime.equals("")){
			sb.append("his.opTime >= ? and ");
			try {
				list.add(format.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != endTime && !endTime.equals("")){
			sb.append("his.opTime <= ? and ");
			try {
				list.add(format.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != cardNo && !cardNo.equals("")){
			sb.append("his.cardNo = ? and ");
			list.add(cardNo);
		}
		if(null != vehPlate && !vehPlate.equals("")){
			sb.append("his.vehPlate = ? and ");
			list.add(vehPlate);
		}
		if(null != owner && !owner.equals("")){
			sb.append("his.owner = ? and ");
			list.add(owner);
		}
		if(list.size() != 0){
			sb = sb.replace(sb.length()-4, sb.length(), "");
		}else{
			hql = hql.substring(0, 20);
		}
		Long count = this.executeCount(hql + sb.toString(), list.toArray());
		pager.setTotalSize(count);
		resultList = this.executeQuery(pager,hql+sb.toString()+" order by outOpTime desc", list.toArray());
		return resultList;
	}
	
	/**
	 * 根据 cardNo 和 opTime获得对象
	 */
	@SuppressWarnings("unchecked")
	public LoseCardHis getById(String cardNo,Date opTime){
		String hql = "from LoseCardHis his where his.cardNo = ? and his.opTime = ?";
		List list = this.executeQuery(hql, cardNo,opTime);
		if(list.size() != 0){
			return (LoseCardHis) list.get(0);
		}
		return null;
	}
	
	public void deleteByCardNoAndOpTime(String cardNo, String opTime){
		String hql = "delete from tb_LoseCardHis where cardNo=:cardNo and opTime=:opTime";
		this.getSession().createSQLQuery(hql).setParameter("cardNo", cardNo).setParameter("opTime", opTime).executeUpdate();
	}
	@SuppressWarnings("unchecked")
	public AllOutList getByOutListNo(String outListNo){
		String hql = "from AllOutList allOutList where allOutList.listNo=?";
		List<AllOutList> list = this.executeQuery(hql, outListNo);
		if(!list.isEmpty()){
			return list.get(0);
		}else{
			return null;
		}
	}
}
