package com.hgsoft.service;

import java.io.Serializable;
import java.util.List;

import com.hgsoft.dao.OtherBaseDao;
import com.hgsoft.util.Order;
import com.hgsoft.util.Pager;

public class OtherBaseService<T extends Serializable> {
	
	private OtherBaseDao<T> dao;
	
	public T save(T entity){
		return dao.save(entity);
	}
	
	public void update(Object entity) {
		dao.update(entity);
	}
	
	public void saveOrUpdate(Object entity) {
		dao.saveOrUpdate(entity);
	}
	
	public Object merge(Object entity) {
		dao.merge(entity);
		return entity;
	}
	
	public void delete(Object entity) {
		dao.delete(entity);
	}
	
	public void deleteById(Serializable id) {
		dao.delete(load(id));
	}

	public T get(Serializable id) {
		T entity = (T)dao.get(id);
		return entity;
	}
	
	public T load(Serializable id) {
		T entity = (T)dao.load(id);
		return entity;
	}
	
	public List<T> findAll(){
		return dao.findAll(Order.asc("name"));
	}
	
	public List<T> findByPager(Pager pager){
		return getDao().findByPager(pager, Order.desc("id"));
	}
	
	//caijunhua ���Ӱ���� �ϼ����޸� ���������ڵ����ѯ
	public List<T> findBySquadDatePager(Pager pager){
		return getDao().findByPager(pager, Order.desc("squadDate"));
	}
	//caijunhua �������� ������ʱ�䵹������
	public List<T> findByStartTimePager(Pager pager){
		return getDao().findByPager(pager, Order.desc("startTime"));
	}
	//caijunhua ���˿������� ��ֵ�������� ��ʧЧ���ڵ�������
	public List<T> findByGenTimePager(Pager pager){
		return getDao().findByPager(pager, Order.desc("genTime"));
	}
	//caijunhua ͨ�п������� ��ݿ������� ��ʧЧ���ڵ�������
	public List<T> findByOpTimePager(Pager pager){
		return getDao().findByPager(pager, Order.desc("opTime"));
	}
	//caijunhua ��λ��Ϣ ������ʱ�䵹������
	public List<T> findByModifyTimePager(Pager pager) {
		return getDao().findByPager(pager, Order.desc("modifyTime"));
	}
	
	public OtherBaseDao<T> getDao() {
		return dao;
	}

	public void setDao(OtherBaseDao<T> dao) {
		this.dao = dao;
	}
}
