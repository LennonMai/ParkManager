package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.action.BaseAction.Result;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.Operator;
import com.hgsoft.entity.SquadLog;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.OperatorService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SquadLogService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date December 02, 2010
 * @Description 合计数修改
 */

@Controller
@Scope("prototype")
public class SquadLogAction extends BaseAction {
	@Resource
	private SquadLogService squadLogService;
	@Resource
	private GatewayInformationService gatewayInformationService;
	@Resource
	private LaneInformationService laneInformationService;
	@Resource
	private SquadInformationService squadInformationService;
	@Resource
	private OperatorService operatorService;
	@Resource
	private SystemLogService systemLogService;
	
	private SquadLog squadLog;
	
	@SuppressWarnings("unchecked")
	public List listGate;
	@SuppressWarnings("unchecked")
	public List listLane;
	@SuppressWarnings("unchecked")
	public List listSquad;
	@SuppressWarnings("unchecked")
	public List listOperator;
	
	private int count;
	private BigDecimal money;
	private Operator operator;
	
	//跳转合计数修改列表页面
	public String list() {
	//	squadLog=null;
	//	list = squadLogService.findBySquadDatePager(pager);	//列出记录
		list = squadLogService.fillAllSquadLog(pager);
		listGate = gatewayInformationService.getAllGatewayInformation();	//大门
		listSquad = squadInformationService.getAllSquadInformation();	//工班
		listOperator = operatorService.getAllOperator();	//操作员
		return "list";
	}
	
	//查询合计数
	public String querySquadLog() {		
		if(squadLog.getGateNo() != null || squadLog.getLaneNo() != null 
				|| squadLog.getSquadDate() != null || squadLog.getSquadNo() != null
				|| squadLog.getOperatorNo() != null) {
			
			list = squadLogService.fillAllSquadLogByHql(pager, squadLog.getGateNo(), squadLog.getLaneNo(),
					squadLog.getSquadDate(), squadLog.getSquadNo(), squadLog.getOperatorNo());
			listGate = gatewayInformationService.getAllGatewayInformation();	//大门
			if(null != squadLog.getGateNo()) {
				listLane = laneInformationService.getLaneInformationByGateNo(squadLog.getGateNo());//车道
			}
			listSquad = squadInformationService.getAllSquadInformation();	//工班
			listOperator = operatorService.getAllOperator();	//操作员
			
			return "list";
		} else {
			return list();	//查询条件为空
		}
	}
	
	//跳转到修改合计数信息页面
	@SuppressWarnings("unchecked")
	public String edit() {
		List<SquadLog> squadList = squadLogService.loadSquadLog(squadLog.getAreaNo(), squadLog.getParkNo(),
				squadLog.getGateNo(), squadLog.getLaneNo(), squadLog.getOperatorNo(), squadLog.getSquadDate(),
				squadLog.getSquadNo(), squadLog.getLoginTime());
		squadLog = squadList.get(0);
		String squadDateTemp = squadLog.getSquadDate().toString();
		String month = squadDateTemp.substring(5, 7);
		//获取中心数据
		List centerData = squadLogService.loadCenterData(month, squadLog.getAreaNo(),squadLog.getParkNo(),squadLog.getGateNo(),squadLog.getLaneNo(),
				squadLog.getSquadDate(), squadLog.getSquadNo(),squadLog.getListName());
		Map map = (Map) centerData.get(0);
		count = (Integer) map.get("Count");
		money = new BigDecimal(map.get("Money").toString()) ;
		operator = operatorService.get(squadLog.getOperatorNo());
		if(operator!=null){
			squadLog.setOperatorName(operator.getOperatorName());
		}		
//		Iterator it = centerData.iterator();
//		while(it.hasNext()){
//			Map obj = (Map) it.next();
//			count = (Integer) obj.get("Count");
//			money = (Integer) obj.get("Money");
//		}
		return EDIT;
	}
	
	//修改合计数信息
	public String update() {
		int countTemp = squadLog.getTotalVehCnt();
		BigDecimal moneyTemp = squadLog.getTotalVehMoney();
		List<SquadLog> squadList = squadLogService.loadSquadLog(squadLog.getAreaNo(), squadLog.getParkNo(),
				squadLog.getGateNo(), squadLog.getLaneNo(), squadLog.getOperatorNo(), squadLog.getSquadDate(),
				squadLog.getSquadNo(), squadLog.getLoginTime());
		if(!squadList.isEmpty()){
			squadLog = squadList.get(0);
			squadLog.setTotalVehCnt(countTemp);
			squadLog.setTotalVehMoney(moneyTemp);
			squadLogService.update(squadLog);
			
		}
		//squadLogService.update(squadLog);
		
		//插入系统日志
		Admin admin = this.getCurrentOperator();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户修改工班日期为"+format.format(squadLog.getSquadDate())+"的合计数信息",
				"报表管理--业务处理--合计数修改", "tb_SquadLog");
		result = Result.SUCCESS;
		list = squadLogService.fillAllSquadLogByHql(pager, squadLog.getGateNo(), squadLog.getLaneNo(),
				squadLog.getSquadDate(), squadLog.getSquadNo(), squadLog.getOperatorNo());
		listGate = gatewayInformationService.getAllGatewayInformation();	//大门
		listLane = laneInformationService.getLaneInformationByGateNo(squadLog.getGateNo());//车道
		listSquad = squadInformationService.getAllSquadInformation();	//工班
		listOperator = operatorService.getAllOperator();	//操作员
		return "list";
	}
	
	/**
	 * 异步获得大门 出口 车道信息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String ajaxLane() {
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = laneInformationService.getLaneInformationByGateNo(squadLog.getGateNo());
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<lanes>");
		for(int i = 0; i < tempList.size(); i++) {
			LaneInformation information = (LaneInformation)tempList.get(i);
			pw.print("<lane id='" + information.getLaneNo() + "' name='" + information.getLaneNo() + "' /> ");
		}
		pw.print("</lanes>");
		return null;
	}
	
	// Getters/Setters方法
	public SquadLog getSquadLog() {
		return squadLog;
	}
	public void setSquadLog(SquadLog squadLog) {
		this.squadLog = squadLog;
	}
	@SuppressWarnings("unchecked")
	public List getListGate() {
		return listGate;
	}
	@SuppressWarnings("unchecked")
	public List getListLane() {
		return listLane;
	}
	@SuppressWarnings("unchecked")
	public List getListSquad() {
		return listSquad;
	}
	@SuppressWarnings("unchecked")
	public List getListOperator() {
		return listOperator;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public BigDecimal getMoney() {
		return money;
	}
	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	public Operator getOperator() {
		return operator;
	}
	public void setOperator(Operator operator) {
		this.operator = operator;
	}
}
