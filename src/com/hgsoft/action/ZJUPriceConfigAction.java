package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.FeeRuleTypeDef;
import com.hgsoft.entity.FreeDays;
import com.hgsoft.entity.InOutSignDef;
import com.hgsoft.entity.PriceRule_zd;
import com.hgsoft.entity.TimesSignDef;
import com.hgsoft.entity.VehFreeTimes;

import com.hgsoft.entity.ZJU_PriceBase;
import com.hgsoft.service.FeeRuleTypeDefService;
import com.hgsoft.service.FreeDaysService;
import com.hgsoft.service.InOutSignDefService;
import com.hgsoft.service.PriceRule_zdService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.TimesSignDefService;
import com.hgsoft.service.VehFreeTimesService;

import com.hgsoft.service.ZJU_PriceBaseService;

/**
 * --zd费率--
 * @author qinzuohai
 */
@Controller
@Scope("prototype")
public class ZJUPriceConfigAction extends BaseAction{
	@Resource
	private SystemLogService systemLogService; 
	private HttpSession session;
	private String freeWeek;
	@Resource
	private FeeRuleTypeDefService feeRuleTypeDefService;
	private FeeRuleTypeDef feeRuleTypeDef;
	
	@Resource
	private FreeDaysService freeDaysService;
	private FreeDays freeDays;
	
	

	@Resource
	private InOutSignDefService inOutSignDefService;
	private InOutSignDef inOutSignDef;
	
	@Resource
	private TimesSignDefService timesSignDefService;
	private TimesSignDef timesSignDef;

	@Resource
	private VehFreeTimesService vehFreeTimesService;
	private VehFreeTimes vehFreeTimes;
	
	
	@Resource
	private PriceRule_zdService priceRule_zdService;
	private PriceRule_zd priceRule_zd;

	@Resource
	private ZJU_PriceBaseService zju_PriceBaseService ;
	private ZJU_PriceBase zju_PriceBase;


