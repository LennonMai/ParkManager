/**
 * 
 */
package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.UserCardRate;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Repository
public class UserCardRateDao extends BaseDao<UserCardRate> {
	@Resource
	private JdbcUtil jdbcUtil;
	//验证费率唯一性
	@SuppressWarnings("unchecked")
	public List<UserCardRate> ishasUserCardRate(Object version,Object recNo){
		String hql=" from UserCardRate userCardRate where userCardRate.version=? and userCardRate.recNo=? ";
		List<UserCardRate> list=executeQuery(hql,version,recNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//加载UserCardRate
	@SuppressWarnings("unchecked")
	public List<UserCardRate> LoadUserCardRate(Object version,Object recNo){
		
		String hql="from UserCardRate userCardRate where userCardRate.version=? and userCardRate.recNo=? ";
		List<UserCardRate> list=executeQuery(hql,version,recNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//根据联合主键删除数据
	public boolean deleteBycompositeID(Object version,Object recNo){
		List<UserCardRate> li=this.LoadUserCardRate(version, recNo);
		if(li!=null){
			UserCardRate userCardRate=li.get(0);
			getSession().clear();
			getSession().refresh(userCardRate);
			getSession().merge(userCardRate);
			getSession().delete(userCardRate);
		}
		
		if (this.LoadUserCardRate(version, recNo) == null)
			return true;
		else
			return false;
	}
	//chenfuyuan
   @SuppressWarnings("unchecked")
	public List<UserCardRate> getAllUserCardRate() {
		String hql = " from UserCardRate userCardRate";
		List resultList = this.executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
   @SuppressWarnings("unchecked")
public UserCardRate getUserCardRateByVersionAndRecNo(Short version,Short recNo){
	   String hql = " from UserCardRate userCardRate where userCardRate.version="+version+" and userCardRate.recNo="+recNo;
	   List resultList = this.executeQuery(hql);
	   if (resultList.isEmpty()) {
			return null;
		} else {
			return (UserCardRate)resultList.get(0);
		}
   }
   
   //zenggenbao(获得recNo的最大值)
   public int getMax(){
	   String sql = "select max(recNo) from tb_UserCardRate";
	  // List list = this.executeQuery(hql);
	   int seqNo = jdbcUtil.select(sql);
	   /*if(!list.isEmpty()){
		   System.out.println("=================list================:"+list);
		   return Integer.parseInt(list.get(0).toString());
	   }*/
	   return seqNo;
   }
   
   @SuppressWarnings("unchecked")
	public List<UserCardRate> findByCondition(Pager pager,
			Short version, Short userCardType, Short recNo) {

		StringBuffer sf = new StringBuffer(
				"from UserCardRate userCardRate where");
		List<Object> obj = new ArrayList<Object>();
		if (version!=null) {
			sf.append(" userCardRate.version = ? and");
			obj.add(version);
		}
		if (userCardType!=null) {
			sf.append(" userCardRate.userCardType = ? and");
			obj.add(userCardType);
		}
		if (recNo!=null) {
			sf.append(" userCardRate.recNo = ? and");
			obj.add(recNo);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
   
}
