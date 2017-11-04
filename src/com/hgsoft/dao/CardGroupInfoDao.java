package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.CardGroupInfo;
import com.hgsoft.util.Pager;

@Repository
public class CardGroupInfoDao  extends BaseDao<CardGroupInfo>{
	@SuppressWarnings("unchecked")
	public List<CardGroupInfo> getAllCardGroupInfoByPager(Pager pager) {
		String hql = "from CardGroupInfo cardGroupInfo where cardGroupInfo.laneGroupNo=1";
		List<Object> obj = new ArrayList<Object>();
		Long count = executeCount(hql, obj.toArray());
		pager.setTotalSize(count);
		List resultList = this.executeQuery(pager, hql, obj.toArray());
		if (resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}

	}
	@SuppressWarnings("unchecked")
	public CardGroupInfo getCardGroupInfoByGroupNo(int groupNo) {
		String hql = "from CardGroupInfo cardGroupInfo where  cardGroupInfo.groupNo=?";
		List resultList = executeQuery(hql, groupNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (CardGroupInfo) resultList.get(0);
		}

	}
	@SuppressWarnings("unchecked")
	public CardGroupInfo getCardGroupInfoByGroupNoAndLaneGroupNo(int groupNo,int laneGroupNo) {
		String hql = "from CardGroupInfo cardGroupInfo where  cardGroupInfo.groupNo=? and cardGroupInfo.laneGroupNo="+laneGroupNo;
		List resultList = executeQuery(hql, groupNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (CardGroupInfo) resultList.get(0);
		}

	}
	@SuppressWarnings("unchecked")
	public List<CardGroupInfo> findAllItemByHql(Pager pager,Integer groupNo,String groupName) {
		StringBuffer sf = new StringBuffer("from CardGroupInfo cardGroupInfo where cardGroupInfo.laneGroupNo=1 and");
		List<Object> obj = new ArrayList<Object>();
		if(groupNo !=null){
			sf.append(" cardGroupInfo.groupNo=? and");
			obj.add(groupNo);
		}
		if (!"".equals(groupName)) {
			sf.append(" cardGroupInfo.groupName like? and");
			obj.add("%" + groupName + "%");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	@SuppressWarnings("unchecked")
	public Integer getMaxGroupNo() {
		String hql = "from CardGroupInfo cardGroupInfo order by cardGroupInfo.groupNo desc";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty())
			return 1;
		else {
			return ((CardGroupInfo) resultList.get(0)).getGroupNo() + 1;
		}

	}
	public void deleteByGroupNo(int groupNo) {
		String hql = "delete from CardGroupInfo cardGroupInfo where  cardGroupInfo.groupNo=?";
		Query q = getSession().createQuery(hql) ;
        q.setInteger(0, groupNo) ;
        q.executeUpdate() ;		
	}


}
