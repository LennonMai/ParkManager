package com.hgsoft.unit.testDao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.SecurityUserInfoDao;
import com.hgsoft.entity.SecurityUserInfo;
import com.hgsoft.util.Pager;



public class TestSecurityUserInfoDao extends AbstractDaoTransactionalTests{
	
	@Autowired
	SecurityUserInfoDao securityUserInfodao;
	
	/**
	 * ��ҳ��ѯ
	 */
	@Test
	@Rollback
	public void testFindPaperByHql(){
		//List list  = securityUserInfodao.findPagerByHql(new Pager(), null, null, null, null, null, null, null, null,null);
		//assertNotNull(list);
		//System.out.println("findPaperByHql size:" +list.size());
	}
	
	/**
	 * ɾ��(String)
	 */
	@Test
	@Rollback
	public void testDelete(){
		String regId = "4";
		securityUserInfodao.delete(regId);
		SecurityUserInfo info = securityUserInfodao.get(Integer.parseInt(regId));
		assertNull("ɾ���󣬸ö���Ϊ��",info);
	}
	
	/**
	 * ����û�����ȫ��Ϣ��string cardNo��
	 */
	@Test
	@Rollback
	public void testGetByCardNo(){
		String cardNo = "";
		boolean flagNull = securityUserInfodao.getByCardNo(cardNo);
		assertEquals("ʵ��Ϊtrue",false, flagNull);
		cardNo = "543543545";
		boolean flagTrue = securityUserInfodao.getByCardNo(cardNo);
		assertEquals("ʵ��Ϊfalse",true, flagTrue);
	}
	
	/**
	 *ע�ᰲȫ��Ϣ��String callnum,string password,Stirng cardNo��
	 */
	@Test
	@Rollback
	public void testRegister(){
		String callNum = "13728058624";
		String password = "123456";
		String cardNo = "45435";
		SecurityUserInfo info = securityUserInfodao.register(callNum, password, cardNo);
		assertNotNull("info����Ϊ��", info);
	}

	/**
	 * ���Ҫ���µĶ���
	 * string regId
	 */
	@Test
	@Rollback
	public void testToUpdate(){
		String regId = "0";
		SecurityUserInfo info = securityUserInfodao.toUpdate(regId);
		assertNull("info����Ϊnull", info);
		regId = "21";
		SecurityUserInfo temp = securityUserInfodao.toUpdate(regId);
		assertNotNull("tempΪnull", temp);
	}
	
	
	
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
		
	}
}
