package com.hgsoft.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.FeeRuleTypeDef;

/**
 * �շ�����Dao
 */
@Repository
public class FeeRuleTypeDefDao extends BaseDao<FeeRuleTypeDef>  {

	//��֤�շ�����Ψһ��
	@SuppressWarnings("unchecked")
	public List<FeeRuleTypeDef> ishasFeeRuleType(Object feeRuleType){
		String hql=" from FeeRuleTypeDef feeRuleTypeDef where feeRuleTypeDef.feeRuleType=? ";
		List<FeeRuleTypeDef> list=executeQuery(hql,feeRuleType);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//��֤���������Ψһ��
	@SuppressWarnings("unchecked")
	public List<FeeRuleTypeDef> ishasName(Object name){
		String hql=" from FeeRuleTypeDef feeRuleTypeDef where feeRuleTypeDef.name=? ";
		List<FeeRuleTypeDef> list=executeQuery(hql,name);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	
	//����FeeRuleTypeDef
	@SuppressWarnings("unchecked")
	public List<FeeRuleTypeDef> LoadFeeRuleTypeDef(Object feeRuleType){
		
		String hql=" from FeeRuleTypeDef feeRuleTypeDef where feeRuleTypeDef.feeRuleType=? ";
		List<FeeRuleTypeDef> list=executeQuery(hql,feeRuleType);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//��������ɾ������
	public boolean deleteByFeeRuleType(Object feeRuleType){
		
		List<FeeRuleTypeDef> li=this.LoadFeeRuleTypeDef(feeRuleType);
		if(li!=null){
			FeeRuleTypeDef feeRuleTypeDef=li.get(0);
			getSession().clear();
			getSession().refresh(feeRuleTypeDef);
			getSession().merge(feeRuleTypeDef);
			getSession().delete(feeRuleTypeDef);
		}
		
		if (this.LoadFeeRuleTypeDef(feeRuleType) == null)
			return true;
		else
			return false;
	}
	
	@SuppressWarnings("unchecked")
	public List<FeeRuleTypeDef> getAllFeeRuleTypeDef() {
		String hql = "from FeeRuleTypeDef feeRuleTypeDef ";
		List list = executeQuery(hql);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}

}