	/**
	 * 收费类型  Start
	 */
	public String feeRuleTypeDef_list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list=feeRuleTypeDefService.findByPager(pager);
		return "feeRuleTypeDef_list";
	}
	
	public String feeRuleTypeDef_add(){
		return "feeRuleTypeDef_add";
	}
	
	public String saveFeeRuleTypeDef() {
		if (feeRuleTypeDefService.ishasFeeRuleType(feeRuleTypeDef
				.getFeeRuleType()) != null) {
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加时已存在收费类型为["+feeRuleTypeDef.getFeeRuleType()+"]收费类型信息，添加失败", "添加收费类型信息", "tb_FeeRuleTypeDef");
			return "feeRuleTypeDef_add";
		} 
		else if(feeRuleTypeDefService.ishasName(feeRuleTypeDef
				.getName()) != null){
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加时已存在车辆类别名为["+feeRuleTypeDef.getName()+"]收费类型信息，添加失败", "添加收费类型信息", "tb_FeeRuleTypeDef");
			return "feeRuleTypeDef_add";
		}
		else {
			
			FeeRuleTypeDef ftTemp=new FeeRuleTypeDef();
			ftTemp.setFeeRuleType(feeRuleTypeDef.getFeeRuleType());
			ftTemp.setName(feeRuleTypeDef.getName().trim());
			
			feeRuleTypeDefService.save(ftTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加收费类型为["+feeRuleTypeDef.getFeeRuleType()+"]收费类型信息成功", "添加收费类型信息", "tb_FeeRuleTypeDef");
			ftTemp=null;
		}

		return feeRuleTypeDef_list();
	}
	
	public String feeRuleTypeDef_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		feeRuleTypeDef=feeRuleTypeDefService.LoadFeeRuleTypeDef(feeRuleTypeDef.getFeeRuleType()).get(0);
		return "feeRuleTypeDef_edit";
	}
	
	public String updateFeeRuleTypeDef() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		FeeRuleTypeDef ftTemp=new FeeRuleTypeDef();
		ftTemp.setFeeRuleType(feeRuleTypeDef.getFeeRuleType());
		ftTemp.setName(feeRuleTypeDef.getName().trim());
		
		feeRuleTypeDefService.update(ftTemp);
		message="updateSuccess";

		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改收费类型为["+feeRuleTypeDef.getFeeRuleType()+"]收费类型信息成功", "修改收费类型信息", "tb_FeeRuleTypeDef");
		
		list=feeRuleTypeDefService.findByPager(pager);
		ftTemp=null;
		return "feeRuleTypeDef_list";
	}
	
	public String feeRuleTypeDef_delete(){
		feeRuleTypeDefService.deleteByFeeRuleType(feeRuleTypeDef.getFeeRuleType());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除收费类型为["+feeRuleTypeDef.getFeeRuleType()+"]收费类型信息成功", "删除收费类型信息", "tb_FeeRuleTypeDef");
		
		return feeRuleTypeDef_list();
	}
	
	//验证收费类型是否存在
	public void ishasFeeRuleType() {
		FeeRuleTypeDef _feeRuleTypeDef = feeRuleTypeDefService.ishasFeeRuleType(feeRuleTypeDef.getFeeRuleType()).get(0);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (_feeRuleTypeDef==null) {
			out.print("noFeeRuleType");
		} else {
			out.print("hasFeeRuleType");
		}
	}
	//验证车辆类别名是否存在
	public void ishasName() {
		FeeRuleTypeDef _feeRuleTypeDef = feeRuleTypeDefService.ishasName(feeRuleTypeDef.getName()).get(0);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (_feeRuleTypeDef==null) {
			out.print("noName");
		} else {
			out.print("hasName");
		}
	}
	
	/**
	 * 收费类型  End
	 */

	/**
	 * 免费日期Start
	 */
	public String freeDays_list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list=freeDaysService.findByPager(pager);
		return "freeDays_list";
	}
	
	public String freeDays_add(){
		return "freeDays_add";
	}
	
	public String saveFreeDays() {
		if(String.valueOf(freeDays.getType()).equals("0")){
			//System.out.println(freeWeek);
			//int week=Integer.valueOf(freeWeek.toString().trim());
			/*String weeks=null;
			switch (week) {
			case 1:weeks="星期一";break;
			case 2:weeks="星期二";break;
			case 3:weeks="星期三";break;
			case 4:weeks="星期四";break;
			case 5:weeks="星期五";break;
			case 6:weeks="星期六";break;
			case 7:weeks="星期日";break;
			}*/
			//System.out.println(weeks);
			freeDays.setValue(freeWeek);
		}
		if (freeDaysService.ishasFreeDays(freeDays.getFeeRuleType(),freeDays.getType(),freeDays.getValue()) != null) {
			message="hasFreeDays";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加时已存在收费类型为["+freeDays.getFeeRuleType()+"]免费日期信息，添加失败", "添加免费日期信息", "tb_FreeDays");
			return "freeDays_add";
		} else {
			freeDaysService.save(freeDays);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加收费类型为["+freeDays.getFeeRuleType()+"]免费日期信息成功", "添加免费日期信息", "tb_FreeDays");
			
		}

		return freeDays_list();
	}
	
	public String freeDays_edit(){
		freeDays=freeDaysService.LoadFreeDays(freeDays.getFeeRuleType(),freeDays.getType(),freeDays.getValue()).get(0);
		HttpServletRequest request = ServletActionContext.getRequest();
		session=request.getSession();
		session.setAttribute("_FeeRuleType", freeDays.getFeeRuleType());
		session.setAttribute("_Type", freeDays.getType());
		session.setAttribute("_Value", freeDays.getValue());
		
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		return "freeDays_edit";
	}
	
	public String updateFreeDays() {
		HttpServletRequest request = ServletActionContext.getRequest();
		session=request.getSession();
		
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		if(String.valueOf(freeDays.getType()).equals("0")){

			//int week=Integer.valueOf(freeWeek.toString().trim());
			/*String weeks=null;
			switch (week) {
			case 1:weeks="星期一";break;
			case 2:weeks="星期二";break;
			case 3:weeks="星期三";break;
			case 4:weeks="星期四";break;
			case 5:weeks="星期五";break;
			case 6:weeks="星期六";break;
			case 7:weeks="星期日";break;
			}*/
			//System.out.println(weeks);
			freeDays.setValue(freeWeek);
		}
		//System.out.println(freeDays.getFeeRuleType()+"--"+freeDays.getType()+"--"+freeDays.getValue());
		
		freeDaysService._update(freeDays,session.getAttribute("_FeeRuleType"),session.getAttribute("_Type"),session.getAttribute("_Value"));
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改收费类型为["+freeDays.getFeeRuleType()+"]免费日期信息成功", "修改免费日期信息", "tb_FreeDays");
		
		list=freeDaysService.findByPager(pager);
		return "freeDays_list";
	}
	
	public String freeDays_delete(){
		freeDaysService.deleteByFeeRuleType(freeDays.getFeeRuleType(),freeDays.getType(),freeDays.getValue());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除收费类型为["+freeDays.getFeeRuleType()+"]免费日期信息成功", "删除免费日期信息", "tb_FreeDays");
		
		return freeDays_list();
	}
	
	/*//验证免费日期是否存在
	public void ishasFreeDays() {
		FreeDays _freeDays = freeDaysService.ishasFreeDays(freeDays.getFeeRuleType(),freeDays.getType(),freeDays.getValue()).get(0);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (_freeDays==null) {
			out.print("noFreeDays");
		} else {
			out.print("hasFreeDays");
		}
	}*/
	/**
	 * 免费日期  End
	 */
	
	
	/**
	 * 出入口标志Start
	 */
	public String inOutSignDef_list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list=inOutSignDefService.findByPager(pager);
		return "inOutSignDef_list";
	}
	
	public String inOutSignDef_add(){
		return "inOutSignDef_add";
	}
	
	public String saveInOutSignDef() {
		if (inOutSignDefService.ishasInOutSignDef(inOutSignDef.getInGateNo(),inOutSignDef.getOutGateNo()) != null) {
			message = "hasInOutSignDef";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加时已存在入口大门编码为["+inOutSignDef.getInGateNo()+"]_出口大门编码为["+inOutSignDef.getOutGateNo()+"]出入口标志信息，添加失败", "添加出入口标志信息", "tb_InOutSignDef");
			
			return "inOutSignDef_add";
		} else {
			inOutSignDefService.save(inOutSignDef);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加入口大门编码为["+inOutSignDef.getInGateNo()+"]_出口大门编码为["+inOutSignDef.getOutGateNo()+"]出入口标志信息成功", "添加出入口标志信息", "tb_InOutSignDef");
		
		}

		return inOutSignDef_list();
	}
	
	public String inOutSignDef_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		inOutSignDef=inOutSignDefService.LoadInOutSignDef(inOutSignDef.getInGateNo(),inOutSignDef.getOutGateNo()).get(0);
		return "inOutSignDef_edit";
	}
	
	public String updateInOutSignDef() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		inOutSignDefService.update(inOutSignDef);
		message="updateSuccess";

		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改入口大门编码为["+inOutSignDef.getInGateNo()+"]_出口大门编码为["+inOutSignDef.getOutGateNo()+"]出入口标志信息成功", "修改出入口标志信息", "tb_InOutSignDef");
		
		list=inOutSignDefService.findByPager(pager);
		return "inOutSignDef_list";
	}
	
	public String inOutSignDef_delete(){
		inOutSignDefService.deleteByCompositeID(inOutSignDef.getInGateNo(),inOutSignDef.getOutGateNo());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除入口大门编码为["+inOutSignDef.getInGateNo()+"]_出口大门编码为["+inOutSignDef.getOutGateNo()+"]出入口标志信息成功", "删除出入口标志信息", "tb_InOutSignDef");
		
		return inOutSignDef_list();
	}
	/**
	 * 出入口标志  End
	 */
	
	/**
	 * 时间标志Start
	 */
	public String timesSignDef_list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list=timesSignDefService.findByPager(pager);
		return "timesSignDef_list";
	}
	
	public String timesSignDef_add(){
		return "timesSignDef_add";
	}
	
	public String saveTimesSignDef() {
		if (timesSignDefService.ishasTimesSignDef(timesSignDef.getFeeRuleType(),timesSignDef.getDayType(),timesSignDef.getStartTime()) == null) {
			timesSignDefService.save(timesSignDef);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加收费类型为["+timesSignDef.getFeeRuleType()+"]_开始时间为["+timesSignDef.getStartTime()+"]时间标志信息成功", "添加时间标志信息", "tb_TimesSignDef");
			
		} else {
			message = "hasTimesSignDef";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加时已存在收费类型为["+timesSignDef.getFeeRuleType()+"]_开始时间为["+timesSignDef.getStartTime()+"]时间标志信息，添加失败", "添加时间标志信息", "tb_TimesSignDef");
			
			return "timesSignDef_add";
		}

		return timesSignDef_list();
	}
	
	public String timesSignDef_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		timesSignDef=timesSignDefService.LoadTimesSignDef(timesSignDef.getFeeRuleType(),timesSignDef.getDayType(),timesSignDef.getStartTime()).get(0);
		return "timesSignDef_edit";
	}
	
	public String updateTimesSignDef() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		timesSignDefService.update(timesSignDef);
		message="updateSuccess";

		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改收费类型为["+timesSignDef.getFeeRuleType()+"]_开始时间为["+timesSignDef.getStartTime()+"]时间标志信息成功", "修改时间标志信息", "tb_TimesSignDef");
		
		list=timesSignDefService.findByPager(pager);
		return "timesSignDef_list";
	}
	
	public String timesSignDef_delete(){
		timesSignDefService.deleteByCompositeID(timesSignDef.getFeeRuleType(),timesSignDef.getDayType(),timesSignDef.getStartTime());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除收费类型为["+timesSignDef.getFeeRuleType()+"]_开始时间为["+timesSignDef.getStartTime()+"]时间标志信息成功", "删除时间标志信息", "tb_TimesSignDef");
		
		return timesSignDef_list();
	}
	/**
	 * 时间标志  End
	 */
	
	
	/**
	 * 车辆免费次数Start
	 */
	public String vehFreeTimes_list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list=vehFreeTimesService.findByPager(pager);
		return "vehFreeTimes_list";
	}
	
	public String vehFreeTimes_add(){
		return "vehFreeTimes_add";
	}
	
	public String saveVehFreeTimes() {
		if (vehFreeTimesService.ishasVehFreeTimes(vehFreeTimes.getVehPlate()) == null) {
			vehFreeTimesService.save(vehFreeTimes);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加车牌号为["+vehFreeTimes.getVehPlate()+"]车辆免费次数信息成功", "添加车辆免费次数信息", "tb_VehFreeTimes");
			
		} else {
			message = "hasVehFreeTimes";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加时已存在车牌号为["+vehFreeTimes.getVehPlate()+"]车辆免费次数信息，添加失败", "添加车辆免费次数信息", "tb_VehFreeTimes");
			
			return "vehFreeTimes_add";
		}

		return vehFreeTimes_list();
	}
	
	public String vehFreeTimes_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		vehFreeTimes=vehFreeTimesService.LoadVehFreeTimes(vehFreeTimes.getVehPlate()).get(0);
		return "vehFreeTimes_edit";
	}
	
	public String updateVehFreeTimes() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		vehFreeTimesService.update(vehFreeTimes);
		message="updateSuccess";

		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改车牌号为["+vehFreeTimes.getVehPlate()+"]车辆免费次数信息成功", "修改车辆免费次数信息", "tb_VehFreeTimes");
		
		list=vehFreeTimesService.findByPager(pager);
		return "vehFreeTimes_list";
	}
	
	public String vehFreeTimes_delete(){
		vehFreeTimesService.deleteByVehPlate(vehFreeTimes.getVehPlate());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除车牌号为["+vehFreeTimes.getVehPlate()+"]车辆免费次数信息成功", "删除车辆免费次数信息", "tb_VehFreeTimes");
		
		return vehFreeTimes_list();
	}
	
	//验证车牌号是否存在
	public void ishasVehPlate() {
		VehFreeTimes _vehFreeTimes = vehFreeTimesService.ishasVehFreeTimes(vehFreeTimes.getVehPlate()).get(0);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (_vehFreeTimes==null) {
			out.print("noVehPlate");
		} else {
			out.print("hasVehPlate");
		}
	}
	
	/**
	 * 车辆免费次数 End
	 */
	
	
	/**
	 *费率规则Start
	 */
	public String priceRule_zd_list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list=priceRule_zdService.findByPager(pager);
		return "priceRule_zd_list";
	}
	
	public String priceRule_zd_add(){
		return "priceRule_zd_add";
	}
	
	public String savePriceRule_zd() {
		//主键，车型 1：摩托车 2：小车，3：大中型车
		String veh=null;
		switch (priceRule_zd.getVehTypeNo()) {
		case 1:veh="摩托车";break;
		case 2:veh="小轿车";break;
		case 3:veh="大中型车";break;
		}
		if (priceRule_zdService.ishasPriceRule_zd(priceRule_zd.getFeeRuleType(), priceRule_zd.getVehTypeNo()) == null) {
			//当每次使用免费次数为空时，赋初始化值1
			if(priceRule_zd.getMaxFreeTimesUsedEveryTimes()==null){
				
				priceRule_zd.setMaxFreeTimesUsedEveryTimes(1);
				priceRule_zdService.save(priceRule_zd);
			}else {
				priceRule_zdService.save(priceRule_zd);
			}
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加收费类型为["+priceRule_zd.getFeeRuleType()+"]_车型为["+veh+"]费率规则成功", "添加费率规则", "tb_pricerule_zd");
		
		} else {
			message = "hasPriceRule_zd";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加时已存在收费类型为["+priceRule_zd.getFeeRuleType()+"]_车型为["+veh+"]费率规则，添加失败", "添加费率规则", "tb_pricerule_zd");
			
			return "priceRule_zd_add";
		}

		return priceRule_zd_list();
	}
	
	public String priceRule_zd_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		priceRule_zd=priceRule_zdService.LoadPriceRule_zd(priceRule_zd.getFeeRuleType(), priceRule_zd.getVehTypeNo()).get(0);
		return "priceRule_zd_edit";
	}
	
	public String updatePriceRule_zd() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		String veh=null;
		switch (priceRule_zd.getVehTypeNo()) {
		case 1:veh="摩托车";break;
		case 2:veh="小轿车";break;
		case 3:veh="大中型车";break;
		}
		priceRule_zdService.update(priceRule_zd);
		message="updateSuccess";

		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改收费类型为["+priceRule_zd.getFeeRuleType()+"]_车型为["+veh+"]费率规则成功", "修改费率规则", "tb_pricerule_zd");
		list=priceRule_zdService.findByPager(pager);
		return "priceRule_zd_list";
	}
	
	public String priceRule_zd_delete(){
		String veh=null;
		switch (priceRule_zd.getVehTypeNo()) {
		case 1:veh="摩托车";break;
		case 2:veh="小轿车";break;
		case 3:veh="大中型车";break;
		}
		priceRule_zdService.deleteByCompositeID(priceRule_zd.getFeeRuleType(), priceRule_zd.getVehTypeNo());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除收费类型为["+priceRule_zd.getFeeRuleType()+"]_车型为["+veh+"]费率规则成功", "删除费率规则", "tb_pricerule_zd");
		return priceRule_zd_list();
	}
	/**
	 * 费率规则End
	 */
	
	/**
	 * 基本费率Start
	 */
	
	//基本费率列表
	public String priceBase_list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list=zju_PriceBaseService.findByPager(pager);
		return "priceBase_list";
	}
	//跳转到基本费率添加页面
	public String priceBase_add(){	
		return "priceBase_add";
	}
	
	//添加费率
	public String savePriceBase(){
		String veh=null;
		switch (zju_PriceBase.getVehTypeNo()) {
		case 1:veh="摩托车";break;
		case 2:veh="小轿车";break;
		case 3:veh="大中型车";break;
		}
		zju_PriceBase.setFeeNo(zju_PriceBaseService.findMaxFeeNo()+1);
		if(zju_PriceBaseService.ishasZJU_PriceBase(zju_PriceBase.getVerNo(), zju_PriceBase.getFeeNo(), zju_PriceBase.getRebateType()
				, zju_PriceBase.getInOutSign(), zju_PriceBase.getTimesSign(), zju_PriceBase.getVehTypeNo())==null){
			//zju_PriceBase.setStayAdd(zju_PriceBase.getStayAdd()*60);//免费停留 ,小时化为分钟
			//zju_PriceBase.setAddFee(zju_PriceBase.getAddFee()*10);	//单位收费金额,元化为分
			//zju_PriceBase.setMaxFee(zju_PriceBase.getMaxFee()*10);	//最多收费,元化为分
			zju_PriceBaseService.save(zju_PriceBase);
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加费率版本为["+zju_PriceBase.getVerNo()+"]_费率编号为["+zju_PriceBase.getFeeNo()+"]_出入口标志为["+zju_PriceBase.getInOutSign()+"]_时间标志为["+zju_PriceBase.getTimesSign()+"]_车型为["+veh+"]基本费率成功", "添加基本费率", "tb_pricerule_zd");
			
			result = Result.SUCCESS;	
		}
		else{
			message ="haszju_PriceBase";
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加时已存在费率版本为["+zju_PriceBase.getVerNo()+"]_费率编号为["+zju_PriceBase.getFeeNo()+"]_出入口标志为["+zju_PriceBase.getInOutSign()+"]_时间标志为["+zju_PriceBase.getTimesSign()+"]_车型为["+veh+"]基本费率，添加失败", "添加基本费率", "tb_pricerule_zd");
			
			return "priceBase_add";		
		}
		return  priceBase_list();
	}
	
	//跳转到基本费率修改页面
	public String priceBase_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		zju_PriceBase=zju_PriceBaseService.LoadZJU_PriceBase(zju_PriceBase.getVerNo(), zju_PriceBase.getFeeNo(), zju_PriceBase.getRebateType()
				, zju_PriceBase.getInOutSign(), zju_PriceBase.getTimesSign(), zju_PriceBase.getVehTypeNo()).get(0);
		return "priceBase_edit";
	}
	//修改费率
	public String updatePriceBase(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		String veh=null;
		switch (zju_PriceBase.getVehTypeNo()) {
		case 1:veh="摩托车";break;
		case 2:veh="小轿车";break;
		case 3:veh="大中型车";break;
		}
		//caijunhua
		//zju_PriceBase.setFeeNo(zju_PriceBaseService.findMaxFeeNo());
		zju_PriceBaseService.update(zju_PriceBase);
		message="updateSuccess";

		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改费率版本为["+zju_PriceBase.getVerNo()+"]_费率编号为["+zju_PriceBase.getFeeNo()+"]_出入口标志为["+zju_PriceBase.getInOutSign()+"]_时间标志为["+zju_PriceBase.getTimesSign()+"]_车型为["+veh+"]基本费率成功", "修改基本费率", "tb_pricerule_zd");
		
		list=zju_PriceBaseService.findByPager(pager);
		return "priceBase_list";
	}
	
	//删除基本费率
	public String delete(){
		zju_PriceBaseService.deleteBycompositeID(zju_PriceBase.getVerNo(), zju_PriceBase.getFeeNo(), zju_PriceBase.getRebateType()
				, zju_PriceBase.getInOutSign(), zju_PriceBase.getTimesSign(), zju_PriceBase.getVehTypeNo());

		message="deleteSuccess";
		String veh=null;
		switch (zju_PriceBase.getVehTypeNo()) {
		case 1:veh="摩托车";break;
		case 2:veh="小轿车";break;
		case 3:veh="大中型车";break;
		}
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除费率版本为["+zju_PriceBase.getVerNo()+"]_费率编号为["+zju_PriceBase.getFeeNo()+"]_出入口标志为["+zju_PriceBase.getInOutSign()+"]_时间标志为["+zju_PriceBase.getTimesSign()+"]_车型为["+veh+"]基本费率成功", "删除基本费率", "tb_pricerule_zd");
		
		return priceBase_list();
	}
	
	/**
	 * 基本费率End
	 */
	
	//Getter/Setter
	public FeeRuleTypeDef getFeeRuleTypeDef() {
		return feeRuleTypeDef;
	}

	public void setFeeRuleTypeDef(FeeRuleTypeDef feeRuleTypeDef) {
		this.feeRuleTypeDef = feeRuleTypeDef;
	}

	public FreeDays getFreeDays() {
		return freeDays;
	}

	public void setFreeDays(FreeDays freeDays) {
		this.freeDays = freeDays;
	}
	public InOutSignDef getInOutSignDef() {
		return inOutSignDef;
	}

	public void setInOutSignDef(InOutSignDef inOutSignDef) {
		this.inOutSignDef = inOutSignDef;
	}
	public TimesSignDef getTimesSignDef() {
		return timesSignDef;
	}

	public void setTimesSignDef(TimesSignDef timesSignDef) {
		this.timesSignDef = timesSignDef;
	}
	public VehFreeTimes getVehFreeTimes() {
		return vehFreeTimes;
	}

	public void setVehFreeTimes(VehFreeTimes vehFreeTimes) {
		this.vehFreeTimes = vehFreeTimes;
	}
	public PriceRule_zd getPriceRule_zd() {
		return priceRule_zd;
	}

	public void setPriceRule_zd(PriceRule_zd priceRule_zd) {
		this.priceRule_zd = priceRule_zd;
	}

	public ZJU_PriceBase getZju_PriceBase() {
		return zju_PriceBase;
	}

	public void setZju_PriceBase(ZJU_PriceBase zju_PriceBase) {
		this.zju_PriceBase = zju_PriceBase;
	}

	public String getFreeWeek() {
		return freeWeek;
	}

	public void setFreeWeek(String freeWeek) {
		this.freeWeek = freeWeek;
	}
}
