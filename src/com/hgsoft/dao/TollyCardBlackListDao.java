package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.TollyCardBlackList;
import com.hgsoft.util.Pager;

@Repository 
public class TollyCardBlackListDao extends BaseDao<TollyCardBlackList>{
	
	//验证唯一性
	@SuppressWarnings("unchecked")
	public List<TollyCardBlackList> ishasTollyCardBlackList(Object accode){
		String hql="select tcblInfo.accode from TollyCardBlackList tcblInfo where tcblInfo.accode=?";
		List<TollyCardBlackList> list=executeQuery(hql,accode);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//加载TollyCardBlackList
	@SuppressWarnings("unchecked")
	public List<TollyCardBlackList> LoadTollyCardBlackList(Object accode){
		
		String hql=" from TollyCardBlackList tcblInfo where tcblInfo.accode=?";
		List<TollyCardBlackList> list=executeQuery(hql,accode);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<TollyCardBlackList> findByCondition(Pager pager,String accode,String genCau,Date genTime){
		StringBuffer sf = new StringBuffer("from TollyCardBlackList tollyCardBlackList where");
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
		
		if (!accode.equals("")){
			sf.append(" tollyCardBlackList.accode like ? and");
			obj.add("%"+accode+"%");
		}
		if (!genCau.equals("")){
			sf.append(" tollyCardBlackList.genCau like ? and");
			obj.add("%"+genCau+"%");
		}
		if (startTime!=null){
			sf.append(" tollyCardBlackList.genTime >= ? and");
			obj.add(startTime);
		}
		if (endTime!=null){
			sf.append(" tollyCardBlackList.genTime<= ? and");
			obj.add(endTime);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString()+"ORDER BY tollyCardBlackList.genTime DESC", obj.toArray());
	}
	
}
