package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.AreaInformation;
import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.HandInMoney;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.service.AreaInformationService;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.HandInMoneyService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.OperatorService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date October 22, 2010
 * @Description ���Ӱ����
 */

@Controller
@Scope("prototype")
public class HandInMoneyAction extends BaseAction {
	@Resource
	private HandInMoneyService handInMoneyService;
	@Resource
	private OperatorService operatorService;
	@Resource
	private AreaInformationService areaInformationService;
	@Resource
	private ParkInformationService parkInformationService;
	@Resource
	private GatewayInformationService gatewayInformationService;
	@Resource
	private LaneInformationService laneInformationService;
	@Resource
	private SquadInformationService squadInformationService;
	@Resource
	private SystemLogService systemLogService;
	
	private HandInMoney handInMoney;
	private AreaInformation areaInformation;
	private ParkInformation parkInformation;
	private GatewayInformation gatewayInformation;
	
	@SuppressWarnings("unchecked")
	public List listArea;
	@SuppressWarnings("unchecked")
	public List listPark;
	@SuppressWarnings("unchecked")
	public List listGate;
	@SuppressWarnings("unchecked")
	public List listLane;
	@SuppressWarnings("unchecked")
	public List listSquad;
	
	
	
	//��ת�����Ӱ�����б�ҳ��
	public String list() {
		list = handInMoneyService.findBySquadDatePager(pager);
		listArea = areaInformationService.getAllAreaInformation();	//����
		listPark = parkInformationService.getAllParkInformation();	//С��
		listGate = gatewayInformationService.getAllGatewayInformation();	//����
//		if(null != handInMoney.getGateNo()){
//			listLane = laneInformationService.getLaneInformationByGateNo(handInMoney.getGateNo());//����
//		}
		listSquad = squadInformationService.getAllSquadInformation();	//����
//		System.out.println(list.size());
		return "list";
	}
	
	//��ѯ���Ӱ�
	public String queryHandInMoney() {
		if(handInMoney.getGateNo() != null || handInMoney.getLaneNo() != null 
				|| handInMoney.getSquadDate() != null || handInMoney.getSquadNo() != null) {//��ѯ������Ϊ��
			list = handInMoneyService.findAllHandInMoneyByHql(pager, handInMoney.getGateNo(), 
					handInMoney.getLaneNo(), handInMoney.getSquadDate(), handInMoney.getSquadNo());
			listArea = areaInformationService.getAllAreaInformation();	//����
			listPark = parkInformationService.getAllParkInformation();	//С��
			listGate = gatewayInformationService.getAllGatewayInformation();	//����
			if(null != handInMoney.getGateNo()) {
				listLane = laneInformationService.getLaneInformationByGateNo(handInMoney.getGateNo());//����
			}
			listSquad = squadInformationService.getAllSquadInformation();	//����
			
			return "list";
		} else {
			return list();	//��ѯ����Ϊ��
		}
	}
	
	//��ת���޸Ľ��Ӱ���Ϣҳ��
	public String edit() {
		list = operatorService.getAllOperator();	//��������Ա
		areaInformation = areaInformationService.get(handInMoney.getAreaNo());
		parkInformation = parkInformationService.LoadParkInfo(handInMoney.getParkNo()).get(0);
		gatewayInformation = gatewayInformationService.LoadGatewayInfo(handInMoney.getAreaNo(), handInMoney.getParkNo(), handInMoney.getGateNo()).get(0);
//		listArea = areaInformationService.getAllAreaInformation();	//����
//		listPark = parkInformationService.getAllParkInformation();	//С��
//		listGate = gatewayInformationService.getAllGatewayInformation();	//����
//		listSquad = squadInformationService.getAllSquadInformation();	//����
		List<HandInMoney> handInMoneyList = handInMoneyService.loadHandInMoney(handInMoney.getAreaNo(), 
				handInMoney.getParkNo(), handInMoney.getGateNo(), handInMoney.getLaneNo(), 
				handInMoney.getSquadDate(), handInMoney.getSquadNo());
		handInMoney = handInMoneyList.get(0);
		return EDIT;
	}
	
	//�޸Ľ��Ӱ���Ϣ
	public String update() {
		handInMoney.setLaneOperatorName(operatorService.get(handInMoney.getLaneOperatorNo()).getOperatorName());
//		System.out.println(operatorService.get(handInMoney.getLaneOperatorNo()).getOperatorName());
		handInMoney.setOpTime(new Date());	//����ʱ��
		handInMoney.setOperatorNo((getCurrentOperator().getId()).toString());	//����Ա����
		handInMoney.setOperatorName(getCurrentOperator().getName());	//����Ա����
		handInMoneyService.update(handInMoney);
		
		//����ϵͳ��־
//		admin = adminService.get(getCurrentOperator().getId());
		Admin admin = this.getCurrentOperator(); 
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û��޸Ĺ�������Ϊ"+format.format(handInMoney.getSquadDate())+"�Ľ��Ӱ���Ϣ",
				"�������--ҵ����--���Ӱ����", "tb_HandInMoney");
		
		//ȥ����ѯ������ʾ
		handInMoney = null;
		
		return list();
	}
	//ɾ�����Ӱ���Ϣ
	public String delete() {
		handInMoneyService.deleteHandInMoney(handInMoney.getAreaNo(), 
				handInMoney.getParkNo(), handInMoney.getGateNo(), handInMoney.getLaneNo(), 
				handInMoney.getSquadDate(), handInMoney.getSquadNo());
		
		//����ϵͳ��־
		Admin admin = this.getCurrentOperator();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û�ɾ����������Ϊ"+format.format(handInMoney.getSquadDate())+"�Ľ��Ӱ���Ϣ",
				"�������--ҵ����--���Ӱ����", "tb_HandInMoney");
		
		//ȥ����ѯ������ʾ
		handInMoney = null;
		
		return list();
	}
	
	/**
	 * �첽��ô��� ���� ������Ϣ
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String ajaxLane() {
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = laneInformationService.getLaneInformationByGateNo(handInMoney.getGateNo());
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

	
	// Getters/Setters����
	public HandInMoney getHandInMoney() {
		return handInMoney;
	}
	public void setHandInMoney(HandInMoney handInMoney) {
		this.handInMoney = handInMoney;
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

	public GatewayInformation getGatewayInformation() {
		return gatewayInformation;
	}
	public void setGatewayInformation(GatewayInformation gatewayInformation) {
		this.gatewayInformation = gatewayInformation;
	}
	
	
	@SuppressWarnings("unchecked")
	public List getListArea() {
		return listArea;
	}
	@SuppressWarnings("unchecked")
	public List getListPark() {
		return listPark;
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


	
	

}
