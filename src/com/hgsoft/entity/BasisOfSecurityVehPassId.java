package com.hgsoft.entity;

/**
 * TbBasisOfSecurityVehPassId entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class BasisOfSecurityVehPassId implements java.io.Serializable {

	// Fields

	private String vehPassId;
	private Integer commandId;
	private Integer commandModId;

	// Constructors

	/** default constructor */
	public BasisOfSecurityVehPassId() {
	}

	/** full constructor */
	public BasisOfSecurityVehPassId(String vehPassId, Integer commandId,
			Integer commandModId) {
		this.vehPassId = vehPassId;
		this.commandId = commandId;
		this.commandModId = commandModId;
	}

	// Property accessors

	public String getVehPassId() {
		return this.vehPassId;
	}

	public void setVehPassId(String vehPassId) {
		this.vehPassId = vehPassId;
	}

	public Integer getCommandId() {
		return this.commandId;
	}

	public void setCommandId(Integer commandId) {
		this.commandId = commandId;
	}

	public Integer getCommandModId() {
		return this.commandModId;
	}

	public void setCommandModId(Integer commandModId) {
		this.commandModId = commandModId;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof BasisOfSecurityVehPassId))
			return false;
		BasisOfSecurityVehPassId castOther = (BasisOfSecurityVehPassId) other;

		return ((this.getVehPassId() == castOther.getVehPassId()) || (this
				.getVehPassId() != null
				&& castOther.getVehPassId() != null && this.getVehPassId()
				.equals(castOther.getVehPassId())))
				&& ((this.getCommandId() == castOther.getCommandId()) || (this
						.getCommandId() != null
						&& castOther.getCommandId() != null && this
						.getCommandId().equals(castOther.getCommandId())))
				&& ((this.getCommandModId() == castOther.getCommandModId()) || (this
						.getCommandModId() != null
						&& castOther.getCommandModId() != null && this
						.getCommandModId().equals(castOther.getCommandModId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getVehPassId() == null ? 0 : this.getVehPassId().hashCode());
		result = 37 * result
				+ (getCommandId() == null ? 0 : this.getCommandId().hashCode());
		result = 37
				* result
				+ (getCommandModId() == null ? 0 : this.getCommandModId()
						.hashCode());
		return result;
	}

}