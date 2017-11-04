package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.OpCardBlackList;
import com.hgsoft.util.Pager;
@Repository 
public class OpCardBlackListDao extends BaseDao<OpCardBlackList>{
	
	//验证唯一性
	@SuppressWarnings("unchecked")
	public List<OpCardBlackList> ishasOpCardBlackList(Object cardNo){
		String hql="select opCardBlackList.cardNo from OpCardBlackList opCardBlackList where opCardBlackList.cardNo=?";
		List<OpCardBlackList> list=executeQuery(hql,cardNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//加载PassCardBlackList
	@SuppressWarnings("unchecked")
	public List<OpCardBlackList> LoadOpCardBlackList(Object cardNo){
	
		String hql=" from OpCardBlackList opCardBlackList where opCardBlackList.cardNo=?";
		List<OpCardBlackList> list=executeQuery(hql,cardNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<OpCardBlackList> findByCondition(Pager pager,String cardNo,Short inValidTypeNo,Date opTime){
		StringBuffer sf = new StringBuffer("from OpCardBlackList opCardBlackList where");
		List<Object> obj = new ArrayList<Object>();

		SimpleDateFormat formatI = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatII = new SimpleDateFormat("yyyy-MM-dd");
		Date startTime=null,endTime=null;
		if(opTime!=null){
			try {
				startTime=formatI.parse(formatII.format(opTime)+" 00:00:00");
				endTime=formatI.parse(formatII.format(opTime)+" 23:59:59");
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if (!cardNo.equals("")){
			sf.append(" opCardBlackList.cardNo like ? and");
			obj.add("%"+cardNo+"%");
		}
		if (inValidTypeNo!=null){
			sf.append(" opCardBlackList.inValidTypeNo = ? and");
			obj.add(inValidTypeNo);
		}
		if (startTime!=null){
			sf.append(" opCardBlackList.opTime >= ? and");
			obj.add(startTime);
		}
		if (endTime!=null){
			sf.append(" opCardBlackList.opTime<= ? and");
			obj.add(endTime);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString()+"ORDER BY opCardBlackList.opTime DESC", obj.toArray());
	}
}
