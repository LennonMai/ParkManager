/**
 * 
 */
package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.SendPara;
import com.hgsoft.entity.SystemPara;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Repository
public class SendParaDao extends BaseDao<SendPara>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	//查询字段下发失败列表
	@SuppressWarnings("unchecked")
	public List<SendPara> findFailSendParaByTypeTwo(Pager pager){
		String hql="from SendPara sendPara where sendPara.sendType='2'" ;
		Long count = this.executeCount(hql.toString());
		pager.setTotalSize(count);
		return this.executeQuery(pager,hql); 
	}
	
	@SuppressWarnings("unchecked")
	public List<SendPara> findFailSendParaByTypeOne(Pager pager){
		String hql="from SendPara sendPara where sendPara.sendType='1'" ;
		Long count = this.executeCount(hql.toString());
		pager.setTotalSize(count);
		return this.executeQuery(pager,hql); 
	}
	
	public boolean delete(Object fieldValue,Object laneNo,Object laneComputerIp,Object tableName){
		String hql="from SendPara sendPara where sendPara.fieldValue='"+fieldValue+"' and " +
				"sendPara.laneNo='"+laneNo+"' and sendPara.laneComputerIp='"+laneComputerIp+"' and " +
						"sendPara.tableName='"+tableName+"'" ;
		@SuppressWarnings("unchecked")
		List<SendPara> list=this.executeQuery(hql);
		SendPara sendPara=new SendPara();
		if(!list.isEmpty()){
			sendPara=list.get(0);
			getSession().clear();
			getSession().refresh(sendPara);
			getSession().merge(sendPara);
			getSession().delete(sendPara);
			return true;
		}else{
			return false;
		}
	}
	
	//根据条件查询失败列表
	@SuppressWarnings("unchecked")
	public List<SendPara> findFailSendParaByCondition(Pager pager,String fieldName,Short sendType,String fieldValue,
			Short laneNo,String laneComputerIp,String tableName){
		StringBuffer sf = new StringBuffer("from SendPara sendPara where");
		List<Object> obj = new ArrayList<Object>();
		if (!fieldName.equals("")) {
			sf.append(" sendPara.fieldName like ? and");
			obj.add("%" + fieldName + "%");
		}
		if (sendType != null) {
			if(sendType!=0){
				sf.append(" sendPara.sendType = ? and");
				obj.add(sendType);
			}else{
				sf.append(" sendPara.sendType != ? and");
				obj.add(sendType);
			}
			
		}
		if (!fieldValue.equals("")) {
			sf.append(" sendPara.fieldValue like ? and");
			obj.add("%" + fieldValue + "%");
		}
		if (laneNo!=null) {
			sf.append(" sendPara.laneNo = ? and");
			obj.add(laneNo);
		}
		if (!laneComputerIp.equals("")) {
			sf.append(" sendPara.laneComputerIp like ? and");
			obj.add("%" + laneComputerIp + "%");
		}
		if (!tableName.equals("")) {
			sf.append(" sendPara.tableName like ? and");
			obj.add("%" + tableName + "%");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置

		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	//根据条件删除
	public boolean deleteFailSendParaByCondition(String fieldName,Short sendType,String fieldValue,
			Short laneNo,String laneComputerIp,String tableName){
		StringBuffer sf = new StringBuffer("delete tb_SendPara where");
		if (fieldName!=null) {
			if (!fieldName.equals("")) {
				sf.append(" fieldName ='"+fieldName+"' and");
			}
		}
		
		if (sendType != null) {
			if(sendType!=0){
				sf.append(" sendType ='"+sendType+"' and");
			}else{
				sf.append(" sendType !='"+sendType+"' and");
			}
			
		}
		if (fieldValue!=null) {
			if (!fieldValue.equals("")) {
				sf.append(" fieldValue ='" + fieldValue + "' and");
			}
		}
		
		if (laneNo!=null) {
			sf.append(" laneNo ='" + laneNo + "' and");
		}
		if (laneComputerIp!=null) {
			if (!laneComputerIp.equals("")) {
				sf.append(" laneComputerIp ='" + laneComputerIp + "' and");
			}
		}
		if (tableName!=null) {
			if (!tableName.equals("")) {
				sf.append(" tableName ='" + tableName + "' and");
			}
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//System.out.println(sf);
		// 查出总行数，对分页进行设置
		jdbcUtil.delete(sf.toString());
		return true;
	}
	
	//查询图像下发参数数据
	public List<SendPara> findTypeTwoPara(){
		String hql="from SendPara sendPara where sendPara.sendType='2'" ;
		@SuppressWarnings("unchecked")
		List<SendPara> list=this.executeQuery(hql); 
		if(!list.isEmpty()){
			return list;
		}
		else return null;
	}
	//查询字段下发参数数据
	public List<SendPara> findTypeOnePara(){
		String hql="from SendPara sendPara where sendPara.sendType='1'" ;
		@SuppressWarnings("unchecked")
		List<SendPara> list=this.executeQuery(hql); 
		if(!list.isEmpty()){
			return list;
		}
		else return null;
	}
	
	//参数全部为-1的参数
	public List<SystemPara> findSystemPara(){
		String hql="from SystemPara systemPara where systemPara.paraClass='-1'" ;
		@SuppressWarnings("unchecked")
		List<SystemPara> list=this.executeQuery(hql); 
		if(!list.isEmpty()){
			return list;
		}
		else return null;
	}
	
	//根据参数值查询参数名
	public String findItemByItemValue(String itemValue){
		String hql="from SystemPara systemPara where systemPara.itemValue=?" ;
		@SuppressWarnings("unchecked")
		List<SystemPara> list=this.executeQuery(hql,itemValue); 
		if(!list.isEmpty()){
			return list.get(0).getItem();
		}
		else return null;
	}
	//查询是否存在已经设置的下发任务
	public List<SendPara> ishasSendMission(Short laneNo,String laneComputerIp,String tableName){
		String hql="from SendPara sendPara where sendPara.sendType='1' and sendPara.laneNo=? and sendPara.laneComputerIp=? and sendPara.tableName=?" ;
		@SuppressWarnings("unchecked")
		List<SendPara> list=this.executeQuery(hql,laneNo,laneComputerIp,tableName); 
		if(!list.isEmpty()){
			return list;
		}
		else return null;
	}
	
	//根据联合主键删除数据
	public boolean deletehasSendMission(Short laneNo,String laneComputerIp,String tableName){
		String hql="from SendPara sendPara where sendPara.sendType='1' and sendPara.laneNo=? and sendPara.laneComputerIp=? and sendPara.tableName=?" ;
		@SuppressWarnings("unchecked")
		List<SendPara> list=this.executeQuery(hql,laneNo,laneComputerIp,tableName); 
		
		SendPara sendPara=list.get(0);
		getSession().clear();
		getSession().refresh(sendPara);
		getSession().merge(sendPara);
		delete(sendPara);
		if(!list.isEmpty()) return true;
		else return false;
	}
	
	//根据参数名，查询参数信息，返回String
	@SuppressWarnings("rawtypes")
	public String findTXTdata(String tableName){
		StringBuffer sql=new StringBuffer("select ");
		String line="-------------------------------------\r\n";
		StringBuffer txtlist=new StringBuffer(line+tableName+":\r\n");
		txtlist.append(line);
		String sql_U="select name from syscolumns where id in (select id from sysobjects where name = '"+tableName+"') ";
        
		List list_u=jdbcUtil.selectForList(sql_U);
		
		if(!list_u.isEmpty()){
			String[] fields=new String[list_u.size()];
			for(int i=0;i<list_u.toArray().length;i++){
				fields[i]=list_u.toArray()[i].toString().split("=")[1].split("}")[0];
				txtlist.append(list_u.toArray()[i].toString().split("=")[1].split("}")[0]+"\t");
				sql.append(list_u.toArray()[i].toString().split("=")[1].split("}")[0]+",");
			}
			sql = sql.replace(sql.length() - 1, sql.length(), " ");
			sql.append("from "+tableName);
			
			txtlist.append("\r\n\r\n");
			List list=jdbcUtil.selectForList(sql.toString());
		
			if(!list.isEmpty()){
				Iterator it = list.iterator();
				while(it.hasNext()) {
				    Map userMap = (Map) it.next();    
				    for(int i=0;i<fields.length;i++){
				    	txtlist.append(userMap.get(fields[i])+"\t");
				    }
				    txtlist.append("\r\n");
				}
				txtlist.append("\r\n\r\n");
				return txtlist.toString();
			}else{
				return null;
			}
		}else{
			return null;
		}
	}
	
	

	@SuppressWarnings("unchecked")
	public String findTXTdataToLane(String tableName){
		StringBuffer sql=new StringBuffer("select ");
		//String line="-------------------------------------\r\n";
		StringBuffer txtlist=new StringBuffer();
		//txtlist.append(line);
		String sql_U="select name from syscolumns where id in (select id from sysobjects where name = '"+tableName+"') ";
       
		List list_u=jdbcUtil.selectForList(sql_U);		
		if(!list_u.isEmpty()){
			String[] fields=new String[list_u.size()];
			for(int i=0;i<list_u.toArray().length;i++){
				fields[i]=list_u.toArray()[i].toString().split("=")[1].split("}")[0];
				if(i!=(list_u.toArray().length-1)){
					txtlist.append(list_u.toArray()[i].toString().split("=")[1].split("}")[0]+"\t");
				}else{
					txtlist.append(list_u.toArray()[i].toString().split("=")[1].split("}")[0]);
				}
				sql.append(list_u.toArray()[i].toString().split("=")[1].split("}")[0]+",");
			}
			sql = sql.replace(sql.length() - 1, sql.length(), " ");
			sql.append("from "+tableName);
			txtlist.append("\r\n");
			List list=jdbcUtil.selectForList(sql.toString());		
			if(!list.isEmpty()){
				Iterator it = list.iterator();
				while(it.hasNext()) {
				    Map userMap = (Map) it.next();    
				    for(int i=0;i<fields.length;i++){
				    	if(i!=(fields.length-1)){
				    		if(i!=4&&i!=5){
				    			if(userMap.get(fields[i])==null){
				    				txtlist.append("\t");
				    			}else{
				    				txtlist.append(userMap.get(fields[i]).toString().trim()+"\t");
				    			}
				    			
				    		}else{				    			
				    			txtlist.append(userMap.get(fields[i]).toString().replace(".0", "")+"\t");
				    		}
				    		
				    	}else{
				    		if(userMap.get(fields[i])==null){
				    			txtlist.append("\t");
				    		}else{
				    			txtlist.append(userMap.get(fields[i]).toString().trim());
				    		}
				    		
				    	}
				    	
				    }
				    txtlist.append("\r\n");
				}
				//txtlist.append("\r\n\r\n");
				String s = txtlist.toString();
				s = s.replaceAll("null", "");
				return s;
			}else{
				return null;
			}
		}else{
			return null;
		}
	}
	
	public void sendParaToLane(String tablename){
		String sql = "delete from tb_SendPara where tablename='"+tablename+"'";
		String sql1 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'"+tablename+"','"+tablename+"' from tb_LaneUse";
		jdbcUtil.delete(sql);
		jdbcUtil.save(sql1);
		
	}
}
