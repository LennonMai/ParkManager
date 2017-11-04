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
		assertNotNull("context����Ϊ�գ�", context);
		accountAction = (AccountAction) context.getBean("accountAction");
    }

	@Test
	public void testMul() {// ����AccountAction�е�public double mul(double d1, double d2) {  ���Ƚ���ת�����������������������磺41070.7(double��)*100�����
		double expectedValue = 4107070;// ����ֵ
		double actualValue = accountAction.mul(100, 41070.7);// ʵ��ֵ
		assertEquals(expectedValue, actualValue, 0);
		// assertEquals(4107070, 41070.7*100,0);//���������41070.7*100,0�Ľ��Ϊ��4107069.9999999995
	}
	@Test
	public void testDeleteFirstZero(){// ȥ������ǰ���0
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

