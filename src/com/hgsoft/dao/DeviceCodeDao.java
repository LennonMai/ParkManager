package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.DeviceCode;
import com.hgsoft.util.Pager;

@Repository 
public class DeviceCodeDao extends BaseDao<DeviceCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<DeviceCode> findByCondition(Pager pager,Short deviceNo,String deviceName){
		StringBuffer sf = new StringBuffer("from DeviceCode deviceCode where");
		List<Object> obj = new ArrayList<Object>();
		
		if (deviceNo!=null) {
			sf.append(" deviceCode.deviceNo = ? and");
			obj.add(deviceNo);
		}
		if (!deviceName.equals("")){
			sf.append(" deviceCode.deviceName like ? and");
			obj.add("%"+deviceName+"%");
		}
	
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
