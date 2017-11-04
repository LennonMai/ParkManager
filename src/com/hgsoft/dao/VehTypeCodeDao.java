package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.VehTypeCode;
import com.hgsoft.util.Pager;

@Repository 
public class VehTypeCodeDao extends BaseDao<VehTypeCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<VehTypeCode> findByCondition(Pager pager,Short vehTypeNo,String vehTypeName,Short keyCode){
		StringBuffer sf = new StringBuffer("from VehTypeCode vehTypeCode where");
		List<Object> obj = new ArrayList<Object>();
		
		if (vehTypeNo!=null) {
			sf.append(" vehTypeCode.vehTypeNo = ? and");
			obj.add(vehTypeNo);
		}
		if (!vehTypeName.equals("")){
			sf.append(" vehTypeCode.vehTypeName like ? and");
			obj.add("%"+vehTypeName+"%");
		}
		if (keyCode!=null) {
			sf.append(" vehTypeCode.keyCode = ? and");
			obj.add(keyCode);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	
}
