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
	 * ����������ѯ��ȫ�û���Ϣ
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
	 * �ύ��ȫ�û�ע����Ϣ
	 * @return
	 */
	public SecurityUserInfo register(String callNum,String password,String cardNo){
		
		SecurityUserInfo securityUserInfo= securityUserInfoDao.register(callNum, password, cardNo);
		return securityUserInfo;
	}
	
	
	/**
	 * ��ȡҪ���µĶ���
	 * @param regId
	 * @return
	 */
	public SecurityUserInfo toUpdate(String regId){
		SecurityUserInfo securityUserInfo = securityUserInfoDao.toUpdate(regId);
		return securityUserInfo;
	}
	
	
	
	/**
	 * ���°�ȫ�û���Ϣ
	 * @param regId
	 * @param cardNo
	 * @param password
	 * @param callNum
	 */
	public void update(SecurityUserInfo entity){
		securityUserInfoDao.update(entity);
	}
	
	/**
	 * ɾ����ȫ�û�ע����Ϣ
	 * @param regId
	 */
	public void delete(String regId){
		securityUserInfoDao.delete(regId);		
	}
	
	//ͨ��cardNo������û���ȫ��Ϣ
	public boolean getByCardNo(String cardNo){
		return securityUserInfoDao.getByCardNo(cardNo);
	}
	public void deleteByCardNo(String cardNo) {
		securityUserInfoDao.deleteByCardNo(cardNo);
	}
}
