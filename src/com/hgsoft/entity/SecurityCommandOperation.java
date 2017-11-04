package com.hgsoft.entity;


public class SecurityCommandOperation implements java.io.Serializable {

	private Integer operationId;
	private Short operationType;
	private Integer preModId;
	private Integer postModId;
	private Integer commandId;

	
	public SecurityCommandOperation() {
	}

	/** full constructor */
	public SecurityCommandOperation(Short operationType, Integer preModId,
			Integer postModId, Integer commandId) {
		this.operationType = operationType;
		this.preModId = preModId;
		this.postModId = postModId;
		this.commandId = commandId;
	}

	// Property accessors

	public Integer getOperationId() {
		return this.operationId;
	}

	public void setOperationId(Integer operationId) {
		this.operationId = operationId;
	}

	public Short getOperationType() {
		return this.operationType;
	}

	public void setOperationType(Short operationType) {
		this.operationType = operationType;
	}

	public Integer getPreModId() {
		return this.preModId;
	}

	public void setPreModId(Integer preModId) {
		this.preModId = preModId;
	}

	public Integer getPostModId() {
		return this.postModId;
	}

	public void setPostModId(Integer postModId) {
		this.postModId = postModId;
	}

	public Integer getCommandId() {
		return this.commandId;
	}

	public void setCommandId(Integer commandId) {
		this.commandId = commandId;
	}

}