package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SpecialType;


/**
 * 
 * @author qinzuohai
 *
 */
@Repository
public class SpecialTypeDao  extends BaseDao<SpecialType>{

	@SuppressWarnings("unchecked")
	public List<SpecialType> findSpecialType(){
		String hql=" from SpecialType specialType " ;
		List<SpecialType> specialType=executeQuery(hql);
		if(!specialType.isEmpty()){
			return specialType;
		}else
			return null;
		
	}
	
}
