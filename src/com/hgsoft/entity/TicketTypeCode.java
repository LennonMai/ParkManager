package com.hgsoft.entity;
/**
 * 通行卷类型编码
 *
 */
@SuppressWarnings("serial")
public class TicketTypeCode implements java.io.Serializable {

	private Short ticketTypeNo;//PK 通行券类型编码
	private String ticketTypeName;//通行券类型名称


	public TicketTypeCode() {
	}

	public TicketTypeCode(Short ticketTypeNo, String ticketTypeName) {
		this.ticketTypeNo = ticketTypeNo;
		this.ticketTypeName = ticketTypeName;
	}

	public Short getTicketTypeNo() {
		return this.ticketTypeNo;
	}

	public void setTicketTypeNo(Short ticketTypeNo) {
		this.ticketTypeNo = ticketTypeNo;
	}

	public String getTicketTypeName() {
		return this.ticketTypeName;
	}

	public void setTicketTypeName(String ticketTypeName) {
		this.ticketTypeName = ticketTypeName;
	}
}