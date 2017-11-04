package com.hgsoft.entity;

@SuppressWarnings("serial")
public class GatewayInformation implements java.io.Serializable {

	private Short areaNo;// areaNo主键，区域编码
	private Short parkNo;// parkNo主键，小区编码
	private Short gateNo;// 主键，大门编码
	private String gateName;// 大门名称
	private String gateAllName;// 大门全称
	private String remark;// 备注

	public GatewayInformation() {
	}

	public GatewayInformation(Short areaNo, Short parkNo,
			Short gateNo, String gateName, String gateAllName, String remark) {
		this.areaNo = areaNo;
		this.parkNo = parkNo;
		this.gateNo = gateNo;
		this.gateName = gateName;
		this.gateAllName = gateAllName;
		this.remark = remark;
	}


	public Short getAreaNo() {
		return areaNo;
	}

	public void setAreaNo(Short areaNo) {
		this.areaNo = areaNo;
	}

	public Short getParkNo() {
		return parkNo;
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

	public String getGateName() {
		return this.gateName;
	}

	public void setGateName(String gateName) {
		this.gateName = gateName;
	}

	public String getGateAllName() {
		return this.gateAllName;
	}

	public void setGateAllName(String gateAllName) {
		this.gateAllName = gateAllName;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof GatewayInformation))
			return false;
		GatewayInformation castOther = (GatewayInformation) other;

		return ((this.getAreaNo() == castOther.getAreaNo()) || (this
				.getAreaNo() != null && castOther.getAreaNo() != null && this
				.getAreaNo().equals(castOther.getAreaNo())))
				&& ((this.getParkNo() == castOther.getParkNo()) || (this
						.getParkNo() != null && castOther.getParkNo() != null && this
						.getParkNo().equals(castOther.getParkNo())))
				&& ((this.getGateNo() == castOther.getGateNo()) || (this
						.getGateNo() != null && castOther.getGateNo() != null && this
						.getGateNo().equals(castOther.getGateNo())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getAreaNo() == null ? 0 : this.getAreaNo().hashCode());
		result = 37 * result
				+ (getParkNo() == null ? 0 : this.getParkNo().hashCode());
		result = 37 * result
				+ (getGateNo() == null ? 0 : this.getGateNo().hashCode());
		return result;
	}

}