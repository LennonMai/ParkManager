package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.VehNoCmpPlate;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository
public class VehNoCmpPlateDao extends BaseDao<VehNoCmpPlate>{

	@Resource
	private JdbcUtil jdbcUtil;
	
	@SuppressWarnings("unchecked")
	public List<VehNoCmpPlate> findVehNoCmpPlateByCondition(Pager pager,String vehPlate) {

		StringBuffer sf = new StringBuffer(
				"from VehNoCmpPlate vehNoCmpPlate where ");
		List<Object> obj = new ArrayList<Object>();
		
		if (!vehPlate.equals("")) {
			sf.append(" vehNoCmpPlate.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public boolean findVehNoCmpPlate(String vehPlate){
		String hql=" from VehNoCmpPlate vehNoCmpPlate where vehNoCmpPlate.vehPlate=?" ;
		List<VehNoCmpPlate> vehNoCmpPlate=executeQuery(hql,vehPlate);
		if(!vehNoCmpPlate.isEmpty()){
			return true;
		}else
			return false;
	}
	
	public boolean _update(String updateVehPlate,VehNoCmpPlate vehNoCmpPlate){
		jdbcUtil.update("update tb_VehNoCmpPlate set VehPlate='"+vehNoCmpPlate.getVehPlate()+"' where  VehPlate='"+updateVehPlate+"'");
		return true;
	}
	
}
