package com.hgsoft.entity;


public class LaneType implements java.io.Serializable {

	/**
	 * �������ͱ���
	 */
	private static final long serialVersionUID = 1L;
	private Short laneTypeNo;// PK �������ͱ��
	private String laneTypeName;// ������������

	public LaneType() {
	}

	public LaneType(Short laneTypeNo, String laneTypeName) {
		this.laneTypeNo = laneTypeNo;
		this.laneTypeName = laneTypeName;
	}

	public Short getLaneTypeNo() {
		return this.laneTypeNo;
	}

	public void setLaneTypeNo(Short laneTypeNo) {
		this.laneTypeNo = laneTypeNo;
	}

	public String getLaneTypeName() {
		return this.laneTypeName;
	}

	public void setLaneTypeName(String laneTypeName) {
		this.laneTypeName = laneTypeName;
	}
	
}