package com.hgsoft.dao;


import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SecurityCommandBackup;
import com.hgsoft.entity.SecurityCommandOperation;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.util.Pager;




@Repository
public class SecurityCommandBackupDao extends BaseDao<SecurityCommandBackup> {

	
	@SuppressWarnings("unchecked")
	public List query(Pager pager,String type,String validType,String owner,String cardNo,String vehPlate){
		String hql = "from SecurityCommandBackup securityCommandBackup,UserCardInfo userCardInfo where securityCommandBackup.cardNo = userCardInfo.cardNo and ";
		List list = new ArrayList();
		StringBuffer sb = new StringBuffer(0);
		List resultList = new ArrayList();
		if(null != type && !type.equals("")){
			sb.append("securityCommandBackup.type = ? and ");
			list.add(Short.parseShort(type));
		}
		if(null != validType && !validType.equals("")){
			sb.append("securityCommandBackup.validType = ? and ");
			list.add(Short.parseShort(validType));
		}
		if(null != owner && !owner.equals("")){
			sb.append("userCardInfo.owner =? and ");
			list.add(owner);
		}
		if(null != cardNo && !cardNo.equals("")){
			sb.append("userCardInfo.cardNo = ? and ");
			list.add(cardNo);
		}
		if(null != vehPlate && !vehPlate.equals("")){
			sb.append("userCardInfo.vehPlate = ? and ");
			list.add(vehPlate);
		}
		if(list.size() != 0){
			sb = sb.replace(sb.length() - 4, sb.length(), "");
		}else{
			hql = hql.substring(0, 131);
		}
		Long count = this.executeCount(hql + sb.toString(), list.toArray());
		pager.setTotalSize(count);
		List list1 = this.executeQuery(pager,hql + sb.toString() + " order by securityCommandBackup.opTime desc", list.toArray());
		Iterator it = list1.iterator();
		while(it.hasNext()){
			Object[] obj = (Object[]) it.next();
			SecurityCommandBackup scb = (SecurityCommandBackup) obj[0];
			if(!scb.getStartTime().trim().equals("")){
				if(scb.getStartTime().trim().length()==4){
					String yuan = scb.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					scb.setStartTime(sb1.toString());
				}
				if(scb.getStartTime().trim().length()==12){
					String yuan = scb.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					scb.setStartTime(sb1.toString());
				}
			}
			if(!scb.getEndTime().trim().equals("")){
				if(scb.getEndTime().trim().length()==4){
					String yuan = scb.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					scb.setEndTime(sb1.toString());
				}
				if(scb.getEndTime().trim().length()==12){
					String yuan = scb.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					scb.setEndTime(sb1.toString());
				}
			}
			UserCardInfo uci = (UserCardInfo) obj[1];
			Object[] ay = new Object[]{scb,uci};
			resultList.add(ay);
		}
		return resultList;
	}
	
	
	@SuppressWarnings("unchecked")
	public Long getCount(String commandId){	
		String hql="from SecurityCommandBackup securityCommandBackup where securityCommandBackup.commandId = ?";
		Long count = this.executeCount(hql, Integer.parseInt(commandId));
		return count;
	}
	
	
	@SuppressWarnings("unchecked")
	public List show(Pager pager,String commandId,String modId){
		String hql = "from SecurityCommandBackup backup,SecurityCommandOperation operation where operation.commandId = backup.commandId and backup.commandId = ? and backup.modId =?";
		List resultList = new ArrayList();
		Long count = this.executeCount(hql, Integer.parseInt(commandId),Integer.parseInt(modId));
		pager.setTotalSize(count);
		List list = this.executeQuery(pager,hql, Integer.parseInt(commandId),Integer.parseInt(modId));
		Iterator it = list.iterator();
		while(it.hasNext()){
			Object[] obj = (Object[])it.next();
			SecurityCommandOperation operation = (SecurityCommandOperation) obj[1];
			SecurityCommandBackup backup = (SecurityCommandBackup) obj[0];
			if(!backup.getStartTime().trim().equals("")){
				if(backup.getStartTime().trim().length()==4){
					String yuan = backup.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					backup.setStartTime(sb1.toString());
				}
				if(backup.getStartTime().trim().length()==12){
					String yuan = backup.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					backup.setStartTime(sb1.toString());
				}
			}
			if(!backup.getEndTime().trim().equals("")){
				if(backup.getEndTime().trim().length()==4){
					String yuan = backup.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					backup.setEndTime(sb1.toString());
				}
				if(backup.getEndTime().trim().length()==12){
					String yuan = backup.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					backup.setEndTime(sb1.toString());
				}
			}
			Object[] ay = new Object[]{backup,operation};
			resultList.add(ay);
		}
		return resultList;
	}
}
