/**
 * 
 */
package com.hgsoft.dao;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.TollyCardDate;
import com.hgsoft.util.JdbcUtil;

/**
 * @author qinzuohai
 *
 */
@Repository
public class TollyCardDateDao extends BaseDao<TollyCardDate>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	//����Ψһ�ֶΣ��������ı��ĳ������
	public boolean Update(Date firTime){ 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String hql="update tb_TollyCardDate set FirTime='"+dateFormat.format(firTime)+"'  where FirTime =(select FirTime from tb_TollyCardDate) ";
		jdbcUtil.update(hql);
		return true;
	}
}
