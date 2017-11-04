package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.ICCardStorage;

@Repository
public class ICCardStorageDao extends BaseDao<ICCardStorage>{
	@SuppressWarnings("unchecked")
	public List<Object[]> getICCardStorageAndGatewayInformation() {
		List myList = new ArrayList();
		String hql = "from ICCardStorage iCCardStorage,GatewayInformation gatewayInformation where iCCardStorage.position=gatewayInformation.gateNo";
		List resultList = executeQuery(hql);
		Iterator iterator1 = resultList.iterator();
		while (iterator1.hasNext()) {
			Object[] o = (Object[]) iterator1.next();
			ICCardStorage iCCardStorage = (ICCardStorage) o[0];
			GatewayInformation gatewayInformation = (GatewayInformation) o[1];
			Object ay = new Object[] { iCCardStorage, gatewayInformation };
			myList.add(ay);
		}

		return myList;
	}
	@SuppressWarnings("unchecked")
	public ICCardStorage getICCardStorageByPosition(int position){
		String hql = "from ICCardStorage iCCardStorage where iCCardStorage.position="+position;
		List resultList = executeQuery(hql);
		if(resultList.isEmpty()){
			return null;
		}else{
			return (ICCardStorage)resultList.get(0);
		}
	}
}
