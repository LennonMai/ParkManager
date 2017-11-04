package com.hgsoft.dao;



import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.CarSpaceDynamic;


@Repository 
public class CarSpaceDynamicDao extends BaseDao<CarSpaceDynamic> {
	@SuppressWarnings("unchecked")
	public CarSpaceDynamic getCarSpaceDynamicByRecNo(int recNo) {// 通过账号查询账户
		String hql = "from CarSpaceDynamic carSpaceDynamic where  carSpaceDynamic.recNo=?";
		List resultList = executeQuery(hql, recNo);
		if (resultList.isEmpty())
			return null;
		else
			return (CarSpaceDynamic)resultList.get(0);
	}

}
