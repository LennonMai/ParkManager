package com.hgsoft.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.FreeDays;
import com.hgsoft.util.JdbcUtil;


@Repository 
public class FreeDaysDao  extends BaseDao<FreeDays>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	//��֤�շ�����Ψһ��
	@SuppressWarnings("unchecked")
	public List<FreeDays> ishasFreeDays(Object feeRuleType,Object type,Object value){
		String hql=" from FreeDays freeDays where freeDays.feeRuleType=? and freeDays.type=? and freeDays.value=?";
		List<FreeDays> list=executeQuery(hql,feeRuleType,type,value);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//����freeDays
	@SuppressWarnings("unchecked")
	public List<FreeDays> LoadFreeDays(Object feeRuleType,Object type,Object value){
		String hql=" from FreeDays freeDays where freeDays.feeRuleType=? and freeDays.type=? and freeDays.value=? ";
		List<FreeDays> list=executeQuery(hql,feeRuleType,type,value);
		if(!list.isEmpty())
			return list;
		else
			return null;
	}
	
	//����
	public boolean _update(FreeDays freeDays,Object feeRuleType,Object type,Object value){
		String sql=" update tb_FreeDays set FeeRuleType='"+freeDays.getFeeRuleType()+"',Type='"+freeDays.getType()+"',Value='"+freeDays.getValue().trim()+"' where FeeRuleType='"+feeRuleType.toString().trim()+"'and Type='"+type.toString().trim()+"'and Value='"+value.toString().trim()+"'";
		//System.out.println(sql);
		jdbcUtil.update(sql);
		return true;
	}
	
	//��������ɾ������
	public boolean deleteByFeeRuleType(Object feeRuleType,Object type,Object value){
		//System.out.println(feeRuleType+"--"+type+"--"+value);
		FreeDays freeDays=this.LoadFreeDays(feeRuleType,type,value).get(0);
		getSession().clear();
		getSession().refresh(freeDays);
		getSession().merge(freeDays);
		getSession().delete(freeDays);
		if (this.LoadFreeDays(feeRuleType,type,value) == null)
			return true;
		else
			return false;
	}
}
