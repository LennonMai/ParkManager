package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.TimesSignDef;
@Repository
public class TimesSignDefDao extends BaseDao<TimesSignDef>{
	//��֤Ψһ��
	@SuppressWarnings("unchecked")
	public List<TimesSignDef> ishasTimesSignDef(Object feeRuleType,Object dayType,Object startTime){
		String hql=" from TimesSignDef timesSignDef where timesSignDef.feeRuleType=? and timesSignDef.dayType=? and timesSignDef.startTime=? ";
		List<TimesSignDef> list=executeQuery(hql,feeRuleType,dayType,startTime);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//����TimesSignDef
	@SuppressWarnings("unchecked")
	public List<TimesSignDef> LoadTimesSignDef(Object feeRuleType,Object dayType,Object startTime){
		
		String hql=" from TimesSignDef timesSignDef where timesSignDef.feeRuleType=? and timesSignDef.dayType=? and timesSignDef.startTime=? ";
		List<TimesSignDef> list=executeQuery(hql,feeRuleType,dayType,startTime);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//������������ɾ������
	public boolean deleteByCompositeID(Object feeRuleType,Object dayType,Object startTime){
		TimesSignDef timesSignDef=this.LoadTimesSignDef(feeRuleType, dayType, startTime).get(0);
		getSession().clear();
		getSession().refresh(timesSignDef);
		getSession().merge(timesSignDef);
		getSession().delete(timesSignDef);
		if (this.LoadTimesSignDef(feeRuleType, dayType, startTime) == null)
			return true;
		else
			return false;
	}
}
