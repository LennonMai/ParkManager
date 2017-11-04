package com.hgsoft.unit.testAction;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import com.hgsoft.action.AccountAction;
public class TestAccountAction extends AbstractActionTransactionalTests{
	private AccountAction accountAction;
	private static ApplicationContext context;	
     @Override
    protected void onSetUp() throws Exception {
    	if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		accountAction = (AccountAction) context.getBean("accountAction");
    }

	@Test
	public void testMul() {// 测试AccountAction中的public double mul(double d1, double d2) {  精度结算转换，不用这个函数会出错，比如：41070.7(double型)*100会出错
		double expectedValue = 4107070;// 期望值
		double actualValue = accountAction.mul(100, 41070.7);// 实际值
		assertEquals(expectedValue, actualValue, 0);
		// assertEquals(4107070, 41070.7*100,0);//这样会出错，41070.7*100,0的结果为：4107069.9999999995
	}
	@Test
	public void testDeleteFirstZero(){// 去掉卡号前面的0
		String expectedValue = "25";
		String actualValue = accountAction.deleteFirstZero("00000000025");
		assertEquals(expectedValue, actualValue);
	}
	@Test
	public void testBalanceQuery(){
		accountAction.balanceQuery();
	}
	@Test
	public void testPaymantEdit(){
		accountAction.paymentEdit();
	}
    
	@Override
	protected void onTearDown() throws Exception {
		accountAction = null;
	}
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}

}

