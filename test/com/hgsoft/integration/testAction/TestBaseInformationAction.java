/**
 * 
 */
package com.hgsoft.integration.testAction;

import static org.junit.Assert.*;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.BaseAction.Result;
import com.hgsoft.entity.CityInformation;
import com.hgsoft.service.CityInformationService;

/**
 * @author hai
 *
 */
public class TestBaseInformationAction extends AbstractActionTransactionalTests{

	
	@Autowired
	private CityInformationService cityInformationService;
	private CityInformation cityInformation;
	

	/**
	 * Test method for {@link com.hgsoft.action.BaseInformationAction#saveCityInfo()}.
	 */
	@Test
	@Rollback
	public void testSaveCityInfo() {
		cityInformation=new CityInformation();
		cityInformation.setCityName("上海");
		cityInformation.setCityNo((short)40);
		cityInformation.setRemark("参数");
		
		if(cityInformationService.ishasCityNo(cityInformation.getCityNo())==null){
			
			cityInformationService.save(cityInformation);
			System.out.println("SUCCESS");
		}else{
			System.out.println("hascityNo");

		}	
	}

	/**
	 * Test method for {@link com.hgsoft.action.BaseInformationAction#city_edit()}.
	 */
	@Test
	@Rollback
	public void testCity_edit() {
//		CityInformation cityInfo=cityInformationService.get(cityInformation.getCityNo());
		cityInformation=new CityInformation();
		cityInformation.setCityName("上海");
		cityInformation.setCityNo((short)40);
		cityInformation.setRemark("参数");
		
		CityInformation cityInfo=new CityInformation();
		cityInfo.setCityNo(cityInformation.getCityNo());
		cityInfo.setCityName(cityInformation.getCityName());
		cityInfo.setRemark(cityInformation.getRemark());
		cityInformationService.update(cityInfo);
		
	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#updateCityInfo()}.
//	 */
//	@Test
//	public void testUpdateCityInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#city_delete()}.
//	 */
//	@Test
//	public void testCity_delete() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#area_list()}.
//	 */
//	@Test
//	public void testArea_list() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#area_add()}.
//	 */
//	@Test
//	public void testArea_add() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#saveAreaInfo()}.
//	 */
//	@Test
//	public void testSaveAreaInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#area_edit()}.
//	 */
//	@Test
//	public void testArea_edit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#updateAreaInfo()}.
//	 */
//	@Test
//	public void testUpdateAreaInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#area_delete()}.
//	 */
//	@Test
//	public void testArea_delete() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#park_list()}.
//	 */
//	@Test
//	public void testPark_list() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#park_add()}.
//	 */
//	@Test
//	public void testPark_add() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#saveParkInfo()}.
//	 */
//	@Test
//	public void testSaveParkInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#park_edit()}.
//	 */
//	@Test
//	public void testPark_edit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#updateParkInfo()}.
//	 */
//	@Test
//	public void testUpdateParkInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#park_delete()}.
//	 */
//	@Test
//	public void testPark_delete() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#carSpace_list()}.
//	 */
//	@Test
//	public void testCarSpace_list() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#carSpace_add()}.
//	 */
//	@Test
//	public void testCarSpace_add() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#savecarSpaceInfo()}.
//	 */
//	@Test
//	public void testSavecarSpaceInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#carSpace_edit()}.
//	 */
//	@Test
//	public void testCarSpace_edit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#updatecarSpaceInfo()}.
//	 */
//	@Test
//	public void testUpdatecarSpaceInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#carSpace_delete()}.
//	 */
//	@Test
//	public void testCarSpace_delete() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#position_list()}.
//	 */
//	@Test
//	public void testPosition_list() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#position_add()}.
//	 */
//	@Test
//	public void testPosition_add() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#savePositionInfo()}.
//	 */
//	@Test
//	public void testSavePositionInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#position_edit()}.
//	 */
//	@Test
//	public void testPosition_edit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#updatePositionInfo()}.
//	 */
//	@Test
//	public void testUpdatePositionInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#position_delete()}.
//	 */
//	@Test
//	public void testPosition_delete() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#gateway_list()}.
//	 */
//	@Test
//	public void testGateway_list() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#gateway_add()}.
//	 */
//	@Test
//	public void testGateway_add() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#saveGatewayInfo()}.
//	 */
//	@Test
//	public void testSaveGatewayInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#gateway_edit()}.
//	 */
//	@Test
//	public void testGateway_edit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#updateGatewayInfo()}.
//	 */
//	@Test
//	public void testUpdateGatewayInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#gateway_delete()}.
//	 */
//	@Test
//	public void testGateway_delete() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#lane_list()}.
//	 */
//	@Test
//	public void testLane_list() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#lane_add()}.
//	 */
//	@Test
//	public void testLane_add() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#saveLaneInfo()}.
//	 */
//	@Test
//	public void testSaveLaneInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#lane_edit()}.
//	 */
//	@Test
//	public void testLane_edit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#updateLaneInfo()}.
//	 */
//	@Test
//	public void testUpdateLaneInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#lane_delete()}.
//	 */
//	@Test
//	public void testLane_delete() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#squad_list()}.
//	 */
//	@Test
//	public void testSquad_list() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#squad_add()}.
//	 */
//	@Test
//	public void testSquad_add() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#saveSquadInfo()}.
//	 */
//	@Test
//	public void testSaveSquadInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#squad_edit()}.
//	 */
//	@Test
//	public void testSquad_edit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#updateSquadInfo()}.
//	 */
//	@Test
//	public void testUpdateSquadInfo() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#squad_delete()}.
//	 */
//	@Test
//	public void testSquad_delete() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#getCityInformation()}.
//	 */
//	@Test
//	public void testGetCityInformation() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseInformationAction#setCityInformation(com.hgsoft.entity.CityInformation)}.
//	 */
//	@Test
//	public void testSetCityInformation() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#init()}.
//	 */
//	@Test
//	public void testInit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#add()}.
//	 */
//	@Test
//	public void testAdd() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#edit()}.
//	 */
//	@Test
//	public void testEdit() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#getPager()}.
//	 */
//	@Test
//	public void testGetPager() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#setPager(com.hgsoft.util.Pager)}.
//	 */
//	@Test
//	public void testSetPager() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#getList()}.
//	 */
//	@Test
//	public void testGetList() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#getMessage()}.
//	 */
//	@Test
//	public void testGetMessage() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#getBasePath()}.
//	 */
//	@Test
//	public void testGetBasePath() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#setMid(java.lang.Integer)}.
//	 */
//	@Test
//	public void testSetMid() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link com.hgsoft.action.BaseAction#getResult()}.
//	 */
//	@Test
//	public void testGetResult() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#Object()}.
//	 */
//	@Test
//	public void testObject() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#getClass()}.
//	 */
//	@Test
//	public void testGetClass() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#hashCode()}.
//	 */
//	@Test
//	public void testHashCode() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#equals(java.lang.Object)}.
//	 */
//	@Test
//	public void testEquals() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#clone()}.
//	 */
//	@Test
//	public void testClone() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#toString()}.
//	 */
//	@Test
//	public void testToString() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#notify()}.
//	 */
//	@Test
//	public void testNotify() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#notifyAll()}.
//	 */
//	@Test
//	public void testNotifyAll() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#wait(long)}.
//	 */
//	@Test
//	public void testWaitLong() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#wait(long, int)}.
//	 */
//	@Test
//	public void testWaitLongInt() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#wait()}.
//	 */
//	@Test
//	public void testWait() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link java.lang.Object#finalize()}.
//	 */
//	@Test
//	public void testFinalize() {
//		fail("Not yet implemented");
//	}

	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
