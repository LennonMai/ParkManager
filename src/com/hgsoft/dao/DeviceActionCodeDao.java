package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.DeviceActionCode;
import com.hgsoft.util.Pager;

@Repository 
public class DeviceActionCodeDao extends BaseDao<DeviceActionCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<DeviceActionCode> findByCondition(Pager pager,Short deviceActionNo,String  deviceActionName,Short deviceNo){
		StringBuffer sf = new StringBuffer("from DeviceActionCode deviceActionCode where");
		List<Object> obj = new ArrayList<Object>();
		
		if (deviceActionNo!=null) {
			sf.append(" deviceActionCode.deviceActionNo = ? and");
			obj.add(deviceActionNo);
		}
		if (!deviceActionName.equals("")){
			sf.append(" deviceActionCode.deviceActionName like ? and");
			obj.add("%"+deviceActionName+"%");
		}
		if (deviceNo!=null) {
			sf.append(" deviceActionCode.deviceNo = ? and");
			obj.add(deviceNo);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
