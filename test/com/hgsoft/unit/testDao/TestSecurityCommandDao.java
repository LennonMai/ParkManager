/**
*CopyRight (c) 曾根宝 (kevin)  广州华工信息软件有限公司 http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*转载请注明版权所有
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
	 * 检查不定时操作（String,string,String）
	 */
	@Test
	@Rollback
	public void testGetByCardNoTypeValidType(){
		boolean flag = securityCommandDao.getByCardNoTypeValidType("123456", Short.parseShort("1"), Short.parseShort("1"));
		assertEquals("flag判断为：true",false, flag);
	}
	/**
	 * 获取命令（根据commandId）
	 */
	@Test
	@Rollback
	public void testGetByCommandId(){
		SecurityCommand command = securityCommandDao.getByCommandId("1");
		assertNull("command对象不为空！",command);
	}
	
	/**
	 * 根据卡号和车牌号检验
	 */
	@Test
	@Rollback
	public void testGetCheckUserCardInfo(){
		boolean flag = securityCommandDao.getCheckUserCardInfo("123456", "123456");
		assertEquals("flae判断为：true",false,flag);
	}
	/**
	 * 根据(cardNo,type,validType)获取命令数据
	 */
	@Test
	@Rollback
	public void testQueryCommand(){
		List list = securityCommandDao.queryCommand("11111", "1", "1");
		assertNotNull("list数组为空！",list);
		assertEquals(0,list.size());
	}
	/**
	 *  根据条件查询安全指令
	 */
	@Test
	@Rollback
	public void testQuerySecurityCommand(){
		List list = securityCommandDao.querySecurityCommand(new Pager(), null, null, null, null, null);
		assertNotNull("list数组为空！",list);
		System.out.println(list.size());
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
