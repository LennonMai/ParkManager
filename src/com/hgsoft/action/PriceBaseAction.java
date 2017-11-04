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


/**费率配置
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
	
	//费率列表
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
	
	//跳转到费率添加页面
	public String add(){	
		return "add";
	}
	
	//添加费率
	public String savePriceBase(){
	
		//非常用字段初始值
		int rebateType=0;//优惠类型
		int inOutSign=0;//进出口标志
		int timesSign=0;//时间标志
		int baseFeeTime=60;//首段停留时间
		int baseFee=100;//首段收费金额
		int addStart=1;//单位时间起算时间
		int maxTime=720;//最大停留时间
		int maxFeeTime=0;//每个计费周期最大收费时间
		int sumFeeCtr=1;//计算费率控制
		String backup1="0";//备用1,可空
		String backup2="0";//备用2,可空
		
		int feeNo=priceBaseService.findMaxFeeNo()+1;

		if(priceBaseService.ishasPriceBase(priceBase.getVerNo(), priceBase.getFeeNo(), priceBase.getRebateType()
				, priceBase.getInOutSign(), priceBase.getTimesSign(), priceBase.getVehTypeNo())==null){
			
			String vehType=null;
			
			if(priceBase.getVehTypeNo()!=0){
				if(priceBase.getVehTypeNo()==1)vehType="摩托车";
				if(priceBase.getVehTypeNo()==2)vehType="小轿车";
				if(priceBase.getVehTypeNo()==3)vehType="大型车";
				if(priceBase.getVehTypeNo()==4)vehType="超大型车";
				
				PriceBase temp=new PriceBase();
				temp.setVerNo(priceBase.getVerNo());
				temp.setFeeNo(feeNo);
				temp.setVehTypeNo(priceBase.getVehTypeNo());
				temp.setAllowStayTime(priceBase.getAllowStayTime());
				temp.setStayAdd(priceBase.getStayAdd()*60);//免费停留 ,小时化为分钟
				temp.setAddFee(priceBase.getAddFee()*10);//单位收费金额,元化为分
				temp.setMaxFee(priceBase.getMaxFee()*10);//最多收费,元化为分
				temp.setStartTime(priceBase.getStartTime());
				temp.setRemark(priceBase.getRemark());
				
				//初始化以下值，当用户没有填写时赋予初始值
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
				
				systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加费率版本为["+priceBase.getVerNo()+"]_费率编号为["+feeNo+"]_车型为["+vehType+"]的费率成功", "配置费率", "tb_PriceBase");
			}else{
				//当车类型是所有车型时，将添加四种车型费率
				//添加 1－摩托车
				PriceBase temp1=new PriceBase();
				temp1.setVerNo(priceBase.getVerNo());
				temp1.setFeeNo(feeNo);
				temp1.setVehTypeNo(1);
				temp1.setAllowStayTime(priceBase.getAllowStayTime());
				temp1.setStayAdd(priceBase.getStayAdd()*60);//免费停留 ,小时化为分钟
				temp1.setAddFee(priceBase.getAddFee()*10);//单位收费金额,元化为分
				temp1.setMaxFee(priceBase.getMaxFee()*10);//最多收费,元化为分
				temp1.setStartTime(priceBase.getStartTime());
				temp1.setRemark(priceBase.getRemark());
				//初始化以下值，当用户没有填写时赋予初始值
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
				
				//添加 2－小轿车
				PriceBase temp2=new PriceBase();
				temp2=temp1;
				temp2.setVehTypeNo(2);
				priceBaseService.save(temp2);
				
				//添加 3－大型车
				PriceBase temp3=new PriceBase();
				temp3=temp1;
				temp3.setVehTypeNo(3);
				priceBaseService.save(temp3);
				
				//添加 4－超大型车
				PriceBase temp4=new PriceBase();
				temp4=temp1;
				temp4.setVehTypeNo(4);
				priceBaseService.save(temp4);
				systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加费率版本为["+priceBase.getVerNo()+"]_费率编号为["+feeNo+"]_车型为[摩托车、小轿车、大型车、超大型车]的费率成功", "配置所有车型的费率", "tb_PriceBase");
			};
			result = Result.SUCCESS;	
		}
		else{
			String vehType=null;
			if(priceBase.getVehTypeNo()==1)vehType="摩托车";
			if(priceBase.getVehTypeNo()==2)vehType="小轿车";
			if(priceBase.getVehTypeNo()==3)vehType="大型车";
			if(priceBase.getVehTypeNo()==4)vehType="超大型车";
			message ="hasPriceBase";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加费率版本为["+priceBase.getVerNo()+"]_费率编号为["+feeNo+"]_车型为["+vehType+"]的费率失败，已存在该费率", "配置费率", "tb_PriceBase");
			return "add";		
		}
		priceBase=null;
		return  list();
	}
	
	//跳转到费率修改页面
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
	//修改费率
	public String updatePriceBase(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		//非常用字段初始值
		int rebateType=0;//优惠类型
		int inOutSign=0;//进出口标志
		int timesSign=0;//时间标志
		int baseFeeTime=60;//首段停留时间
		int baseFee=100;//首段收费金额
		int addStart=1;//单位时间起算时间
		int maxTime=720;//最大停留时间
		int maxFeeTime=0;//每个计费周期最大收费时间
		int sumFeeCtr=1;//计算费率控制
		String backup1="0";//备用1,可空
		String backup2="0";//备用2,可空
		
		PriceBase temp=new PriceBase();
		temp.setVerNo(priceBase.getVerNo());
		temp.setFeeNo(priceBase.getFeeNo());
		temp.setVehTypeNo(priceBase.getVehTypeNo());
		temp.setAllowStayTime(priceBase.getAllowStayTime());
		temp.setStayAdd(priceBase.getStayAdd()*60);//免费停留 ,小时化为分钟
		temp.setAddFee(priceBase.getAddFee()*10);//单位收费金额,元化为分
		temp.setMaxFee(priceBase.getMaxFee()*10);//最多收费,元化为分
		temp.setStartTime(priceBase.getStartTime());
		temp.setRemark(priceBase.getRemark());
		
		//初始化以下值，当用户没有填写时赋予初始值
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
		if(priceBase.getVehTypeNo()==1)vehType="摩托车";
		if(priceBase.getVehTypeNo()==2)vehType="小轿车";
		if(priceBase.getVehTypeNo()==3)vehType="大型车";
		if(priceBase.getVehTypeNo()==4)vehType="超大型车";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改费率版本为["+priceBase.getVerNo()+"]_费率编号为["+priceBase.getFeeNo()+"]_车型为["+vehType+"]的费率成功", "修改费率", "tb_PriceBase");
		
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
	
	//删除费率
	public String delete(){
		priceBaseService.deleteBycompositeID(priceBase.getVerNo(), priceBase.getFeeNo(), priceBase.getRebateType()
				, priceBase.getInOutSign(), priceBase.getTimesSign(), priceBase.getVehTypeNo());

		message="deleteSuccess";
		String vehType=null;
		if(priceBase.getVehTypeNo()==1)vehType="摩托车";
		if(priceBase.getVehTypeNo()==2)vehType="小轿车";
		if(priceBase.getVehTypeNo()==3)vehType="大型车";
		if(priceBase.getVehTypeNo()==4)vehType="超大型车";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除费率版本为["+priceBase.getVerNo()+"]_费率编号为["+priceBase.getFeeNo()+"]_车型为["+vehType+"]的费率成功", "删除费率", "tb_PriceBase");
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
