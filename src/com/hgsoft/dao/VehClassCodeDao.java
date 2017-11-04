package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.VehClassCode;
import com.hgsoft.util.Pager;

@Repository 
public class VehClassCodeDao extends BaseDao<VehClassCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<VehClassCode> findByCondition(Pager pager,Short vehClassNo,String vehClassName,Short keyCode){
		StringBuffer sf = new StringBuffer("from VehClassCode vehClassCode where");
		List<Object> obj = new ArrayList<Object>();
		
		if (vehClassNo!=null) {
			sf.append(" vehClassCode.vehClassNo = ? and");
			obj.add(vehClassNo);
		}
		if (!vehClassName.equals("")){
			sf.append(" vehClassCode.vehClassName like ? and");
			obj.add("%"+vehClassName+"%");
		}
		if (keyCode!=null) {
			sf.append(" vehClassCode.keyCode = ? and");
			obj.add(keyCode);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
