package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.DeviceErrorCode;
import com.hgsoft.util.Pager;

@Repository 
public class DeviceErrorCodeDao extends BaseDao<DeviceErrorCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<DeviceErrorCode> findByCondition(Pager pager,Short deviceErrorNo,String  deviceErrorName,Short deviceNo){
		StringBuffer sf = new StringBuffer("from DeviceErrorCode deviceErrorCode where");
		List<Object> obj = new ArrayList<Object>();
		
		if (deviceErrorNo!=null) {
			sf.append(" deviceErrorCode.deviceErrorNo = ? and");
			obj.add(deviceErrorNo);
		}
		if (!deviceErrorName.equals("")){
			sf.append(" deviceErrorCode.deviceErrorName like ? and");
			obj.add("%"+deviceErrorName+"%");
		}
		if (deviceNo!=null) {
			sf.append(" deviceErrorCode.deviceNo = ? and");
			obj.add(deviceNo);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
