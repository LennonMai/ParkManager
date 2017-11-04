package com.hgsoft.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.SecurityUserInfoDao;
import com.hgsoft.entity.SecurityUserInfo;
import com.hgsoft.util.Pager;

@Service
public class SecurityUserInfoService {
	
	@Resource
	private SecurityUserInfoDao securityUserInfoDao;
	
	
	/**
	 * 根据条件查询安全用户信息
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
	public List<Object[]> querySecurityUserInfo(Pager pager,String owner,String IDCard,String vehPlate,String OBU,String userType,String cardNO,String status,String feeRuleType,String whtherPayType,String whtherRegister){
		
		return securityUserInfoDao.findPagerByHql(pager,owner,IDCard,vehPlate,OBU,userType,cardNO,status,feeRuleType,whtherPayType,whtherRegister);
	}
	
	
	/**
	 * 提交安全用户注册信息
	 * @return
	 */
	public SecurityUserInfo register(String callNum,String password,String cardNo){
		
		SecurityUserInfo securityUserInfo= securityUserInfoDao.register(callNum, password, cardNo);
		return securityUserInfo;
	}
	
	
	/**
	 * 获取要更新的对象
	 * @param regId
	 * @return
	 */
	public SecurityUserInfo toUpdate(String regId){
		SecurityUserInfo securityUserInfo = securityUserInfoDao.toUpdate(regId);
		return securityUserInfo;
	}
	
	
	
	/**
	 * 更新安全用户信息
	 * @param regId
	 * @param cardNo
	 * @param password
	 * @param callNum
	 */
	public void update(SecurityUserInfo entity){
		securityUserInfoDao.update(entity);
	}
	
	/**
	 * 删除安全用户注册信息
	 * @param regId
	 */
	public void delete(String regId){
		securityUserInfoDao.delete(regId);		
	}
	
	//通过cardNo来获得用户安全信息
	public boolean getByCardNo(String cardNo){
		return securityUserInfoDao.getByCardNo(cardNo);
	}
	public void deleteByCardNo(String cardNo) {
		securityUserInfoDao.deleteByCardNo(cardNo);
	}
}
