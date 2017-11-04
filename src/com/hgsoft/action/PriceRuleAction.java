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
 * ��������
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
	
	//�����б�
	public String list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("verNo");
		session.removeAttribute("feeTypeNo");
		session.removeAttribute("vehTypeNo");
		
		//������ʱ�䵹������
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
	
	//��ת���������ҳ��
	public String add(){	
		return "add";
	}
	//��ӷ���
	public String savePriceRule(){
		String vehType=null;
		if(priceRule.getVehTypeNo()==1)vehType="Ħ�г�";
		if(priceRule.getVehTypeNo()==2)vehType="С�γ�";
		if(priceRule.getVehTypeNo()==3)vehType="���ͳ�";
		if(priceRule.getVehTypeNo()==4)vehType="�����ͳ�";
		if(priceRuleService.ishasPriceRule(this.getPriceRule().getParkNo(),this.getPriceRule().getFeeTypeNo(),
				this.getPriceRule().getVehTypeNo(),this.getPriceRule().getStartRange())==null){
			
			priceRuleService.save(priceRule);
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û����С������Ϊ["+this.getPriceRule().getParkNo()+"]_�շ�����Ϊ["+this.getPriceRule().getFeeTypeNo()+"]_����Ϊ["+vehType+"]_��Сʱ��Ϊ["+this.getPriceRule().getStartRange()+"]�ĳ������ʳɹ�", "��ӳ�������", "tb_PriceRule");
			result = Result.SUCCESS;	
		}
		else{
			message ="hasPriceRule";
			return "add";		
		}
		priceRule=null;
		return  list();
	}
	
	//��ת�������޸�ҳ��
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
	//�޸ķ���
	public String updatePriceRule(){
		/*System.out.println("-------"+this.getPriceRule().getParkNo()+"-"+this.getPriceRule().getFeeTypeNo()+"-"+
		this.getPriceRule().getVehTypeNo()+"-"+this.getPriceRule().getStartRange());*/
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		String vehType=null;
		if(priceRule.getVehTypeNo()==1)vehType="Ħ�г�";
		if(priceRule.getVehTypeNo()==2)vehType="С�γ�";
		if(priceRule.getVehTypeNo()==3)vehType="���ͳ�";
		if(priceRule.getVehTypeNo()==4)vehType="�����ͳ�";
		
		priceRuleService.update(priceRule);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��޸�С������Ϊ["+priceRule.getParkNo()+"]_�շ�����Ϊ["+priceRule.getFeeTypeNo()+"]_����Ϊ["+vehType+"]_��Сʱ��Ϊ["+priceRule.getStartRange()+"]�ĳ������ʳɹ�", "�޸ĳ�������", "tb_PriceRule");
		
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
	
	//ɾ������
	public String delete(){
		String vehType=null;
		if(priceRule.getVehTypeNo()==1)vehType="Ħ�г�";
		if(priceRule.getVehTypeNo()==2)vehType="С�γ�";
		if(priceRule.getVehTypeNo()==3)vehType="���ͳ�";
		if(priceRule.getVehTypeNo()==4)vehType="�����ͳ�";
			
		priceRuleService.deleteBycompositeID(this.getPriceRule().getParkNo(),this.getPriceRule().getFeeTypeNo(),
				this.getPriceRule().getVehTypeNo(),this.getPriceRule().getStartRange());

		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ��С������Ϊ["+priceRule.getParkNo()+"]_�շ�����Ϊ["+priceRule.getFeeTypeNo()+"]_����Ϊ["+vehType+"]_��Сʱ��Ϊ["+priceRule.getStartRange()+"]�ĳ������ʳɹ�", "ɾ����������", "tb_PriceRule");
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
