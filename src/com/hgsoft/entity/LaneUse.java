package com.hgsoft.entity;


@SuppressWarnings("serial")
public class LaneUse implements java.io.Serializable {

	private Short areaNo;//PK
	private Short parkNo;//PK
	private Short gateNo;//PK
	private Short laneNo;//PK
	private String laneComputerIp;
	//private Short isUse;//启用标志：0 不启用，1 启用

	public LaneUse() {
	}

	public LaneUse(Short areaNo, Short parkNo, Short gateNo, Short laneNo,
			String laneComputerIp, Short isUse) {
		this.areaNo = areaNo;
		this.parkNo = parkNo;
		this.gateNo = gateNo;
		this.laneNo = laneNo;
		this.laneComputerIp = laneComputerIp;
		//this.isUse = isUse;
	}

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

	public String getLaneComputerIp() {
		return this.laneComputerIp;
	}

	public void setLaneComputerIp(String laneComputerIp) {
		this.laneComputerIp = laneComputerIp;
	}

	//public Short getIsUse() {
	//	return this.isUse;
	//}

	//public void setIsUse(Short isUse) {
	//	this.isUse = isUse;
	//}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof LaneUse))
			return false;
		LaneUse castOther = (LaneUse) other;

		return ((this.getAreaNo() == castOther.getAreaNo()) || (this
				.getAreaNo() != null && castOther.getAreaNo() != null && this
				.getAreaNo().equals(castOther.getAreaNo())))
				&& ((this.getParkNo() == castOther.getParkNo()) || (this
						.getParkNo() != null && castOther.getParkNo() != null && this
						.getParkNo().equals(castOther.getParkNo())))
				&& ((this.getGateNo() == castOther.getGateNo()) || (this
						.getGateNo() != null && castOther.getGateNo() != null && this
						.getGateNo().equals(castOther.getGateNo())))
				&& ((this.getLaneNo() == castOther.getLaneNo()) || (this
						.getLaneNo() != null && castOther.getLaneNo() != null && this
						.getLaneNo().equals(castOther.getLaneNo())));
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
		return result;
	}

}