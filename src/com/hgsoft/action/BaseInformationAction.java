package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.AreaInformation;
import com.hgsoft.entity.CarSpaceInformation;
import com.hgsoft.entity.CityInformation;
import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.ICCardStorage;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.LaneUse;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.entity.PositionInformation;
import com.hgsoft.entity.SquadInformation;
import com.hgsoft.entity.SupplyLightInformation;
import com.hgsoft.service.AreaInformationService;
import com.hgsoft.service.CarSpaceInformationService;
import com.hgsoft.service.CityInformationService;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.ICCardStorageService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.LaneUseService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.PositionInformationService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SupplyLightInformationService;
import com.hgsoft.service.SystemLogService;

/**
 * 基本信息
 * 
 * @author qinzuohai
 */
@Controller
@Scope("prototype")
public class BaseInformationAction extends BaseAction {

	@Resource
	private SystemLogService systemLogService;
	@Resource
	private CityInformationService cityInformationService;
	private CityInformation cityInformation;
	@Resource
	private AreaInformationService areaInformationService;
	private AreaInformation areaInformation;

	@Resource
	private ParkInformationService parkInformationService;
	private ParkInformation parkInformation;

	@Resource
	private CarSpaceInformationService carSpaceInformationService;
	private CarSpaceInformation carSpaceInformation;

	@Resource
	private PositionInformationService positionInformationService;
	private PositionInformation positionInformation;
	@Resource
	private GatewayInformationService gatewayInformationService;
	private GatewayInformation gatewayInformation;

	@Resource
	private LaneInformationService laneInformationService;
	private LaneInformation laneInformation;
	
	@Resource
	private LaneUseService laneUseService;
	private LaneUse laneUse;
	
	public LaneUse getLaneUse() {
		return laneUse;
	}

	public void setLaneUse(LaneUse laneUse) {
		this.laneUse = laneUse;
	}

	@Resource
	private SquadInformationService squadInformationService;
	private SquadInformation squadInformation;
	@Resource
	private SupplyLightInformationService supplyLightInformationService;
	@Resource
	private ICCardStorageService iCCardStorageService;
	private SupplyLightInformation supplyLightInformation;
	private String areaNo;
    private String parkNo;

    private List<GatewayInformation> gateList; 
    private List<ParkInformation> parkList;
    private List<GatewayInformation> gatewayList; //后面添加，为了不修改之前的代码，所以重新定义
    
	/**
	 * 城市信息
	 ***************************************************************************************************
	 * */

