package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.BillStorage;
import com.hgsoft.entity.BillTransfer;
import com.hgsoft.entity.BillTransferDetail;
import com.hgsoft.entity.Sysparamconf;

import com.hgsoft.service.AdminService;
import com.hgsoft.service.BillStorageService;
import com.hgsoft.service.BillTransferDetailService;
import com.hgsoft.service.BillTransferService;
import com.hgsoft.service.CardInfoSendParaService;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.OperatorService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;

@Controller
@Scope("prototype")
public class BillAction extends BaseAction {
	@SuppressWarnings("unchecked")
	private List listgatewayInformation;
	private BillStorage billStorage;
	private BillStorage billStorageTemp;
	private BillTransfer billTransfer;
	private BillTransfer billTransferTemp;
	private List<BillStorage> billStorageList;
	private String squadDate;
	private Admin admin;
	private BillTransferDetail billTransferDetail;
	private Sysparamconf param_whtherPayType;
	private BillTransferDetail billTransferDetailTemp;
	@SuppressWarnings("unchecked")
	private List listTemp;
	private String right;
	private Short position = null;
	private String whtherPayType = "whtherPayType";// 是否有缴费类型，0表示有缴费类型，1表示没有缴费类型
	private String whtherPayType_remark = "是否有缴费类型参数（0表示有缴费类型，1表示没有缴费类型,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	@SuppressWarnings("unchecked")
	private List squadList;

