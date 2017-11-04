package com.hgsoft.service;
/**
 *Copyright (c) ������ (kevin)  ���ݻ�����Ϣ������޹�˾ http://www.fgsoft.com.cn
 *Email:rabitt450@163.com
 *ת����ע����Ȩ����
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
	 * ��ҳ��ѯ��ʶ��ͼƬȷ��
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager,String startTime,String endTime,String parkNo,String gateNo,String laneNo,String sign){
		return dao.query(pager,startTime,endTime,parkNo,gateNo,laneNo,sign);
	}
	/**
	 * ����listNo��ö���
	 */
	public IdentifyResult getById(String listNo){
		return dao.getById(listNo);
	}
	/**
	 * ���¶���
	 */
	public void update(IdentifyResult result){
		dao.update(result);
	}
	/**
	 * ���InListForAuto���е�һ������
	 */
	public InListForAuto getInAutoByListNo(String listNo){
		return dao.getInAutoByListNo(listNo);
	}
	/**
	 * ���OutListForAuto���е�һ������
	 */
	public OutListForAuto getOutAutoByListNo(String listNo){
		return dao.getOutAutoByListNo(listNo);
	}
}
