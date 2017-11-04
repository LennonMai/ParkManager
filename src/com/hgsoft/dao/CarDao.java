package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Account;
import com.hgsoft.entity.Car;

@Repository 
public class CarDao extends BaseDao<Car> {
	private Car car2;
	@SuppressWarnings("unchecked")
	public Car getCar(String vehPlate) {
	    car2=null;
		String hql="from Car car where car.vehPlate=?";		
		List resultList=executeQuery(hql,vehPlate);
		if(resultList.isEmpty())return null;
		else { for(int i=0;i<resultList.size();i++){
			   Car car1=(Car) resultList.get(i);
		       String hql1="from Account account where account.car.sys_id=?";
		       List resultList1=executeQuery(hql1,car1.getSys_id());
		       if(resultList1.isEmpty())return null;
		       else{ Account account1=(Account)resultList1.get(0);
		    	 if(account1.getStatus()!=5){car2=account1.getCar(); break;}
		        }
		    	
		    	 
		     }
		return car2;
		 
			
		}
	}

}