	@Resource
	private BillStorageService billStorageService;
	@Resource
	private GatewayInformationService gatewayInformationService;
	@Resource
	private CardInfoSendParaService cardInfoSendParaService;
	@Resource
	private AdminService adminService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private OperatorService operatorService;
	@Resource
	private BillTransferDetailService billTransferDetailService;
	@Resource
	private BillTransferService billTransferService;
	@Resource
	private SquadInformationService squadInformationService;
	@Resource
	private SysparamconfService sysparamconfService;
	public void removePagerAndConditionSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("hankNo");
		session.removeAttribute("position");
		session.removeAttribute("billType");
		session.removeAttribute("billHead");
	}
	public void setConditionSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("hankNo", billStorage.getHankNo());
		session.setAttribute("position",billStorage.getPosition());
		session.setAttribute("billType", billStorage.getBillType());
		session.setAttribute("billHead",billStorage.getBillHead().trim());
	}
	public void setPagerSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}
	// ---------------------------------------------------------下面为票据查询-------------------------------------------------------------------------
	public String queryBillStorage(){
		list = billStorageService.findByPager(pager);
		listgatewayInformation = gatewayInformationService.getAllGatewayInformation();// 大门信息
		billStorage = null;
		return "queryBillStorage";
	}
	public String queryBillStorageToCheck(){//按条件查询
		if (null == billStorage.getHankNo() && null == billStorage.getPosition() && null == billStorage.getBillType() && "".equals(billStorage.getBillHead().trim())) {
			return queryBillStorage();
		} else {
			list = billStorageService.findAllItemByHql(pager, billStorage.getHankNo(), billStorage.getPosition(), billStorage.getBillType(), billStorage.getBillHead().trim());
			listgatewayInformation = gatewayInformationService.getAllGatewayInformation();// 大门信息
			return "queryBillStorage";
		}
	}
	

	// ---------------------------------------------------------上面为票据查询，下面为票据登记-------------------------------------------------------------
	public String queryToAdd() {// 显示全部票据库存信息
		this.removePagerAndConditionSession();
		list = billStorageService.findByPager(pager);
		listgatewayInformation = gatewayInformationService.getAllGatewayInformation();// 大门信息
		billStorage = null;
		return "queryToAdd";
	}

	public String queryBillStorageToAdd() {// 查询票据库存信息
		this.removePagerAndConditionSession();
		if (null == billStorage.getHankNo() && null == billStorage.getPosition() && null == billStorage.getBillType() && "".equals(billStorage.getBillHead().trim())) {
			return queryToAdd();
		} else {
			this.setConditionSession();
			list = billStorageService.findAllItemByHql(pager, billStorage.getHankNo(), billStorage.getPosition(), billStorage.getBillType(), billStorage.getBillHead().trim());
			listgatewayInformation = gatewayInformationService.getAllGatewayInformation();// 大门信息
			return "queryToAdd";
		}
	}

	public String add() {// 跳转到登记输入属性界面
		return "add";
	}

	public String addEdit() {// 保存票据库存信息
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		billStorageTemp = new BillStorage();
		billStorageTemp.setHankNo(billStorage.getHankNo());
		billStorageTemp.setPosition((short) 99);
		billStorageTemp.setBillType(billStorage.getBillType());
		billStorageTemp.setBillHead(billStorage.getBillHead().trim());
		billStorageTemp.setStartBillNo(billStorage.getStartBillNo());
		billStorageTemp.setEndBillNo(billStorage.getEndBillNo());
		billStorageTemp.setAmount(billStorage.getAmount());
		billStorageTemp.setUsedBillNo(billStorage.getStartBillNo());
		billStorageTemp.setUsedAmount(0);
		billStorageTemp.setOpTime(date);
		billStorageService.save(billStorageTemp);
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户票据登记票据号["+billStorage.getHankNo()+"]成功",
				"卡票管理--票据管理--票据登记", "tb_BillStorage");
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else{//没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}	
		result = Result.SUCCESS;
		return queryToAdd();
	}

	public String getBillStorageByHankNo() {// 验证票据号是否已经存在
		billStorage = billStorageService.get(billStorage.getHankNo());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "BillAction中getBillStorageByHankNo（）验证票据号是否存在是时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (billStorage == null) {
			out.println("success");

		} else {
			out.print("fail");

		}
		return null;
	}
	public String update(){
		this.setPagerSession();
		billStorage = billStorageService.get(billStorage.getHankNo());
		return "update";
	}
	public String updateEdit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		admin = adminService.get(getCurrentOperator().getId());
		billStorageTemp = billStorageService.get(billStorage.getHankNo());
		billStorageTemp.setBillType(billStorage.getBillType());
		billStorageTemp.setStartBillNo(billStorage.getStartBillNo());
		billStorageTemp.setEndBillNo(billStorage.getEndBillNo());
		billStorageTemp.setAmount(billStorage.getAmount());
		billStorageTemp.setUsedBillNo(billStorage.getStartBillNo());
		billStorageTemp.setBillHead(billStorage.getBillHead().trim());
		billStorageService.update(billStorageTemp);
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户票据修改票据号["+billStorage.getHankNo()+"]信息成功",
				"卡票管理--票据管理--票据登记--修改", "tb_BillStorage");
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else{//没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}	
		result = Result.SUCCESS1;		
		if(session.getAttribute("billHead") != null){
			billStorage.setBillHead(session.getAttribute("billHead").toString());
		} else{
			billStorage.setBillHead("");
		}
		billStorage.setHankNo((Integer)session.getAttribute("hankNo"));
		billStorage.setPosition((Short)session.getAttribute("position"));
		billStorage.setBillType((Short)session.getAttribute("billType"));
		listgatewayInformation = gatewayInformationService.getAllGatewayInformation();// 大门信息	
		if (null == billStorage.getHankNo() && null == billStorage.getPosition() && null == billStorage.getBillType() && "".equals(billStorage.getBillHead().trim())) {
			list = billStorageService.findByPager(pager);
		} else {
			list = billStorageService.findAllItemByHql(pager, billStorage.getHankNo(), billStorage.getPosition(), billStorage.getBillType(), billStorage.getBillHead().trim());				
		}
		return "queryToAdd";
	}
	public String cancel(){
		admin = adminService.get(getCurrentOperator().getId());
		billStorage = billStorageService.get(billStorage.getHankNo());
		if(billStorage!=null){
			billStorageService.delete(billStorage);
			param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
			if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
				cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
			} else{//没有缴费类型
				cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
			}				
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户票据删除票据号["+billStorage.getHankNo()+"]信息成功",
					"卡票管理--票据管理--票据登记--删除", "tb_BillStorage");
		}
		result = Result.SUCCESS2;
		return queryToAdd();
	}

	// ---------------------------------------------------------上面为票据登记，下面为票据出库---------------------------------------------------
	public String moveOut() {// 出库界面
		listgatewayInformation = gatewayInformationService.getAllGatewayInformation();// 大门信息
		listTemp = operatorService.getAllOperator();
		list = billStorageService.getBillStorageByPosition((short) 99);
		
		//caijunhua 工班班次
		squadList = squadInformationService.getAllSquadInformation();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		squadDate = sdf.format(new Date());
		billStorage = null;
		return "moveOut";
	}

	public String moveOutEdit() {// 出库操作，修改BillStorage的信息，插入一条信息_BillTransferDetail和插入一条信息到BillTransfer
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		billTransferDetailTemp = new BillTransferDetail();
		billTransferTemp = new BillTransfer();
		String[] hankNo = right.split(",");
		for (int i = 0; i < hankNo.length; i++) {
			billStorageTemp = billStorageService.get(Integer.valueOf(hankNo[i]));
			billStorageTemp.setPosition(billStorage.getPosition());
			billStorageService.update(billStorageTemp);
			billTransferDetailTemp.setRecNo(billTransferDetailService.getMaxRecNO());
			billTransferDetailTemp.setHankNo(Integer.valueOf(hankNo[i]));
			billTransferDetailTemp.setStartBillNo(billStorageTemp.getStartBillNo());
			billTransferDetailTemp.setEndBillNo(billStorageTemp.getEndBillNo());
			billTransferDetailTemp.setAmount(billStorageTemp.getAmount());
			billTransferDetailService.save(billTransferDetailTemp);
			billTransferTemp.setRecNo(billTransferService.getMaxRecNO());
			billTransferTemp.setTransferType((short) 1);
			billTransferTemp.setAmount(billStorageTemp.getAmount());
			billTransferTemp.setOutPosition((short) 99);
			billTransferTemp.setInPosition(billStorageTemp.getPosition());
			billTransferTemp.setTransactor(billTransfer.getTransactor());
			billTransferTemp.setOperator(getCurrentOperator().getId());
			billTransferTemp.setOpTime(date);
			if (!squadDate.equals("")) {
				billTransferTemp.setSquadDate(Timestamp.valueOf(changeDateFormat(squadDate)));
			}
			billTransferTemp.setSquadNo(billTransfer.getSquadNo());
			billTransferTemp.setRemark(billTransfer.getRemark());
			billTransferService.save(billTransferTemp);
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户票据号["+Integer.valueOf(hankNo[i])+"]出库成功，出库到位置["+billStorage.getPosition()+"]",
					"卡票管理--票据管理--票据出库", "tb_BillStorage");
		}
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else{//没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}	
		result = Result.SUCCESS;
		
		return moveOut();

	}

	// ---------------------------------------------------------上面为票据出库，下面为票据入库---------------------------------------------------
	public String moveIn() {// 入库界面
		listgatewayInformation = gatewayInformationService.getAllGatewayInformation();// 大门信息
		listTemp = operatorService.getAllOperator();
		if (position == null) {
			list = null;
		} else {
			list = billStorageService.getBillStorageByPosition(position);
		}
		
		//caijunhua 工班班次
		squadList = squadInformationService.getAllSquadInformation();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		squadDate = sdf.format(new Date());
		billStorage = null;
		return "moveIn";
	}

	public String moveInEdit() {// 入库操作，修改BillStorage的信息，插入一条信息_BillTransferDetail和插入一条信息到BillTransfer
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		billTransferDetailTemp = new BillTransferDetail();
		billTransferTemp = new BillTransfer();
		String[] hankNo = right.split(",");
		for (int i = 0; i < hankNo.length; i++) {
			billStorageTemp = billStorageService.get(Integer.valueOf(hankNo[i]));
			billStorageTemp.setPosition((short) 99);
			billStorageService.update(billStorageTemp);
			billTransferDetailTemp.setRecNo(billTransferDetailService.getMaxRecNO());
			billTransferDetailTemp.setHankNo(Integer.valueOf(hankNo[i]));
			billTransferDetailTemp.setStartBillNo(billStorageTemp.getStartBillNo());
			billTransferDetailTemp.setEndBillNo(billStorageTemp.getEndBillNo());
			billTransferDetailTemp.setAmount(billStorageTemp.getAmount());
			billTransferDetailService.save(billTransferDetailTemp);
			billTransferTemp.setRecNo(billTransferService.getMaxRecNO());
			billTransferTemp.setTransferType((short) 2);
			billTransferTemp.setAmount(billStorageTemp.getAmount());
			billTransferTemp.setOutPosition(billStorage.getPosition());
			billTransferTemp.setInPosition((short) 99);
			billTransferTemp.setTransactor(billTransfer.getTransactor());
			billTransferTemp.setOperator(getCurrentOperator().getId());
			billTransferTemp.setOpTime(date);
			if (!squadDate.equals("")) {
				billTransferTemp.setSquadDate(Timestamp.valueOf(changeDateFormat(squadDate)));
			}
			billTransferTemp.setSquadNo(billTransfer.getSquadNo());
			billTransferTemp.setRemark(billTransfer.getRemark());
			billTransferService.save(billTransferTemp);
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户票据号["+Integer.valueOf(hankNo[i])+"]入库成功,从位置["+billStorage.getPosition()+"]入库",
					"卡票管理--票据管理--票据入库", "tb_BillStorage");
		}
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else{//没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}	
		result = Result.SUCCESS;
		return moveIn();

	}

	@SuppressWarnings("unchecked")
	public String setStartBillNo() {// 修改开始票号，异步刷新
		admin = adminService.get(getCurrentOperator().getId());
		billStorageTemp = billStorageService.get(billStorage.getHankNo());
		billStorageTemp.setUsedBillNo(billStorage.getStartBillNo());
		billStorageTemp.setUsedAmount(billStorageTemp.getUsedBillNo()-billStorageTemp.getStartBillNo());
		//billStorageTemp.setAmount(10);
		billStorageService.update(billStorageTemp);
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户修改票据号["+billStorage.getHankNo()+"]开始票号为["+billStorage.getStartBillNo()+"]",
				"卡票管理--票据管理--票据入库--修改", "tb_BillStorage");
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction中queryParkCardToLoss()设置whtherPayType参数时set（），get（）参数时的异常", admin);
		if(!param_whtherPayType.getPvalue().equals("1")){//	有缴费类型时	
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// 下发卡组参数
		} else{//没有缴费类型
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		}	
		if (position == null) {
			billStorageList = null;
		} else {
			billStorageList = new ArrayList();
			String[] hankNo = right.split(",");
			for (int i = 0; i < hankNo.length; i++) {
				billStorageTemp = billStorageService.get(Integer.valueOf(hankNo[i]));
				billStorageList.add(billStorageTemp);
			}
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/xml;charset=gbk");
		try {
			PrintWriter out = response.getWriter();
			out.println("<?xml version='1.0' encoding='gbk'?>");
			if (billStorageList.size() > 0) {
				out.println("<billStorageList>");
				for (BillStorage billStorage : billStorageList) {
					out.println("<billStorage>");
					out.println("<hankNo>" + billStorage.getHankNo() + "</hankNo>");
					out.println("<amount>" + (billStorage.getAmount()-billStorage.getUsedAmount())+ "</amount>");
					out.println("<billHead>" + billStorage.getBillHead().trim() + "</billHead>");
					out.println("<usedBillNo>" + billStorage.getUsedBillNo() + "</usedBillNo>");
					out.println("<endBillNo>" + billStorage.getEndBillNo() + "</endBillNo>");
					out.println("</billStorage>");
				}
				out.println("</billStorageList>");

			}
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public String getStartBillNo() {// 点击票据获得票据开始票号，异步刷新
		billStorage = billStorageService.get(billStorage.getHankNo());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "BillAction中getBillStorageByHankNo（）验证票据号是否存在是时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (billStorage != null) {
			out.println(billStorage.getUsedBillNo());

		} else {
			out.print("");

		}
		return null;
	}

	public String changeDateFormat(String dateFormat) {// Date的格式"yyyy-MM-dd"转换成"yyyy-MM-dd HH:mm:ss"
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date dateTemp = sdf.parse(dateFormat);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(dateTemp);
			Date date = calendar.getTime();
			SimpleDateFormat sdfTemp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowdateTemp = sdfTemp.format(date);
			return nowdateTemp;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "BillAction中changeDateFormat（）date格式转换时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowdate = sdf.format(new Date(0));
			return nowdate;
		}

	}

	// set get 函数
	@SuppressWarnings("unchecked")
	public List getListgatewayInformation() {
		return listgatewayInformation;
	}

	@SuppressWarnings("unchecked")
	public void setListgatewayInformation(List listgatewayInformation) {
		this.listgatewayInformation = listgatewayInformation;
	}

	public BillStorage getBillStorage() {
		return billStorage;
	}

	public void setBillStorage(BillStorage billStorage) {
		this.billStorage = billStorage;
	}

	@SuppressWarnings("unchecked")
	public List getListTemp() {
		return listTemp;
	}

	@SuppressWarnings("unchecked")
	public void setListTemp(List listTemp) {
		this.listTemp = listTemp;
	}

	public String getRight() {
		return right;
	}

	public void setRight(String right) {
		this.right = right;
	}

	public BillTransfer getBillTransfer() {
		return billTransfer;
	}

	public void setBillTransfer(BillTransfer billTransfer) {
		this.billTransfer = billTransfer;
	}

	public String getSquadDate() {
		return squadDate;
	}

	public void setSquadDate(String squadDate) {
		this.squadDate = squadDate;
	}

	public BillStorage getBillStorageTemp() {
		return billStorageTemp;
	}

	public void setBillStorageTemp(BillStorage billStorageTemp) {
		this.billStorageTemp = billStorageTemp;
	}

	public BillTransferDetail getBillTransferDetail() {
		return billTransferDetail;
	}

	public void setBillTransferDetail(BillTransferDetail billTransferDetail) {
		this.billTransferDetail = billTransferDetail;
	}

	public BillTransferDetail getBillTransferDetailTemp() {
		return billTransferDetailTemp;
	}

	public void setBillTransferDetailTemp(BillTransferDetail billTransferDetailTemp) {
		this.billTransferDetailTemp = billTransferDetailTemp;
	}

	public BillTransfer getBillTransferTemp() {
		return billTransferTemp;
	}

	public void setBillTransferTemp(BillTransfer billTransferTemp) {
		this.billTransferTemp = billTransferTemp;
	}

	public Short getPosition() {
		return position;
	}

	public void setPosition(Short position) {
		this.position = position;
	}
	@SuppressWarnings("unchecked")
	public List getSquadList() {
		return squadList;
	}
	@SuppressWarnings("unchecked")
	public void setSquadList(List squadList) {
		this.squadList = squadList;
	}
}
