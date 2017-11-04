package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.CardGroup;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.util.Pager;

@Repository
public class CardGroupDao  extends BaseDao<CardGroup>{
	@SuppressWarnings("unchecked")
	public List<CardGroup> getCardGroupByGroupNo(Pager pager, int groupNo) {
		String hql = "from CardGroup cardGroup where cardGroup.groupNo= " + groupNo;
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
	public List<Object[]> getUserCardInfoAndCardGroupByGroupNoAndLaneGroupNo(Pager pager, int groupNo,int laneGroupNo) {
		List myList = new ArrayList();
		String hql = "from UserCardInfo userCardInfo,CardGroup cardGroup where userCardInfo.recNO=cardGroup.recNo and cardGroup.groupNo= "+ groupNo+" and cardGroup.laneGroupNo="+laneGroupNo;
		List<Object> obj = new ArrayList<Object>();
		Long count = executeCount(hql, obj.toArray());
		pager.setTotalSize(count);
		List resultList = executeQuery(pager,hql,obj.toArray());
		Iterator iterator1 = resultList.iterator();
		while (iterator1.hasNext()) {
			Object[] o = (Object[]) iterator1.next();
			UserCardInfo userCardInfo = (UserCardInfo) o[0];
			CardGroup cardGroup = (CardGroup) o[1];
			Object ay = new Object[] { userCardInfo, cardGroup };
			myList.add(ay);
		}

		return myList;
	}
	public void deleteByRecNO(int recNo) {
		String hql = "delete from CardGroup cardGroup where  cardGroup.recNo=?";
		Query q = getSession().createQuery(hql) ;
        q.setInteger(0, recNo) ;
        q.executeUpdate() ;		
	}
	public void deleteByGroupNo(int groupNo) {
		String hql = "delete from CardGroup cardGroup where  cardGroup.groupNo=?";
		Query q = getSession().createQuery(hql) ;
        q.setInteger(0, groupNo) ;
        q.executeUpdate() ;		
	}
	public void deleteByCardNo(String cardNo) {
		String hql = "delete from CardGroup cardGroup where  cardGroup.cardNo='"+cardNo+"'";
		Query q = getSession().createQuery(hql) ;
        q.executeUpdate() ;		
	}

}
