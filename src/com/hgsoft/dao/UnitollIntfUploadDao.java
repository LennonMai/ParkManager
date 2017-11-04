package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.UnitollIntfUpload;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;
@Repository
public class UnitollIntfUploadDao extends BaseDao<UnitollIntfUpload> {
	@Resource
	private JdbcUtil jdbcUtil;
	public List<UnitollIntfUpload> findUnitollIntfUploadByHql(Pager pager,
			String startTime, String endTime,UnitollIntfUpload unitollIntfUpload) {
		StringBuffer sf = new StringBuffer("from UnitollIntfUpload unitollIntfUpload where");
		List<Object> list = new ArrayList<Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (null != startTime && !"".equals(startTime)) {
			sf.append(" unitollIntfUpload.squadDate >= ? and");
			try {
				list.add(sdf.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (null != endTime && !"".equals(endTime)) {
			sf.append(" unitollIntfUpload.squadDate <= ? and");
			try {
				list.add(sdf.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null!=unitollIntfUpload && null != unitollIntfUpload.getIsUpload() && !"".equals(unitollIntfUpload.getIsUpload())){
			sf.append(" unitollIntfUpload.isUpload = ? and");
				list.add(unitollIntfUpload.getIsUpload());
		}
		if(list.size() != 0 ) {
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		} else {
			sf = sf.replace(sf.length() - 6, sf.length(), "");
		}
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), list.toArray());
		pager.setTotalSize(count);
		//按时间降序查出记录返回
		return this.executeQuery(pager, sf.toString() + " order by squadDate desc", list.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<Object[]>export(String fileds, Map map){
		StringBuffer conditon = new StringBuffer(0);
		List<Object[]> list = new ArrayList<Object[]>();
		if(map.get("isUpload") != null && !map.get("isUpload").equals("")){
			conditon.append("isUpload="+map.get("isUpload")+" and ");
		}
		if(map.get("startTime") != null && !map.get("startTime").equals("")){
			conditon.append("squadDate >= '"+map.get("startTime")+" 00:00:00' and ");
		}
		if(map.get("endTime") != null && !map.get("endTime").equals("")){
			conditon.append("squadDate <= '"+map.get("endTime")+" 23:59:59' and ");
		}		
		String conditonStr = conditon.toString();
		if(conditonStr.length()>0){
			String sql = "select " + fileds + " from tb_unitollIntfUpload where " + conditonStr.substring(0, conditonStr.length()-4);
			list = jdbcUtil.selectForList(sql);
		}else{
			String sql = "select " + fileds + " from tb_unitollIntfUpload";
			list = jdbcUtil.selectForList(sql);
		}
		return list;
	}	

}
