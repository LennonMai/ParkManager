package com.hgsoft.entity;

import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * TbHandInMoney entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class HandInMoney implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	// Fields
	private Short areaNo;				//区域编码,PK主键
	private Short parkNo;				//小区编码,PK主键
	private Short gateNo;				//大门编码,PK主键
	private Short laneNo;				//车道编码,PK主键
	private Date squadDate;				//工班日期,PK主键
	private Short squadNo;				//工班号,PK主键

	//private TbHandInMoneyId id;			
	private Double money;				//应交金额
	private Double handInMoney;			//实交金额
	private Short moneyTypeNo;			//币种	1:人民币
	private Integer laneOperatorNo;		//收费员工号
	private String laneOperatorName;	//收费员姓名
	private String operatorNo;			//操作员编码
	private String operatorName;		//操作员名称
	private Date opTime;				//操作时间
//	private Integer freevehcount;		//免费车数量
//	private Double freemoney;			//免费车金额

	// Constructors

	/** default constructor */
	public HandInMoney() {
	}

	/** full constructor */
	public HandInMoney(Short areaNo, Short parkNo, Short gateNo, Short laneNo,
			Date squadDate, Short squadNo, Double money, Double handInMoney,
			Short moneyTypeNo, Integer laneOperatorNo, String laneOperatorName,
			String operatorNo, String operatorName, Date opTime,
			Integer freevehcount, Double freemoney) {
		this.areaNo = areaNo;
		this.parkNo = parkNo;
		this.gateNo = gateNo;
		this.laneNo = laneNo;
		this.squadDate = squadDate;
		this.squadNo = squadNo;
		
		this.money = money;
		this.handInMoney = handInMoney;
		this.moneyTypeNo = moneyTypeNo;
		this.laneOperatorNo = laneOperatorNo;
		this.laneOperatorName = laneOperatorName;
		this.operatorNo = operatorNo;
		this.operatorName = operatorName;
		this.opTime = opTime;
//		this.freevehcount = freevehcount;
//		this.freemoney = freemoney;
	}
	
	public boolean equals(Object obj) {
		if (obj == this) {
			return true;
		}
		if (!(obj instanceof HandInMoney)) {
			return false;
		}
		HandInMoney handInMoney = (HandInMoney) obj;
		return new EqualsBuilder()
				.append(this.areaNo,handInMoney.getAreaNo())
				.append(this.parkNo,handInMoney.getParkNo())
				.append(this.gateNo,handInMoney.getGateNo())
				.append(this.laneNo,handInMoney.getLaneNo())
				.append(this.squadDate,handInMoney.getSquadDate())
				.append(this.squadNo,handInMoney.getSquadNo()).isEquals();
	}

	public int hashCode() {
		return new HashCodeBuilder().append(this.areaNo).append(this.parkNo)
				.append(this.gateNo).append(this.laneNo)
				.append(this.squadDate).append(this.squadNo).toHashCode();
	}
	
	/*public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof TbHandInMoneyId))
			return false;
		TbHandInMoneyId castOther = (TbHandInMoneyId) other;

		return ((this.getAreaNo() == castOther.getAreaNo()) || (this
				.getAreaNo() != null
				&& castOther.getAreaNo() != null && this.getAreaNo().equals(
				castOther.getAreaNo())))
				&& ((this.getParkNo() == castOther.getParkNo()) || (this
						.getParkNo() != null
						&& castOther.getParkNo() != null && this.getParkNo()
						.equals(castOther.getParkNo())))
				&& ((this.getGateNo() == castOther.getGateNo()) || (this
						.getGateNo() != null
						&& castOther.getGateNo() != null && this.getGateNo()
						.equals(castOther.getGateNo())))
				&& ((this.getLaneNo() == castOther.getLaneNo()) || (this
						.getLaneNo() != null
						&& castOther.getLaneNo() != null && this.getLaneNo()
						.equals(castOther.getLaneNo())))
				&& ((this.getSquadDate() == castOther.getSquadDate()) || (this
						.getSquadDate() != null
						&& castOther.getSquadDate() != null && this
						.getSquadDate().equals(castOther.getSquadDate())))
				&& ((this.getSquadNo() == castOther.getSquadNo()) || (this
						.getSquadNo() != null
						&& castOther.getSquadNo() != null && this.getSquadNo()
						.equals(castOther.getSquadNo())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getAreaNo() == null ? 0 : this.getAreaNo().hashCode());
		result = 37 * result
				+ (getParkNo() == null ? 0 : this.getParkNo().hashCode());
		result = 37 * result
				+ (getGateNo() == null ? 0 : this.getGateNo().hashCode());
		result = 37 * result
				+ (getLaneNo() == null ? 0 : this.getLaneNo().hashCode());
		result = 37 * result
				+ (getSquadDate() == null ? 0 : this.getSquadDate().hashCode());
		result = 37 * result
				+ (getSquadNo() == null ? 0 : this.getSquadNo().hashCode());
		return result;
	}*/

	// Property accessors
	
	public Short getAreaNo() {
		return this.areaNo;
	}

	public void setAreaNo(Short areaNo) {
		this.areaNo = areaNo;
	}

	public Short getParkNo() {
		return this.parkNo;
	}

	public void setParkNo(Short parkNo) {
		this.parkNo = parkNo;
	}

	public Short getGateNo() {
		return this.gateNo;
	}

	public void setGateNo(Short gateNo) {
		this.gateNo = gateNo;
	}

	public Short getLaneNo() {
		return this.laneNo;
	}

	public void setLaneNo(Short laneNo) {
		this.laneNo = laneNo;
	}

	public Date getSquadDate() {
		return this.squadDate;
	}

	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}

	public Short getSquadNo() {
		return this.squadNo;
	}

	public void setSquadNo(Short squadNo) {
		this.squadNo = squadNo;
	}

	public Double getMoney() {
		return this.money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Double getHandInMoney() {
		return this.handInMoney;
	}

	public void setHandInMoney(Double handInMoney) {
		this.handInMoney = handInMoney;
	}

	public Short getMoneyTypeNo() {
		return this.moneyTypeNo;
	}

	public void setMoneyTypeNo(Short moneyTypeNo) {
		this.moneyTypeNo = moneyTypeNo;
	}

	public Integer getLaneOperatorNo() {
		return this.laneOperatorNo;
	}

	public void setLaneOperatorNo(Integer laneOperatorNo) {
		this.laneOperatorNo = laneOperatorNo;
	}

	public String getLaneOperatorName() {
		return this.laneOperatorName;
	}

	public void setLaneOperatorName(String laneOperatorName) {
		this.laneOperatorName = laneOperatorName;
	}

	public String getOperatorNo() {
		return this.operatorNo;
	}

	public void setOperatorNo(String operatorNo) {
		this.operatorNo = operatorNo;
	}

	public String getOperatorName() {
		return this.operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public Date getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

//	public Integer getFreevehcount() {
//		return this.freevehcount;
//	}
//
//	public void setFreevehcount(Integer freevehcount) {
//		this.freevehcount = freevehcount;
//	}
//
//	public Double getFreemoney() {
//		return this.freemoney;
//	}
//
//	public void setFreemoney(Double freemoney) {
//		this.freemoney = freemoney;
//	}

	//返回币种字符串
	public String getMoneyTypeString() {
		if (this.moneyTypeNo == 1) {
			return "人民币";
		} else {
			return "";
		}
	}
	
}