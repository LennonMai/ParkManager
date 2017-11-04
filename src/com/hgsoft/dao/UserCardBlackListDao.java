package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.UserCardBlackList;
import com.hgsoft.util.Pager;

@Repository
public class UserCardBlackListDao extends BaseDao<UserCardBlackList>{
	@SuppressWarnings("unchecked")
	public List<UserCardBlackList> ishasUserCardBlackList(String uccode){
		String hql="from UserCardBlackList userCardBlackList where userCardBlackList.uccode=?";
		List<UserCardBlackList> list=executeQuery(hql,uccode);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<UserCardBlackList> findByCondition(Pager pager,String uccode,String genCau,Date genTime){
		StringBuffer sf = new StringBuffer("from UserCardBlackList userCardBlackList where");
		List<Object> obj = new ArrayList<Object>();
		
		SimpleDateFormat formatI = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatII = new SimpleDateFormat("yyyy-MM-dd");
		Date startTime=null,endTime=null;
		if(genTime!=null){
			try {
				startTime=formatI.parse(formatII.format(genTime)+" 00:00:00");
				endTime=formatI.parse(formatII.format(genTime)+" 23:59:59");
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if (!uccode.equals("")){
			sf.append(" userCardBlackList.uccode like ? and");
			obj.add("%"+uccode+"%");
		}
		if (!genCau.equals("")){
			sf.append(" userCardBlackList.genCau like ? and");
			obj.add("%"+genCau+"%");
		}
		if (startTime!=null){
			sf.append(" userCardBlackList.genTime >= ? and");
			obj.add(startTime);
		}
		if (endTime!=null){
			sf.append(" userCardBlackList.genTime<= ? and");
			obj.add(endTime);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");

		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString()+"ORDER BY userCardBlackList.genTime DESC", obj.toArray());
	}
}
