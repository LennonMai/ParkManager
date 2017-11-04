/**
 * 
 */
package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.InOutSignDef;

/**
 * 
 * @author qinzuohai
 *
 */
@Repository
public class InOutSignDefDao extends BaseDao<InOutSignDef>{
	//��֤����ڴ���Ψһ��
	@SuppressWarnings("unchecked")
	public List<InOutSignDef> ishasInOutSignDef(Object inGateNo,Object outGateNo){
		String hql=" from InOutSignDef inOutSignDef where inOutSignDef.inGateNo=? and inOutSignDef.outGateNo=? ";
		List<InOutSignDef> list=executeQuery(hql,inGateNo,outGateNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//����InOutSignDef
	@SuppressWarnings("unchecked")
	public  List<InOutSignDef> LoadInOutSignDef(Object inGateNo,Object outGateNo){
	
		String hql=" from InOutSignDef inOutSignDef where inOutSignDef.inGateNo=? and inOutSignDef.outGateNo=? ";
		 List<InOutSignDef> list=executeQuery(hql,inGateNo,outGateNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//������������ɾ������
	public boolean deleteByCompositeID(Object inGateNo,Object outGateNo){
		InOutSignDef inOutSignDef=this.LoadInOutSignDef(inGateNo, outGateNo).get(0);
		getSession().clear();
		getSession().refresh(inOutSignDef);
		getSession().merge(inOutSignDef);
		getSession().delete(inOutSignDef);
		if (this.LoadInOutSignDef(inGateNo, outGateNo) == null)
			return true;
		else
			return false;
	}
}
