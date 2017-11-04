package com.hgsoft.action;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.service.CardDynamicService;

@Controller
@Scope("prototype")
public class CardScatterAction extends BaseAction {
	
	@SuppressWarnings("unchecked") private List cardScatterList;
	@SuppressWarnings("unchecked") private List userCardTypeList;
	@SuppressWarnings("unchecked") private List ticketTypeList;
	
	@Resource private CardDynamicService cardDynamicService;
	
	/**
	 * 查询卡分布情况
	 */
	@SuppressWarnings("unchecked")
	public String queryCardScatter(){
		cardScatterList = cardDynamicService.queryCardScatter();
		userCardTypeList = cardDynamicService.queryUserCardTypeScatter();
		ticketTypeList = cardDynamicService.queryTicketTypeScatter();
		return "cardScatter";
	}
	
	@SuppressWarnings("unchecked")
	public List getCardScatterList() {
		return cardScatterList;
	}
	@SuppressWarnings("unchecked")
	public void setCardScatterList(List cardScatterList) {
		this.cardScatterList = cardScatterList;
	}

	@SuppressWarnings("unchecked")
	public List getUserCardTypeList() {
		return userCardTypeList;
	}

	@SuppressWarnings("unchecked")
	public void setUserCardTypeList(List userCardTypeList) {
		this.userCardTypeList = userCardTypeList;
	}

	@SuppressWarnings("unchecked")
	public List getTicketTypeList() {
		return ticketTypeList;
	}

	@SuppressWarnings("unchecked")
	public void setTicketTypeList(List ticketTypeList) {
		this.ticketTypeList = ticketTypeList;
	}

}
