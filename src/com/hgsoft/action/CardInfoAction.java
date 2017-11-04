/**
 * 
 */
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
import com.hgsoft.entity.OBUDate;
import com.hgsoft.entity.OpCardBlackList;
import com.hgsoft.entity.PassCardBlackList;
import com.hgsoft.entity.StoreCardBlackList;
import com.hgsoft.entity.StoreCardDate;
import com.hgsoft.entity.TollyCardBlackList;
import com.hgsoft.entity.TollyCardDate;
import com.hgsoft.entity.UserCardBlackList;
import com.hgsoft.service.OBUDateService;
import com.hgsoft.service.OpCardBlackListService;
import com.hgsoft.service.PassCardBlackListService;
import com.hgsoft.service.StoreCardBlackListService;
import com.hgsoft.service.StoreCardDateService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.TollyCardBlackListService;
import com.hgsoft.service.TollyCardDateService;
import com.hgsoft.service.UserCardBlackListService;

/**
 * �������Ϣ
 * @author qinzuohai
 *
 */
@Controller
@Scope("prototype")
public class CardInfoAction extends BaseAction{
	@Resource
	private SystemLogService systemLogService; 

	@Resource
	private StoreCardBlackListService storeCardBlackListService;
	private StoreCardBlackList storeCardBlackList;
	
	@Resource
	private TollyCardBlackListService tollyCardBlackListService;
	private TollyCardBlackList tollyCardBlackList;
	
	@Resource
	private PassCardBlackListService passCardBlackListService;
	private PassCardBlackList passCardBlackList;

	@Resource
	private OpCardBlackListService opCardBlackListService;
	private OpCardBlackList opCardBlackList;

	private StoreCardDate storeCardDate;
	private TollyCardDate tollyCardDate;
	private OBUDate obuDate;
	
	@Resource
	private StoreCardDateService storeCardDateService;
	@Resource
	private TollyCardDateService tollyCardDateService;
	@Resource
	private OBUDateService obuDateService;
	
	private UserCardBlackList userCardBlackList;
	@Resource
	private UserCardBlackListService userCardBlackListService;
	
	
	/**
	 * ���˿������� start
	 */
	
	//���˿��������б�ҳ��
	public String tollyCardBlackList_list(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("acCode");
		session.removeAttribute("genCau");
		session.removeAttribute("genTime");
		
		//���������ڵ�������
		list=tollyCardBlackListService.findByGenTimePager(pager);
		return "tollyCardBlackList_list";
	}
	
	public String tollyCardBlackList_query(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("acCode");
		session.removeAttribute("genCau");
		session.removeAttribute("genTime");
		
		if(!tollyCardBlackList.getAccode().equals("")||
				!tollyCardBlackList.getGenCau().equals("")||
				tollyCardBlackList.getGenTime()!=null){
			
			session.setAttribute("acCode", tollyCardBlackList.getAccode().trim());
			session.setAttribute("genCau", tollyCardBlackList.getGenCau().trim());
			session.setAttribute("genTime", tollyCardBlackList.getGenTime());
			list=tollyCardBlackListService.findByCondition(pager, tollyCardBlackList.getAccode().trim(), tollyCardBlackList.getGenCau().trim(), tollyCardBlackList.getGenTime());
			return "tollyCardBlackList_list";
		}else{
			return tollyCardBlackList_list();
		}
		
	}
	
