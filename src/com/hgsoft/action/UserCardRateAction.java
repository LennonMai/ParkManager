package com.hgsoft.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.UserCardFeeRuleType;
import com.hgsoft.entity.UserCardRate;
import com.hgsoft.entity.UserCardType;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardFeeRuleTypeService;
import com.hgsoft.service.UserCardRateService;
import com.hgsoft.service.UserCardTypeService;


/**
 * 用户卡费率
 * @author qinzuohai
 */
@Controller
@Scope("prototype")
public class UserCardRateAction extends BaseAction{
	@Resource
	private SystemLogService systemLogService; 
	@Resource
	private UserCardFeeRuleTypeService userCardFeeRuleTypeService;
	@Resource
	private UserCardTypeService userCardTypeService;
	@Resource
	private UserCardRateService userCardRateService;
	private UserCardRate userCardRate;
	private List<UserCardFeeRuleType> ucfrtList;
	private List<UserCardType> uctList;
	
	//费率列表
	public String list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("version");
		session.removeAttribute("userCardType");
		session.removeAttribute("recNo");
		
		//ucfrtList=userCardFeeRuleTypeService.findAll();
		//uctList=userCardTypeService.findAll();
		uctList = userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		list=userCardRateService.findByPager(pager);
		return "list";
	}
	
	public String query(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("version");
		session.removeAttribute("userCardType");
		session.removeAttribute("recNo");
		
		if(userCardRate.getVersion()!=null||
				userCardRate.getRecNo()!=null||
				userCardRate.getUserCardType()!=null){
			
			session.setAttribute("version", userCardRate.getVersion());
			session.setAttribute("userCardType", userCardRate.getUserCardType());
			session.setAttribute("recNo", userCardRate.getRecNo());
			
			//ucfrtList=userCardFeeRuleTypeService.findAll();
			//uctList=userCardTypeService.findAll();
			uctList = userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
			list=userCardRateService.findByCondition(pager, userCardRate.getVersion(), userCardRate.getUserCardType(), userCardRate.getRecNo());
			return "list";
			
		}else{
			return list();
		}
	}
	
	//跳转到费率添加页面
	public String add(){
		//ucfrtList=userCardFeeRuleTypeService.findAll();
		//uctList=userCardTypeService.findAll();
		uctList = userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		return "add";
	}
	//添加费率
	public String saveUserCardRate(){
		int i = 0;
		if(userCardRateService.ishasUserCardRate(userCardRate.getVersion(), userCardRate.getRecNo())==null){
		    UserCardRate temp=new UserCardRate();
		    i = userCardRateService.getMax()+1;
	    	temp.setVersion(userCardRate.getVersion());
	    	temp.setRecNo(Short.parseShort(String.valueOf(i)));
			//temp.setRecNo(userCardRate.getRecNo());
			temp.setUserCardType(userCardRate.getUserCardType());
			temp.setMoney(userCardRate.getMoney());
			temp.setYear((short)0);
			temp.setMonth((short)1);
			temp.setDay((short)0);
		    userCardRateService.save(temp);
		    systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加版本号为["+userCardRate.getVersion()+"]_记录号为["+i+"]的用户卡费率成功", "添加用户卡费率", "tb_UserCardRate");
			result = Result.SUCCESS;	
		}
		else{
			message ="hasUserCardRate";
			return "add";		
		}
		userCardRate=null;
		return  list();
	}
	
	//跳转到费率修改页面
	public String edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		//ucfrtList=userCardFeeRuleTypeService.findAll();
		//uctList=userCardTypeService.findAll();
		uctList = userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
		userCardRate=userCardRateService.LoadUserCardRate(userCardRate.getVersion(), userCardRate.getRecNo()).get(0);
		return "edit";
	}
	//修改费率
	public String updateUserCardRate(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		UserCardRate temp=new UserCardRate();
		temp.setVersion(userCardRate.getVersion());
		temp.setRecNo(userCardRate.getRecNo());
		temp.setUserCardType(userCardRate.getUserCardType());
		temp.setMoney(userCardRate.getMoney());
		temp.setYear((short)0);
		temp.setMonth((short)1);
		temp.setDay((short)0);
		
		userCardRateService.update(temp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改版本号为["+userCardRate.getVersion()+"]_记录号为["+userCardRate.getRecNo()+"]的用户卡费率成功", "修改用户卡费率", "tb_UserCardRate");
		if(session.getAttribute("version")!=null||
				session.getAttribute("userCardType")!=null||
				session.getAttribute("recNo")!=null){

			userCardRate.setVersion((Short) session.getAttribute("version"));
			userCardRate.setUserCardType((Short) session.getAttribute("userCardType"));
			userCardRate.setRecNo((Short) session.getAttribute("recNo"));
			
			//ucfrtList=userCardFeeRuleTypeService.findAll();
			//uctList=userCardTypeService.findAll();
			uctList = userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
			list=userCardRateService.findByCondition(pager, userCardRate.getVersion(), userCardRate.getUserCardType(),userCardRate.getRecNo());
			return "list";
			
		}else{
			userCardRate=null;
			//ucfrtList=userCardFeeRuleTypeService.findAll();
			//uctList=userCardTypeService.findAll();
			uctList = userCardTypeService.getUserCardTypeByUserCardType((short)13, (short)14);
			list=userCardRateService.findByPager(pager);
			return "list";
		}
	}
	
	//删除费率
	public String delete(){
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除版本号为["+userCardRate.getVersion()+"]_记录号为["+userCardRate.getRecNo()+"]的用户卡费率成功", "删除用户卡费率", "tb_UserCardRate");
		userCardRateService.deleteBycompositeID(userCardRate.getVersion(), userCardRate.getRecNo());
		userCardRate=null;
		message="deleteSuccess";
		return list();
	}
	
	//Getter/Setter
	public UserCardRate getUserCardRate() {
		return userCardRate;
	}
	public void setUserCardRate(UserCardRate userCardRate) {
		this.userCardRate = userCardRate;
	}
	public List<UserCardFeeRuleType> getUcfrtList() {
		return ucfrtList;
	}
	public void setUcfrtList(List<UserCardFeeRuleType> ucfrtList) {
		this.ucfrtList = ucfrtList;
	}
	public List<UserCardType> getUctList() {
		return uctList;
	}
	public void setUctList(List<UserCardType> uctList) {
		this.uctList = uctList;
	}

	
}
