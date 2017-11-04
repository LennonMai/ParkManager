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

	public String queryIDCardInfoToAdd() {//��ѯ��ݿ���Ϣ
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
	public String addIDCardInfoEdit(){//�����ݿ���Ϣ
		admin = adminService.get(getCurrentOperator().getId());
		idCardInfo=new IdcardInfo();
		idCardInfo.setIdcardNo(idCardInfoTemp.getIdcardNo().trim());
		idCardInfo.setUserName(idCardInfoTemp.getUserName().trim());
		idCardInfo.setDepartment("xxx");
		idCardInfo.setJob("yyy");
		idCardInfo.setPlateList("AAAAAAA,bbbbbbb");
		iDCardInfoService.save(idCardInfo);
		cardInfo = cardInfoService.getCardInfoByCardNo(idCardInfoTemp.getIdcardNo().trim());
		if (cardInfo != null) {// ������Ϣ�����д˿�����Ϣʱ�����û�����
            cardInfo.setUserCardType((short)1);
            cardInfoService.update(cardInfo);
		}
		cardInfoSendParaService.SendCardInfoPara();// �·��������
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û������ݿ���["+idCardInfoTemp.getIdcardNo()+"]�ɹ�",
				"��Ʊ����--��ݿ�����", "tb_IDCardInfo");
		return queryIDCardInfo();
	}
	public String updateIDCardInfo(){
		this.setPagerSession();
		idCardInfoTemp=iDCardInfoService.get(idCardInfoTemp.getIdcardNo().trim());
		return "updateIDCardInfo";
		
	}
	public String updateIDCardInfoEdit(){//�޸���ݿ���Ϣ
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		admin = adminService.get(getCurrentOperator().getId());
		idCardInfo=iDCardInfoService.get(idcardNo.trim());
		idCardInfo.setIdcardNo(idCardInfoTemp.getIdcardNo().trim());
		idCardInfo.setUserName(idCardInfoTemp.getUserName().trim());
		iDCardInfoService.updateIdcardInfo(idcardNo,idCardInfoTemp.getIdcardNo().trim(),idCardInfoTemp.getUserName().trim());//�޸���������JDBC�޸�
		cardInfo = cardInfoService.getCardInfoByCardNo(idCardInfoTemp.getIdcardNo().trim());
		if (cardInfo != null) {// ������Ϣ�����д˿�����Ϣʱ�����û�����
            cardInfo.setUserCardType((short)1);
            cardInfoService.update(cardInfo);
		}
		cardInfoSendParaService.SendCardInfoPara();// �·��������
		result = Result.SUCCESS1;
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û��޸���ݿ���["+idCardInfoTemp.getIdcardNo()+"]�ɹ�",
				"��Ʊ����--��ݿ�����", "tb_IDCardInfo");		
		
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
	public String deleteIDCardInfo(){//ɾ����ݿ���Ϣ
		admin = adminService.get(getCurrentOperator().getId());
		idCardInfo=iDCardInfoService.get(idCardInfoTemp.getIdcardNo().trim());
		if(idCardInfo!=null){
			iDCardInfoService.delete(idCardInfo);
			cardInfoSendParaService.SendCardInfoPara();// �·��������			
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û�ɾ����ݿ���["+idCardInfoTemp.getIdcardNo()+"]�ɹ�",
					"��Ʊ����--��ݿ�����", "tb_IDCardInfo");
		}
		result = Result.SUCCESS2;
		return queryIDCardInfo();
	}
	public String checkByidcardNo() {// jquery��֤idcardNo�Ƿ��ѱ����ú��Ƿ��ѵǼǹ����Ǽǹ���������ã�
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
			systemLogService.save(new Date(), 2, admin, "UserCarAccountAction��getCarByVehPlate������֤�����Ƿ������ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		}
		if (idCardInfo == null && userCardInfo == null && cardInfo != null) {
			out.println("success");

		} else {
			if (cardInfo == null) {
				out.print("fail1");// ��û�Ǽ�

			} else {
				if (idCardInfo != null || userCardInfo != null) {
					out.print("fail");// �ѱ�����
				}

			}
		}
		return null;
	}
		//set get����

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
