package com.hgsoft.entity;
/**
 * ͨ�о����ͱ���
 *
 */
@SuppressWarnings("serial")
public class TicketTypeCode implements java.io.Serializable {

	private Short ticketTypeNo;//PK ͨ��ȯ���ͱ���
	private String ticketTypeName;//ͨ��ȯ��������


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