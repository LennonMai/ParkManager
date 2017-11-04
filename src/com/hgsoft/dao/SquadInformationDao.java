package com.hgsoft.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SquadInformation;

@Repository
public class SquadInformationDao extends BaseDao<SquadInformation> {

	// 验证保存或者修改工班信息时，是否存在相同的工班编码
	@SuppressWarnings("unchecked")
	public List<SquadInformation> ishasSquadNo(Object squadNo) {
		String hql = "select squadInfo.squadNo from SquadInformation squadInfo where squadInfo.squadNo=?";
		List<SquadInformation> list = executeQuery(hql, squadNo);
		if (!list.isEmpty()) {
			return list;
		} else
			return null;
	}

	// caijunhua取所有工班的班次
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<SquadInformation> getAllSquadInformation() {
		String hql = "from SquadInformation squadInformation";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}

	// caijunhua 验证工班名称是否存在
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public SquadInformation findSquadByName(String squadName) {
		String hql = "from SquadInformation squadInfo where squadInfo.squadName=?";
		List resultList = executeQuery(hql, squadName);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (SquadInformation) resultList.get(0);
		}
	}
	public boolean findSquadNameByNoThisSquadNo(Short squadNo, String squadName) {
		String hql = "from SquadInformation squadInfo where squadInfo.squadNo!=?";
		@SuppressWarnings("unchecked")
		List<SquadInformation> list = executeQuery(hql, squadNo);
		for(int i=0;i<list.size();i++){
			if(squadName.trim().equals(list.get(i).getSquadName().trim()))
				return true;
		}
		return false;
	}
}
