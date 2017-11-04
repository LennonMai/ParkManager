package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.TicketTypeCode;
import com.hgsoft.util.Pager;

@Repository 
public class TicketTypeCodeDao extends BaseDao<TicketTypeCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<TicketTypeCode> findByCondition(Pager pager,Short ticketTypeNo,String  ticketTypeName){
		StringBuffer sf = new StringBuffer("from TicketTypeCode ticketTypeCode where");
		List<Object> obj = new ArrayList<Object>();
		
		if (ticketTypeNo!=null) {
			sf.append(" ticketTypeCode.ticketTypeNo = ? and");
			obj.add(ticketTypeNo);
		}
		if (!ticketTypeName.equals("")){
			sf.append(" ticketTypeCode.ticketTypeName like ? and");
			obj.add("%"+ticketTypeName+"%");
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
