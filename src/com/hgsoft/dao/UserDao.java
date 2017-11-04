package com.hgsoft.dao;
import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.User;
import com.hgsoft.util.JdbcUtil;
@Repository 

public class UserDao extends BaseDao<User> {
	@Resource
	private JdbcUtil jdbcUtil;
	public int getMaxSysID() {
		String sql = "SELECT max(sys_id) FROM t_park_user";
		return jdbcUtil.select(sql)+1;
		/*
		 * String hql = "from User user order by user.sys_id desc"; List
		 * resultList = executeQuery(hql); if (resultList.isEmpty()) return 0;
		 * 
		 * else {
		 * 
		 * return ((User) resultList.get(0)).getSys_id(); }
		 */

	}
	public int insertUser(int sys_id,String userName,int credentialsType,String credentialsNo,String phone,String mobileNumber, String address){
		String sql = "insert into t_park_user values("+sys_id+",'"+userName+"',"+credentialsType+",'"+credentialsNo+"','"+phone+"','"+mobileNumber+"','"+address+"')";
		//try{System.out.println("-----------------------------sys_id---------------:"+sys_id);
			return jdbcUtil.update(sql);
	/*/	} catch(Exception e){
			System.out.println("---------------------DAO“Ï≥£---------------");
			System.out.println("-----------------------------getMaxSysID()---------------:"+getMaxSysID());
			 sql = "insert into t_park_user values("+getMaxSysID()+",'"+userName+"',"+credentialsType+",'"+credentialsNo+"','"+phone+"','"+mobileNumber+"','"+address+"')";
			 return jdbcUtil.update(sql);
			
		}*/
	}
}