	/**
	 * 城市信息首页面，导向时先清除 由修改时设置的页面定位session值
	 */
	public String city_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list = cityInformationService.findByPager(pager);
		return "city_list";
	}

	/**
	 *  页面转向城市信息添加页面
	 * @return
	 */
	public String city_add() {
		return "city_add";
	}

	/**
	 * 添加城市信息,判断是否存在相同的城市编码或城市名称，否则添加成功
	 * @return
	 */
	public String saveCityInfo() {
		if (cityInformationService.ishasCityNo(cityInformation.getCityNo()) != null) {
			return "city_add";
		} else if (cityInformationService.findCityByName(cityInformation.getCityName()) != null) {
			return "city_add";
		} else {
			
			CityInformation ciTemp=new CityInformation();
			ciTemp.setCityNo(cityInformation.getCityNo());
			ciTemp.setCityName(cityInformation.getCityName().trim());
			ciTemp.setRemark(cityInformation.getRemark().trim());
			
			cityInformationService.save(ciTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加城市编码为[" + cityInformation.getCityNo() + "]的城市信息成功","添加城市信息", "tb_City");
		
			ciTemp=null;
		}
		return city_list();
	}

	/**
	 * 页面转向城市信息修改页面，设置该条记录的页面定位session值
	 * @return
	 */
	public String city_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());

		cityInformation = cityInformationService.load(cityInformation.getCityNo());
		return "city_edit";
	}

	/**
	 * 修改城市信息，set 页面定位，
	 * @return
	 */
	public String updateCityInfo() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		if(cityInformationService.findCityNameByNoThisCityNo(cityInformation.getCityNo(), cityInformation.getCityName())){
			result = Result.FAIL;
			return "city_edit";
		}
		
		CityInformation ciTemp=new CityInformation();
		ciTemp.setCityNo(cityInformation.getCityNo());
		ciTemp.setCityName(cityInformation.getCityName().trim());
		ciTemp.setRemark(cityInformation.getRemark().trim());
		
		cityInformationService.update(ciTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改城市编码为["+ cityInformation.getCityNo() + "]的城市信息成功", "修改城市信息","tb_City");
		list = cityInformationService.findByPager(pager);
		
		ciTemp=null;
		return "city_list";
	}

	/**
	 *  删除一条城市信息,关联删除该城市下的全部信息
	 * @return
	 */
	public String city_delete() {
		//根据该城市编码查询出该编码的全部区域信息
		List<AreaInformation> alist=areaInformationService.LoadArea(cityInformation.getCityNo());
		
		List<ParkInformation> plist=new ArrayList<ParkInformation>();
		List<GatewayInformation> glist=new ArrayList<GatewayInformation>();
		
		if(alist!=null){
			//遍历该城市编号下的全部区域
			for(int i=0;i<alist.size();i++){
				//根据该区域编码查询出该编码的全部小区信息
				plist=parkInformationService.LoadPark(alist.get(i).getAreaNo());
				if(plist!=null){
					//遍历该区域编号下的全部小区
					for(int j=0;j<plist.size();j++){
						//根据该小区编码查询出该编码的全部大门信息
						glist=gatewayInformationService.LoadGateway(alist.get(i).getAreaNo(), plist.get(j).getParkNo());
						if(glist!=null){
							//遍历该大门编号下的车道
							for(int m=0;m<glist.size();m++){
								//逐条删除车道信息
								laneInformationService.deleteByGateNo(glist.get(m).getGateNo());
							}
						}
						//逐条删除车位信息和大门信息
						carSpaceInformationService.deleteByParkNo(plist.get(j).getParkNo());
						gatewayInformationService.deleteByParkNo(plist.get(j).getParkNo());
					}
					
					//逐条删除小区信息
					parkInformationService.deleteByAreaNo(alist.get(i).getAreaNo());
				}
				
				//逐条删除区域信息
				areaInformationService.delete(alist.get(i).getAreaNo());
			}
		}
		cityInformationService.delete(cityInformation.getCityNo());
		
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除城市编码为["+ cityInformation.getCityNo() + "]的城市信息成功", "删除城市信息","tb_City");

		return city_list();
	}

	// 验证城市编码是否存在
	public void ishasCityNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == cityInformationService.ishasCityNo(cityInformation.getCityNo())) {
			out.print("noCityNo");
		} else {
			out.print("hasCityNo");
		}
	}

	//验证城市名是否存在
	public void getCityByName() {
		CityInformation cityInfo = cityInformationService.findCityByName(cityInformation.getCityName());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == cityInfo) {
			out.print("success");
		} else {
			out.print("fail");
		}
	}


	/**
	 * 区域信息
	 ***************************************************************************************************
	 * */
	
	/**
	 * 区域信息首页面，导向时先清除 由修改时设置的页面定位session值
	 * */


	public String area_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list = areaInformationService.findByPager(pager);
		return "area_list";
	}

	/**
	 * 页面转向区域信息添加页面
	 * @return
	 */
	public String area_add() {
		return "area_add";
	}

	/**
	 * 添加区域信息，,判断是否存在相同的区域编码或区域名称，否则添加成功
	 * @return
	 */
	public String saveAreaInfo() {
		if (null != areaInformationService.ishasAreaNo(areaInformation.getAreaNo())) {
			return "area_add";
		} else if (null != areaInformationService.findAreaByName(areaInformation.getAreaName())) {
			return "area_add";
		} else {
			
			AreaInformation aiTemp=new AreaInformation();
			aiTemp.setCityNo(areaInformation.getCityNo());
			aiTemp.setAreaNo(areaInformation.getAreaNo());
			aiTemp.setAreaName(areaInformation.getAreaName().trim());
			aiTemp.setAreaDbname(areaInformation.getAreaDbname().trim());
			aiTemp.setAreaDbuserName(areaInformation.getAreaDbuserName().trim());
			aiTemp.setAreaDbpassword(areaInformation.getAreaDbpassword().trim());
			aiTemp.setAreaDomain(areaInformation.getAreaDomain().trim());
			aiTemp.setAreaServerIp(areaInformation.getAreaServerIp().trim());
			aiTemp.setAreaServerName(areaInformation.getAreaServerName().trim());
			
			areaInformationService.save(aiTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加区域编码为[" + areaInformation.getAreaNo() + "]的区域信息成功","添加区域信息", "tb_Area");

			aiTemp=null;
		}
		return area_list();
	}

	/**
	 * 转向区域信息修改页面
	 * @return
	 */
	public String area_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		areaInformation = areaInformationService.load(areaInformation.getAreaNo());
		return "area_edit";
	}

	/**
	 * 修改区域信息
	 * @return
	 */
	public String updateAreaInfo() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());

		if(areaInformationService.findAreaNameByNoThisAreaNo(areaInformation.getAreaNo(), areaInformation.getAreaName())){
			result = Result.FAIL;
			return "area_edit";
		}
		
		AreaInformation aiTemp=new AreaInformation();
		aiTemp.setCityNo(areaInformation.getCityNo());
		aiTemp.setAreaNo(areaInformation.getAreaNo());
		aiTemp.setAreaName(areaInformation.getAreaName().trim());
		aiTemp.setAreaDbname(areaInformation.getAreaDbname().trim());
		aiTemp.setAreaDbuserName(areaInformation.getAreaDbuserName().trim());
		aiTemp.setAreaDbpassword(areaInformation.getAreaDbpassword().trim());
		aiTemp.setAreaDomain(areaInformation.getAreaDomain().trim());
		aiTemp.setAreaServerIp(areaInformation.getAreaServerIp().trim());
		aiTemp.setAreaServerName(areaInformation.getAreaServerName().trim());
		
		areaInformationService.update(aiTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为["+ areaInformation.getAreaNo() + "]的区域信息成功", "修改区域信息","tb_Area");

		list = areaInformationService.findByPager(pager);

		aiTemp=null;
		return "area_list";
	}

	/**
	 * 删除一条区域信息,并删除该区域下的全部关联信息
	 * @return
	 */
	public String area_delete() {

		List<ParkInformation> list=parkInformationService.LoadPark(areaInformation.getAreaNo());
		List<GatewayInformation> glist=new ArrayList<GatewayInformation>();
		
		if(list!=null){
			for(int i=0;i<list.size();i++){
				glist=gatewayInformationService.LoadGateway(areaInformation.getAreaNo(), list.get(i).getParkNo());
				if(glist!=null){
					for(int j=0;j<glist.size();j++){
						laneInformationService.deleteByGateNo(glist.get(j).getGateNo());
					}
				}
				gatewayInformationService.deleteByParkNo(list.get(i).getParkNo());
				carSpaceInformationService.deleteByParkNo(list.get(i).getParkNo());
			}
			parkInformationService.deleteByAreaNo(areaInformation.getAreaNo());
		}
		areaInformationService.delete(areaInformation.getAreaNo());
		
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除区域编码为["+ areaInformation.getAreaNo() + "]的区域信息成功", "删除区域信息","tb_Area");

		return area_list();
	}

	// 验证区域编码是否存在
	public void ishasAreaNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == areaInformationService.ishasAreaNo(areaInformation.getAreaNo())) {
			out.print("noAreaNo");
		} else {
			out.print("hasAreaNo");
		}
	}

	//验证区域名是否存在
	public void getAreaByName() {
		AreaInformation areaInfo = areaInformationService.findAreaByName(areaInformation.getAreaName());
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == areaInfo) {
			out.print("success");
		} else {
			out.print("fail");
		}
	}


	/**
	 * 小区信息
	 ***************************************************************************************************
	 * */


	/**
	 * 小区信息列表页面
	 */
	public String park_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list = parkInformationService.findByPager(pager);
		return "park_list";
	}

	/**
	 * 转向小区信息添加页面
	 * @return
	 */
	public String park_add() {
		return "park_add";
	}

	/**
	 * 添加小区信息
	 * @return
	 */
	public String saveParkInfo() {
		if (null != parkInformationService.ishasParkNoAndAreaNo(parkInformation.getAreaNo(), parkInformation.getParkNo())) {
			return "park_add";
		} else if (null != parkInformationService.findParkByName(parkInformation.getParkName())) {
			return "park_add";
		} else {
			
			ParkInformation piTemp=new ParkInformation();
			piTemp.setAreaNo(parkInformation.getAreaNo());
			piTemp.setParkDbname(parkInformation.getParkDbname().trim());
			piTemp.setParkDbuserName(parkInformation.getParkDbuserName().trim());
			piTemp.setParkDbpassword(parkInformation.getParkDbpassword().trim());
			piTemp.setParkDomain(parkInformation.getParkDomain().trim());
			piTemp.setParkFullName(parkInformation.getParkFullName().trim());
			piTemp.setParkLevel(parkInformation.getParkLevel().trim());
			piTemp.setParkName(parkInformation.getParkName().trim());
			piTemp.setParkNo(parkInformation.getParkNo());
			piTemp.setParkServerIp(parkInformation.getParkServerIp().trim());
			piTemp.setParkServerName(parkInformation.getParkServerName().trim());
			piTemp.setParkSpaceCnt(parkInformation.getParkSpaceCnt());
			piTemp.setUplevelParkNo(parkInformation.getUplevelParkNo());
			
			parkInformationService.save(piTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加区域编码为[" + parkInformation.getAreaNo() + "],小区编码为["+ parkInformation.getParkNo() + "]的小区信息成功","添加小区信息", "tb_Park");
		
			piTemp=null;
		}
		return park_list();
	}

	/**
	 * 转向小区信息修改页面
	 * @return
	 */
	public String park_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		parkInformation = parkInformationService.LoadParkInfo(parkInformation.getAreaNo(), parkInformation.getParkNo()).get(0);
		return "park_edit";
	}

	/**
	 *  修改小区信息
	 * @return
	 */
	public String updateParkInfo() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		if (parkInformationService.findParkNameByNoThisParkNo(parkInformation.getParkNo(), parkInformation.getParkName())) {
			result = Result.FAIL;
			return "park_edit";
		}
		
		ParkInformation piTemp=new ParkInformation();
		piTemp.setAreaNo(parkInformation.getAreaNo());
		piTemp.setParkDbname(parkInformation.getParkDbname().trim());
		piTemp.setParkDbuserName(parkInformation.getParkDbuserName().trim());
		piTemp.setParkDbpassword(parkInformation.getParkDbpassword().trim());
		piTemp.setParkDomain(parkInformation.getParkDomain().trim());
		piTemp.setParkFullName(parkInformation.getParkFullName().trim());
		piTemp.setParkLevel(parkInformation.getParkLevel().trim());
		piTemp.setParkName(parkInformation.getParkName().trim());
		piTemp.setParkNo(parkInformation.getParkNo());
		piTemp.setParkServerIp(parkInformation.getParkServerIp().trim());
		piTemp.setParkServerName(parkInformation.getParkServerName().trim());
		piTemp.setParkSpaceCnt(parkInformation.getParkSpaceCnt());
		piTemp.setUplevelParkNo(parkInformation.getUplevelParkNo());
		
		parkInformationService.update(piTemp);
		message="updateSuccess";

		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为[" + parkInformation.getAreaNo() + "],小区编码为["+ parkInformation.getParkNo() + "]的小区信息成功", "修改小区信息","tb_Park");

		list = parkInformationService.findByPager(pager);
		
		piTemp=null;
		return "park_list";
	}

	/**
	 * 删除一条小区信息
	 * @return
	 */
	public String park_delete() {
		
		List<GatewayInformation> list=gatewayInformationService.LoadGateway(parkInformation.getAreaNo(),parkInformation.getParkNo()); 
		if(list!=null){
			for(int i=0;i<list.size();i++){
	        	laneInformationService.deleteByGateNo(list.get(i).getGateNo());
	        }
			gatewayInformationService.deleteByParkNo(parkInformation.getParkNo());
		}
		carSpaceInformationService.deleteByParkNo(parkInformation.getParkNo());
		parkInformationService.deleteByareaNoparkNo(parkInformation.getAreaNo(),parkInformation.getParkNo());
		
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除区域编码为[" + parkInformation.getAreaNo() + "],小区编码为["+ parkInformation.getParkNo() + "]的小区信息成功", "删除小区信息","tb_Park");

		return park_list();
	}

	public void ishasParkNoAndAreaNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == parkInformationService.ishasParkNoAndAreaNo(
				parkInformation.getAreaNo(), parkInformation.getParkNo())) {
			out.print("noAreaNoParkNo");
		} else {
			out.print("hasAreaNoParkNo");
		}
	}

	//验证小区名称是否存在
	public void getParkByName() {
		ParkInformation parkInfo = parkInformationService
				.findParkByName(parkInformation.getParkName());
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == parkInfo) {
			out.print("success");
		} else {
			out.print("fail");
		}
	}

	
	/**
	 * 车位信息
	 ***************************************************************************************************
	 * */

	/**
	 * 车位信息首页面
	 */
	public String carSpace_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");	
		parkList=parkInformationService.findParkInformation();
		gatewayList=gatewayInformationService.findGatewayInformation();	
		list = carSpaceInformationService.findByModifyTimePager(pager);
		return "carSpace_list";
	}

	/**
	 * 转向车位信息添加页面
	 * @return
	 */
	public String carSpace_add() {
		parkList=parkInformationService.findParkInformation();
		return "carSpace_add";
	}

	/**
	 *  添加车位信息
	 * @return
	 */
	public String savecarSpaceInfo() {
		if (carSpaceInformationService.getAllCarSpaceByParkNoAndGateNo(carSpaceInformation.getParkNo(),carSpaceInformation.getGateNo()) == null) {			
			carSpaceInformationService.save(carSpaceInformation);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加小区编码为[" + carSpaceInformation.getParkNo() + "]的车位信息成功","添加车位信息", "tb_CarSpace");
		} else {
			message = "hascarSpace";
			parkList = parkInformationService.getAllParkInformation();
			return "carSpace_add";
		}
		return carSpace_list();
	}


	/**
	 * 转向车位信息修改页面
	 * @return
	 */
	public String carSpace_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		parkList=parkInformationService.findParkInformation();
		gatewayList=gatewayInformationService.findGatewayInformation();
		carSpaceInformation = carSpaceInformationService.getCarSpaceByParkNoAndGateNo(carSpaceInformation.getParkNo(), carSpaceInformation.getGateNo());
		return "carSpace_edit";
	}

	/**
	 * 修改车位信息
	 * @return
	 */
	public String updatecarSpaceInfo() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());		
		carSpaceInformationService.update(carSpaceInformation);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改小区编码为["+ carSpaceInformation.getParkNo() + "]的车位信息成功", "修改车位信息","tb_CarSpace");
        parkList=parkInformationService.findParkInformation();
		gatewayList=gatewayInformationService.findGatewayInformation();
		list = carSpaceInformationService.findByModifyTimePager(pager);
		return "carSpace_list";
	}

	/**
	 * 删除一条车位信息
	 * @return
	 */
	public String carSpace_delete() {
		//carSpaceInformationService.delete(carSpaceInformation.getParkNo());
		carSpaceInformationService.deleteByParkNoAndGateNo(carSpaceInformation.getParkNo(), carSpaceInformation.getGateNo());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除小区编码为["+ carSpaceInformation.getParkNo() + "]的车位信息成功", "删除车位信息","tb_CarSpace");
		parkList=parkInformationService.findParkInformation();
		gatewayList=gatewayInformationService.findGatewayInformation();
		list = carSpaceInformationService.findByModifyTimePager(pager);
		return "carSpace_list";
	}


	

	
	/**
	 * 位置信息
	 ***************************************************************************************************
	 * */


	/**
	 * 位置信息首页面
	 */
	public String position_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list = positionInformationService.findByPager(pager);
		return "position_list";
	}

	/**
	 * 转向位置信息添加页面
	 * @return
	 */
	public String position_add() {
		return "position_add";
	}

	/**
	 * 添加位置信息
	 * @return
	 */
	public String savePositionInfo() {	
		if (positionInformationService.ishasPositionNoAndClass(positionInformation.getNo(), positionInformation.getClass_()) == null) {
			if (positionInformationService.ishasiid(positionInformation.getIid()) == null) {
				
				PositionInformation pTemp=new PositionInformation();
				pTemp.setClass_(positionInformation.getClass_());
				pTemp.setIid(positionInformation.getIid());
				pTemp.setNo(positionInformation.getNo());
				pTemp.setName(positionInformation.getName().trim());
				
				positionInformationService.save(pTemp);
				result = Result.SUCCESS;
				systemLogService.save(new Date(),1,getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加位置编码为[" + positionInformation.getNo()+ "],位置名称为["+ positionInformation.getName()+ "]的位置信息成功", "添加位置信息", "tb_Position");
			
				pTemp=null;
			} else {
				
				return "position_add";
			}
		} else {
			message="hasNoandClass";
			return "position_add";
		}
		return position_list();
	}

	/**
	 * 转向位置信息修改页面
	 * @return
	 */
	public String position_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());

		positionInformation = positionInformationService.LoadPositionInfo(positionInformation.getNo(), positionInformation.getClass_()).get(0);
		return "position_edit";
	}

	/**
	 * 修改位置信息
	 * @return
	 */
	public String updatePositionInfo() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		PositionInformation pTemp=new PositionInformation();
		pTemp.setClass_(positionInformation.getClass_());
		pTemp.setIid(positionInformation.getIid());
		pTemp.setNo(positionInformation.getNo());
		pTemp.setName(positionInformation.getName().trim());
		
		positionInformationService.update(pTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改位置编码为["+ positionInformation.getNo() + "],位置名称为["+ positionInformation.getName() + "]的位置信息成功", "修改位置信息","tb_Position");
		list = positionInformationService.findByPager(pager);
		
		pTemp=null;
		return "position_list";
	}

	/**
	 * 删除一条位置信息
	 * @return
	 */
	public String position_delete() {
		positionInformationService.deleteByNoAndClass(positionInformation.getNo(), positionInformation.getClass_());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除位置编码为["+ positionInformation.getNo() + "],位置名称为["+ positionInformation.getName() + "]的位置信息成功", "删除位置信息","tb_Position");

		list = positionInformationService.findByPager(pager);
		return "position_list";
	}

	public void ishasIid() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == positionInformationService.ishasiid(positionInformation.getIid())) {
			out.print("noIid");
		} else {
			out.print("hasIid");
		}
	}



	
	
	/**
	 * 位置信息
	 ***************************************************************************************************
	 * */


	/**
	 * 大门信息首页面
	 */
	public String gateway_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list = gatewayInformationService.findByPager(pager);
		return "gateway_list";
	}

	/**
	 * 转向大门信息添加页面
	 * @return
	 */
	public String gateway_add() {
		return "gateway_add";
	}

	/**
	 * 添加大门信息
	 * @return
	 */
	public String saveGatewayInfo() {
		if (gatewayInformationService.ishasGatewayInfo(gatewayInformation.getAreaNo(), gatewayInformation.getParkNo(),gatewayInformation.getGateNo()) == null) {

			if (gatewayInformationService.ishasGateNo(gatewayInformation.getGateNo()) != null) {
				return "gateway_add";
			} else if (null != gatewayInformationService.findGateByName(gatewayInformation.getGateName())) {
				return "gateway_add";
			} else {
				
				GatewayInformation giTemp=new GatewayInformation();
				giTemp.setAreaNo(gatewayInformation.getAreaNo());
				giTemp.setGateAllName(gatewayInformation.getGateAllName().trim());
				giTemp.setGateName(gatewayInformation.getGateName().trim());
				giTemp.setGateNo(gatewayInformation.getGateNo());
				giTemp.setParkNo(gatewayInformation.getParkNo());
				giTemp.setRemark(gatewayInformation.getRemark().trim());
				
				gatewayInformationService.save(giTemp);
				
				// chenfuyuan
				if (iCCardStorageService.get(gatewayInformation.getGateNo().intValue()) != null) {
					iCCardStorageService.deleteById(gatewayInformation.getGateNo().intValue());
				}
				ICCardStorage ICCardStorageTemp = new ICCardStorage();
				ICCardStorageTemp.setAmount(0);
				ICCardStorageTemp.setOpTime(new Date());
				ICCardStorageTemp.setPosition(gatewayInformation.getGateNo().intValue());
				iCCardStorageService.save(ICCardStorageTemp);
				result = Result.SUCCESS;
				systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加区域编码为[" + gatewayInformation.getAreaNo()+ "],小区编码为[" + gatewayInformation.getParkNo()+ "],大门编码为[" + gatewayInformation.getGateNo()+ "]的大门信息成功", "添加大门信息", "tb_Gateway");
			
				giTemp=null;
			}

		} else {
			return "gateway_add";

		}

		return gateway_list();
	}

	/**
	 * 转向大门信息修改页面
	 * @return
	 */
	public String gateway_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		gatewayInformation = gatewayInformationService.LoadGatewayInfo(gatewayInformation.getAreaNo(), gatewayInformation.getParkNo(),gatewayInformation.getGateNo()).get(0);
		return "gateway_edit";
	}

	/**
	 * 修改大门信息
	 * @return
	 */
	public String updateGatewayInfo() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		if (gatewayInformationService.findGateNameInThisParkNoNoThisGateNo(gatewayInformation.getParkNo(),gatewayInformation.getGateNo(),gatewayInformation.getGateName())) {
			result = Result.FAIL;
			return "gateway_edit";
		}
		
		GatewayInformation giTemp=new GatewayInformation();
		giTemp.setAreaNo(gatewayInformation.getAreaNo());
		giTemp.setGateAllName(gatewayInformation.getGateAllName().trim());
		giTemp.setGateName(gatewayInformation.getGateName().trim());
		giTemp.setGateNo(gatewayInformation.getGateNo());
		giTemp.setParkNo(gatewayInformation.getParkNo());
		giTemp.setRemark(gatewayInformation.getRemark().trim());
		
		gatewayInformationService.update(giTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为["+ gatewayInformation.getAreaNo() + "],小区编码为["+ gatewayInformation.getParkNo() + "],大门编码为["+ gatewayInformation.getGateNo() + "]的大门信息成功", "修改大门信息","tb_Gateway");

		list = gatewayInformationService.findByPager(pager);
		
		giTemp=null;
		return "gateway_list";
	}

	/**
	 * 删除一条大门信息
	 * @return
	 */
	public String gateway_delete() {
		gatewayInformationService.deleteBygateInfo(gatewayInformation.getAreaNo(), gatewayInformation.getParkNo(),gatewayInformation.getGateNo());
		laneInformationService.deleteByGateNo(gatewayInformation.getGateNo());
	
		message="deleteSuccess";
		
		// chenfuyuan
		if (iCCardStorageService.get(gatewayInformation.getGateNo().intValue()) != null) {
			iCCardStorageService.deleteById(gatewayInformation.getGateNo().intValue());
		}
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除区域编码为["+ gatewayInformation.getAreaNo() + "],小区编码为["+ gatewayInformation.getParkNo() + "],大门编码为["+ gatewayInformation.getGateNo() + "]的大门信息成功", "删除大门信息","tb_Gateway");

		return gateway_list();
	}

	public void ishasGateNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == gatewayInformationService.ishasGateNo(gatewayInformation
				.getGateNo())) {
			out.print("noGateNo");
		} else {
			out.print("hasGateNo");
		}
	}

	//验证大门名是否存在
	public void getGateByName() {
		GatewayInformation gatewayInfo = gatewayInformationService
				.findGateByName(gatewayInformation.getGateName());
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == gatewayInfo) {
			out.print("success");
		} else {
			out.print("fail");
		}
	}


	
	
	/**
	 * 车道信息 
	 ***************************************************************************************************
	 * */


	/**
	 * 车道信息首页面
	 */
	public String lane_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		gateList=gatewayInformationService.findGatewayInformation();
		list = laneInformationService.findByPager(pager);
		return "lane_list";
	}

	/**
	 * 转向车道信息添加页面
	 * @return
	 */
	public String lane_add() {
		return "lane_add";
	}

	/**
	 * 添加车道信息
	 * @return
	 */
	public String saveLaneInfo() {
		if (laneInformationService.ishasLaneInfo(laneInformation.getAreaNo(), laneInformation.getParkNo(), laneInformation.getGateNo(), laneInformation.getLaneNo()) == null) {

			LaneInformation liTemp = new LaneInformation();
			liTemp.setAreaNo(laneInformation.getAreaNo());
			liTemp.setGateNo(laneInformation.getGateNo());
			liTemp.setParkNo(laneInformation.getParkNo());
			liTemp.setLaneNo(laneInformation.getLaneNo());
			liTemp.setLaneTypeNo(laneInformation.getLaneTypeNo());
			liTemp.setLaneComputerIp(laneInformation.getLaneComputerIp().trim());
			liTemp.setLaneComputerName(laneInformation.getLaneComputerName().trim());
			liTemp.setIsUse(laneInformation.getIsUse());
			// 保存车道信息
			laneInformationService.save(liTemp);

			// 如该车道信息在有用车道中不存在，则保存到有用车道中
			/*
			 * if(laneUseService.ishasLaneUse(liTemp.getAreaNo(),
			 * liTemp.getParkNo(), liTemp.getGateNo(),
			 * liTemp.getLaneNo())==null){ LaneUse luTemp=new LaneUse();
			 * luTemp.setAreaNo(liTemp.getAreaNo());
			 * luTemp.setGateNo(liTemp.getGateNo());
			 * luTemp.setParkNo(liTemp.getParkNo());
			 * luTemp.setLaneNo(liTemp.getLaneNo());
			 * luTemp.setLaneComputerIp(liTemp.getLaneComputerIp());
			 * luTemp.setIsUse((short)0); laneUseService.save(luTemp);
			 * 
			 * luTemp=null; systemLogService.save(new Date(), 1,
			 * getCurrentOperator
			 * (),"["+this.getCurrentOperator().getId()+"]"+this
			 * .getCurrentOperator().getUsername()+"用户添加区域编码为[" +
			 * laneInformation.getAreaNo() + "],小区编码为["+
			 * laneInformation.getParkNo() + "],大门编码为["+
			 * laneInformation.getGateNo() + "],车道编码为["+
			 * laneInformation.getLaneNo() + "]的车道信息和有用车道成功","添加车道信息、有用车道",
			 * "tb_Lane,tb_LaneUse");
			 * 
			 * }else{
			 */
			systemLogService.save(new Date(), 1, getCurrentOperator(), "[" + this.getCurrentOperator().getId() + "]" + this.getCurrentOperator().getUsername() + "用户添加区域编码为[" + laneInformation.getAreaNo() + "],小区编码为[" + laneInformation.getParkNo() + "],大门编码为[" + laneInformation.getGateNo() + "],车道编码为[" + laneInformation.getLaneNo() + "]的车道信息成功", "添加车道信息", "tb_Lane");
			result = Result.SUCCESS;
			liTemp = null;

		}

		/*
		 * } else { return "lane_add"; }
		 */
		return lane_list();
	}

	/**
	 * 转向车道信息修改页面
	 * @return
	 */
	public String lane_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		session.removeAttribute("laneComputerIp");
		
		laneInformation = laneInformationService.LoadLaneInfo(laneInformation.getAreaNo(), laneInformation.getParkNo(),laneInformation.getGateNo(), laneInformation.getLaneNo()).get(0);
		session.setAttribute("laneComputerIp", laneInformation.getLaneComputerIp());
		return "lane_edit";
	}

	/**
	 *  修改车道信息
	 * @return
	 */
	public String updateLaneInfo() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		gateList=gatewayInformationService.findGatewayInformation();
		
		LaneInformation liTemp=new LaneInformation();
		liTemp.setAreaNo(laneInformation.getAreaNo());
		liTemp.setGateNo(laneInformation.getGateNo());
		liTemp.setParkNo(laneInformation.getParkNo());
		liTemp.setLaneNo(laneInformation.getLaneNo());
		liTemp.setLaneTypeNo(laneInformation.getLaneTypeNo());
		liTemp.setLaneComputerIp(laneInformation.getLaneComputerIp().trim());
		liTemp.setLaneComputerName(laneInformation.getLaneComputerName().trim());
		liTemp.setIsUse(laneInformation.getIsUse());
		
		if(!session.getAttribute("laneComputerIp").toString().trim().equals(liTemp.getLaneComputerIp())){
			
			//修改车道信息
			laneInformationService.update(liTemp);
			
			if(laneUseService.ishasLaneUse(liTemp.getAreaNo(), liTemp.getParkNo(), liTemp.getGateNo(), liTemp.getLaneNo())!=null
					&&laneUseService.ishasLaneUseIP(liTemp.getLaneComputerIp())==null){
				LaneUse luTemp=new LaneUse();
				luTemp.setAreaNo(liTemp.getAreaNo());
				luTemp.setGateNo(liTemp.getGateNo());
				luTemp.setParkNo(liTemp.getParkNo());
				luTemp.setLaneNo(liTemp.getLaneNo());
				luTemp.setLaneComputerIp(liTemp.getLaneComputerIp());
				
				/*short isUse=laneUseService.LoadLaneUse(liTemp.getAreaNo(), liTemp.getParkNo(), liTemp.getGateNo(), liTemp.getLaneNo()).get(0).getIsUse();
			
				luTemp.setIsUse(isUse);*/
				laneUseService.update(luTemp);
				luTemp=null;
				
				/*systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为[" + laneInformation.getAreaNo() + "],小区编码为["+ laneInformation.getParkNo() + "],大门编码为["+ laneInformation.getGateNo() + "],车道编码为["+ laneInformation.getLaneNo() + "]的车道信息和有用车道成功", "修改车道信息,有用车道","tb_Lane,tb_LaneUse");*/

			}else{
				systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为[" + laneInformation.getAreaNo() + "],小区编码为["+ laneInformation.getParkNo() + "],大门编码为["+ laneInformation.getGateNo() + "],车道编码为["+ laneInformation.getLaneNo() + "]的车道信息成功", "修改车道信息","tb_Lane");

			}
			
			message="updateSuccess";
			session.removeAttribute("laneComputerIp");
			list = laneInformationService.findByPager(pager);
			liTemp=null;
			return "lane_list";
			
//			if(laneInformationService.ishasLaneIP(liTemp.getLaneComputerIp())==null){
//				//修改车道信息
//				laneInformationService.update(liTemp);
//				
//				if(laneUseService.ishasLaneUse(liTemp.getAreaNo(), liTemp.getParkNo(), liTemp.getGateNo(), liTemp.getLaneNo())!=null
//						&&laneUseService.ishasLaneUseIP(liTemp.getLaneComputerIp())==null){
//					LaneUse luTemp=new LaneUse();
//					luTemp.setAreaNo(liTemp.getAreaNo());
//					luTemp.setGateNo(liTemp.getGateNo());
//					luTemp.setParkNo(liTemp.getParkNo());
//					luTemp.setLaneNo(liTemp.getLaneNo());
//					luTemp.setLaneComputerIp(liTemp.getLaneComputerIp());
//					
//					short isUse=laneUseService.LoadLaneUse(liTemp.getAreaNo(), liTemp.getParkNo(), liTemp.getGateNo(), liTemp.getLaneNo()).get(0).getIsUse();
//				
//					luTemp.setIsUse(isUse);
//					laneUseService.update(luTemp);
//					luTemp=null;
//					
//					systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为[" + laneInformation.getAreaNo() + "],小区编码为["+ laneInformation.getParkNo() + "],大门编码为["+ laneInformation.getGateNo() + "],车道编码为["+ laneInformation.getLaneNo() + "]的车道信息和有用车道成功", "修改车道信息,有用车道","tb_Lane,tb_LaneUse");
//
//				}else{
//					systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为[" + laneInformation.getAreaNo() + "],小区编码为["+ laneInformation.getParkNo() + "],大门编码为["+ laneInformation.getGateNo() + "],车道编码为["+ laneInformation.getLaneNo() + "]的车道信息成功", "修改车道信息","tb_Lane");
//
//				}
//				
//				message="updateSuccess";
//				session.removeAttribute("laneComputerIp");
//				list = laneInformationService.findByPager(pager);
//				liTemp=null;
//				return "lane_list";
//			}else{
//				message="exitIP";
//				liTemp=null;
//				return "lane_edit";
//			}
		}else{
			laneInformationService.update(liTemp);
			message="updateSuccess";
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为[" + laneInformation.getAreaNo() + "],小区编码为["+ laneInformation.getParkNo() + "],大门编码为["+ laneInformation.getGateNo() + "],车道编码为["+ laneInformation.getLaneNo() + "]的车道信息成功", "修改车道信息","tb_Lane");
			
			session.removeAttribute("laneComputerIp");
			list = laneInformationService.findByPager(pager);
			liTemp=null;
			return "lane_list";
		}
		
	}
	
	/**
	 * 设置一条车道是否启用合计
	 * @return
	 */
	public String lane_isUse() {
		laneInformation = laneInformationService.LoadLaneInfo(laneInformation.getAreaNo(), laneInformation.getParkNo(),laneInformation.getGateNo(), laneInformation.getLaneNo()).get(0);
		if(laneInformation.getIsUse() == 1) {
			laneInformation.setIsUse(0);
		} else {
			laneInformation.setIsUse(1);
		}
		laneInformationService.update(laneInformation);
		message = "updateSuccess";
		return lane_list();
	}
	/**
	 * 设置车道全部启用合计
	 * @return
	 */
	public String lane_allUse() {
		laneInformationService.allUse();
		message = "updateSuccess";
		return lane_list();
	}
	/**
	 * 设置车道全部不启用合计
	 * @return
	 */
	public String lane_allNotUse() {
		laneInformationService.allNotUse();
		message = "updateSuccess";
		return lane_list();
	}

	/**
	 *  删除一条车道信息
	 * @return
	 */
	public String lane_delete() {
		laneInformationService.deleteBylaneInfo(laneInformation.getAreaNo(),laneInformation.getParkNo(), laneInformation.getGateNo(),laneInformation.getLaneNo());
		
		if(laneUseService.LoadLaneUse(laneInformation.getAreaNo(),laneInformation.getParkNo(), laneInformation.getGateNo(),laneInformation.getLaneNo())!=null){
			laneUseService.deleteBylaneUse(laneInformation.getAreaNo(),laneInformation.getParkNo(), laneInformation.getGateNo(),laneInformation.getLaneNo());
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除区域编码为[" + laneInformation.getAreaNo() + "],小区编码为["+ laneInformation.getParkNo() + "],大门编码为["+ laneInformation.getGateNo() + "],车道编码为["+ laneInformation.getLaneNo() + "]的车道信息和有用车道成功", "删除车道信息,有用车道","tb_Lane,tb_LaneUse");

		}else{
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除区域编码为[" + laneInformation.getAreaNo() + "],小区编码为["+ laneInformation.getParkNo() + "],大门编码为["+ laneInformation.getGateNo() + "],车道编码为["+ laneInformation.getLaneNo() + "]的车道信息成功", "删除车道信息","tb_Lane");

		}
		message="deleteSuccess";
		return lane_list();
	}

	public void ishasLaneNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == laneInformationService.ishasLaneNo(laneInformation
				.getLaneNo())) {
			out.print("noLaneNo");
		} else {
			out.print("hasLaneNo");
		}
	}
	public void ishasLaneIP() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == laneInformationService.ishasLaneIP(laneInformation
				.getLaneComputerIp())) {
			out.print("noLaneIP");
		} else {
			out.print("hasLaneIP");
		}
	}
	

	
	/**
	 * 有用车道信息
	 ***************************************************************************************************
	 * */
	
	public String laneUse_list() {	
		gateList=gatewayInformationService.findGatewayInformation();
		list = laneInformationService.findLaneInformation();
	//	list = laneUseService.findLaneUse();
		return "laneUse_list";
	}
	public String addLaneUse(){//设置车道为有用车道
		LaneInformation laneInformationTemp =new LaneInformation();
		laneInformationTemp = laneInformationService.getLaneInfoByAPGL(laneUse.getAreaNo(), laneUse.getParkNo(), laneUse.getGateNo(), laneUse.getLaneNo());
		if(laneInformationTemp!=null){
			LaneUse lanUseTemp = new LaneUse();
			lanUseTemp.setAreaNo(laneInformationTemp.getAreaNo());
			lanUseTemp.setGateNo(laneInformationTemp.getGateNo());
			lanUseTemp.setParkNo(laneInformationTemp.getParkNo());
			lanUseTemp.setLaneNo(laneInformationTemp.getLaneNo());
			lanUseTemp.setLaneComputerIp(laneInformationTemp.getLaneComputerIp());
			laneUseService.deleteLaneUseByAPGL(laneUse.getAreaNo(), laneUse.getParkNo(), laneUse.getGateNo(), laneUse.getLaneNo());
			laneUseService.save(lanUseTemp);
			
		}
		gateList=gatewayInformationService.findGatewayInformation();
		list = laneInformationService.findLaneInformation();
		result = Result.SUCCESS;
		return "laneUse_list";
	}
	public String deleteLaneUse(){	//设置车道为没用车道
		laneUseService.deleteLaneUseByAPGL(laneUse.getAreaNo(), laneUse.getParkNo(), laneUse.getGateNo(), laneUse.getLaneNo());
		gateList=gatewayInformationService.findGatewayInformation();
		list = laneInformationService.findLaneInformation();
		result = Result.SUCCESS;
		return "laneUse_list";
	}
   public String addAllLaneUse(){//设置全部车道为启用车道
	   laneUseService.deleteAllLaneUse();
	   laneUseService.insertLaneUseByLane();
	   gateList=gatewayInformationService.findGatewayInformation();
	   list = laneInformationService.findLaneInformation();
	   result = Result.SUCCESS;
	   return "laneUse_list";
	   
   }
   public String deleteAllLaneUse(){//设置全部车道为没用车道
	   laneUseService.deleteAllLaneUse();
	   list = laneInformationService.findLaneInformation();
	   gateList=gatewayInformationService.findGatewayInformation();
	   result = Result.SUCCESS;
	   return "laneUse_list"; 
   }

	public String laneUse_add() {
		return "laneUse_add";
	}

	/*public String saveLaneUse() {
		if (laneUseService.ishasLaneUse(laneUse.getAreaNo(),laneUse.getParkNo(), laneUse.getGateNo(),laneUse.getLaneNo()) == null) {
			
			LaneUse luTemp=new LaneUse();
			luTemp.setAreaNo(laneUse.getAreaNo());
			luTemp.setParkNo(laneUse.getParkNo());
			luTemp.setGateNo(laneUse.getGateNo());
			luTemp.setLaneNo(laneUse.getLaneNo());
			luTemp.setLaneComputerIp(laneUse.getLaneComputerIp().trim());
			luTemp.setIsUse(laneUse.getIsUse());
			
			laneUseService.save(luTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加区域编码为[" + laneUse.getAreaNo() + "],小区编码为["+ laneUse.getParkNo() + "],大门编码为["+ laneUse.getGateNo() + "],车道编码为["+ laneUse.getLaneNo() + "]的有用车道成功","添加有用车道", "tb_LaneUse");
			luTemp=null;
		} else {
			return "laneUse_add";
		}
		return laneUse_list();
	}

	public String laneUse_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		session.removeAttribute("laneUseComputerIp");
		
		laneUse = laneUseService.LoadLaneUse(laneUse.getAreaNo(), laneUse.getParkNo(),laneUse.getGateNo(), laneUse.getLaneNo()).get(0);
		session.setAttribute("laneUseComputerIp", laneUse.getLaneComputerIp());
		return "laneUse_edit";
	}


	public String updateLaneUse() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		gateList=gatewayInformationService.findGatewayInformation();
		
		if(!session.getAttribute("laneUseComputerIp").toString().trim().equals(laneUse.getLaneComputerIp().trim())){
			if(laneUseService.ishasLaneUseIP(laneUse.getLaneComputerIp())==null){
			
				LaneUse luTemp=new LaneUse();
				luTemp.setAreaNo(laneUse.getAreaNo());
				luTemp.setParkNo(laneUse.getParkNo());
				luTemp.setGateNo(laneUse.getGateNo());
				luTemp.setLaneNo(laneUse.getLaneNo());
				luTemp.setLaneComputerIp(laneUse.getLaneComputerIp().trim());
				luTemp.setIsUse(laneUse.getIsUse());
				
				laneUseService.update(luTemp);
				message="updateSuccess";
				systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为[" + laneUse.getAreaNo() + "],小区编码为["+ laneUse.getParkNo() + "],大门编码为["+ laneUse.getGateNo() + "],车道编码为["+ laneUse.getLaneNo() + "]的有用车道成功", "修改有用车道","tb_LaneUse");
				luTemp=null;
				session.removeAttribute("laneUseComputerIp");
				list = laneUseService.findByPager(pager);
				return "laneUse_list";
			}else{
				message="exitIP";
				return "laneUse_edit";
			}
		}else{
			LaneUse luTemp=new LaneUse();
			luTemp.setAreaNo(laneUse.getAreaNo());
			luTemp.setParkNo(laneUse.getParkNo());
			luTemp.setGateNo(laneUse.getGateNo());
			luTemp.setLaneNo(laneUse.getLaneNo());
			luTemp.setLaneComputerIp(laneUse.getLaneComputerIp().trim());
			luTemp.setIsUse(laneUse.getIsUse());
			
			laneUseService.update(luTemp);
			message="updateSuccess";
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改区域编码为[" + laneUse.getAreaNo() + "],小区编码为["+ laneUse.getParkNo() + "],大门编码为["+ laneUse.getGateNo() + "],车道编码为["+ laneUse.getLaneNo() + "]的有用车道成功", "修改有用车道","tb_LaneUse");
			luTemp=null;
			session.removeAttribute("laneUseComputerIp");
			list = laneUseService.findByPager(pager);
			return "laneUse_list";
		}
		
	}


	public String laneUse_delete() {
		laneUseService.deleteBylaneUse(laneUse.getAreaNo(),laneUse.getParkNo(), laneUse.getGateNo(),laneUse.getLaneNo());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除区域编码为[" + laneUse.getAreaNo() + "],小区编码为["+ laneUse.getParkNo() + "],大门编码为["+ laneUse.getGateNo() + "],车道编码为["+ laneUse.getLaneNo() + "]的有用车道成功", "删除有用车道","tb_LaneUse");

		return laneUse_list();
	}
*/
	public void ishasLaneUseNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == laneUseService.ishasLaneUseNo(laneUse.getLaneNo())) {
			out.print("noLaneUseNo");
		} else {
			out.print("hasLaneUseNo");
		}
	}
	public void ishasLaneUseIP() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == laneUseService.ishasLaneUseIP(laneUse
				.getLaneComputerIp())) {
			out.print("noLaneUseIP");
		} else {
			out.print("hasLaneUseIP");
		}
	}
	
	
	/**
	 * 工班信息
	 ***************************************************************************************************
	 * */


	/**
	 * 工班信息首页面
	 */
	public String squad_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list = squadInformationService.findByPager(pager);
		return "squad_list";
	}

	/**
	 * 转向工班信息添加页面
	 * @return
	 */
	public String squad_add() {
		return "squad_add";
	}

	/**
	 * 添加工班信息
	 * @return
	 */
	public String saveSquadInfo() {

		if (null != squadInformationService.ishasSquadNo(squadInformation.getSquadNo())) {
			return "squad_add";	
		} else if (null != squadInformationService.findSquadByName(squadInformation.getSquadName())) {
			return "squad_add";
		} else {
			
			SquadInformation siTemp=new SquadInformation();
			siTemp.setSquadNo(squadInformation.getSquadNo());
			siTemp.setSquadName(squadInformation.getSquadName().trim());
			siTemp.setStartTime(squadInformation.getStartTime().trim());
			siTemp.setEndTime(squadInformation.getEndTime().trim());
			siTemp.setStartDate(squadInformation.getStartDate());
			siTemp.setRemark(squadInformation.getRemark().trim());
			siTemp.setTimeDiff(squadInformation.getTimeDiff());
			
			squadInformationService.save(siTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加工班编号为[" + squadInformation.getSquadNo() + "]的工班信息成功","添加工班信息", "tb_Squad");
			
			siTemp=null;
		}
		return squad_list();
	}

	/**
	 * 转向工班信息修改页面
	 * @return
	 */
	public String squad_edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		squadInformation = squadInformationService.load(squadInformation.getSquadNo());
		return "squad_edit";
	}

	/**
	 * 修改工班信息
	 * @return
	 */
	public String updateSquadInfo() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		if(squadInformationService.findSquadNameByNoThisSquadNo(squadInformation.getSquadNo(), squadInformation.getSquadName())){
			result = Result.FAIL;
			return "squad_edit";
		}
		
		SquadInformation siTemp=new SquadInformation();
		siTemp.setSquadNo(squadInformation.getSquadNo());
		siTemp.setSquadName(squadInformation.getSquadName().trim());
		siTemp.setStartTime(squadInformation.getStartTime().trim());
		siTemp.setEndTime(squadInformation.getEndTime().trim());
		siTemp.setStartDate(squadInformation.getStartDate());
		siTemp.setRemark(squadInformation.getRemark().trim());
		siTemp.setTimeDiff(squadInformation.getTimeDiff());
		
		squadInformationService.update(siTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改工班编号为["+ squadInformation.getSquadNo() + "]的工班信息成功", "修改工班信息","tb_Squad");

		list = squadInformationService.findByPager(pager);
		
		siTemp=null;
		return "squad_list";
	}

	/**
	 * 删除一条工班信息
	 * @return
	 */
	public String squad_delete() {
		squadInformationService.delete(squadInformation.getSquadNo());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除工班编号为["
				+ squadInformation.getSquadNo() + "]的工班信息成功", "删除工班信息",
				"tb_Squad");

		list = squadInformationService.findByPager(pager);
		return "squad_list";
	}

	public void ishasSquadNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == squadInformationService.ishasSquadNo(squadInformation
				.getSquadNo())) {
			out.print("noSquadNo");
		} else {
			out.print("hasSquadNo");
		}
	}

	//验证工班名是否存在
	public void getSquadByName() {
		SquadInformation squadInfo = squadInformationService.findSquadByName(squadInformation.getSquadName());
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == squadInfo) {
			out.print("success");
		} else {
			out.print("fail");
		}
	}

	
	
	/**
	 * 补光灯时间信息 
	 ***************************************************************************************************
	 * */


	public String supplyLight_list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list = supplyLightInformationService.findByPager(pager);
		return "supplyLight_list";
	}

	/**
	 * 转向补光灯时间信息添加页面
	 * @return
	 */
	public String supplyLight_add() {
		return "supplyLight_add";
	}

	/**
	 * 添加补光灯信息
	 * @return
	 */
	public String saveSupplyLight() {
		if (supplyLightInformationService.ishasStartTime(supplyLightInformation.getStartTime()) == null) {
			
			SupplyLightInformation siTemp=new SupplyLightInformation();
			siTemp.setStartTime(supplyLightInformation.getStartTime().trim());
			siTemp.setEndTime(supplyLightInformation.getEndTime().trim());
			
			supplyLightInformationService.save(siTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加补光灯开始时间为[" + supplyLightInformation.getStartTime()+ "]的补光灯信息成功", "添加补光灯信息", "tb_Supplylight");

			siTemp=null;
			
		} else {
			message = "hasSupplyLight";
			return "supplyLight_add";
		}
		return supplyLight_list();
	}

	/**
	 * 转向补光灯时间信息添加页面
	 * @return
	 */
	public String supplyLight_edit() {
		supplyLightInformation = supplyLightInformationService.load(supplyLightInformation.getStartTime());
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		session.setAttribute("startTime", supplyLightInformation.getStartTime());
		
		return "supplyLight_edit";
	}

	/**
	 * 修改一条补光灯信息
	 * @return
	 */
	public String updateSupplyLight() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		supplyLightInformation.setStartTime(session.getAttribute("startTime").toString());
		
		SupplyLightInformation siTemp=new SupplyLightInformation();
		siTemp.setStartTime(supplyLightInformation.getStartTime().trim());
		siTemp.setEndTime(supplyLightInformation.getEndTime().trim());
		
		supplyLightInformationService.update(siTemp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改补光灯开始时间为[" + supplyLightInformation.getStartTime()+ "]的补光灯信息成功", "修改补光灯信息", "tb_Supplylight");

		list = supplyLightInformationService.findByPager(pager);
		
		siTemp=null;
		return "supplyLight_list";
	}

	/**
	 * 删除一条补光灯信息
	 * @return
	 */
	public String supplyLight_delete() {

		supplyLightInformationService.delete(supplyLightInformation.getStartTime());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除补光灯开始时间为[" + supplyLightInformation.getStartTime()+ "]的补光灯信息成功", "删除补光灯信息", "tb_Supplylight");

		return supplyLight_list();
	}

	/**
	 * 异步根据区域编码获取小区信息
	 */
	public String ajaxInitPark(){

		HttpServletResponse response = ServletActionContext.getResponse();
		List<ParkInformation> tempList = parkInformationService.getAllParkInformationByAreaNo(Short.parseShort(this.areaNo.trim()));

		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<parks>");
		for (int i = 0; i < tempList.size(); i++) {
			ParkInformation information = (ParkInformation) tempList.get(i);
			pw.print("<park id='" + information.getParkNo() + "' name='" + information.getParkName() + "' />");
		}
		pw.print("</parks>");
		return null;
	}
	
	/**
	 * 异步根据小区编码获取大门信息
	 * @return
	 */

	public String ajaxInitGate(){	
		HttpServletResponse response = ServletActionContext.getResponse();
		
		List<GatewayInformation> tempList = gatewayInformationService.getGatewayInformationByParkNo(Short.parseShort(this.parkNo.trim()));
		
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<gates>");
		for (int i = 0; i < tempList.size(); i++) {
			GatewayInformation information = (GatewayInformation) tempList.get(i);
			pw.print("<gate id='" + information.getGateNo() + "' name='" + information.getGateName() + "' />");
		}
		pw.print("</gates>");
		return null;
	}
	
	
	//转码方法
	public String getGBKSting(String str){
		String getString=null;
		try {
		    getString= new String(str.getBytes("ISO8859-1"),"GBK");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return getString;
	}
	
	// Getter/Setter方法
	public CityInformation getCityInformation() {
		return cityInformation;
	}

	public void setCityInformation(CityInformation cityInformation) {
		this.cityInformation = cityInformation;
	}

	public AreaInformation getAreaInformation() {
		return areaInformation;
	}

	public void setAreaInformation(AreaInformation areaInformation) {
		this.areaInformation = areaInformation;
	}

	public ParkInformation getParkInformation() {
		return parkInformation;
	}

	public void setParkInformation(ParkInformation parkInformation) {
		this.parkInformation = parkInformation;
	}

	public CarSpaceInformation getCarSpaceInformation() {
		return carSpaceInformation;
	}

	public void setCarSpaceInformation(CarSpaceInformation carSpaceInformation) {
		this.carSpaceInformation = carSpaceInformation;
	}

	public PositionInformation getPositionInformation() {
		return positionInformation;
	}

	public void setPositionInformation(PositionInformation positionInformation) {
		this.positionInformation = positionInformation;
	}

	public GatewayInformation getGatewayInformation() {
		return gatewayInformation;
	}

	public void setGatewayInformation(GatewayInformation gatewayInformation) {
		this.gatewayInformation = gatewayInformation;
	}

	public LaneInformation getLaneInformation() {
		return laneInformation;
	}

	public void setLaneInformation(LaneInformation laneInformation) {
		this.laneInformation = laneInformation;
	}

	public SquadInformation getSquadInformation() {
		return squadInformation;
	}

	public void setSquadInformation(SquadInformation squadInformation) {
		this.squadInformation = squadInformation;
	}

	public SupplyLightInformation getSupplyLightInformation() {
		return supplyLightInformation;
	}

	public void setSupplyLightInformation(
			SupplyLightInformation supplyLightInformation) {
		this.supplyLightInformation = supplyLightInformation;
	}
	public String getAreaNo() {
		return areaNo;
	}

	public String getParkNo() {
		return parkNo;
	}

	public void setAreaNo(String areaNo) {
		this.areaNo = areaNo;
	}

	public void setParkNo(String parkNo) {
		this.parkNo = parkNo;
	}
	public List<GatewayInformation> getGateList() {
		return gateList;
	}
	public void setGateList(List<GatewayInformation> gateList) {
		this.gateList = gateList;
	}
	public List<ParkInformation> getParkList() {
		return parkList;
	}

	public void setParkList(List<ParkInformation> parkList) {
		this.parkList = parkList;
	}
	public List<GatewayInformation> getGatewayList() {
		return gatewayList;
	}

	public void setGatewayList(List<GatewayInformation> gatewayList) {
		this.gatewayList = gatewayList;
	}
}
