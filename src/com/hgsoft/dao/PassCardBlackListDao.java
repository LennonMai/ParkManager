package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.PassCardBlackList;
import com.hgsoft.util.Pager;

@Repository 
public class PassCardBlackListDao extends BaseDao<PassCardBlackList>{
	
	//验证唯一性
	@SuppressWarnings("unchecked")
	public List<PassCardBlackList> ishasPassCardBlackList(Object cardNo){
		String hql="select pcblInfo.cardNo from PassCardBlackList pcblInfo where pcblInfo.cardNo=?";
		List<PassCardBlackList> list=executeQuery(hql,cardNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//加载PassCardBlackList
	@SuppressWarnings("unchecked")
	public List<PassCardBlackList> LoadPassCardBlackList(Object cardNo){
		
		String hql=" from PassCardBlackList pcblInfo where pcblInfo.cardNo=?";
		List<PassCardBlackList> list=executeQuery(hql,cardNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<PassCardBlackList> findByCondition(Pager pager,String cardNo,Short inValidTypeNo,Date opTime){
		StringBuffer sf = new StringBuffer("from PassCardBlackList passCardBlackList where");
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
			sf.append(" passCardBlackList.cardNo like ? and");
			obj.add("%"+cardNo+"%");
		}
		if (inValidTypeNo!=null){
			sf.append(" passCardBlackList.inValidTypeNo = ? and");
			obj.add(inValidTypeNo);
		}
		if (startTime!=null){
			sf.append(" passCardBlackList.opTime >= ? and");
			obj.add(startTime);
		}
		if (endTime!=null){
			sf.append(" passCardBlackList.opTime<= ? and");
			obj.add(endTime);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString()+"ORDER BY passCardBlackList.opTime DESC", obj.toArray());
	}
}
