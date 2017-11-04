package com.hgsoft.entity;

import java.util.Date;

public class WaterQuery {
	private Integer queryType;
	private String spEvent;   					//特殊事件
	private Date inTime;    					//入口操作时间
	private Date outTime;						//出口操作时间
	private String entrance;					//出口
	private Short cashMoney;  					//金额
	private Integer timeState; 					//0：查入口时间   1：查出口时间
	private Integer spEventState; 				//0：查入口特殊事件   1：查出口特殊事件
	private String vehClass; 					//车种
	private String vehPlate; 					//车牌号
	private String cardNo;						//卡号
	private Integer cashType;					//流水表中收费车金额类型
	private Integer laneNo;						//车道号
	private Date dltime;						//操作时间下限
	private Date dhtime;    					//操作时间上限
	private String squadNo;  					//工班号
	private Integer laneNoState;				//0：查询入口车道  1：查询出口车道
	private Short inLaneNo;					    //入口车道
	private Integer operatorNo;  				//操作人员
	private String operatorName; 				//操作人员姓名
	private Short vehType;					    //车型
	private Integer totalMoney;					//总金额
	
	
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
	 * 处理左位移, Math.pow(2,23)2的23次方,把值转换车2的（value-1）次方,然后转化成二进制,数据库中的值也转化成二进制，然后比较包含是否存在
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
				s = null;//value的值大于31时就不给查询出值，车道中只用到29.正数转为二进制字符串最多31位
			}
		} else {
			return "0";
		}
		return s;
	}	
}
