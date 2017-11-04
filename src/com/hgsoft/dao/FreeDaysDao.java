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
	
	//验证收费类型唯一性
	@SuppressWarnings("unchecked")
	public List<FreeDays> ishasFreeDays(Object feeRuleType,Object type,Object value){
		String hql=" from FreeDays freeDays where freeDays.feeRuleType=? and freeDays.type=? and freeDays.value=?";
		List<FreeDays> list=executeQuery(hql,feeRuleType,type,value);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//加载freeDays
	@SuppressWarnings("unchecked")
	public List<FreeDays> LoadFreeDays(Object feeRuleType,Object type,Object value){
		String hql=" from FreeDays freeDays where freeDays.feeRuleType=? and freeDays.type=? and freeDays.value=? ";
		List<FreeDays> list=executeQuery(hql,feeRuleType,type,value);
		if(!list.isEmpty())
			return list;
		else
			return null;
	}
	
	//更新
	public boolean _update(FreeDays freeDays,Object feeRuleType,Object type,Object value){
		String sql=" update tb_FreeDays set FeeRuleType='"+freeDays.getFeeRuleType()+"',Type='"+freeDays.getType()+"',Value='"+freeDays.getValue().trim()+"' where FeeRuleType='"+feeRuleType.toString().trim()+"'and Type='"+type.toString().trim()+"'and Value='"+value.toString().trim()+"'";
		//System.out.println(sql);
		jdbcUtil.update(sql);
		return true;
	}
	
	//根据主键删除数据
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
