package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.StoreCardBlackList;
import com.hgsoft.util.Pager;

@Repository 
public class StoreCardBlackListDao extends BaseDao<StoreCardBlackList>{
	
	//验证唯一性
	@SuppressWarnings("unchecked")
	public List<StoreCardBlackList> ishasStoreCardBlackList(Object scCode){
		String hql="select scblInfo.scCode from StoreCardBlackList scblInfo where scblInfo.scCode=?";
		List<StoreCardBlackList> list=executeQuery(hql,scCode);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//加载StoreCardBlackList
	@SuppressWarnings("unchecked")
	public List<StoreCardBlackList> LoadStoreCardBlackList(Object scCode){
		
		String hql=" from StoreCardBlackList scblInfo where scblInfo.scCode=?";
		
		List<StoreCardBlackList> list=executeQuery(hql,scCode);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	@SuppressWarnings("unchecked")
	public StoreCardBlackList getStoreCardBlackListByCardNo(String cardNo) {
		String hql="from StoreCardBlackList storeCardBlackList where  storeCardBlackList.scCode=?";
		List resultList=executeQuery(hql,cardNo);
		if(resultList.isEmpty())return null;	
		else return (StoreCardBlackList)resultList.get(0);
		
	}
	
	@SuppressWarnings("unchecked")
	public List<StoreCardBlackList> findByCondition(Pager pager,String scCode,String genCau,Date genTime){
		StringBuffer sf = new StringBuffer("from StoreCardBlackList storeCardBlackList where");
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
		
		if (!scCode.equals("")){
			sf.append(" storeCardBlackList.scCode like ? and");
			obj.add("%"+scCode+"%");
		}
		if (!genCau.equals("")){
			sf.append(" storeCardBlackList.genCau like ? and");
			obj.add("%"+genCau+"%");
		}
		if (startTime!=null){
			sf.append(" storeCardBlackList.genTime >= ? and");
			obj.add(startTime);
		}
		if (endTime!=null){
			sf.append(" storeCardBlackList.genTime<= ? and");
			obj.add(endTime);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString()+"ORDER BY storeCardBlackList.genTime DESC", obj.toArray());
	}

}
