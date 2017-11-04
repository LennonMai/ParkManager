package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.SecurityVehPassService;




@Controller
@Scope("prototype")
public class SecurityVehPassAction extends BaseAction {
	//��ѯ����
	private String startTime;
	private String endTime;
	private String cardNo;
	private String onwer;
	private String parkNo;//С��
	private String gateNo;//����
	private String laneNo;//����
	private String vehPass;//ʵ�ʹ���
	//������� С�������š�������Ϣ
	@SuppressWarnings("unchecked")
	private List parkList;
	@SuppressWarnings("unchecked")
	private List gateList;
	@SuppressWarnings("unchecked")
	private List laneList;
	//����������ʾ�����ݣ����ţ�
	@SuppressWarnings("unchecked")
	private List gates;
	//������ѯ��������
	private String vehPassId;
	//�鿴ָ�������¼
	private String numberType;//��������
	private String number;//����
	private String operatorType;
	@Resource SecurityVehPassService securityVehPassService;
	@Resource ParkInformationService parkInformationService;
	@Resource GatewayInformationService gatewayInformationService;
	@Resource LaneInformationService laneInformationService;
	/**
	 * ��ѯ����������Ϣ
	 */
	public String query(){
		list = securityVehPassService.query(pager,startTime,endTime,cardNo,onwer,parkNo,gateNo,laneNo,vehPass);
		parkList = parkInformationService.getAllParkInformation();
		gates =  gatewayInformationService.getAllGatewayInformation();
		if(null != parkNo && !parkNo.equals("")){
			gateList = gatewayInformationService.getGatewayInformationByParkNo(Short.valueOf(parkNo));
		}
		if(null != parkNo && !parkNo.equals("") && null != gateNo && !gateNo.equals("")){
			laneList = laneInformationService.getLaneInformationByParkNoAndGateNo(Short.valueOf(parkNo), Short.valueOf(gateNo));
		}
		return SUCCESS;
	}
	/**
	 *  ��ѯ����������Ϣ
	 */
	public String queryVehPass(){
		list = securityVehPassService.query(pager, vehPassId);
		return "vehPass";
	}
	/**
	 * ��ѯָ�������¼
	 */
	public String queryHistory(){
		list = securityVehPassService.queryHistory(pager,startTime,endTime,parkNo,gateNo,laneNo,numberType,number,operatorType);
		parkList = securityVehPassService.queryParkList();
		if(null != parkNo && !parkNo.equals("")){
			gateList = securityVehPassService.queryGateList(parkNo);
		}
		if(null != parkNo && !parkNo.equals("") && null != gateNo && !gateNo.equals("")){
			laneList = securityVehPassService.queryLaneList(parkNo,gateNo);
		}
		return "history";
	}
	/**
	 * �첽���С��������Ϣ
	 */
	@SuppressWarnings("unchecked")
	public String ajaxGate(){
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = gatewayInformationService.getGatewayInformationByParkNo(Short.parseShort(parkNo));
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
	/**
	 * �첽��ô��ų�����Ϣ
	 */
	@SuppressWarnings("unchecked")
	public String ajaxLane(){
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = laneInformationService.getLaneInformationByParkNoAndGateNo(Short.parseShort(parkNo), Short.parseShort(gateNo));
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<lanes>");
		for (int i = 0; i < tempList.size(); i++) {
			LaneInformation information = (LaneInformation) tempList.get(i);
			pw.print("<lane id='" + information.getLaneNo() + "' name='" + information.getLaneNo() + "' />");
		}
		pw.print("</lanes>");
		return null;
	}
	public String getNumberType() {
		return numberType;
	}
	public void setNumberType(String numberType) {
		this.numberType = numberType;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getOperatorType() {
		return operatorType;
	}
	public void setOperatorType(String operatorType) {
		this.operatorType = operatorType;
	}
	public String getVehPassId() {
		return vehPassId;
	}
	public void setVehPassId(String vehPassId) {
		this.vehPassId = vehPassId;
	}
	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getOnwer() {
		return onwer;
	}

	public void setOnwer(String onwer) {
		this.onwer = onwer;
	}

	public String getParkNo() {
		return parkNo;
	}

	public void setParkNo(String parkNo) {
		this.parkNo = parkNo;
	}

	public String getGateNo() {
		return gateNo;
	}

	public void setGateNo(String gateNo) {
		this.gateNo = gateNo;
	}

	public String getLaneNo() {
		return laneNo;
	}

	public void setLaneNo(String laneNo) {
		this.laneNo = laneNo;
	}

	public String getVehPass() {
		return vehPass;
	}

	public void setVehPass(String vehPass) {
		this.vehPass = vehPass;
	}

	@SuppressWarnings("unchecked")
	public List getParkList() {
		return parkList;
	}

	@SuppressWarnings("unchecked")
	public void setParkList(List parkList) {
		this.parkList = parkList;
	}

	@SuppressWarnings("unchecked")
	public List getGateList() {
		return gateList;
	}

	@SuppressWarnings("unchecked")
	public void setGateList(List gateList) {
		this.gateList = gateList;
	}

	@SuppressWarnings("unchecked")
	public List getLaneList() {
		return laneList;
	}

	@SuppressWarnings("unchecked")
	public void setLaneList(List laneList) {
		this.laneList = laneList;
	}
	@SuppressWarnings("unchecked")
	public List getGates() {
		return gates;
	}
	@SuppressWarnings("unchecked")
	public void setGates(List gates) {
		this.gates = gates;
	}
}
