/**
 * 
 */
package com.hgsoft.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.PriceBase;
import com.hgsoft.service.PriceBaseService;
import com.hgsoft.service.SystemLogService;


/**��������
 * @author qinzuohai
 *
 */
@Controller
@Scope("prototype")
public class PriceBaseAction extends BaseAction{
	@Resource
	private SystemLogService systemLogService; 
	@Resource
	private PriceBaseService priceBaseService;
	private PriceBase priceBase;
	
	//�����б�
	public String list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("verNo");
		session.removeAttribute("vehTypeNo");
		session.removeAttribute("feeNo");
		
		list=priceBaseService.findByPager(pager);
		return "list";
	}
	
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("verNo");
		session.removeAttribute("vehTypeNo");
		session.removeAttribute("feeNo");
		
		if(priceBase.getVerNo()!=null||
				priceBase.getFeeNo()!=null||
				priceBase.getVehTypeNo()!=null){
			
			session.setAttribute("verNo", priceBase.getVerNo());
			session.setAttribute("vehTypeNo", priceBase.getVehTypeNo());
			session.setAttribute("feeNo", priceBase.getFeeNo());
			
			list=priceBaseService.findByCondition(pager, priceBase.getVerNo(), priceBase.getVehTypeNo(), priceBase.getFeeNo());
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
	public String savePriceBase(){
	
		//�ǳ����ֶγ�ʼֵ
		int rebateType=0;//�Ż�����
		int inOutSign=0;//�����ڱ�־
		int timesSign=0;//ʱ���־
		int baseFeeTime=60;//�׶�ͣ��ʱ��
		int baseFee=100;//�׶��շѽ��
		int addStart=1;//��λʱ������ʱ��
		int maxTime=720;//���ͣ��ʱ��
		int maxFeeTime=0;//ÿ���Ʒ���������շ�ʱ��
		int sumFeeCtr=1;//������ʿ���
		String backup1="0";//����1,�ɿ�
		String backup2="0";//����2,�ɿ�
		
		int feeNo=priceBaseService.findMaxFeeNo()+1;

		if(priceBaseService.ishasPriceBase(priceBase.getVerNo(), priceBase.getFeeNo(), priceBase.getRebateType()
				, priceBase.getInOutSign(), priceBase.getTimesSign(), priceBase.getVehTypeNo())==null){
			
			String vehType=null;
			
			if(priceBase.getVehTypeNo()!=0){
				if(priceBase.getVehTypeNo()==1)vehType="Ħ�г�";
				if(priceBase.getVehTypeNo()==2)vehType="С�γ�";
				if(priceBase.getVehTypeNo()==3)vehType="���ͳ�";
				if(priceBase.getVehTypeNo()==4)vehType="�����ͳ�";
				
				PriceBase temp=new PriceBase();
				temp.setVerNo(priceBase.getVerNo());
				temp.setFeeNo(feeNo);
				temp.setVehTypeNo(priceBase.getVehTypeNo());
				temp.setAllowStayTime(priceBase.getAllowStayTime());
				temp.setStayAdd(priceBase.getStayAdd()*60);//���ͣ�� ,Сʱ��Ϊ����
				temp.setAddFee(priceBase.getAddFee()*10);//��λ�շѽ��,Ԫ��Ϊ��
				temp.setMaxFee(priceBase.getMaxFee()*10);//����շ�,Ԫ��Ϊ��
				temp.setStartTime(priceBase.getStartTime());
				temp.setRemark(priceBase.getRemark());
				
				//��ʼ������ֵ�����û�û����дʱ�����ʼֵ
				if(priceBase.getRebateType()==null){
					temp.setRebateType(rebateType);
				}else{
					temp.setRebateType(priceBase.getRebateType());
				}
				if(priceBase.getInOutSign()==null){
					temp.setInOutSign(inOutSign);
				}else{
					temp.setInOutSign(priceBase.getInOutSign());
				}
				if(priceBase.getTimesSign()==null){
					temp.setTimesSign(timesSign);
				}else{
					temp.setTimesSign(priceBase.getTimesSign());
				}
				if(priceBase.getBaseFeeTime()==null){
					temp.setBaseFeeTime(baseFeeTime);
				}else{
					temp.setBaseFeeTime(priceBase.getBaseFeeTime());
				}
				if(priceBase.getBaseFee()==null){
					temp.setBaseFee(baseFee);
				}else{
					temp.setBaseFee(priceBase.getBaseFee());
				}
				if(priceBase.getAddStart()==null){
					temp.setAddStart(addStart);
				}else{
					temp.setAddStart(priceBase.getAddStart());
				}
				if(priceBase.getMaxTime()==null){
					temp.setMaxTime(maxTime);
				}else{
					temp.setMaxTime(priceBase.getMaxTime());
				}
				if(priceBase.getSumFeeCtr()==null){
					temp.setSumFeeCtr(sumFeeCtr);
				}else{
					temp.setSumFeeCtr(priceBase.getSumFeeCtr());
				}
				
				if(priceBase.getMaxFeeTime()==null){
					temp.setMaxFeeTime(maxFeeTime);
				}else{
					temp.setMaxFeeTime(priceBase.getMaxFeeTime());
				}
				
				if(priceBase.getBackup1().equals("")){
					temp.setBackup1(backup1);
				}else{
					temp.setBackup1(priceBase.getBackup1());
				}
				if(priceBase.getBackup2().equals("")){
					temp.setBackup2(backup2);
				}else{
					temp.setBackup2(priceBase.getBackup2());
				}
				priceBaseService.save(temp);
				
				systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���ӷ��ʰ汾Ϊ["+priceBase.getVerNo()+"]_���ʱ��Ϊ["+feeNo+"]_����Ϊ["+vehType+"]�ķ��ʳɹ�", "���÷���", "tb_PriceBase");
			}else{
				//�������������г���ʱ����������ֳ��ͷ���
				//��� 1��Ħ�г�
				PriceBase temp1=new PriceBase();
				temp1.setVerNo(priceBase.getVerNo());
				temp1.setFeeNo(feeNo);
				temp1.setVehTypeNo(1);
				temp1.setAllowStayTime(priceBase.getAllowStayTime());
				temp1.setStayAdd(priceBase.getStayAdd()*60);//���ͣ�� ,Сʱ��Ϊ����
				temp1.setAddFee(priceBase.getAddFee()*10);//��λ�շѽ��,Ԫ��Ϊ��
				temp1.setMaxFee(priceBase.getMaxFee()*10);//����շ�,Ԫ��Ϊ��
				temp1.setStartTime(priceBase.getStartTime());
				temp1.setRemark(priceBase.getRemark());
				//��ʼ������ֵ�����û�û����дʱ�����ʼֵ
				if(priceBase.getRebateType()==null){
					temp1.setRebateType(rebateType);
				}else{
					temp1.setRebateType(priceBase.getRebateType());
				}
				if(priceBase.getInOutSign()==null){
					temp1.setInOutSign(inOutSign);
				}else{
					temp1.setInOutSign(priceBase.getInOutSign());
				}
				if(priceBase.getTimesSign()==null){
					temp1.setTimesSign(timesSign);
				}else{
					temp1.setTimesSign(priceBase.getTimesSign());
				}
				if(priceBase.getBaseFeeTime()==null){
					temp1.setBaseFeeTime(baseFeeTime);
				}else{
					temp1.setBaseFeeTime(priceBase.getBaseFeeTime());
				}
				if(priceBase.getBaseFee()==null){
					temp1.setBaseFee(baseFee);
				}else{
					temp1.setBaseFee(priceBase.getBaseFee());
				}
				if(priceBase.getAddStart()==null){
					temp1.setAddStart(addStart);
				}else{
					temp1.setAddStart(priceBase.getAddStart());
				}
				if(priceBase.getMaxTime()==null){
					temp1.setMaxTime(maxTime);
				}else{
					temp1.setMaxTime(priceBase.getMaxTime());
				}
				if(priceBase.getSumFeeCtr()==null){
					temp1.setSumFeeCtr(sumFeeCtr);
				}else{
					temp1.setSumFeeCtr(priceBase.getSumFeeCtr());
				}
				if(priceBase.getMaxFeeTime()==null){
					temp1.setMaxFeeTime(maxFeeTime);
				}else{
					temp1.setMaxFeeTime(priceBase.getMaxFeeTime());
				}
				if(priceBase.getBackup1().equals("")){
					temp1.setBackup1(backup1);
				}else{
					temp1.setBackup1(priceBase.getBackup1());
				}
				if(priceBase.getBackup2().equals("")){
					temp1.setBackup2(backup2);
				}else{
					temp1.setBackup2(priceBase.getBackup2());
				}
				priceBaseService.save(temp1);
				
				//��� 2��С�γ�
				PriceBase temp2=new PriceBase();
				temp2=temp1;
				temp2.setVehTypeNo(2);
				priceBaseService.save(temp2);
				
				//��� 3�����ͳ�
				PriceBase temp3=new PriceBase();
				temp3=temp1;
				temp3.setVehTypeNo(3);
				priceBaseService.save(temp3);
				
				//��� 4�������ͳ�
				PriceBase temp4=new PriceBase();
				temp4=temp1;
				temp4.setVehTypeNo(4);
				priceBaseService.save(temp4);
				systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���ӷ��ʰ汾Ϊ["+priceBase.getVerNo()+"]_���ʱ��Ϊ["+feeNo+"]_����Ϊ[Ħ�г���С�γ������ͳ��������ͳ�]�ķ��ʳɹ�", "�������г��͵ķ���", "tb_PriceBase");
			};
			result = Result.SUCCESS;	
		}
		else{
			String vehType=null;
			if(priceBase.getVehTypeNo()==1)vehType="Ħ�г�";
			if(priceBase.getVehTypeNo()==2)vehType="С�γ�";
			if(priceBase.getVehTypeNo()==3)vehType="���ͳ�";
			if(priceBase.getVehTypeNo()==4)vehType="�����ͳ�";
			message ="hasPriceBase";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���ӷ��ʰ汾Ϊ["+priceBase.getVerNo()+"]_���ʱ��Ϊ["+feeNo+"]_����Ϊ["+vehType+"]�ķ���ʧ�ܣ��Ѵ��ڸ÷���", "���÷���", "tb_PriceBase");
			return "add";		
		}
		priceBase=null;
		return  list();
	}
	
	//��ת�������޸�ҳ��
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		priceBase=priceBaseService.LoadPriceBase(priceBase.getVerNo(), priceBase.getFeeNo(), priceBase.getRebateType()
				, priceBase.getInOutSign(), priceBase.getTimesSign(), priceBase.getVehTypeNo()).get(0);
		return "edit";
	}
	//�޸ķ���
	public String updatePriceBase(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		//�ǳ����ֶγ�ʼֵ
		int rebateType=0;//�Ż�����
		int inOutSign=0;//�����ڱ�־
		int timesSign=0;//ʱ���־
		int baseFeeTime=60;//�׶�ͣ��ʱ��
		int baseFee=100;//�׶��շѽ��
		int addStart=1;//��λʱ������ʱ��
		int maxTime=720;//���ͣ��ʱ��
		int maxFeeTime=0;//ÿ���Ʒ���������շ�ʱ��
		int sumFeeCtr=1;//������ʿ���
		String backup1="0";//����1,�ɿ�
		String backup2="0";//����2,�ɿ�
		
		PriceBase temp=new PriceBase();
		temp.setVerNo(priceBase.getVerNo());
		temp.setFeeNo(priceBase.getFeeNo());
		temp.setVehTypeNo(priceBase.getVehTypeNo());
		temp.setAllowStayTime(priceBase.getAllowStayTime());
		temp.setStayAdd(priceBase.getStayAdd()*60);//���ͣ�� ,Сʱ��Ϊ����
		temp.setAddFee(priceBase.getAddFee()*10);//��λ�շѽ��,Ԫ��Ϊ��
		temp.setMaxFee(priceBase.getMaxFee()*10);//����շ�,Ԫ��Ϊ��
		temp.setStartTime(priceBase.getStartTime());
		temp.setRemark(priceBase.getRemark());
		
		//��ʼ������ֵ�����û�û����дʱ�����ʼֵ
		if(priceBase.getRebateType()==null){
			temp.setRebateType(rebateType);
		}else{
			temp.setRebateType(priceBase.getRebateType());
		}
		if(priceBase.getInOutSign()==null){
			temp.setInOutSign(inOutSign);
		}else{
			temp.setInOutSign(priceBase.getInOutSign());
		}
		if(priceBase.getTimesSign()==null){
			temp.setTimesSign(timesSign);
		}else{
			temp.setTimesSign(priceBase.getTimesSign());
		}
		if(priceBase.getBaseFeeTime()==null){
			temp.setBaseFeeTime(baseFeeTime);
		}else{
			temp.setBaseFeeTime(priceBase.getBaseFeeTime());
		}
		if(priceBase.getBaseFee()==null){
			temp.setBaseFee(baseFee);
		}else{
			temp.setBaseFee(priceBase.getBaseFee());
		}
		if(priceBase.getAddStart()==null){
			temp.setAddStart(addStart);
		}else{
			temp.setAddStart(priceBase.getAddStart());
		}
		if(priceBase.getMaxTime()==null){
			temp.setMaxTime(maxTime);
		}else{
			temp.setMaxTime(priceBase.getMaxTime());
		}
		if(priceBase.getSumFeeCtr()==null){
			temp.setSumFeeCtr(sumFeeCtr);
		}else{
			temp.setSumFeeCtr(priceBase.getSumFeeCtr());
		}
		if(priceBase.getMaxFeeTime()==null){
			temp.setMaxFeeTime(maxFeeTime);
		}else{
			temp.setMaxFeeTime(priceBase.getMaxFeeTime());
		}
		if(priceBase.getBackup1().equals("")){
			temp.setBackup1(backup1);
		}else{
			temp.setBackup1(priceBase.getBackup1());
		}
		if(priceBase.getBackup2().equals("")){
			temp.setBackup2(backup2);
		}else{
			temp.setBackup2(priceBase.getBackup2());
		}
		priceBaseService.update(temp);
		message="updateSuccess";

		String vehType=null;
		if(priceBase.getVehTypeNo()==1)vehType="Ħ�г�";
		if(priceBase.getVehTypeNo()==2)vehType="С�γ�";
		if(priceBase.getVehTypeNo()==3)vehType="���ͳ�";
		if(priceBase.getVehTypeNo()==4)vehType="�����ͳ�";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��޸ķ��ʰ汾Ϊ["+priceBase.getVerNo()+"]_���ʱ��Ϊ["+priceBase.getFeeNo()+"]_����Ϊ["+vehType+"]�ķ��ʳɹ�", "�޸ķ���", "tb_PriceBase");
		
		if(session.getAttribute("verNo")!=null||
				session.getAttribute("vehTypeNo")!=null||
				session.getAttribute("feeNo")!=null){
			
			priceBase.setVerNo((Integer) session.getAttribute("verNo"));
			priceBase.setVehTypeNo((Integer) session.getAttribute("vehTypeNo"));
			priceBase.setFeeNo((Integer) session.getAttribute("feeNo"));
			list=priceBaseService.findByCondition(pager, priceBase.getVerNo(), priceBase.getVehTypeNo(), priceBase.getFeeNo());
			return "list";
			
		}else{
			priceBase=null;
			list=priceBaseService.findByPager(pager);
			return "list";
		}
	}
	
	//ɾ������
	public String delete(){
		priceBaseService.deleteBycompositeID(priceBase.getVerNo(), priceBase.getFeeNo(), priceBase.getRebateType()
				, priceBase.getInOutSign(), priceBase.getTimesSign(), priceBase.getVehTypeNo());

		message="deleteSuccess";
		String vehType=null;
		if(priceBase.getVehTypeNo()==1)vehType="Ħ�г�";
		if(priceBase.getVehTypeNo()==2)vehType="С�γ�";
		if(priceBase.getVehTypeNo()==3)vehType="���ͳ�";
		if(priceBase.getVehTypeNo()==4)vehType="�����ͳ�";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ�����ʰ汾Ϊ["+priceBase.getVerNo()+"]_���ʱ��Ϊ["+priceBase.getFeeNo()+"]_����Ϊ["+vehType+"]�ķ��ʳɹ�", "ɾ������", "tb_PriceBase");
		priceBase=null;
		return list();
	}
	
	//Getter/Setter
	public PriceBase getPriceBase() {
		return priceBase;
	}
	public void setPriceBase(PriceBase priceBase) {
		this.priceBase = priceBase;
	}

	
}
