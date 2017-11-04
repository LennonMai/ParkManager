package com.hgsoft.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarStopTimeQueryDao;
import com.hgsoft.util.Pager;

@Service
public class CarStopTimeQueryService {
	@Resource
	private CarStopTimeQueryDao carStopTimeQueryDao;

	public List findByCondition(Pager pager, Integer stopCount,
			String stopTime, String startTime, String endTime, String carType) {
		return carStopTimeQueryDao.findByCondition(pager, stopCount, stopTime,
				startTime, endTime, carType);
	}

	// 导出信息
	public List exportWhite(String filedString,String fileds, Map map) {
		return carStopTimeQueryDao.exportWhite(filedString,fileds, map);
	}

}
