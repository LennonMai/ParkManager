package com.hgsoft.unit.testDao;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.SystemParaDao;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

public class TestSystemParaDao extends AbstractDaoTransactionalTests{
	@Resource
	private SystemParaDao systemParaDao;
	@Resource
	private JdbcUtil jdbcUtil;
	@Autowired
	private SysparamconfService sysparamconfService;

	@Test
	public void testIshasSystemPara() {
		Short paraClass=1;String item[]={"小区编码 ","通行券类型编码表 "};
		assertNotNull(systemParaDao.ishasSystemPara(paraClass, item[0]));
	}

	@Test
	public void testLoadSystemPara() {
		Short paraClass=1;String item[]={"小区编码 ","通行券类型编码表 "};
		assertNotNull(systemParaDao.LoadSystemPara(paraClass, item[0]));
	}

	@Test
	@Rollback
	public void testDeleteBycompositeID() {
		Short paraClass=2 ;String item[]={"test2 ","小区编码 ","通行券类型编码表 "};
		assertNotNull(systemParaDao.ishasSystemPara(paraClass, item[0]));
	}

	@Test
	public void testFindSystemParaByCondition() {
		Pager pager=new Pager();
		pager.setPageSize("15");
		Short paraClass=-1;
		assertNotNull(systemParaDao.findSystemParaByCondition(pager, paraClass, "小区编码 ", "tb_park", "BaseCode"));
	}

	@Test
	public void testFindSecondMaxItemOrderByparaClass() {
		Short paraClass=-1;
		System.out.println("paraClassItemOrder-:"+systemParaDao.findSecondMaxItemOrderByparaClass(paraClass));
	}
	@Test
	public void testFindMaxItemOrderBygroupName() {
		String groupName[]={"AdvCode ","BaseCode ","BlackList","CardInfo ","Price ","Operator ","Security ","Default "};
		System.out.println("AdvCodeItemOrder-:"+systemParaDao.findMaxItemOrderBygroupName(groupName[0]));
		System.out.println("BaseCodeItemOrder-:"+systemParaDao.findMaxItemOrderBygroupName(groupName[1]));
		System.out.println("BlackListItemOrder-:"+systemParaDao.findMaxItemOrderBygroupName(groupName[2]));
		System.out.println("CardInfoItemOrder-:"+systemParaDao.findMaxItemOrderBygroupName(groupName[3]));
		System.out.println("PriceItemOrder-:"+systemParaDao.findMaxItemOrderBygroupName(groupName[4]));
		System.out.println("OperatorItemOrder-:"+systemParaDao.findMaxItemOrderBygroupName(groupName[5]));
		System.out.println("SecurityItemOrder-:"+systemParaDao.findMaxItemOrderBygroupName(groupName[6]));
		System.out.println("DefaultItemOrder-:"+systemParaDao.findMaxItemOrderBygroupName(groupName[7]));
	}
	@Test
	@Rollback(true)
	public void testgetSysparamconfByQname() {
		//运用jdbc查找出pname的pvalue
		String pvalue=jdbcUtil.selectForString("select pvalue from t_park_sysparamconf where pname='endAccount_amongTime'");
		//当参数endAccount_amongTime不存在时
		if (pvalue.equals("")) {
			//模拟插入数据
			Sysparamconf param_endAccount_amongTime = new Sysparamconf();
			param_endAccount_amongTime.setPname("endAccount_amongTime");
			param_endAccount_amongTime.setPtype(1);
			param_endAccount_amongTime.setPvalue("10");
			sysparamconfService.save(param_endAccount_amongTime);
			//验证getSysparamconfByQname(String pname)函数
			Sysparamconf sysparamconf = sysparamconfService.getSysparamconfByQname("endAccount_amongTime");
			//验证数据是否正确
			assertNotNull(sysparamconf);
			String pvalueTemp = sysparamconf.getPvalue();
			assertEquals("10", pvalueTemp);
		}else{//当参数endAccount_amongTime存在时，验证验证getSysparamconfByQname(String pname)函数
			Sysparamconf sysparamconfTemp = sysparamconfService.getSysparamconfByQname("endAccount_amongTime");
			assertNotNull(sysparamconfTemp);
			//运用jdbc查出来的值和getSysparamconfByQname(String pname)查出来的值是否相同
			assertEquals(pvalue,sysparamconfTemp.getPvalue());
		}

	}
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
