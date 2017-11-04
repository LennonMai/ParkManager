package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SendParaResult;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository
public class SendParaResultDao extends BaseDao<SendParaResult>{
	
	@Resource
	private JdbcUtil jdbcUtil;
	
	@SuppressWarnings("unchecked")
	public List<SendParaResult> findByCondition(Pager pager,String fieldName,Short sendType,String fieldValue,
			Short laneNo,String laneComputerIp,String tableName,String fileName,Short sendResult,String startTime,String endTime){
		StringBuffer sf = new StringBuffer("from SendParaResult sendParaResult where");
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startTimeTemp = null;
		Date endTimeTemp = null;
		List<Object> obj = new ArrayList<Object>();
		if (!fieldName.equals("")) {
			sf.append(" sendParaResult.fieldName like ? and");
			obj.add("%" + fieldName + "%");
		}
		if (sendType != null) {
			if(sendType!=0){
				sf.append(" sendParaResult.sendType = ? and");
				obj.add(sendType);
			}else{
				sf.append(" sendParaResult.sendType != ? and");
				obj.add(sendType);
			}			
		}
		if (!fieldValue.equals("")) {
			sf.append(" sendParaResult.fieldValue like ? and");
			obj.add("%" + fieldValue + "%");
		}
		if (laneNo!=null) {
			sf.append(" sendParaResult.laneNo = ? and");
			obj.add(laneNo);
		}
		if (!laneComputerIp.equals("")) {
			sf.append(" sendParaResult.laneComputerIp like ? and");
			obj.add("%" + laneComputerIp + "%");
		}
		if (!tableName.equals("")) {
			sf.append(" sendParaResult.tableName like ? and");
			obj.add("%" + tableName + "%");
		}
		if (!fileName.equals("")) {
			sf.append(" sendParaResult.fileName like ? and");
			obj.add("%" + fileName + "%");
		}
		if (sendResult!=null) {
			sf.append(" sendParaResult.sendResult = ? and");
			obj.add(sendResult);
		}
		if (null != startTime && !startTime.equals("")&&null != endTime && !endTime.equals("")) {
			try {
				
              startTimeTemp = format1.parse(startTime);
             
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//sf.append(" sendParaResult.sendResult = ? and");
			sf.append(" sendParaResult.sendTime >= ? and ");
			obj.add(startTimeTemp);
		}
		if (null != startTime && !startTime.equals("")&&null != endTime && !endTime.equals("")) {
			 try {
				endTimeTemp = format1.parse(endTime);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			sf.append(" sendParaResult.sendTime <= ? and ");
			obj.add(endTimeTemp);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	public boolean delete(Object fieldValue,Object laneNo,Object laneComputerIp,Object tableName){
		String hql="from SendParaResult sendParaResult where sendParaResult.fieldValue='"+fieldValue+"' and " +
				"sendParaResult.laneNo='"+laneNo+"' and sendParaResult.laneComputerIp='"+laneComputerIp+"' and " +
						"sendParaResult.tableName='"+tableName+"'" ;
		@SuppressWarnings("unchecked")
		List<SendParaResult> list=this.executeQuery(hql);
		SendParaResult SendParaResult=new SendParaResult();
		if(!list.isEmpty()){
			SendParaResult=list.get(0);
			getSession().clear();
			getSession().refresh(SendParaResult);
			getSession().merge(SendParaResult);
			getSession().delete(SendParaResult);
			return true;
		}else{
			return false;
		}
	}
	
	//根据条件删除
	public boolean deleteByCondition(String fieldName,Short sendType,String fieldValue,
			Short laneNo,String laneComputerIp,String tableName,String fileName,Short sendResult,String startTime,String endTime){
		StringBuffer sf = new StringBuffer("delete tb_SendParaResult where");
		if (!fieldName.equals("")) {
			sf.append(" FieldName ='"+fieldName+"' and");
		}
		if (sendType != null) {
			if(sendType!=0){
				sf.append(" SendType ='"+sendType+"' and");
			}else{
				sf.append(" SendType !='"+sendType+"' and");
			}
			
		}
		if (!fieldValue.equals("")) {
			sf.append(" FieldValue ='" + fieldValue + "' and");
		}
		if (laneNo!=null) {
			sf.append(" LaneNo ='" + laneNo + "' and");
		}
		if (!laneComputerIp.equals("")) {
			sf.append(" LaneComputerIp ='" + laneComputerIp + "' and");
		}
		if (!tableName.equals("")) {
			sf.append(" TableName ='" + tableName + "' and");
		}
		if (!fileName.equals("")) {
			sf.append(" FileName ='" + fileName + "' and");
		}
		if (sendResult != null) {
			sf.append(" sendResult ='" + sendResult + "' and");
		}
		if (null != startTime && !startTime.equals("")&&null != endTime && !endTime.equals("")){
			sf.append(" sendTime >= '" + startTime + "' and sendTime <= '"+endTime +"' and ");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		jdbcUtil.delete(sf.toString());
		return true;
	}
}
