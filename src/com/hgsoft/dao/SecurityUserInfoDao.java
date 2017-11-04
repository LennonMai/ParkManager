package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.SecurityUserInfo;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.util.Pager;



@Repository
public class SecurityUserInfoDao extends BaseDao<SecurityUserInfo> {

	
	/**
	 * 根据条件查询安全用户信息管理
	 * @param pager
	 * @param owner
	 * @param IDCard
	 * @param vehPlate
	 * @param OBU
	 * @param userType
	 * @param cardNO
	 * @param status
	 * @param feeRuleType
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> findPagerByHql(Pager pager,String owner,String IDCard,String vehPlate,String OBU,String userType,String cardNO,String status,String feeRuleType,String whtherPayType,String whtherRegister){
		List resultList = new ArrayList();
		StringBuffer sb= new StringBuffer(0);
		if(null != owner && !owner.equals("")){
			sb.append(" userCardInfo.owner like '%"+owner+"%' and");
		}
		if(null != IDCard && !IDCard.equals("")){
			sb.append(" userCardInfo.idcard like '%"+IDCard+"%' and");
		}
		if(null != vehPlate && !vehPlate.equals("")){
			sb.append(" userCardInfo.vehPlate like '%"+vehPlate+"%' and");
		}
		if(null != OBU && !OBU.equals("")){
			sb.append(" userCardInfo.obu like '%"+OBU+"%' and");
		}
		if (null != userType && !userType.equals("")) {
			sb.append(" userCardInfo.userCardType = "+Short.valueOf(userType.trim())+" and");
		}
		if(null != cardNO && !cardNO.equals("")){
			sb.append(" userCardInfo.cardNo like '%"+cardNO+"%' and");
		}
		if(null != status && !status.equals("")){
			sb.append(" userCardInfo.status = "+Short.valueOf(status.trim())+" and");
		}
		if(null != feeRuleType && !feeRuleType.equals("")){
			sb.append(" userCardInfo.feeRuleType = "+Short.parseShort(feeRuleType)+" and");
		}
		String hql="";
		if(null==whtherRegister ||"".equals(whtherRegister)){//没注册过、已注册过的用户卡信息
			hql = "from UserCardInfo userCardInfo where";
			if(sb.length()==0){
				hql = hql.substring(0, 30);
			}else{
				sb = sb.replace(sb.length() - 4, sb.length(), "");
				hql = hql +sb.toString();
			}
			Long count = executeCount(hql);
			pager.setTotalSize(count);
			List list = this.executeQuery(pager, hql+" order by registerTime desc");
			Iterator iterator1 = list.iterator();
			while (iterator1.hasNext()) {
			//	Object[] o = (Object[]) iterator1.next();
				UserCardInfo userCardInfo = (UserCardInfo) iterator1.next();
				SecurityUserInfo securityUserInfo = this.getSecurityUserInfoByCardNo(userCardInfo.getCardNo());
				Object ay = new Object[] { securityUserInfo, userCardInfo };
				resultList.add(ay);
			}	
		}else if("0".equals(whtherRegister)){//已注册过的用户卡信息
			hql = "from SecurityUserInfo securityUserInfo,UserCardInfo userCardInfo where userCardInfo.cardNo=securityUserInfo.cardNo and securityUserInfo.isValid=1";
			if(sb.length()==0){
			}else{
				sb = sb.replace(sb.length() - 4, sb.length(), "");
				hql = hql +" and"+sb.toString();
			}
			Long count = executeCount(hql);
			pager.setTotalSize(count);
			List list = this.executeQuery(pager, hql+" order by registerTime desc");
			Iterator iterator1 = list.iterator();
			while (iterator1.hasNext()) {
				Object[] o = (Object[]) iterator1.next();
				SecurityUserInfo securityUserInfo = (SecurityUserInfo) o[0];
				UserCardInfo userCardInfo = (UserCardInfo) o[1];				
				Object ay = new Object[] { securityUserInfo, userCardInfo };
				resultList.add(ay);
			}
		}else if("1".equals(whtherRegister)){//查询没注册过的用户卡信息
			hql = "from UserCardInfo userCardInfo where userCardInfo.cardNo not in (select  securityUserInfo.cardNo from SecurityUserInfo securityUserInfo where securityUserInfo.isValid=1)";
			if(sb.length()==0){
			}else{
				sb = sb.replace(sb.length() - 4, sb.length(), "");
				hql = hql +" and"+sb.toString();
			}
			Long count = executeCount(hql);
			pager.setTotalSize(count);
			List list = this.executeQuery(pager, hql+" order by registerTime desc");
			Iterator iterator1 = list.iterator();
			while (iterator1.hasNext()) {
				UserCardInfo userCardInfo = (UserCardInfo) iterator1.next();
				SecurityUserInfo securityUserInfo = this.getSecurityUserInfoByCardNo(userCardInfo.getCardNo());
				if(securityUserInfo==null){
					Object ay = new Object[] { securityUserInfo, userCardInfo };
					resultList.add(ay);
				}
			}
		}
		return resultList;
	}
	
	
	/**
	 * 注册安全管理信息
	 * @return
	 */
	public SecurityUserInfo register(String callNum,String password,String cardNo){
		
		Calendar ca = Calendar.getInstance();
		Date date = ca.getTime();
		SecurityUserInfo entity = new SecurityUserInfo();
		entity.setCallNum(callNum);
		entity.setCardNo(cardNo);
		entity.setIsValid(Short.valueOf("1"));
		entity.setPassword(password);
		entity.setRegTime(date);
		SecurityUserInfo securityUserInfo = this.save(entity);
		return securityUserInfo;
	}
	
	
	/**
	 * 删除安全用户信息
	 * @param regId
	 * @return
	 */
	public void delete(String regId){
		this.delete(this.load(Integer.parseInt(regId)));
	}
	
	
	/**
	 * 获取要更新的对象
	 * @param regId
	 * @return
	 */
	public SecurityUserInfo toUpdate(String regId){
		SecurityUserInfo securityUserInfo = this.get(Integer.parseInt(regId));
		return securityUserInfo;
		
	}
	//chenfuyuan
	public void deleteByCardNo(String cardNo) {
		String hql = "delete from SecurityUserInfo securityUserInfo where  securityUserInfo.cardNo='"+cardNo+"'";
		Query q = getSession().createQuery(hql) ;
        q.executeUpdate() ;		
	}
	//通过cardNo来获得对象
	@SuppressWarnings("unchecked")
	public boolean getByCardNo(String cardNo){
		boolean flag = false;
		String hql = "from SecurityUserInfo securityUserInfo where securityUserInfo.cardNo = ? and securityUserInfo.isValid ="+Short.parseShort("1");
		List list = this.executeQuery(hql, cardNo);
		if(list.size() != 0){
			flag = true;
		}
		return flag;
	}
	@SuppressWarnings("unchecked")
	public SecurityUserInfo getSecurityUserInfoByCardNo(String cardNo){
		String hql = "from SecurityUserInfo securityUserInfo where securityUserInfo.cardNo = ? and securityUserInfo.isValid ="+Short.parseShort("1");
		List list = this.executeQuery(hql, cardNo);
		if(list.isEmpty()){
			return null;
		}
		else{
			return (SecurityUserInfo)list.get(0);
		}
		
	}
}
