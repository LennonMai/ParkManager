package com.hgsoft.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.PriceRule;
import com.hgsoft.service.PriceRuleService;
import com.hgsoft.service.SystemLogService;

/**
 * 车道费率
 * @author qinzuohai
 */
@Controller
@Scope("prototype")
public class PriceRuleAction extends BaseAction{
	@Resource
	private SystemLogService systemLogService; 

	@Resource
	private PriceRuleService priceRuleService;
	private PriceRule priceRule;
	
	//费率列表
	public String list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("verNo");
		session.removeAttribute("feeTypeNo");
		session.removeAttribute("vehTypeNo");
		
		//按启用时间倒序排列
		list=priceRuleService.findByStartTimePager(pager);
		return "list";
	}
	
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("verNo");
		session.removeAttribute("feeTypeNo");
		session.removeAttribute("vehTypeNo");
		
		if(priceRule.getVerNo()!=null||
				priceRule.getFeeTypeNo()!=null||
				priceRule.getVehTypeNo()!=null){
			
			session.setAttribute("verNo",priceRule.getVerNo());
			session.setAttribute("feeTypeNo",priceRule.getFeeTypeNo());
			session.setAttribute("vehTypeNo",priceRule.getVehTypeNo());
			list=priceRuleService.findByCondition(pager, priceRule.getVerNo(), priceRule.getFeeTypeNo(), priceRule.getVehTypeNo());
			return "list";
		}else{
			return list();
		}
		
		
	}
	
	//跳转到费率添加页面
	public String add(){	
		return "add";
	}
	//添加费率
	public String savePriceRule(){
		String vehType=null;
		if(priceRule.getVehTypeNo()==1)vehType="摩托车";
		if(priceRule.getVehTypeNo()==2)vehType="小轿车";
		if(priceRule.getVehTypeNo()==3)vehType="大型车";
		if(priceRule.getVehTypeNo()==4)vehType="超大型车";
		if(priceRuleService.ishasPriceRule(this.getPriceRule().getParkNo(),this.getPriceRule().getFeeTypeNo(),
				this.getPriceRule().getVehTypeNo(),this.getPriceRule().getStartRange())==null){
			
			priceRuleService.save(priceRule);
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加小区编码为["+this.getPriceRule().getParkNo()+"]_收费类型为["+this.getPriceRule().getFeeTypeNo()+"]_车型为["+vehType+"]_最小时间为["+this.getPriceRule().getStartRange()+"]的车道费率成功", "添加车道费率", "tb_PriceRule");
			result = Result.SUCCESS;	
		}
		else{
			message ="hasPriceRule";
			return "add";		
		}
		priceRule=null;
		return  list();
	}
	
	//跳转到费率修改页面
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		priceRule=priceRuleService.LoadPriceRule(this.getPriceRule().getParkNo(),this.getPriceRule().getFeeTypeNo(),
				this.getPriceRule().getVehTypeNo(),this.getPriceRule().getStartRange()).get(0);
		return "edit";
	}
	//修改费率
	public String updatePriceRule(){
		/*System.out.println("-------"+this.getPriceRule().getParkNo()+"-"+this.getPriceRule().getFeeTypeNo()+"-"+
		this.getPriceRule().getVehTypeNo()+"-"+this.getPriceRule().getStartRange());*/
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		String vehType=null;
		if(priceRule.getVehTypeNo()==1)vehType="摩托车";
		if(priceRule.getVehTypeNo()==2)vehType="小轿车";
		if(priceRule.getVehTypeNo()==3)vehType="大型车";
		if(priceRule.getVehTypeNo()==4)vehType="超大型车";
		
		priceRuleService.update(priceRule);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改小区编码为["+priceRule.getParkNo()+"]_收费类型为["+priceRule.getFeeTypeNo()+"]_车型为["+vehType+"]_最小时间为["+priceRule.getStartRange()+"]的车道费率成功", "修改车道费率", "tb_PriceRule");
		
		if(session.getAttribute("verNo")!=null||
				session.getAttribute("feeTypeNo")!=null||
				session.getAttribute("vehTypeNo")!=null){
			
			priceRule.setVerNo((Integer) session.getAttribute("verNo"));
			priceRule.setFeeTypeNo((Short) session.getAttribute("feeTypeNo"));
			priceRule.setVehTypeNo((Short) session.getAttribute("vehTypeNo"));
			list=priceRuleService.findByCondition(pager, priceRule.getVerNo(), priceRule.getFeeTypeNo(), priceRule.getVehTypeNo());
			return "list";
			
		}else{
			priceRule=null;
			list=priceRuleService.findByStartTimePager(pager);
			return "list";
		}
	}
	
	//删除费率
	public String delete(){
		String vehType=null;
		if(priceRule.getVehTypeNo()==1)vehType="摩托车";
		if(priceRule.getVehTypeNo()==2)vehType="小轿车";
		if(priceRule.getVehTypeNo()==3)vehType="大型车";
		if(priceRule.getVehTypeNo()==4)vehType="超大型车";
			
		priceRuleService.deleteBycompositeID(this.getPriceRule().getParkNo(),this.getPriceRule().getFeeTypeNo(),
				this.getPriceRule().getVehTypeNo(),this.getPriceRule().getStartRange());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除小区编码为["+priceRule.getParkNo()+"]_收费类型为["+priceRule.getFeeTypeNo()+"]_车型为["+vehType+"]_最小时间为["+priceRule.getStartRange()+"]的车道费率成功", "删除车道费率", "tb_PriceRule");
		priceRule=null;
		return list();
	}
	
	//Getter/Setter
	public PriceRule getPriceRule() {
		return priceRule;
	}
	public void setPriceRule(PriceRule priceRule) {
		this.priceRule = priceRule;
	}
	
}
