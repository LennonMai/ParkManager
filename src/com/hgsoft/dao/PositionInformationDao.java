package com.hgsoft.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.PositionInformation;
@Repository 
public class PositionInformationDao extends BaseDao<PositionInformation>{
	
	//��֤����λ����Ϣʱ���Ƿ������ͬ��λ�ñ���
	@SuppressWarnings("unchecked")
	public List<PositionInformation> ishasPositionNo(Object positionNo){
		String hql="select positionInfo.no from PositionInformation positionInfo where positionInfo.no=?";
		List<PositionInformation> list=executeQuery(hql,positionNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//zenggenbao
	@SuppressWarnings("unchecked")
	public List<PositionInformation> ishasPositionNoAndClass(Object positionNo,Object class_){
		String hql = "from PositionInformation positionInfo where positionInfo.no = ? and positionInfo.class_ = ?";
		List<PositionInformation> list = executeQuery(hql, positionNo,class_);
		if(list.isEmpty()){
			return null;
		}else{
			return list;
		}
		
	}
	//�Ƿ������ͬ��Ψһ����
	@SuppressWarnings("unchecked")
	public List<PositionInformation> ishasiid(Object iid){
		String hql = "from PositionInformation positionInfo where positionInfo.iid = ? ";
		List<PositionInformation> list = executeQuery(hql, iid);
		if(list.isEmpty()){
			return null;
		}else{
			return list;
		}
		
	}
	
	@SuppressWarnings("unchecked")
	public List<PositionInformation> LoadPositionInfo(Object no,Object class_){
		String hql="from PositionInformation positionInfo where positionInfo.no = ? and positionInfo.class_ = ?";
		List<PositionInformation> list=executeQuery(hql,no,class_);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}

	public boolean deleteByNoAndClass(Object no,Object class_){
        PositionInformation positionInformation=this.LoadPositionInfo(no,class_).get(0);
		getSession().clear();
		getSession().refresh(positionInformation);
		getSession().merge(positionInformation);
		getSession().delete(positionInformation);
		if (this.LoadPositionInfo(no) == null)
			return true;
		else
			return false;
	}

	//����No����PositionInformation
	@SuppressWarnings("unchecked")
	public List<PositionInformation> LoadPositionInfo(Object no){
		
		String hql="from PositionInformation positionInfo where positionInfo.no=?";
		List<PositionInformation> list=executeQuery(hql,no);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//������������ɾ������
	public boolean deleteByNo(Object no){
        PositionInformation positionInformation=this.LoadPositionInfo(no).get(0);
		getSession().clear();
		getSession().refresh(positionInformation);
		getSession().merge(positionInformation);
		getSession().delete(positionInformation);
		if (this.LoadPositionInfo(no) == null)
			return true;
		else
			return false;
	}
}
