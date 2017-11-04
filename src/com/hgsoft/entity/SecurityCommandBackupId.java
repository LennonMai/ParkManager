package com.hgsoft.entity;


public class SecurityCommandBackupId implements java.io.Serializable {

	private Integer commandId;
	private Integer modId;

	public SecurityCommandBackupId() {
	}

	public SecurityCommandBackupId(Integer commandId, Integer modId) {
		this.commandId = commandId;
		this.modId = modId;
	}

	// Property accessors

	public Integer getCommandId() {
		return this.commandId;
	}

	public void setCommandId(Integer commandId) {
		this.commandId = commandId;
	}

	public Integer getModId() {
		return this.modId;
	}

	public void setModId(Integer modId) {
		this.modId = modId;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SecurityCommandBackupId))
			return false;
		SecurityCommandBackupId castOther = (SecurityCommandBackupId) other;

		return ((this.getCommandId() == castOther.getCommandId()) || (this
				.getCommandId() != null
				&& castOther.getCommandId() != null && this.getCommandId()
				.equals(castOther.getCommandId())))
				&& ((this.getModId() == castOther.getModId()) || (this
						.getModId() != null
						&& castOther.getModId() != null && this.getModId()
						.equals(castOther.getModId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getCommandId() == null ? 0 : this.getCommandId().hashCode());
		result = 37 * result
				+ (getModId() == null ? 0 : this.getModId().hashCode());
		return result;
	}

}