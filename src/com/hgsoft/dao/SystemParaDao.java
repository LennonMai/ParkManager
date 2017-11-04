/**
 * 
 */
package com.hgsoft.dao;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SystemPara;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Repository
public class SystemParaDao extends BaseDao<SystemPara>{
	
	@Resource
	private JdbcUtil jdbcUtil;
	
	//��֤����Ψһ��
	@SuppressWarnings("unchecked")
	public List<SystemPara> ishasSystemPara(Object paraClass,Object item){
		String hql=" from SystemPara systemPara where systemPara.paraClass=? and systemPara.item=? " ;
		List<SystemPara> list=executeQuery(hql,paraClass,item);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//����SystemPara
	@SuppressWarnings("unchecked")
	public List<SystemPara> LoadSystemPara(Object paraClass,Object item){
	
		String hql=" from SystemPara systemPara where systemPara.paraClass=? and systemPara.item=? " ;
		List<SystemPara> systemPara=executeQuery(hql,paraClass,item);
		if(!systemPara.isEmpty()){
			return systemPara;
		}else
			return null;
	}
	
	//������������ɾ������
	public boolean deleteBycompositeID(Object paraClass,Object item){
		List<SystemPara> li=this.LoadSystemPara(paraClass,item);
		if(li!=null){
			SystemPara systemPara=li.get(0);
			getSession().clear();
			getSession().refresh(systemPara);
			getSession().merge(systemPara);
			delete(systemPara);
		}
		
		
		if (this.LoadSystemPara(paraClass,item)==null)
			return true;
		else
			return false;
	}
	//����������ѯ
	@SuppressWarnings("unchecked")
	public List<SystemPara> findSystemParaByCondition(Pager pager,
			Short paraClass, String item, String itemValue, String groupName) {
		StringBuffer sf = new StringBuffer(
				"from SystemPara systemPara where");
		List<Object> obj = new ArrayList<Object>();
		if (paraClass!=null) {
			sf.append(" systemPara.paraClass = ? and");
			obj.add(paraClass);
		}
		if (!item.equals("")) {
			sf.append(" systemPara.item like ? and");
			obj.add("%" + item + "%");
		}
		if (!itemValue.equals("")) {
			sf.append(" systemPara.itemValue like ? and");
			obj.add("%" + itemValue + "%");
		}
		if (!groupName.trim().equals("")) {
			sf.append(" systemPara.groupName like ? and");
			obj.add("%" + groupName.trim() + "%");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// ������������Է�ҳ��������
		
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString()+"order by systemPara.itemOrder desc", obj.toArray());
	}
	
	//��ѯȫ��ϵͳ����
	@SuppressWarnings("unchecked")
	public List<SystemPara> findAll(){
		String hql=" from SystemPara systemPara order by systemPara.paraClass desc" ;
		List<SystemPara> list=executeQuery(hql);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//���ݲ������Ͳ�ѯ��˳��
	public Short findSecondMaxItemOrderByparaClass(Short paraClass){
		/**
		 * ���򷨲�ѯ�ڶ��������
		 * select ItemOrder from (select Top 1* from (select  Top 2 * from tb_SystemPara  where ParaClass='-1' order by ItemOrder desc) ItemOrder order by ItemOrder asc ) ItemOrder
		 */
		String sql="select ItemOrder from (select Top 1* from (select  Top 2 * from tb_SystemPara  where ParaClass='"+paraClass+"' order by ItemOrder desc) ItemOrder order by ItemOrder asc ) ItemOrder" ;
		String hql="select Max(systemPara.itemOrder) from SystemPara systemPara where systemPara.paraClass=?" ;
		
		if(jdbcUtil.selectForString(sql).toString()!=""){
			if(Short.valueOf(executeQuery(hql,paraClass).get(0).toString())==(short)32767){
				return  Short.valueOf(jdbcUtil.selectForString(sql)); 
			}else return  Short.valueOf(executeQuery(hql,paraClass).get(0).toString()); 			
		}else
			return (short)-1;
	}
	
	//��������ѯ��˳��
	public Short findMaxItemOrderBygroupName(String groupName){	
		String hql="select Max(systemPara.itemOrder) from SystemPara systemPara where systemPara.groupName=?" ;
		if(executeQuery(hql,groupName).get(0)!=null){
			return Short.valueOf(executeQuery(hql,groupName).get(0).toString());
		}else
			return (short)-1;
	}
	
	@SuppressWarnings("unchecked")
	public List<SystemPara> findGroupName(){
		String hql=" from SystemPara systemPara where systemPara.paraClass ='-1'" ;
		List<SystemPara> list=executeQuery(hql);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
}
