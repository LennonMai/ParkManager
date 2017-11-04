/**
*CopyRight (c) ������ (kevin)  ���ݻ�����Ϣ������޹�˾ http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*ת����ע����Ȩ����
*/
package com.hgsoft.unit.testDao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.SecurityCommandDao;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.util.Pager;

public class TestSecurityCommandDao extends AbstractDaoTransactionalTests {

	@Autowired
	private SecurityCommandDao securityCommandDao;
	
	/**
	 * ��鲻��ʱ������String,string,String��
	 */
	@Test
	@Rollback
	public void testGetByCardNoTypeValidType(){
		boolean flag = securityCommandDao.getByCardNoTypeValidType("123456", Short.parseShort("1"), Short.parseShort("1"));
		assertEquals("flag�ж�Ϊ��true",false, flag);
	}
	/**
	 * ��ȡ�������commandId��
	 */
	@Test
	@Rollback
	public void testGetByCommandId(){
		SecurityCommand command = securityCommandDao.getByCommandId("1");
		assertNull("command����Ϊ�գ�",command);
	}
	
	/**
	 * ���ݿ��źͳ��ƺż���
	 */
	@Test
	@Rollback
	public void testGetCheckUserCardInfo(){
		boolean flag = securityCommandDao.getCheckUserCardInfo("123456", "123456");
		assertEquals("flae�ж�Ϊ��true",false,flag);
	}
	/**
	 * ����(cardNo,type,validType)��ȡ��������
	 */
	@Test
	@Rollback
	public void testQueryCommand(){
		List list = securityCommandDao.queryCommand("11111", "1", "1");
		assertNotNull("list����Ϊ�գ�",list);
		assertEquals(0,list.size());
	}
	/**
	 *  ����������ѯ��ȫָ��
	 */
	@Test
	@Rollback
	public void testQuerySecurityCommand(){
		List list = securityCommandDao.querySecurityCommand(new Pager(), null, null, null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
		System.out.println(list.size());
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
