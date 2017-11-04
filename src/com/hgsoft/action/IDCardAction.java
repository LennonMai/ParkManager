package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.CardInfo;
import com.hgsoft.entity.IdcardInfo;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CardInfoSendParaService;
import com.hgsoft.service.CardInfoService;
import com.hgsoft.service.IDCardInfoService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardInfoService;

@Controller
@Scope("prototype")
public class IDCardAction extends BaseAction{
	private IdcardInfo idCardInfoTemp;
	private IdcardInfo idCardInfo;
	private UserCardInfo userCardInfo;
	private Admin admin;
	private CardInfo cardInfo;
	private String idcardNo;
	
	@Resource
	private IDCardInfoService iDCardInfoService;
	@Resource
	private CardInfoSendParaService cardInfoSendParaService;
	@Resource
	private UserCardInfoService userCardInfoService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private CardInfoService cardInfoService;
	@Resource
	private AdminService adminService;
	public void removePagerAndConditionSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("userName");
		session.removeAttribute("idcardNo");		
	}
	public void setConditionSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("userName", idCardInfoTemp.getUserName().trim());
		session.setAttribute("idcardNo",idCardInfoTemp.getIdcardNo().trim());		
	}
	public void setPagerSession(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}
	public String queryIDCardInfo() {
		this.removePagerAndConditionSession();
		list = iDCardInfoService.getAllIDCardInfo(pager);
		idCardInfoTemp=null;
		return "queryIDCardInfo";
	}

	public String queryIDCardInfoToAdd() {//查询身份卡信息
		this.removePagerAndConditionSession();
		if ("".equals(idCardInfoTemp.getIdcardNo().trim()) && "".equals(idCardInfoTemp.getUserName().trim())) {
			return queryIDCardInfo();
		} else {
			this.setConditionSession();
			list=iDCardInfoService.findAllItemByHql(pager, idCardInfoTemp.getIdcardNo().trim(), idCardInfoTemp.getUserName().trim());
			return "queryIDCardInfo";
		}
	}
	
	public String addIDCardInfo(){
		return "addIDCardInfo";
	}
	public String addIDCardInfoEdit(){//添加身份卡信息
		admin = adminService.get(getCurrentOperator().getId());
		idCardInfo=new IdcardInfo();
		idCardInfo.setIdcardNo(idCardInfoTemp.getIdcardNo().trim());
		idCardInfo.setUserName(idCardInfoTemp.getUserName().trim());
		idCardInfo.setDepartment("xxx");
		idCardInfo.setJob("yyy");
		idCardInfo.setPlateList("AAAAAAA,bbbbbbb");
		iDCardInfoService.save(idCardInfo);
		cardInfo = cardInfoService.getCardInfoByCardNo(idCardInfoTemp.getIdcardNo().trim());
		if (cardInfo != null) {// 当卡信息表中有此卡号信息时更新用户类型
            cardInfo.setUserCardType((short)1);
            cardInfoService.update(cardInfo);
		}
		cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户添加身份卡号["+idCardInfoTemp.getIdcardNo()+"]成功",
				"卡票管理--身份卡管理", "tb_IDCardInfo");
		return queryIDCardInfo();
	}
	public String updateIDCardInfo(){
		this.setPagerSession();
		idCardInfoTemp=iDCardInfoService.get(idCardInfoTemp.getIdcardNo().trim());
		return "updateIDCardInfo";
		
	}
	public String updateIDCardInfoEdit(){//修改身份卡信息
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		admin = adminService.get(getCurrentOperator().getId());
		idCardInfo=iDCardInfoService.get(idcardNo.trim());
		idCardInfo.setIdcardNo(idCardInfoTemp.getIdcardNo().trim());
		idCardInfo.setUserName(idCardInfoTemp.getUserName().trim());
		iDCardInfoService.updateIdcardInfo(idcardNo,idCardInfoTemp.getIdcardNo().trim(),idCardInfoTemp.getUserName().trim());//修改主键，用JDBC修改
		cardInfo = cardInfoService.getCardInfoByCardNo(idCardInfoTemp.getIdcardNo().trim());
		if (cardInfo != null) {// 当卡信息表中有此卡号信息时更新用户类型
            cardInfo.setUserCardType((short)1);
            cardInfoService.update(cardInfo);
		}
		cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数
		result = Result.SUCCESS1;
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户修改身份卡号["+idCardInfoTemp.getIdcardNo()+"]成功",
				"卡票管理--身份卡管理", "tb_IDCardInfo");		
		
		if(session.getAttribute("userName") != null){
			idCardInfoTemp.setUserName( session.getAttribute("userName").toString());
		} else{
			idCardInfoTemp.setUserName("");
		}
		if(session.getAttribute("idcardNo") != null){
			idCardInfoTemp.setIdcardNo( session.getAttribute("idcardNo").toString());
		} else{
			idCardInfoTemp.setIdcardNo("");
		}		
		if ("".equals(idCardInfoTemp.getIdcardNo().trim()) && "".equals(idCardInfoTemp.getUserName().trim())) {
			list = iDCardInfoService.getAllIDCardInfo(pager);
		} else {
			list=iDCardInfoService.findAllItemByHql(pager, idCardInfoTemp.getIdcardNo().trim(), idCardInfoTemp.getUserName().trim());			
		}
		return "queryIDCardInfo";
	}
	public String deleteIDCardInfo(){//删除身份卡信息
		admin = adminService.get(getCurrentOperator().getId());
		idCardInfo=iDCardInfoService.get(idCardInfoTemp.getIdcardNo().trim());
		if(idCardInfo!=null){
			iDCardInfoService.delete(idCardInfo);
			cardInfoSendParaService.SendCardInfoPara();// 下发卡组参数			
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户删除身份卡号["+idCardInfoTemp.getIdcardNo()+"]成功",
					"卡票管理--身份卡管理", "tb_IDCardInfo");
		}
		result = Result.SUCCESS2;
		return queryIDCardInfo();
	}
	public String checkByidcardNo() {// jquery验证idcardNo是否已被运用和是否已登记过（登记过后才能运用）
		//Car car1 = carService.getCar(car.getVehPlate());
		idCardInfo=iDCardInfoService.get(idCardInfoTemp.getIdcardNo().trim());
		userCardInfo = userCardInfoService.getUserCardInfoByCardNo(idCardInfoTemp.getIdcardNo().trim());
		cardInfo = cardInfoService.getCardInfoByCardNo(idCardInfoTemp.getIdcardNo().trim());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction中getCarByVehPlate（）验证车牌是否存在是时发生的异常", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (idCardInfo == null && userCardInfo == null && cardInfo != null) {
			out.println("success");

		} else {
			if (cardInfo == null) {
				out.print("fail1");// 还没登记

			} else {
				if (idCardInfo != null || userCardInfo != null) {
					out.print("fail");// 已被运用
				}

			}
		}
		return null;
	}
		//set get函数

		public IdcardInfo getIdCardInfoTemp() {
			return idCardInfoTemp;
		}
		public void setIdCardInfoTemp(IdcardInfo idCardInfoTemp) {
			this.idCardInfoTemp = idCardInfoTemp;
		}
		public String getIdcardNo() {
			return idcardNo;
		}

		public void setIdcardNo(String idcardNo) {
			this.idcardNo = idcardNo;
		}

}
