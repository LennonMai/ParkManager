package com.hgsoft.entity;

/**
 * TbSpVehHandle entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SpVehHandle implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// Fields
	private Short laneType;		//车道类型：1入口；2出口
	private String tableName;	//表名
	private Integer status;		//状态

	private Integer handleType;	//处理类型：0放行；1放行，写日志；3人工确认；
	private String hint;		//提示
	private String remark;		//说明

	// Constructors

	/** default constructor */
	public SpVehHandle() {
	}

	/** minimal constructor */
	public SpVehHandle(Short laneType, String tableName, Integer status) {
		this.laneType = laneType;
		this.tableName = tableName;
		this.status = status;
	}

	/** full constructor */
	public SpVehHandle(Short laneType, String tableName, Integer status, Integer handleType, String hint,
			String remark) {
		this.laneType = laneType;
		this.tableName = tableName;
		this.status = status;
		this.handleType = handleType;
		this.hint = hint;
		this.remark = remark;
	}
	
	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SpVehHandle))
			return false;
		SpVehHandle castOther = (SpVehHandle) other;

		return ((this.getLaneType() == castOther.getLaneType()) || (this
				.getLaneType() != null
				&& castOther.getLaneType() != null && this.getLaneType()
				.equals(castOther.getLaneType())))
				&& ((this.getTableName() == castOther.getTableName()) || (this
						.getTableName() != null
						&& castOther.getTableName() != null && this
						.getTableName().equals(castOther.getTableName())))
				&& ((this.getStatus() == castOther.getStatus()) || (this
						.getStatus() != null
						&& castOther.getStatus() != null && this.getStatus()
						.equals(castOther.getStatus())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getLaneType() == null ? 0 : this.getLaneType().hashCode());
		result = 37 * result
				+ (getTableName() == null ? 0 : this.getTableName().hashCode());
		result = 37 * result
				+ (getStatus() == null ? 0 : this.getStatus().hashCode());
		return result;
	}

	// Property accessors
	public Short getLaneType() {
		return this.laneType;
	}

	public void setLaneType(Short laneType) {
		this.laneType = laneType;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getHandleType() {
		return this.handleType;
	}

	public void setHandleType(Integer handleType) {
		this.handleType = handleType;
	}

	public String getHint() {
		return this.hint;
	}

	public void setHint(String hint) {
		this.hint = hint;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}