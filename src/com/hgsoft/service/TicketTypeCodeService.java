package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.TicketTypeCodeDao;
import com.hgsoft.entity.TicketTypeCode;
import com.hgsoft.util.Pager;

@Service
public class TicketTypeCodeService extends BaseService<TicketTypeCode> {

	@Autowired
	public void setDao(@Qualifier("ticketTypeCodeDao") TicketTypeCodeDao dao) {
		super.setDao(dao);
	}

	private TicketTypeCodeDao getTicketTypeCodeDao() {
		return (TicketTypeCodeDao) this.getDao();
	}

	public List<TicketTypeCode> findByCondition(Pager pager, Short ticketTypeNo, String ticketTypeName) {
		return getTicketTypeCodeDao().findByCondition(pager, ticketTypeNo, ticketTypeName);
	}

}
