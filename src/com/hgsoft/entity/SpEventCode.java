package com.hgsoft.entity;
/**
 * �����¼�����
 *
 */
@SuppressWarnings("serial")
public class SpEventCode implements java.io.Serializable {

	private Short spEventNo;//PK �����¼����
	private String spEventName;//�����¼�����


	public SpEventCode() {
	}

	public Short getSpEventNo() {
		return spEventNo;
	}


	public void setSpEventNo(Short spEventNo) {
		this.spEventNo = spEventNo;
	}


	public String getSpEventName() {
		return spEventName;
	}


	public void setSpEventName(String spEventName) {
		this.spEventName = spEventName;
	}
	
}