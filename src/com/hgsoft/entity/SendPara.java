package com.hgsoft.entity;

public class SendPara implements java.io.Serializable {

	/**
	 * �·����� SendType�� ���·�����ģ��ֻʹ��1 1��ȫ���·���2���ֶ��·���ͼƬ���� FieldName��FieldValue��
	 * ��SendTypeΪ1ʱ����Ϊ0��û��ֵ����SendTypeΪ2ʱ������ֵ�����·�����ͼƬʱ�����ֶδ洢�ģ���ʱFieldName��
	 * FieldValueΪ��ӦͼƬ�ֶε�ֵ��
	 */
	private static final long serialVersionUID = 1L;
	private String fieldValue;// �ֶ�ֵ
	private Short laneNo;// ��������
	private String laneComputerIp;// ���������IP��ַ
	private String tableName;// �·�������Ӧ����
	private String fileName;//�ļ��� ����ֵ��tableNameһ��
	private Short sendType;// �·�����
	private String fieldName;// �ֶ���

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