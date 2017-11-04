package com.hgsoft.entity;

public class SendPara implements java.io.Serializable {

	/**
	 * 下发参数 SendType： 在下发参数模块只使用1 1－全表下发，2－字段下发（图片）。 FieldName、FieldValue：
	 * 当SendType为1时，都为0即没有值；当SendType为2时，都有值，如下发的是图片时是以字段存储的，此时FieldName、
	 * FieldValue为相应图片字段的值。
	 */
	private static final long serialVersionUID = 1L;
	private String fieldValue;// 字段值
	private Short laneNo;// 车道编码
	private String laneComputerIp;// 车道计算机IP地址
	private String tableName;// 下发参数对应表名
	private String fileName;//文件名 插入值与tableName一致
	private Short sendType;// 下发类型
	private String fieldName;// 字段名

	public SendPara() {
	}

	public SendPara(String fieldValue, Short laneNo, String laneComputerIp,
			String tableName,String fileName, Short sendType, String fieldName) {
		this.fieldValue = fieldValue;
		this.laneNo = laneNo;
		this.laneComputerIp = laneComputerIp;
		this.tableName = tableName;
		this.fileName=fileName;
		this.sendType = sendType;
		this.fieldName = fieldName;
	}

	public String getFieldValue() {
		return this.fieldValue;
	}

	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
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

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Short getSendType() {
		return this.sendType;
	}

	public void setSendType(Short sendType) {
		this.sendType = sendType;
	}

	public String getFieldName() {
		return this.fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SendPara))
			return false;
		SendPara castOther = (SendPara) other;

		return ((this.getFieldValue() == castOther.getFieldValue()) || (this
				.getFieldValue() != null && castOther.getFieldValue() != null && this
				.getFieldValue().equals(castOther.getFieldValue())))
				&& ((this.getLaneNo() == castOther.getLaneNo()) || (this
						.getLaneNo() != null && castOther.getLaneNo() != null && this
						.getLaneNo().equals(castOther.getLaneNo())))
				&& ((this.getLaneComputerIp() == castOther.getLaneComputerIp()) || (this
						.getLaneComputerIp() != null
						&& castOther.getLaneComputerIp() != null && this
						.getLaneComputerIp().equals(
								castOther.getLaneComputerIp())))
				&& ((this.getTableName() == castOther.getTableName()) || (this
						.getTableName() != null
						&& castOther.getTableName() != null && this
						.getTableName().equals(castOther.getTableName())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getFieldValue() == null ? 0 : this.getFieldValue()
						.hashCode());
		result = 37 * result
				+ (getLaneNo() == null ? 0 : this.getLaneNo().hashCode());
		result = 37
				* result
				+ (getLaneComputerIp() == null ? 0 : this.getLaneComputerIp()
						.hashCode());
		result = 37 * result
				+ (getTableName() == null ? 0 : this.getTableName().hashCode());
		return result;
	}

}