package com.hgsoft.integration.testService;

import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.entity.SecurityUserInfo;
import com.hgsoft.service.SecurityUserInfoService;
import com.hgsoft.util.Pager;



public class TestSecurityUserInfoService extends AbstractServiceTransactionalTests{

	@Autowired
	private SecurityUserInfoService securityUserInfoService;
	
	/**
	 * ��ҳ��ѯ
	 */
	@Test
	@Rollback
	public void testQuerySecurityUserInfo(){
		//List list = securityUserInfoService.querySecurityUserInfo(new Pager(), null, null, null, null, null, null, null, null,null);
		//assertNotNull("list����Ϊ��",list);
		//System.out.println(list.size());
	}
	/**
	 * ɾ�� String
	 */
	@Test
	@Rollback
	public void testDelete(){
		String regId="21";
		SecurityUserInfo temp = securityUserInfoService.toUpdate(regId);
		assertNotNull("temp����Ϊnull",temp);
		securityUserInfoService.delete(regId);
		SecurityUserInfo info = securityUserInfoService.toUpdate(regId);
		assertNull("info����Ϊnull", info);
	}
	/**
	 * ��ȡ��ȫ��Ϣ stirng 
	 */
	@Test
	@Rollback
	public void testGetByCardNo(){
		String cardNo = "";
		boolean flag = securityUserInfoService.getByCardNo(cardNo);
		assertEquals("ʵ��Ϊtrue",false,flag);
		cardNo="543543545";
		boolean temp = securityUserInfoService.getByCardNo(cardNo);
		assertEquals("ʵ��Ϊflase", true,temp);
	}
	/**
	 * ע�ᰲȫ��Ϣ callNum,password,cardNo
	 */
	@Test
	@Rollback
	public void testRegister(){
		String callNum = "13728058624";
		String password = "123456";
		String cardNo = "45435";
		SecurityUserInfo info = securityUserInfoService.register(callNum, password, cardNo);
		assertNotNull("info����Ϊ��", info);
	}
	/**
	 * ���°�ȫ��Ϣ
	 */
	@Test
	@Rollback
	public void testToUpdate(){
		String regId = "0";
		SecurityUserInfo info = securityUserInfoService.toUpdate(regId);
		assertNull("info����Ϊ��", info);
		regId = "4";
		SecurityUserInfo temp = securityUserInfoService.toUpdate(regId);
		assertNotNull("temp����Ϊ��",temp);
	}
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testUpdate(){
		SecurityUserInfo info = securityUserInfoService.toUpdate("4");
		info.setCallNum("12345678901");
		info.setCardNo("123456");
		info.setIsValid(Short.valueOf("1"));
		info.setPassword("123456");
		info.setRegTime(new Date());
		securityUserInfoService.update(info);
		SecurityUserInfo entiy = securityUserInfoService.toUpdate("4");
		assertNotNull("entiy����Ϊ��", entiy);
		//System.out.println(entiy.getCallNum());
	}
	
	
	
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
