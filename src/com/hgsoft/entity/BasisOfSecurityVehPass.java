package com.hgsoft.entity;


public class BasisOfSecurityVehPass implements java.io.Serializable {

	// Fields

	private String vehPassId;
	private Integer commandId;
	private Integer commandModId;
	private Short isValid;

	public BasisOfSecurityVehPass() {
	}

	public Short getIsValid() {
		return this.isValid;
	}

	public void setIsValid(Short isValid) {
		this.isValid = isValid;
	}

	public String getVehPassId() {
		return vehPassId;
	}

	public void setVehPassId(String vehPassId) {
		this.vehPassId = vehPassId;
	}

	public Integer getCommandId() {
		return commandId;
	}

	public void setCommandId(Integer commandId) {
		this.commandId = commandId;
	}

	public Integer getCommandModId() {
		return commandModId;
	}

	public void setCommandModId(Integer commandModId) {
		this.commandModId = commandModId;
	}
	
}