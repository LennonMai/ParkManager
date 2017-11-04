package com.hgsoft.entity;
/**
 * 特殊事件编码
 *
 */
@SuppressWarnings("serial")
public class SpEventCode implements java.io.Serializable {

	private Short spEventNo;//PK 特殊事件编号
	private String spEventName;//特殊事件名称


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