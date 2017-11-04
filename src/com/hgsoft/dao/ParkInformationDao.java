package com.hgsoft.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.util.JdbcUtil;

@Repository
public class ParkInformationDao extends BaseDao<ParkInformation> {
	@Resource
	private JdbcUtil jdbcUtil;

	// ��֤��������޸�С����Ϣʱ���Ƿ������ͬ��С������
	@SuppressWarnings("unchecked")
	public List<ParkInformation> ishasParkNo(Object parkNo) {
		String hql = "select parkInfo.parkNo from ParkInformation parkInfo where parkInfo.parkNo=?";
		List<ParkInformation> list = executeQuery(hql, parkNo);
		if (!list.isEmpty()) {
			return list;
		} else
			return null;
	}

	// zenggenbao
	@SuppressWarnings("unchecked")
	public List<ParkInformation> ishasParkNoAndAreaNo(Object areaNo,
			Object parkNo) {
		String hql = "from ParkInformation parkInfo where parkInfo.areaNo = ? and parkInfo.parkNo = ? ";
		List<ParkInformation> list = this.executeQuery(hql, areaNo, parkNo);
		if (!list.isEmpty()) {
			return list;
		}
		return null;
	}

	// caijunhua ��֤С�����Ƿ����
	@SuppressWarnings({ "rawtypes" })
	public ParkInformation findParkByName(String parkName) {
		String hql = "from ParkInformation parkInfo where parkInfo.parkName=?";
		List list = executeQuery(hql, parkName);
		if (list.isEmpty()) {
			return null;
		} else {
			return (ParkInformation) list.get(0);
		}
	}

	// ����parkNo����ParkInformation
	@SuppressWarnings("unchecked")
	public List<ParkInformation> LoadParkInfo(Object parkNo) {
		String hql = "from ParkInformation parkInfo where parkInfo.parkNo=?";
		List<ParkInformation> list = executeQuery(hql, parkNo);
		if (!list.isEmpty()) {
			return list;
		} else
			return null;
	}

	@SuppressWarnings("unchecked")
	public List<ParkInformation> LoadPark(Object areaNo) {
		String hql = "from ParkInformation parkInfo where parkInfo.areaNo = ? ";
		List<ParkInformation> list = executeQuery(hql, areaNo);
		if (!list.isEmpty()) {
			return list;
		} else
			return null;
	}

	// zenggenbao
	@SuppressWarnings("unchecked")
	public List<ParkInformation> LoadParkInfo(Object areaNo, Object parkNo) {
		String hql = "from ParkInformation parkInfo where parkInfo.areaNo = ? and parkInfo.parkNo = ?";
		List<ParkInformation> list = executeQuery(hql, areaNo, parkNo);
		if (!list.isEmpty()) {
			return list;
		} else
			return null;
	}

	// ������������ɾ������
	public boolean deleteByparkNo(Object parkNo) {
		ParkInformation parkInformation = this.LoadParkInfo(parkNo).get(0);
		getSession().clear();
		getSession().refresh(parkInformation);
		getSession().merge(parkInformation);
		getSession().delete(parkInformation);
		if (this.LoadParkInfo(parkNo) == null)
			return true;
		else
			return false;
	}

	// ����С��ɾ����С���µ�ȫ������
	public boolean deleteByAreaNo(Object areaNo) {
		String sql = "delete tb_Park where AreaNo='" + areaNo + "'";
		jdbcUtil.delete(sql);
		return true;
	}

	// zenggenbao
	// ������������ɾ������
	public boolean deleteByareaNoparkNo(Object areaNo, Object parkNo) {
		List<ParkInformation> li=this.LoadParkInfo(areaNo, parkNo);
		if(li!=null){
			ParkInformation parkInformation = li.get(0);
			getSession().clear();
			getSession().refresh(parkInformation);
			getSession().merge(parkInformation);
			getSession().delete(parkInformation);
		}
		
		if (this.LoadParkInfo(areaNo, parkNo) == null)
			return true;
		else
			return false;
	}

	// chenfuyuan
	@SuppressWarnings("unchecked")
	public List<ParkInformation> getAllParkInformation() {
		String hql = "from ParkInformation parkInfo";
		if (!executeQuery(hql).isEmpty()) {
			return executeQuery(hql);
		} else
			return null;

	}

	// chenfuyuan
	@SuppressWarnings({ "rawtypes" })
	public ParkInformation getParkInformationByParkNo(Short parkNo) {
		String hql = "from ParkInformation parkInfo where parkInfo.parkNo=?";
		List resultList = executeQuery(hql, parkNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (ParkInformation) resultList.get(0);
		}

	}

	// zenggenbao
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<ParkInformation> getAllParkInformationByAreaNo(Short areaNo) {
		String hql = "from ParkInformation parkInfo where parkInfo.areaNo = ?";
		List list = executeQuery(hql, areaNo);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
	
	public boolean findParkNameByNoThisParkNo(Short parkNo,String parkName) {
		String hql = "from ParkInformation parkInfo where parkInfo.parkNo!=?";
		@SuppressWarnings("unchecked")
		List<ParkInformation> resultList = this.executeQuery(hql, parkNo);
		for(int i=0;i<resultList.size();i++){
			if(parkName.trim().equals(resultList.get(i).getParkName().trim()))
				return true;
		}
		return false;
	}
	@SuppressWarnings("unchecked")
	public List<ParkInformation> findParkInformation() {
		String hql = "from ParkInformation parkInfo ";
		List<ParkInformation> list = executeQuery(hql);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
	
}
