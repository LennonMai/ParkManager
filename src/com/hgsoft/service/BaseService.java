package com.hgsoft.service;

import java.io.Serializable;
import java.util.List;

import com.hgsoft.dao.BaseDao;
import com.hgsoft.util.Order;
import com.hgsoft.util.Pager;

public class BaseService<T extends Serializable> {

	private BaseDao<T> dao;

	public T save(T entity) {
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
		T entity = (T) dao.get(id);
		return entity;
	}

	public T load(Serializable id) {
		T entity = (T) dao.load(id);
		return entity;
	}

	public List<T> findAll() {
		return dao.findAll(Order.asc("name"));
	}

	public List<T> findByPager(Pager pager) {
		return getDao().findByPager(pager, Order.desc("id"));
	}

	// caijunhua 交接班管理 合计数修改 按工班日期倒序查询
	public List<T> findBySquadDatePager(Pager pager) {
		return getDao().findByPager(pager, Order.desc("squadDate"));
	}

	// caijunhua 车道费率 按启用时间倒序排列
	public List<T> findByStartTimePager(Pager pager) {
		return getDao().findByPager(pager, Order.desc("startTime"));
	}

	// caijunhua 记账卡黑名单 储值卡黑名单 按失效日期倒序排列
	public List<T> findByGenTimePager(Pager pager) {
		return getDao().findByPager(pager, Order.desc("genTime"));
	}

	// caijunhua 通行卡黑名单 身份卡黑名单 按失效日期倒序排列
	public List<T> findByOpTimePager(Pager pager) {
		return getDao().findByPager(pager, Order.desc("opTime"));
	}

	// caijunhua 车位信息 按更新时间倒序排列
	public List<T> findByModifyTimePager(Pager pager) {
		return getDao().findByPager(pager, Order.desc("modifyTime"));
	}

	public BaseDao<T> getDao() {
		return dao;
	}

	public void setDao(BaseDao<T> dao) {
		this.dao = dao;
	}
}