	//ҳ��ת����˿����������ҳ��
	public String tollyCardBlackList_add(){
		return "tollyCardBlackList_add";
	}
	//��Ӽ��˿�������
	public String saveTollyCardBlackList(){
		if(tollyCardBlackListService.ishasTollyCardBlackList(tollyCardBlackList.getAccode())==null){	

			tollyCardBlackList.setAccode(tollyCardBlackList.getAccode().trim());
			tollyCardBlackList.setGenCau(tollyCardBlackList.getGenCau().trim());
			
			tollyCardBlackListService.save(tollyCardBlackList);
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���ӱ���Ϊ��["+tollyCardBlackList.getAccode()+"]���˿��������ɹ�", "��Ӽ��˿�������", "tb_TollyCardBlackList");
			result = Result.SUCCESS;
		}else{
			return "tollyCardBlackList_add";
		}
		tollyCardBlackList=null;
		return tollyCardBlackList_list();
	}
	//ҳ��ת����˿��������޸�ҳ��
	public String tollyCardBlackList_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		tollyCardBlackList=tollyCardBlackListService.LoadTollyCardBlackList(tollyCardBlackList.getAccode()).get(0);
		return "tollyCardBlackList_edit";
	}
	//�޸ļ��˿�������
	public String updateTollyCardBlackList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		tollyCardBlackList.setAccode(tollyCardBlackList.getAccode().trim());
		tollyCardBlackList.setGenCau(tollyCardBlackList.getGenCau().trim());
		
		tollyCardBlackListService.update(tollyCardBlackList);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��޸ı���Ϊ��["+tollyCardBlackList.getAccode()+"]���˿��������ɹ�", "�޸ļ��˿�������", "tb_TollyCardBlackList");
		
		if(session.getAttribute("acCode")!=null||
				session.getAttribute("genCau")!=null||
				session.getAttribute("genTime")!=null){
			
			tollyCardBlackList.setAccode((String) session.getAttribute("acCode"));
			tollyCardBlackList.setGenCau((String) session.getAttribute("genCau"));
			tollyCardBlackList.setGenTime((Date) session.getAttribute("genTime"));
			
			list=tollyCardBlackListService.findByCondition(pager, tollyCardBlackList.getAccode(), tollyCardBlackList.getGenCau(), tollyCardBlackList.getGenTime());
			return "tollyCardBlackList_list";
		}else{
			tollyCardBlackList=null;
			list=tollyCardBlackListService.findByGenTimePager(pager);
			return "tollyCardBlackList_list";
		}
	}
	
	//ɾ��һ�����˿�������
	public String tollyCardBlackList_delete(){
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ������Ϊ��["+tollyCardBlackList.getAccode()+"]���˿��������ɹ�", "ɾ�����˿�������", "tb_TollyCardBlackList");
		tollyCardBlackListService.delete(tollyCardBlackList.getAccode());
		message="deleteSuccess";
		tollyCardBlackList=null;
		return tollyCardBlackList_list();
	}
	public void ishasAccode() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == tollyCardBlackListService.ishasTollyCardBlackList(tollyCardBlackList.getAccode())) {
			out.print("noAccode");
		} else {
			out.print("hasAccode");
		}
	}

	
	/**
	 * ��ֵ�������� start
	 */
	
	// ��ֵ���������б�ҳ��
	public String storeCardBlackList_list(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("scCode");
		session.removeAttribute("genCau");
		session.removeAttribute("genTime");
		
		//���������ڵ�������
		list=storeCardBlackListService.findByGenTimePager(pager);
		return "storeCardBlackList_list";
	}
	
	public String storeCardBlackList_query(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("scCode");
		session.removeAttribute("genCau");
		session.removeAttribute("genTime");
		
		if(!storeCardBlackList.getScCode().equals("")||
				!storeCardBlackList.getGenCau().equals("")||
				storeCardBlackList.getGenTime()!=null){
			
			session.setAttribute("scCode",storeCardBlackList.getScCode().trim());
			session.setAttribute("genCau", storeCardBlackList.getGenCau().trim());
			session.setAttribute("genTime", storeCardBlackList.getGenTime());
			list=storeCardBlackListService.findByCondition(pager, storeCardBlackList.getScCode().trim(), storeCardBlackList.getGenCau().trim(), storeCardBlackList.getGenTime());
			return "storeCardBlackList_list";
		}else{
			return storeCardBlackList_list();
		}
		
	}
	
	//ҳ��ת�� ��ֵ�����������ҳ��
	public String storeCardBlackList_add(){
		return "storeCardBlackList_add";
	}
	//��� ��ֵ��������
	public String saveStoreCardBlackList(){
		if(storeCardBlackListService.ishasStoreCardBlackList(storeCardBlackList.getScCode())==null){	
			
			storeCardBlackList.setScCode(storeCardBlackList.getScCode().trim());
			storeCardBlackList.setGenCau(storeCardBlackList.getGenCau().trim());
			
			storeCardBlackListService.save(storeCardBlackList);
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���ӱ���Ϊ��["+storeCardBlackList.getScCode()+"]��ֵ���������ɹ�", "��Ӵ�ֵ��������", "tb_StoreCardBlackList");
			result = Result.SUCCESS;
		}else{
			return "storeCardBlackList_add";
		}
		storeCardBlackList=null;
		return storeCardBlackList_list();
	}
	//ҳ��ת�� ��ֵ���������޸�ҳ��
	public String storeCardBlackList_edit(){
		storeCardBlackList=storeCardBlackListService.LoadStoreCardBlackList(storeCardBlackList.getScCode()).get(0);
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		return "storeCardBlackList_edit";
	}
	//�޸� ��ֵ��������
	public String updateStoreCardBlackList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		storeCardBlackListService.update(storeCardBlackList);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��޸ı���Ϊ��["+storeCardBlackList.getScCode()+"]��ֵ���������ɹ�", "�޸Ĵ�ֵ��������", "tb_StoreCardBlackList");
		
		if(session.getAttribute("scCode")!=null||
				session.getAttribute("genCau")!=null||
				session.getAttribute("genTime")!=null){
			
			storeCardBlackList.setScCode((String) session.getAttribute("scCode"));
			storeCardBlackList.setGenCau((String) session.getAttribute("genCau"));
			storeCardBlackList.setGenTime((Date) session.getAttribute("genTime"));
			
			list=storeCardBlackListService.findByCondition(pager, storeCardBlackList.getScCode(), storeCardBlackList.getGenCau(), storeCardBlackList.getGenTime());
			return "storeCardBlackList_list";
		}else{
			storeCardBlackList=null;
			list=storeCardBlackListService.findByGenTimePager(pager);
			return "storeCardBlackList_list";
		}
	}
	
	//ɾ��һ�� ��ֵ��������
	public String storeCardBlackList_delete(){
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ������Ϊ��["+storeCardBlackList.getScCode()+"]��ֵ���������ɹ�", "ɾ����ֵ��������", "tb_StoreCardBlackList");
		storeCardBlackListService.delete(storeCardBlackList.getScCode());
		storeCardBlackList=null;
		message="deleteSuccess";
		return storeCardBlackList_list();
	}
	public void ishasScCode() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == storeCardBlackListService.ishasStoreCardBlackList(storeCardBlackList.getScCode())) {
			out.print("noScCode");
		} else {
			out.print("hasScCode");
		}
	}
	
	/**
	 * ͨ�п������� start
	 */
	
	// ͨ�п��������б�ҳ��
	public String passCardBlackList_list(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("cardNo");
		session.removeAttribute("opTime");
		session.removeAttribute("inValidTypeNo");
		
		//��ʧЧ���ڵ�������
		list=passCardBlackListService.findByOpTimePager(pager);
		return "passCardBlackList_list";
	}
	
	public String passCardBlackList_query(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("cardNo");
		session.removeAttribute("opTime");
		session.removeAttribute("inValidTypeNo");
		
		if(!passCardBlackList.getCardNo().equals("")||
				passCardBlackList.getInValidTypeNo()!=null||
				passCardBlackList.getOpTime()!=null){
			
			session.setAttribute("cardNo", passCardBlackList.getCardNo().trim());
			session.setAttribute("opTime", passCardBlackList.getOpTime());
			session.setAttribute("inValidTypeNo",passCardBlackList.getInValidTypeNo());
			list=passCardBlackListService.findByCondition(pager, passCardBlackList.getCardNo().trim(), passCardBlackList.getInValidTypeNo(), passCardBlackList.getOpTime());
			return "passCardBlackList_list";
		}else{
			return passCardBlackList_list();
		}
		
	}
	
	//ҳ��ת�� ͨ�п����������ҳ��
	public String passCardBlackList_add(){
		return "passCardBlackList_add";
	}
	//��� ͨ�п�������
	public String savePassCardBlackList(){
		if(passCardBlackListService.ishasPassCardBlackList(passCardBlackList.getCardNo())==null){	
			
			passCardBlackList.setCardNo(passCardBlackList.getCardNo().trim());
			passCardBlackListService.save(passCardBlackList);
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���ӱ���Ϊ��["+passCardBlackList.getCardNo()+"]ͨ�п��������ɹ�", "���ͨ�п�������", "tb_PassCardBlackList");
			result = Result.SUCCESS;
		}else{
			return "passCardBlackList_add";
		}
		passCardBlackList=null;
		return passCardBlackList_list();
	}
	//ҳ��ת��ͨ�п��������޸�ҳ��
	public String passCardBlackList_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		passCardBlackList=passCardBlackListService.LoadPassCardBlackList(passCardBlackList.getCardNo()).get(0);
		return "passCardBlackList_edit";
	}
	//�޸�ͨ�п�������
	public String updatePassCardBlackList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		passCardBlackList.setCardNo(passCardBlackList.getCardNo().trim());
		passCardBlackListService.update(passCardBlackList);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��޸ı���Ϊ��["+passCardBlackList.getCardNo()+"]ͨ�п��������ɹ�", "�޸�ͨ�п�������", "tb_PassCardBlackList");
		
		if(session.getAttribute("cardNo")!=null||
				session.getAttribute("opTime")!=null||
				session.getAttribute("inValidTypeNo")!=null){
			
			passCardBlackList.setCardNo((String) session.getAttribute("cardNo"));
			passCardBlackList.setInValidTypeNo((Short) session.getAttribute("inValidTypeNo"));
			passCardBlackList.setOpTime((Date) session.getAttribute("opTime"));
			list=passCardBlackListService.findByCondition(pager, passCardBlackList.getCardNo(), passCardBlackList.getInValidTypeNo(), passCardBlackList.getOpTime());
			return "passCardBlackList_list";
		
		}else{
			passCardBlackList=null;
			list=passCardBlackListService.findByOpTimePager(pager);
			return "passCardBlackList_list";
		}
	}
	
	//ɾ��һ�� ͨ�п�������
	public String passCardBlackList_delete(){
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ������Ϊ��["+passCardBlackList.getCardNo()+"]ͨ�п��������ɹ�", "ɾ��ͨ�п�������", "tb_PassCardBlackList");
		passCardBlackListService.delete(passCardBlackList.getCardNo());
		passCardBlackList=null;
		message="deleteSuccess";
		return passCardBlackList_list();
	}
	public void ishasCardNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == passCardBlackListService.ishasPassCardBlackList(passCardBlackList.getCardNo())) {
			out.print("noCardNo");
		} else {
			out.print("hasCardNo");
		}
	}

	
	/**
	 * ��ݿ������� start
	 */
	
	// ��ݿ��������б�ҳ��
	public String opCardBlackList_list(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("cardNo");
		session.removeAttribute("opTime");
		session.removeAttribute("inValidTypeNo");

		//��ʧЧ���ڵ�������
		list=opCardBlackListService.findByOpTimePager(pager);
		return "opCardBlackList_list";
	}
	
	public String opCardBlackList_query(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("cardNo");
		session.removeAttribute("opTime");
		session.removeAttribute("inValidTypeNo");
		
		if(!opCardBlackList.getCardNo().equals("")||
				opCardBlackList.getInValidTypeNo()!=null||
				opCardBlackList.getOpTime()!=null){
			
			session.setAttribute("cardNo", opCardBlackList.getCardNo().trim());
			session.setAttribute("opTime", opCardBlackList.getOpTime());
			session.setAttribute("inValidTypeNo",opCardBlackList.getInValidTypeNo());
			list=opCardBlackListService.findByCondition(pager, opCardBlackList.getCardNo().trim(), opCardBlackList.getInValidTypeNo(), opCardBlackList.getOpTime());
			return "opCardBlackList_list";
		}else{
			return opCardBlackList_list();
		}
		
	}
	
	//ҳ��ת�� ��ݿ����������ҳ��
	public String opCardBlackList_add(){
		return "opCardBlackList_add";
	}
	//��� ��ݿ�������
	public String saveOpCardBlackList(){
		if(opCardBlackListService.ishasOpCardBlackList(opCardBlackList.getCardNo())==null){	
			
			opCardBlackList.setCardNo(opCardBlackList.getCardNo().trim());
			opCardBlackListService.save(opCardBlackList);
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���ӱ���Ϊ��["+opCardBlackList.getCardNo()+"]��ݿ��������ɹ�", "�����ݿ�������", "tb_OpCardBlackList");
			result = Result.SUCCESS;
		}else{
			return "opCardBlackList_add";
		}	
		opCardBlackList=null;
		return opCardBlackList_list();
	}
	//ҳ��ת�� ��ݿ��������޸�ҳ��
	public String opCardBlackList_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		opCardBlackList=opCardBlackListService.LoadOpCardBlackList(opCardBlackList.getCardNo()).get(0);
		return "opCardBlackList_edit";
	}
	//�޸� ��ֵ��������
	public String updateOpCardBlackList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		opCardBlackList.setCardNo(opCardBlackList.getCardNo().trim());
		opCardBlackListService.update(opCardBlackList);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��޸ı���Ϊ��["+opCardBlackList.getCardNo()+"]��ݿ��������ɹ�", "�޸���ݿ�������", "tb_OpCardBlackList");
		
		if(session.getAttribute("cardNo")!=null||
				session.getAttribute("opTime")!=null||
				session.getAttribute("inValidTypeNo")!=null){
			
			opCardBlackList.setCardNo((String) session.getAttribute("cardNo"));
			opCardBlackList.setInValidTypeNo((Short) session.getAttribute("inValidTypeNo"));
			opCardBlackList.setOpTime((Date) session.getAttribute("opTime"));
			list=opCardBlackListService.findByCondition(pager, opCardBlackList.getCardNo(), opCardBlackList.getInValidTypeNo(), opCardBlackList.getOpTime());
			return "opCardBlackList_list";
		
		}else{
			opCardBlackList=null;
			list=opCardBlackListService.findByOpTimePager(pager);
			return "opCardBlackList_list";
		}
		
	}
	
	//ɾ��һ����ݿ�������
	public String opCardBlackList_delete(){
		opCardBlackListService.delete(opCardBlackList.getCardNo());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ������Ϊ��["+opCardBlackList.getCardNo()+"]��ݿ��������ɹ�", "ɾ����ݿ�������", "tb_OpCardBlackList");
		opCardBlackList=null;
		return opCardBlackList_list();
	}
	public void ishasOPCardNo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == opCardBlackListService.ishasOpCardBlackList(opCardBlackList.getCardNo())) {
			out.print("noOPCardNo");
		} else {
			out.print("hasOPCardNo");
		}
	}
	/**
	 * ��ֵ�������� end
	 */
	
	/**
	 * ��ͨ���������� start
	 */
	
	public String dateStart_list(){
		return "dateStart_list";
	}
	public String dateStart_set(){
		//System.out.println(storeCardDate.getFirTime()+"--"+tollyCardDate.getFirTime()+"--"+obuDate.getFirTime());
		if(storeCardDate.getFirTime()!=null){
		   storeCardDateService.Update(storeCardDate.getFirTime());
		   systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�������ֵ�����ڳɹ�", "������ֵ������", "tb_StoreCardDate");
		}
		if(tollyCardDate.getFirTime()!=null){
		   tollyCardDateService.Update(tollyCardDate.getFirTime());
		   systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��������˿����ڳɹ�", "�������˿�����", "tb_TollyCardDate");
		}
		if(obuDate.getFirTime()!=null){
		   obuDateService.Update(obuDate.getFirTime());
		   systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�����OBU���ڳɹ�", "����OBU����", "	tb_OBUDate");
		}
		result=Result.SUCCESS;
		return dateStart_list();
	}
	/**
	 *  ��ͨ���������� end
	 */
	
	
	
	/**
	 * �û��������� start
	 */
	
	public String userCardBlackList_list(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("ucCode");
		session.removeAttribute("genCau");
		session.removeAttribute("genTime");

		list=userCardBlackListService.findByGenTimePager(pager);
		return "userCardBlackList_list";
	}
	
	public String userCardBlackList_query(){
	 	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("ucCode");
		session.removeAttribute("genCau");
		session.removeAttribute("genTime");
		
		if(!userCardBlackList.getUccode().equals("")||
				!userCardBlackList.getGenCau().equals("")||
				userCardBlackList.getGenTime()!=null){
			
			session.setAttribute("ucCode", userCardBlackList.getUccode().trim());
			session.setAttribute("genCau", userCardBlackList.getGenCau().trim());
			session.setAttribute("genTime", userCardBlackList.getGenTime());
			
			list=userCardBlackListService.findByCondition(pager, userCardBlackList.getUccode().trim(), userCardBlackList.getGenCau().trim(), userCardBlackList.getGenTime());
			return "userCardBlackList_list";
		}else{
			return userCardBlackList_list();
		}
		
	}
	
	public String userCardBlackList_add(){
		return "userCardBlackList_add";
	}
	public String saveUserCardBlackList(){
		if(userCardBlackListService.ishasUserCardBlackList(userCardBlackList.getUccode())==null){	
			
			userCardBlackList.setUccode(userCardBlackList.getUccode().trim());
			userCardBlackList.setGenCau(userCardBlackList.getGenCau().trim());

			userCardBlackListService.save(userCardBlackList);
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���ӱ���Ϊ��["+userCardBlackList.getUccode().trim()+"]�û����������ɹ�", "����û���������", "tb_UserCardBlackList");
			result = Result.SUCCESS;
		}else{
			message="hasUserCardBlackList";
			return "userCardBlackList_add";
		}	
		userCardBlackList=null;
		return userCardBlackList_list();
	}
	public String userCardBlackList_edit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		userCardBlackList=userCardBlackListService.get(userCardBlackList.getUccode());
		return "userCardBlackList_edit";
	}

	public String updateUserCardBlackList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		userCardBlackList.setUccode(userCardBlackList.getUccode().trim());
		userCardBlackList.setGenCau(userCardBlackList.getGenCau().trim());
	
		opCardBlackListService.update(userCardBlackList);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��޸ı���Ϊ��["+userCardBlackList.getUccode()+"]�û����������ɹ�", "�޸��û���������", "tb_UserCardBlackList");

		if(session.getAttribute("ucCode")!=null||
				session.getAttribute("genCau")!=null||
				session.getAttribute("genTime")!=null){
			
			userCardBlackList.setUccode((String)session.getAttribute("ucCode"));
			userCardBlackList.setGenCau((String) session.getAttribute("genCau"));
			userCardBlackList.setGenTime((Date) session.getAttribute("genTime"));
			
			list=userCardBlackListService.findByCondition(pager, userCardBlackList.getUccode(), userCardBlackList.getGenCau(), userCardBlackList.getGenTime());
			return "userCardBlackList_list";
		}else{
			userCardBlackList=null;
			list=userCardBlackListService.findByGenTimePager(pager);
			return "userCardBlackList_list";
		}
	}
	

	public String userCardBlackList_delete(){
		userCardBlackListService.delete(userCardBlackList.getUccode());
		message="deleteSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ������Ϊ��["+userCardBlackList.getUccode()+"]�û����������ɹ�", "ɾ���û���������", "tb_UserCardBlackList");
		userCardBlackList=null;
		return userCardBlackList_list();
	}
	public void ishasUccode() {
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == userCardBlackListService.ishasUserCardBlackList(userCardBlackList.getUccode().trim())) {
			out.print("noUccode");
		} else {
			out.print("hasUccode");
		}
	}
	
	
	//Getter/Setter
	public TollyCardBlackList getTollyCardBlackList() {
		return tollyCardBlackList;
	}

	public void setTollyCardBlackList(TollyCardBlackList tollyCardBlackList) {
		this.tollyCardBlackList = tollyCardBlackList;
	}
	public StoreCardBlackList getStoreCardBlackList() {
		return storeCardBlackList;
	}

	public void setStoreCardBlackList(StoreCardBlackList storeCardBlackList) {
		this.storeCardBlackList = storeCardBlackList;
	}
	public PassCardBlackList getPassCardBlackList() {
		return passCardBlackList;
	}

	public void setPassCardBlackList(PassCardBlackList passCardBlackList) {
		this.passCardBlackList = passCardBlackList;
	}

	public OpCardBlackList getOpCardBlackList() {
		return opCardBlackList;
	}

	public void setOpCardBlackList(OpCardBlackList opCardBlackList) {
		this.opCardBlackList = opCardBlackList;
	}
	public StoreCardDate getStoreCardDate() {
		return storeCardDate;
	}

	public void setStoreCardDate(StoreCardDate storeCardDate) {
		this.storeCardDate = storeCardDate;
	}

	public TollyCardDate getTollyCardDate() {
		return tollyCardDate;
	}

	public void setTollyCardDate(TollyCardDate tollyCardDate) {
		this.tollyCardDate = tollyCardDate;
	}

	public OBUDate getObuDate() {
		return obuDate;
	}

	public void setObuDate(OBUDate obuDate) {
		this.obuDate = obuDate;
	}

	public UserCardBlackList getUserCardBlackList() {
		return userCardBlackList;
	}

	public void setUserCardBlackList(UserCardBlackList userCardBlackList) {
		this.userCardBlackList = userCardBlackList;
	}
	
}
