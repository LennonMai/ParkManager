package com.hgsoft.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.CarSpaceInformation;
import com.hgsoft.util.JdbcUtil;

@Repository 
public class CarSpaceInformationDao extends BaseDao<CarSpaceInformation>{
	
	@Resource
	private JdbcUtil jdbcUtil;
	
	//验证保存或者修改车位信息时，是否存在相同的小区编码
	@SuppressWarnings("unchecked")
	public List<CarSpaceInformation> ishascarSpace(Object parkNo){
		String hql="select carSpaceInfo.parkNo from CarSpaceInformation carSpaceInfo where carSpaceInfo.parkNo=?";
		List<CarSpaceInformation> list=executeQuery(hql,parkNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//根据小区删除该小区下的全部车位
	public boolean deleteByParkNo(Object ParkNo){
		String sql="delete tb_CarSpace where ParkNo='"+ParkNo+"'";
		jdbcUtil.delete(sql);
		return true;
	}
	@SuppressWarnings("unchecked")
	public List<CarSpaceInformation> getAllCarSpaceByParkNoAndGateNo(Object parkNo,Object gateNo){
		String hql="";
		if(parkNo==null && gateNo==null){
			hql="from CarSpaceInformation carSpaceInformation";
		} else if(parkNo!=null && gateNo==null){
			hql="from CarSpaceInformation carSpaceInformation where carSpaceInformation.parkNo="+parkNo;
		}else if(parkNo==null && gateNo!=null){
			hql="from CarSpaceInformation carSpaceInformation where carSpaceInformation.gateNo='"+gateNo+"'";
		}else if(parkNo!=null && gateNo!=null){
			hql="from CarSpaceInformation carSpaceInformation where carSpaceInformation.parkNo="+parkNo+" and carSpaceInformation.gateNo='"+gateNo+"'";
		}		
		List<CarSpaceInformation> list=executeQuery(hql);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	public void deleteByParkNoAndGateNo(Object ParkNo,Object gateNo){
		String sql="delete tb_CarSpace where ParkNo="+ParkNo+" and GateNo='"+gateNo+"'";
		jdbcUtil.delete(sql);
	}
	@SuppressWarnings("unchecked")
	public CarSpaceInformation getCarSpaceByParkNoAndGateNo(Object parkNo,Object gateNo){
		String hql="from CarSpaceInformation carSpaceInformation where carSpaceInformation.parkNo="+parkNo+" and carSpaceInformation.gateNo='"+gateNo+"'";
		List<CarSpaceInformation> list=executeQuery(hql);
		if(!list.isEmpty()){
			return (CarSpaceInformation)list.get(0);
		}else{
			return null;
		}
			
	}
}
