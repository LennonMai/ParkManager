package com.hgsoft.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;

import com.hgsoft.util.Order;
import com.hgsoft.util.Pager;
import com.hgsoft.util.Property;

public class OtherBaseDao<T extends Serializable> {

	@Resource private SessionFactory otherSessionFactory;
	
	public Session getSession(){
		Session session = otherSessionFactory.getCurrentSession();
		return session;
	}
	
	private Class<T> className;
	
	@SuppressWarnings("unchecked")
	public OtherBaseDao() {
		className = (Class<T>)((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
	}
	
	public T save(T entity) {
		getSession().save(entity);
		return entity;
	}

	public void update(Object entity) {
		getSession().update(entity);
	}
	
	public void saveOrUpdate(Object entity) {
		getSession().saveOrUpdate(entity);
	}
	
	public Object merge(Object entity) {
		getSession().merge(entity);
		return entity;
	}

	public void delete(Object entity) {
		getSession().delete(entity);
	}
	
	@SuppressWarnings("unchecked")
	public T get(Serializable id) {
		T entity = (T)getSession().get(className, id);
		return entity;
	}
	
	@SuppressWarnings("unchecked")
	public T load(Serializable id) {
		T entity = (T)getSession().load(className, id);
		return entity;
	}
	
	public List<T> findAll(Order order, Property ... propertys) {
		return findByPager(null, new Order[]{order},propertys);
	}
	
	public List<T> findAll(Order[] orders, Property ... propertys) {
		return findByPager(null, orders, propertys);
	}

	public List<T> findByPager(Pager pager, Order order, Property ... propertys) {
		return findByPager(pager, new Order[]{order},propertys);
	}
	
	@SuppressWarnings("unchecked")
	public List<T> findByPager(Pager pager, Order[] orders, Property ... propertys) {
		Criteria criteria = getSession().createCriteria(className);
		//查询条件
		for(Property property:propertys){
			if(property != null)
				criteria.add(property.getCriterion());
		}
		//分页
		if(pager != null){
			criteria.setProjection(Projections.rowCount());
			Integer count = (Integer)criteria.uniqueResult();
			
			if(count == null)
				return new ArrayList();
			pager.setTotalSize(count);
			criteria.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
			criteria.setMaxResults(pager.getPageSize());
			criteria.setProjection(null);
		}
		//排序
		if(orders != null && orders.length > 0){
			for(Order order:orders){
				if(order != null)
					criteria.addOrder(order.getHibernateOrder());
			}
		}
		return criteria.list();
	}
	
	public Integer countByProperty(String propertyName, Property ... propertys){
		Criteria criteria = getSession().createCriteria(className);
		//查询条件
		for(Property property:propertys){
			if(property != null)
				criteria.add(property.getCriterion());
		}
		criteria.setProjection(Projections.count(propertyName));
		return (Integer)criteria.uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	protected List executeQuery(String hql, Object... values) { 
		return executeQuery(null, hql, values);
	}
	
	@SuppressWarnings("unchecked")
	protected List executeQuery(Pager pager, String hql, Object... values) {
        Query query = getSession().createQuery(hql);  
        for (int i = 0; values != null && i < values.length; i++) {    
            query.setParameter(i, values[i]);  
        } 
        if(pager != null){
        	query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
        	query.setMaxResults(pager.getPageSize());
        }
        return query.list();
    }  
	
    protected Long executeCount(String hql, Object... values) { 	
    	Query query = getSession().createQuery("select count(*) " + hql);
    	for (int i = 0; values != null && i < values.length; i++) {    
            query.setParameter(i, values[i]);  
        }  	
        return (Long)query.list().get(0);     
    } 
    
}
