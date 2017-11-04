package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.IdcardInfo;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository
public class IDCardInfoDao extends BaseDao<IdcardInfo>{
	@Resource
	private JdbcUtil jdbcUtil;
	@SuppressWarnings("unchecked")
	public IdcardInfo getIDCardInfoByCardNo(String cardNo) {
		String hql = "from IdcardInfo iDCardInfo where  iDCardInfo.idcardNo=?";
		List resultList = executeQuery(hql, cardNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (IdcardInfo) resultList.get(0);
		}

	}
	@SuppressWarnings("unchecked")
	public List<IdcardInfo> getAllIDCardInfo(Pager pager){
		String hql = "from IdcardInfo iDCardInfo";
		List<Object> obj = new ArrayList<Object>();
		Long count = executeCount(hql, obj.toArray());
		pager.setTotalSize(count);
		List resultList = this.executeQuery(pager, hql, obj.toArray());;
		if (resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	@SuppressWarnings("unchecked")
	public List<IdcardInfo> findAllItemByHql(Pager pager, String idcardNo,String userName) {		
		StringBuffer sf = new StringBuffer("from IdcardInfo IdcardInfoTemp where");// 查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		List<Object> obj = new ArrayList<Object>();
		if (!"".equals(idcardNo)) {
			sf.append(" IdcardInfoTemp.idcardNo like? and");
			obj.add("%" + idcardNo + "%");
		}
		if (!"".equals(userName)) {
			sf.append(" IdcardInfoTemp.userName like? and");
			obj.add("%" + userName + "%");
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		// System.out.println(sf.toString()+"obj"+obj.get(0));

		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	public void updateIdcardInfo(String idCardInfo,String idCardInfoTemp,String userName){
		String sql="update tb_IDCardInfo set IDCardNo='"+idCardInfoTemp+"',UserName='"+userName+"' where IDCardNo='"+idCardInfo+"'";
		jdbcUtil.update(sql);
	}

}
