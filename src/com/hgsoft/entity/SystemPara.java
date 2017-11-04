package com.hgsoft.entity;

@SuppressWarnings("serial")
public class SystemPara implements java.io.Serializable {

	/**
	 * ϵͳ����
	 */

	private Short paraClass;// ��������������
	private String item;// ����������
	private String itemValue;// ��ֵ
	private String groupName;// ���
	private Short itemOrder;// ��˳��
	private Short sendControl;// �����·�������ֻ��paraClass=1ʱʹ��,0Ϊ���·���1Ϊ�·�

	public SystemPara() {
	}

	public SystemPara(Short paraClass, String item, String itemValue,
			String groupName, Short itemOrder, Short sendControl) {
		this.paraClass = paraClass;
		this.item = item;
		this.itemValue = itemValue;
		this.groupName = groupName;
		this.itemOrder = itemOrder;
		this.sendControl = sendControl;
	}

	public Short getParaClass() {
		return this.paraClass;
	}

	public void setParaClass(Short paraClass) {
		this.paraClass = paraClass;
	}

	public String getItem() {
		return this.item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getItemValue() {
		return this.itemValue;
	}

	public void setItemValue(String itemValue) {
		this.itemValue = itemValue;
	}

	public String getGroupName() {
		return this.groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Short getItemOrder() {
		return this.itemOrder;
	}

	public void setItemOrder(Short itemOrder) {
		this.itemOrder = itemOrder;
	}

	public Short getSendControl() {
		return this.sendControl;
	}

	public void setSendControl(Short sendControl) {
		this.sendControl = sendControl;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SystemPara))
			return false;
		SystemPara castOther = (SystemPara) other;

		return ((this.getParaClass() == castOther.getParaClass()) || (this
				.getParaClass() != null && castOther.getParaClass() != null && this
				.getParaClass().equals(castOther.getParaClass())))
				&& ((this.getItem() == castOther.getItem()) || (this.getItem() != null
						&& castOther.getItem() != null && this.getItem()
						.equals(castOther.getItem())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getParaClass() == null ? 0 : this.getParaClass().hashCode());
		result = 37 * result
				+ (getItem() == null ? 0 : this.getItem().hashCode());
		return result;
	}

}