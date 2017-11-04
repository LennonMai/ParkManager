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
	 * 分页查询
	 */
	@Test
	@Rollback
	public void testQuerySecurityUserInfo(){
		//List list = securityUserInfoService.querySecurityUserInfo(new Pager(), null, null, null, null, null, null, null, null,null);
		//assertNotNull("list对象为空",list);
		//System.out.println(list.size());
	}
	/**
	 * 删除 String
	 */
	@Test
	@Rollback
	public void testDelete(){
		String regId="21";
		SecurityUserInfo temp = securityUserInfoService.toUpdate(regId);
		assertNotNull("temp对象为null",temp);
		securityUserInfoService.delete(regId);
		SecurityUserInfo info = securityUserInfoService.toUpdate(regId);
		assertNull("info对象不为null", info);
	}
	/**
	 * 获取安全信息 stirng 
	 */
	@Test
	@Rollback
	public void testGetByCardNo(){
		String cardNo = "";
		boolean flag = securityUserInfoService.getByCardNo(cardNo);
		assertEquals("实际为true",false,flag);
		cardNo="543543545";
		boolean temp = securityUserInfoService.getByCardNo(cardNo);
		assertEquals("实际为flase", true,temp);
	}
	/**
	 * 注册安全信息 callNum,password,cardNo
	 */
	@Test
	@Rollback
	public void testRegister(){
		String callNum = "13728058624";
		String password = "123456";
		String cardNo = "45435";
		SecurityUserInfo info = securityUserInfoService.register(callNum, password, cardNo);
		assertNotNull("info对象为空", info);
	}
	/**
	 * 更新安全信息
	 */
	@Test
	@Rollback
	public void testToUpdate(){
		String regId = "0";
		SecurityUserInfo info = securityUserInfoService.toUpdate(regId);
		assertNull("info对象不为空", info);
		regId = "4";
		SecurityUserInfo temp = securityUserInfoService.toUpdate(regId);
		assertNotNull("temp对象为空",temp);
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
		assertNotNull("entiy对象为空", entiy);
		//System.out.println(entiy.getCallNum());
	}
	
	
	
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
