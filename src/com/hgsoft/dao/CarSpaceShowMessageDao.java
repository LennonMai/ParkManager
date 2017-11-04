package com.hgsoft.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.CarSpaceShowMessage;


@Repository
public class CarSpaceShowMessageDao extends BaseDao<CarSpaceShowMessage> {
	@SuppressWarnings("unchecked")
	public List<CarSpaceShowMessage> getAllCarSpaceShowMessage(){
		String hql = "from CarSpaceShowMessage carSpaceShowMessage";
		List resultList = this.executeQuery(hql);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	@SuppressWarnings("unchecked")
	public CarSpaceShowMessage getCarSpaceShowMessageByPGL(short parkNo,short gateNo,short laneNo){
		String hql = "from CarSpaceShowMessage carSpaceShowMessage where carSpaceShowMessage.parkNo="+parkNo+" and carSpaceShowMessage.gateNo="+gateNo+" and carSpaceShowMessage.laneNo="+laneNo;
		List resultList = this.executeQuery(hql);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return (CarSpaceShowMessage)resultList.get(0);
		}
	}
}
