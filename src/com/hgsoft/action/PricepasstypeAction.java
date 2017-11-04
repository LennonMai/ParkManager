package com.hgsoft.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Pricepasstype;
import com.hgsoft.service.PricepasstypeService;
import com.hgsoft.service.SystemLogService;

/**
 * 收费类型影射Action
 * @author caijunhua
 */

@Controller
@Scope("prototype")
public class PricepasstypeAction extends BaseAction {
	@Resource private PricepasstypeService pricepasstypeService;
	@Resource private SystemLogService systemLogService;
	
	private Pricepasstype pricepasstype;
	
	/**
	 * 列表信息
	 * @return
	 */
	public String list() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		
		list = pricepasstypeService.findByPager(pager);
		return "list";
	}
	
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("parkNo");
		session.removeAttribute("inGateNo");
		session.removeAttribute("outGateNo");
		session.removeAttribute("feeType");
		session.removeAttribute("verNo");
		
		if(pricepasstype.getParkNo()!=null||pricepasstype.getInGateNo()!=null||
				pricepasstype.getOutGateNo()!=null||pricepasstype.getFeeType()!=null){
			session.setAttribute("parkNo", pricepasstype.getParkNo());
			session.setAttribute("inGateNo", pricepasstype.getInGateNo());
			session.setAttribute("outGateNo", pricepasstype.getOutGateNo());
			session.setAttribute("feeType", pricepasstype.getFeeType());
			session.setAttribute("verNo", pricepasstype.getVerNo());
			
			list=pricepasstypeService.getByCondition(pager, pricepasstype.getParkNo(),
					pricepasstype.getInGateNo(), pricepasstype.getOutGateNo(),
					pricepasstype.getFeeType(), pricepasstype.getVerNo());
			return "list";
			
		}else{
			return list();
		}
	}
	
	public String add() {
		return "add";
	}
	
	public String savePricepasstype() {
		if(pricepasstypeService.isExist(pricepasstype.getParkNo(), pricepasstype.getInGateNo(),
				pricepasstype.getOutGateNo(), pricepasstype.getFeeType(), pricepasstype.getVerNo())) {
			message = "hasPricepasstype";
			return "add";
		} else {
			Pricepasstype pricepasstypeTemp = new Pricepasstype();
			pricepasstypeTemp.setParkNo(pricepasstype.getParkNo());
			pricepasstypeTemp.setInGateNo(pricepasstype.getInGateNo());
			pricepasstypeTemp.setOutGateNo(pricepasstype.getOutGateNo());
			pricepasstypeTemp.setFeeType(pricepasstype.getFeeType());
			pricepasstypeTemp.setVerNo(pricepasstype.getVerNo());
			
			pricepasstypeService.save(pricepasstypeTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+
					this.getCurrentOperator().getUsername()+"用户添加小区编号为[" + pricepasstype.getParkNo() +
					"],收费类型号为["+pricepasstype.getFeeType()+"]的收费类型影射信息成功",
					"参数管理--费率信息--收费类型影射--添加", "tb_PricePassType");
			
			pricepasstype = null;
		}
		return list();
	}
	
	public String delete() {
		pricepasstype = pricepasstypeService.getPricepasstype(pricepasstype.getParkNo(), 
				pricepasstype.getInGateNo(),pricepasstype.getOutGateNo(),
				pricepasstype.getFeeType(), pricepasstype.getVerNo());
		pricepasstypeService.delete(pricepasstype);
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+
				this.getCurrentOperator().getUsername()+"用户添加小区编号为[" + pricepasstype.getParkNo() +
				"],收费类型号为["+pricepasstype.getFeeType()+"]的收费类型影射信息成功",
				"参数管理--费率信息--收费类型影射--删除", "tb_PricePassType");
		//去除查询条件显示
		pricepasstype = null;
		return list();
	}
/*	public String edit() {
		setAttribute();
		pricepasstype = pricepasstypeService.getPricepasstype(pricepasstype.getParkNo(), 
				pricepasstype.getInGateNo(),pricepasstype.getOutGateNo(),
				pricepasstype.getFeeType(), pricepasstype.getVerNo());
		return "edit";
	}
	
	public String updatePricepasstype() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		if(pricepasstypeService.isExist(pricepasstype.getParkNo(), pricepasstype.getInGateNo(),
				pricepasstype.getOutGateNo(), pricepasstype.getFeeType(), pricepasstype.getVerNo())) {
			result = Result.FAIL;
			return "edit";
		} else {
			pricepasstypeService.updatePricepasstype(pricepasstype.getParkNo(),pricepasstype.getInGateNo(),
					pricepasstype.getOutGateNo(),pricepasstype.getFeeType(),
					pricepasstype.getVerNo());
			Pricepasstype pricepasstypeTemp = new Pricepasstype();
			pricepasstypeTemp.setParkNo(pricepasstype.getParkNo());
			pricepasstypeTemp.setInGateNo(pricepasstype.getInGateNo());
			pricepasstypeTemp.setOutGateNo(pricepasstype.getOutGateNo());
			pricepasstypeTemp.setFeeType(pricepasstype.getFeeType());
			pricepasstypeTemp.setVerNo(pricepasstype.getVerNo());
			
			pricepasstypeService.update(pricepasstypeTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),"["+this.getCurrentOperator().getId()+"]"+
					this.getCurrentOperator().getUsername()+"用户修改小区编号为[" + pricepasstype.getParkNo() +
					"],收费类型号为["+pricepasstype.getFeeType()+"]的收费类型影射信息成功",
					"参数管理--费率信息--收费类型影射--修改", "tb_PricePassType");
			list = pricepasstypeService.findByPager(pager);
//			pricepasstypeTemp = null;
			return "list";
		}
	}

	private void setAttribute() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}*/
	
	public Pricepasstype getPricepasstype() {
		return pricepasstype;
	}
	public void setPricepasstype(Pricepasstype pricepasstype) {
		this.pricepasstype = pricepasstype;
	}
}
