package com.hgsoft.service;
/**
 *Copyright (c) 曾根宝 (kevin)  广州华工信息软件有限公司 http://www.fgsoft.com.cn
 *Email:rabitt450@163.com
 *转载请注明版权所有
 */
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.IdentifyResultDao;
import com.hgsoft.entity.IdentifyResult;
import com.hgsoft.entity.InListForAuto;
import com.hgsoft.entity.OutListForAuto;
import com.hgsoft.util.Pager;

@Service
public class IdentifyResultService {
	@Resource private IdentifyResultDao dao;
	
	/**
	 * 分页查询再识别图片确认
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager,String startTime,String endTime,String parkNo,String gateNo,String laneNo,String sign){
		return dao.query(pager,startTime,endTime,parkNo,gateNo,laneNo,sign);
	}
	/**
	 * 根据listNo获得对象
	 */
	public IdentifyResult getById(String listNo){
		return dao.getById(listNo);
	}
	/**
	 * 更新对象
	 */
	public void update(IdentifyResult result){
		dao.update(result);
	}
	/**
	 * 获得InListForAuto表中的一个对象
	 */
	public InListForAuto getInAutoByListNo(String listNo){
		return dao.getInAutoByListNo(listNo);
	}
	/**
	 * 获得OutListForAuto表中的一个对象
	 */
	public OutListForAuto getOutAutoByListNo(String listNo){
		return dao.getOutAutoByListNo(listNo);
	}
}
