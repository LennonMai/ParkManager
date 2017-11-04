package com.hgsoft.unit.testAction;

import javax.servlet.ServletException;
import org.easymock.EasyMock;
import org.easymock.IMocksControl;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletResponse;
import com.hgsoft.entity.Account;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.User;
import com.hgsoft.service.AccountService;
import com.hgsoft.service.AccountTransactionService;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CarService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserService;
import com.hgsoft.util.Pager;

public class TestUserCarAccountAction {
	private IMocksControl mocksControl;

	@Before
	public void setUp() throws Exception {
		/**
		 * ����Mock���������ַ����� 1����ֻ��Ҫ����һ��Mock����ʱ����ֱ�ӵ���EasyMock.createMock(toMock)����;
		 * 2���贴�����Mock����ʱ����Ҫ����Mock�������ഴ��Mock�����磺
		 * mocksControl=EasyMock.createControl();
		 * mock=mocksControl.createMock(toMcok);
		 */
		mocksControl = EasyMock.createControl();
		mocksControl.createMock(UserService.class);
		mocksControl.createMock(CarService.class);
		mocksControl.createMock(AccountService.class);
		mocksControl.createMock(SysparamconfService.class);
		mocksControl.createMock(AdminService.class);
		mocksControl.createMock(SystemLogService.class);
		mocksControl.createMock(AccountTransactionService.class);
		mocksControl.createMock(Pager.class);
		new MockHttpServletResponse();

	}

	@After
	public void tearDown() throws Exception {
		// ���ڴ˴����ж���ȵ����ٲ���
	}

	@Test
	public void testQueryAccountToAdd() throws ServletException {
		Account account = new Account();
		User user = new User();
		Car car = new Car();
		account.setCardNo("");
		user.setUserName("");
		user.setCredentialsNo("");
		car.setVehPlate("");

		// EasyMock.expect(mockAccountService.getAccount(cardNo).andReturn(account));
		System.out.println("account.getCardNo())" + account.getCardNo());
		if (null == account.getSys_id() && "".equals(account.getCardNo()) && "".equals(user.getUserName()) && null == user.getCredentialsType() && "".equals(user.getCredentialsNo()) && "".equals(car.getVehPlate()) && null == account.getStatus()) {
			System.out.println("111111111111111");
		} else {
			// list = accountService.findAllItemByHql(pager,
			// account.getSys_id(), account.getCardNo(), user.getUserName(),
			// user.getCredentialsType(), user.getCredentialsNo(),
			// car.getVehPlate(), account.getStatus());
			System.out.println("2222222222222222222");
		}
	}
}
