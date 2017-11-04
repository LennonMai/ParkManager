package com.hgsoft.entity;


@SuppressWarnings("serial")
public class CarSpaceShowMessage implements java.io.Serializable {
	private Short parkNo;//PK
	private Short gateNo;//PK
	private Short laneNo;//PK
	private String initShow;//--显示内容
	private String isShowPosition;//是否显示，0代表显示，1代表不显示

	public CarSpaceShowMessage() {
	}
	public Short getParkNo() {
		return parkNo;
	}

	public void setParkNo(Short parkNo) {
		this.parkNo = parkNo;
	}

	public Short getGateNo() {
		return gateNo;
	}

	public void setGateNo(Short gateNo) {
		this.gateNo = gateNo;
	}

	public Short getLaneNo() {
		return laneNo;
	}

	public void setLaneNo(Short laneNo) {
		this.laneNo = laneNo;
	}

	public String getInitShow() {
		return initShow;
	}

	public void setInitShow(String initShow) {
		this.initShow = initShow;
	}

	public String getIsShowPosition() {
		return isShowPosition;
	}

	public void setIsShowPosition(String isShowPosition) {
		this.isShowPosition = isShowPosition;
	}
	
}