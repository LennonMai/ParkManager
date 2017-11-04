package com.hgsoft.entity;

import java.io.Serializable;

public class OwnerIdentity implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer identityType;
	private String identityName;
	
	public OwnerIdentity() {
	}

	public OwnerIdentity(Integer identityType, String identityName) {
		this.identityType = identityType;
		this.identityName = identityName;
	}

	public Integer getIdentityType() {
		return identityType;
	}

	public void setIdentityType(Integer identityType) {
		this.identityType = identityType;
	}

	public String getIdentityName() {
		return identityName;
	}

	public void setIdentityName(String identityName) {
		this.identityName = identityName;
	}
	
	
	
}
