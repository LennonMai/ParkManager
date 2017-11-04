package com.hgsoft.entity;

import java.util.Date;

public class WaterQuery {
	private Integer queryType;
	private String spEvent;   					//�����¼�
	private Date inTime;    					//��ڲ���ʱ��
	private Date outTime;						//���ڲ���ʱ��
	private String entrance;					//����
	private Short cashMoney;  					//���
	private Integer timeState; 					//0�������ʱ��   1�������ʱ��
	private Integer spEventState; 				//0������������¼�   1������������¼�
	private String vehClass; 					//����
	private String vehPlate; 					//���ƺ�
	private String cardNo;						//����
	private Integer cashType;					//��ˮ�����շѳ��������
	private Integer laneNo;						//������
	private Date dltime;						//����ʱ������
	private Date dhtime;    					//����ʱ������
	private String squadNo;  					//�����
	private Integer laneNoState;				//0����ѯ��ڳ���  1����ѯ���ڳ���
	private Short inLaneNo;					    //��ڳ���
	private Integer operatorNo;  				//������Ա
	private String operatorName; 				//������Ա����
	private Short vehType;					    //����
	private Integer totalMoney;					//�ܽ��
	
	
	public Integer getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(Integer totalMoney) {
		this.totalMoney = totalMoney;
	}
	public Integer getOperatorNo() {
		return operatorNo;
	}
	public void setOperatorNo(Integer operatorNo) {
		this.operatorNo = operatorNo;
	}
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	public void setInLaneNo(Short inLaneNo) {
		this.inLaneNo = inLaneNo;
	}
	public Integer getLaneNoState() {
		return laneNoState;
	}
	public void setLaneNoState(Integer laneNoState) {
		this.laneNoState = laneNoState;
	}
	public Integer getTimeState() {
		return timeState;
	}
	public void setTimeState(Integer timeState) {
		this.timeState = timeState;
	}
	public Integer getSpEventState() {
		return spEventState;
	}
	public void setSpEventState(Integer spEventState) {
		this.spEventState = spEventState;
	}
	public Integer getQueryType() {
		return queryType;
	}
	public void setQueryType(Integer queryType) {
		this.queryType = queryType;
	}
	public String getSpEvent() {
		return spEvent;
	}
	public void setSpEvent(String spEvent) {
		this.spEvent = spEvent;
	}
	
	public String getBinSqEvent() {
		return removeLeftAndToBin(spEvent);
	}
	
	public Date getInTime() {
		return inTime;
	}
	public void setInTime(Date inTime) {
		this.inTime = inTime;
	}
	public Date getOutTime() {
		return outTime;
	}
	public void setOutTime(Date outTime) {
		this.outTime = outTime;
	}

	public String getEntrance() {
		return entrance;
	}
	public void setEntrance(String entrance) {
		this.entrance = entrance;
	}
	public Short getCashMoney() {
		return cashMoney;
	}
	public void setCashMoney(Short cashMoney) {
		this.cashMoney = cashMoney;
	}
	public String getVehClass() {
		return vehClass;
	}
	public void setVehClass(String vehClass) {
		this.vehClass = vehClass;
	}
	public String getVehPlate() {
		return vehPlate;
	}
	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public Short getVehType() {
		return vehType;
	}
	public void setVehType(Short vehType) {
		this.vehType = vehType;
	}
	public Short getInLaneNo() {
		return inLaneNo;
	}
	public Integer getCashType() {
		return cashType;
	}
	public void setCashType(Integer cashType) {
		this.cashType = cashType;
	}
	
	public Integer getLaneNo() {
		return laneNo;
	}
	public void setLaneNo(Integer laneNo) {
		this.laneNo = laneNo;
	}

	public Date getDltime() {
		return dltime;
	}
	public void setDltime(Date dltime) {
		this.dltime = dltime;
	}
	public Date getDhtime() {
		return dhtime;
	}
	public void setDhtime(Date dhtime) {
		this.dhtime = dhtime;
	}
	
	public String getSquadNo() {
		return squadNo;
	}
	public void setSquadNo(String squadNo) {
		this.squadNo = squadNo;
	}
	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		WaterQuery temp = (WaterQuery)obj;
		if(this.getOutTime()!=null&&temp.getOutTime()!=null){
			if(this.getOutTime().getTime()>temp.getOutTime().getTime())
				return true;
			else return false;
		}
		return super.equals(obj);
	}
	/**
	 * ������λ��, Math.pow(2,23)2��23�η�,��ֵת����2�ģ�value-1���η�,Ȼ��ת���ɶ�����,���ݿ��е�ֵҲת���ɶ����ƣ�Ȼ��Ƚϰ����Ƿ����
	 * @return
	 */
	public String removeLeftAndToBin(String value){
		String s="";	
		int a =0;
		if(!value.equals("0")){	
			 a = Integer.parseInt(value)-1;
			if(a<=23){
				int tempInt =  1<<a;//(int) Math.pow(2, a);
				s = Integer.toBinaryString(tempInt).toString();
				//s = String.valueOf(tempInt);
			} else if(a>23&&a<31){
				int c=a%23;
				int tempInt =(1<<c)*(1<<23);//(int) Math.pow(2, c)*(int) Math.pow(2, 23);
				s = Integer.toBinaryString(tempInt).toString();
				//s = String.valueOf(tempInt);
			} else{
				s = null;//value��ֵ����31ʱ�Ͳ�����ѯ��ֵ��������ֻ�õ�29.����תΪ�������ַ������31λ
			}
		} else {
			return "0";
		}
		return s;
	}	
}
