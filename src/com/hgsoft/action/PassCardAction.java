package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.CardHandOutIn;
import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CardHandOutInService;
import com.hgsoft.service.CardInfoSendParaService;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.OperatorService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;

@Controller
@Scope("prototype")
public class PassCardAction extends BaseAction {
	@SuppressWarnings("unchecked")
	private List parkList;
	@SuppressWarnings("unchecked")
	private List gatewayList;
	@SuppressWarnings("unchecked")
	private List listOperator;
	@SuppressWarnings("unchecked")
	private List gateList;
	@SuppressWarnings("unchecked")
	private List laneList;
	@SuppressWarnings("unchecked")
	private List listAdmin;
	@SuppressWarnings("unchecked")
	private List squadList;
	private Sysparamconf param_whtherPayType;

	private CardHandOutIn cardHandOutIn;
	private CardHandOutIn cardHandOutInTemp;
	private String squadDate;
	private Admin admin;
	private String whtherPayType = "whtherPayType";// �Ƿ��нɷ����ͣ�0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����
	private String whtherPayType_remark = "�Ƿ��нɷ����Ͳ�����0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)";
	@Resource
	private CardHandOutInService cardHandOutInService;
	@Resource
	private ParkInformationService parkInformationService;
	@Resource
	private GatewayInformationService gatewayInformationService;
	@Resource
	private OperatorService operatorService;
	@Resource
	private LaneInformationService laneInformationService;
	@Resource
	private AdminService adminService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private CardInfoSendParaService cardInfoSendParaService;
	@Resource
	private SquadInformationService squadInformationService;
	@Resource
	private SysparamconfService sysparamconfService;

	public void removePagerAndConditionSession() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("squadDate");
		session.removeAttribute("squadNo");
		session.removeAttribute("type");
		session.removeAttribute("operatorNo");
		session.removeAttribute("recorderNo");
		session.removeAttribute("parkNo");
		session.removeAttribute("gateNo");
		session.removeAttribute("laneNo");
	}

	public void setConditionSession() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.setAttribute("squadDate", squadDate);
		session.setAttribute("squadNo", cardHandOutIn.getSquadNo());
		session.setAttribute("type", cardHandOutIn.getType());
		session.setAttribute("operatorNo", cardHandOutIn.getOperatorNo());
		session.setAttribute("recorderNo", cardHandOutIn.getRecorderNo());
		session.setAttribute("parkNo", cardHandOutIn.getParkNo());
		session.setAttribute("gateNo", cardHandOutIn.getGateNo());
		session.setAttribute("laneNo", cardHandOutIn.getLaneNo());

	}

	public void setPagerSession() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
	}

	public String queryToCardHandOutIn() {
		this.removePagerAndConditionSession();
		list = cardHandOutInService.findByPager(pager);
		parkList = parkInformationService.getAllParkInformation();
		gatewayList = gatewayInformationService.getAllGatewayInformation();
		listOperator = operatorService.getAllOperator();
		listAdmin = adminService.getAllAdmin();
		squadList = squadInformationService.getAllSquadInformation();
		cardHandOutIn = null;
		squadDate = null;
		return "queryToCardHandOutIn";
	}

	public String queryCardHandOutIn() {
		this.removePagerAndConditionSession();
		if ("".equals(squadDate.trim()) && null == cardHandOutIn.getSquadNo() && null == cardHandOutIn.getType() && null == cardHandOutIn.getParkNo() && null == cardHandOutIn.getGateNo() && null == cardHandOutIn.getLaneNo() && null == cardHandOutIn.getOperatorNo() && null == cardHandOutIn.getRecorderNo()) {
			return queryToCardHandOutIn();
		} else {
			this.setConditionSession();
			if (squadDate.equals("")) {
				list = cardHandOutInService.findAllItemByHql(pager, null, cardHandOutIn.getSquadNo(), cardHandOutIn.getType(), cardHandOutIn.getParkNo(), cardHandOutIn.getGateNo(), cardHandOutIn.getLaneNo(), cardHandOutIn.getOperatorNo(), cardHandOutIn.getRecorderNo());
			} else {
				list = cardHandOutInService.findAllItemByHql(pager, Timestamp.valueOf(changeDateFormat(squadDate.trim())), cardHandOutIn.getSquadNo(), cardHandOutIn.getType(), cardHandOutIn.getParkNo(), cardHandOutIn.getGateNo(), cardHandOutIn.getLaneNo(), cardHandOutIn.getOperatorNo(), cardHandOutIn.getRecorderNo());
			}
			if (null != cardHandOutIn.getParkNo()) {
				gateList = gatewayInformationService.getGatewayInformationByParkNo(cardHandOutIn.getParkNo());
			}
			if (null != cardHandOutIn.getParkNo() && null != cardHandOutIn.getGateNo()) {
				laneList = laneInformationService.getLaneInformationByParkNoAndGateNo(cardHandOutIn.getParkNo(), cardHandOutIn.getGateNo());
			}

			parkList = parkInformationService.getAllParkInformation();
			gatewayList = gatewayInformationService.getAllGatewayInformation();
			listOperator = operatorService.getAllOperator();
			listAdmin = adminService.getAllAdmin();
			squadList = squadInformationService.getAllSquadInformation();
			return "queryToCardHandOutIn";
		}

	}

	public String addCardHandOutIn() {
		parkList = parkInformationService.getAllParkInformation();
		listOperator = operatorService.getAllOperator();
		squadList = squadInformationService.getAllSquadInformation();
		return "addCardHandOutIn";
	}

	public String addCardHandOutInEdit() {// ����쿨�����Ǽ���Ϣ���쿨�����ǼǱ�
		admin = adminService.get(getCurrentOperator().getId());
		Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		cardHandOutInTemp = new CardHandOutIn();
		cardHandOutInTemp.setSquadDate(Timestamp.valueOf(changeDateFormat(squadDate)));
		cardHandOutInTemp.setSquadNo(cardHandOutIn.getSquadNo());
		cardHandOutInTemp.setParkNo(cardHandOutIn.getParkNo());
		cardHandOutInTemp.setGateNo(cardHandOutIn.getGateNo());
		cardHandOutInTemp.setLaneNo(cardHandOutIn.getLaneNo());
		cardHandOutInTemp.setType(cardHandOutIn.getType());
		cardHandOutInTemp.setAmount(cardHandOutIn.getAmount());
		cardHandOutInTemp.setOperatorName(operatorService.get(cardHandOutIn.getOperatorNo()).getOperatorName());
		cardHandOutInTemp.setOperatorNo(cardHandOutIn.getOperatorNo());
		cardHandOutInTemp.setRecorderNo(getCurrentOperator().getId());
		cardHandOutInTemp.setRecorderName(getCurrentOperator().getName());
		cardHandOutInTemp.setRecordTime(date);
		cardHandOutInTemp.setRecordNo(cardHandOutInService.getMaxRecordNo());
		cardHandOutInService.save(cardHandOutInTemp);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û��쿨�����Ǽǵ�С�����[" + cardHandOutIn.getParkNo() + "]���ű��[" + cardHandOutIn.getGateNo() + "]�������[" + cardHandOutIn.getLaneNo() + "], ����Ϊ[" + cardHandOutIn.getAmount() + "]", "��Ʊ����--ͨ�п�����--�쿨�����Ǽ�--����", "tb_CardHandOutIn");
		return queryToCardHandOutIn();
	}

	public String updateCardHandOutIn() {
		this.setPagerSession();
		cardHandOutIn = cardHandOutInService.get(cardHandOutIn.getRecordNo());
		squadDate = changeDateFormat(cardHandOutIn.getSquadDate());
		listOperator = operatorService.getAllOperator();
		listAdmin = adminService.getAllAdmin();
		parkList = parkInformationService.getAllParkInformation();
		gateList = gatewayInformationService.getGatewayInformationByParkNo(cardHandOutIn.getParkNo());
		laneList = laneInformationService.getLaneInformationByParkNoAndGateNo(cardHandOutIn.getParkNo(), cardHandOutIn.getGateNo());
		squadList = squadInformationService.getAllSquadInformation();
		return "updateCardHandOutIn";

	}

	public String updteEdit() {// �����쿨�����Ǽ���Ϣ
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		admin = adminService.get(getCurrentOperator().getId());
		cardHandOutInTemp = cardHandOutInService.get(cardHandOutIn.getRecordNo());
		cardHandOutInTemp.setSquadDate(Timestamp.valueOf(changeDateFormat(squadDate)));
		cardHandOutInTemp.setSquadNo(cardHandOutIn.getSquadNo());
		cardHandOutInTemp.setParkNo(cardHandOutIn.getParkNo());
		cardHandOutInTemp.setGateNo(cardHandOutIn.getGateNo());
		cardHandOutInTemp.setLaneNo(cardHandOutIn.getLaneNo());
		cardHandOutInTemp.setType(cardHandOutIn.getType());
		cardHandOutInTemp.setAmount(cardHandOutIn.getAmount());
		cardHandOutInTemp.setOperatorName(operatorService.get(cardHandOutIn.getOperatorNo()).getOperatorName());
		cardHandOutInTemp.setOperatorNo(cardHandOutIn.getOperatorNo());
		cardHandOutInTemp.setRecorderNo(getCurrentOperator().getId());
		cardHandOutInTemp.setRecorderName(getCurrentOperator().getName());
		cardHandOutInService.update(cardHandOutInTemp);
		param_whtherPayType = sysparamconfService.queryOrSave(whtherPayType, "0", whtherPayType_remark, "ParkCardAction��queryParkCardToLoss()����whtherPayType����ʱset������get��������ʱ���쳣", admin);
		if (!param_whtherPayType.getPvalue().equals("1")) {// �нɷ�����ʱ
			cardInfoSendParaService.SendCardInfoParaHavaPayType();// �·��������
		} else {// û�нɷ�����
			cardInfoSendParaService.SendCardInfoPara();// �·��������
		}
		result = Result.SUCCESS1;
		systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û��޸��쿨�����ǼǼ�¼��[" + cardHandOutIn.getRecordNo() + "]��Ϣ�ɹ�", "��Ʊ����--ͨ�п�����--�쿨�����Ǽ�--�޸�", "tb_CardHandOutIn");
		if (session.getAttribute("squadDate") != null) {
			squadDate = session.getAttribute("squadDate").toString();
		} else {
			squadDate = "";
		}
		cardHandOutIn.setSquadNo((Short) session.getAttribute("squadNo"));
		cardHandOutIn.setType((Short) session.getAttribute("type"));
		cardHandOutIn.setOperatorNo((Integer) session.getAttribute("operatorNo"));
		cardHandOutIn.setRecorderNo((Integer) session.getAttribute("recorderNo"));
		cardHandOutIn.setParkNo((Short) session.getAttribute("parkNo"));
		cardHandOutIn.setGateNo((Short) session.getAttribute("gateNo"));
		cardHandOutIn.setLaneNo((Short) session.getAttribute("laneNo"));
		parkList = parkInformationService.getAllParkInformation();
		gatewayList = gatewayInformationService.getAllGatewayInformation();
		listOperator = operatorService.getAllOperator();
		listAdmin = adminService.getAllAdmin();
		squadList = squadInformationService.getAllSquadInformation();
		if ("".equals(squadDate) && null == cardHandOutIn.getSquadNo() && null == cardHandOutIn.getType() && null == cardHandOutIn.getParkNo() && null == cardHandOutIn.getGateNo() && null == cardHandOutIn.getLaneNo() && null == cardHandOutIn.getOperatorNo() && null == cardHandOutIn.getRecorderNo()) {
			list = cardHandOutInService.findByPager(pager);

		} else {
			this.setConditionSession();
			if (squadDate.equals("")) {
				list = cardHandOutInService.findAllItemByHql(pager, null, cardHandOutIn.getSquadNo(), cardHandOutIn.getType(), cardHandOutIn.getParkNo(), cardHandOutIn.getGateNo(), cardHandOutIn.getLaneNo(), cardHandOutIn.getOperatorNo(), cardHandOutIn.getRecorderNo());
			} else {
				list = cardHandOutInService.findAllItemByHql(pager, Timestamp.valueOf(changeDateFormat(squadDate)), cardHandOutIn.getSquadNo(), cardHandOutIn.getType(), cardHandOutIn.getParkNo(), cardHandOutIn.getGateNo(), cardHandOutIn.getLaneNo(), cardHandOutIn.getOperatorNo(), cardHandOutIn.getRecorderNo());
			}
			if (null != cardHandOutIn.getParkNo()) {
				gateList = gatewayInformationService.getGatewayInformationByParkNo(cardHandOutIn.getParkNo());
			}
			if (null != cardHandOutIn.getParkNo() && null != cardHandOutIn.getGateNo()) {
				laneList = laneInformationService.getLaneInformationByParkNoAndGateNo(cardHandOutIn.getParkNo(), cardHandOutIn.getGateNo());
			}

		}
		return "queryToCardHandOutIn";

	}

	public String deleteCardHandOutIn() {// ɾ���쿨�����Ǽ���Ϣ
		admin = adminService.get(getCurrentOperator().getId());
		cardHandOutInTemp = cardHandOutInService.get(cardHandOutIn.getRecordNo());
		if (cardHandOutInTemp != null) {
			cardHandOutInService.delete(cardHandOutInTemp);
			systemLogService.save(new Date(), 1, admin, "[" + admin.getId() + "]" + admin.getUsername() + "�û�ɾ���쿨�����ǼǼ�¼��[" + cardHandOutIn.getRecordNo() + "]��Ϣ�ɹ�", "��Ʊ����--ͨ�п�����--�쿨�����Ǽ�--ɾ��", "tb_CardHandOutIn");
		}
		result = Result.SUCCESS2;
		return queryToCardHandOutIn();

	}

	/*
	 * public String ajaxGate() {// �첽���С��������Ϣ List<GatewayInformation>
	 * gatewayList =
	 * gatewayInformationService.getGatewayInformationByParkNo(cardHandOutIn
	 * .getParkNo()); HttpServletResponse response =
	 * ServletActionContext.getResponse();
	 * response.setContentType("text/xml;charset=gbk"); try { PrintWriter out =
	 * response.getWriter();
	 * out.println("<?xml version='1.0' encoding='gbk'?>"); if
	 * (gatewayList.size() > 0) { out.println("<gatewayList>"); for
	 * (GatewayInformation gateway:gatewayList) { out.println("<gateway>");
	 * out.println("<gateNo>" + gateway.getGateNo() + "</gateNo>");
	 * out.println("<gateName>" + gateway.getGateName() + "</gateName>");
	 * out.println("</gateway>"); } out.println("</gatewayList>");
	 * 
	 * } out.close(); } catch (IOException e) { // TODO Auto-generated catch
	 * block e.printStackTrace(); } return null;
	 * 
	 * 
	 * 
	 * }
	 * 
	 * public String ajaxLane() {// �첽��ô��ų�����Ϣ List<LaneInformation> laneList =
	 * laneInformationService
	 * .getLaneInformationByParkNoAndGateNo(cardHandOutIn.getParkNo(),
	 * cardHandOutIn.getGateNo());
	 * 
	 * HttpServletResponse response = ServletActionContext.getResponse();
	 * response.setContentType("text/xml;charset=gbk"); try { PrintWriter out =
	 * response.getWriter();
	 * out.println("<?xml version='1.0' encoding='gbk'?>"); if (laneList.size()
	 * > 0) { out.println("<laneList>"); for (LaneInformation lane:laneList) {
	 * out.println("<lane>"); out.println("<laneNo>" + lane.getLaneNo() +
	 * "</laneNo>"); out.println("<name>" +lane.getLaneNo() + "</name>");
	 * out.println("</lane>"); } out.println("</laneList>");
	 * 
	 * } out.close(); } catch (IOException e) { // TODO Auto-generated catch
	 * block e.printStackTrace(); } return null;
	 * 
	 * 
	 * 
	 * }
	 */
	@SuppressWarnings("unchecked")
	public String ajaxGate() {
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = gatewayInformationService.getGatewayInformationByParkNo(cardHandOutIn.getParkNo());
		// List<GatewayInformation> gatewayList =
		// gatewayInformationService.getGatewayInformationByParkNo(cardHandOutIn.getParkNo());
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<gates>");
		for (int i = 0; i < tempList.size(); i++) {
			GatewayInformation information = (GatewayInformation) tempList.get(i);
			pw.print("<gate id='" + information.getGateNo() + "' name='" + information.getGateName() + "' />");
		}
		pw.print("</gates>");
		return null;
	}

	/**
	 * �첽��ô��ų�����Ϣ
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String ajaxLane() {
		HttpServletResponse response = ServletActionContext.getResponse();
		// List tempList =
		// laneInformationService.getLaneInformationByParkNoAndGateNo(Short.parseShort(parkNo),
		// Short.parseShort(gateNo));
		List tempList = laneInformationService.getLaneInformationByParkNoAndGateNo(cardHandOutIn.getParkNo(), cardHandOutIn.getGateNo());
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<lanes>");
		for (int i = 0; i < tempList.size(); i++) {
			LaneInformation information = (LaneInformation) tempList.get(i);
			pw.print("<lane id='" + information.getLaneNo() + "' name='" + information.getLaneNo() + "' />");
		}
		pw.print("</lanes>");
		return null;
	}

	public String changeDateFormat(Timestamp dateFormat) {// Date�ĸ�ʽ"yyyy-MM-dd HH:mm:ss"ת����"yyyy-MM-dd"
		try {
			String time = dateFormat.toString();
			SimpleDateFormat sdfTemp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dateTemp = sdfTemp.parse(time);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowdateTemp = sdf.format(dateTemp);
			return nowdateTemp;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "Passction��changeDateFormat��Timestamp��date��ʽת��ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowdate = sdf.format(new Date(0));
			return nowdate;
		}

	}

	public String changeDateFormat(String dateFormat) {// Date�ĸ�ʽ"yyyy-MM-dd"ת����"yyyy-MM-dd HH:mm:ss"
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date dateTemp = sdf.parse(dateFormat);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(dateTemp);
			Date date = calendar.getTime();
			SimpleDateFormat sdfTemp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowdateTemp = sdfTemp.format(date);
			return nowdateTemp;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin, "Passction��changeDateFormat��String��date��ʽת��ʱ�������쳣", e.getMessage(), "IOException");
			e.printStackTrace();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowdate = sdf.format(new Date(0));
			return nowdate;
		}

	}

	// get set ����
	@SuppressWarnings("unchecked")
	public List getParkList() {
		return parkList;
	}

	@SuppressWarnings("unchecked")
	public void setParkList(List parkList) {
		this.parkList = parkList;
	}

	@SuppressWarnings("unchecked")
	public List getGatewayList() {
		return gatewayList;
	}

	@SuppressWarnings("unchecked")
	public void setGatewayList(List gatewayList) {
		this.gatewayList = gatewayList;
	}

	@SuppressWarnings("unchecked")
	public List getListOperator() {
		return listOperator;
	}

	@SuppressWarnings("unchecked")
	public void setListOperator(List listOperator) {
		this.listOperator = listOperator;
	}

	public CardHandOutIn getCardHandOutIn() {
		return cardHandOutIn;
	}

	public void setCardHandOutIn(CardHandOutIn cardHandOutIn) {
		this.cardHandOutIn = cardHandOutIn;
	}

	public String getSquadDate() {
		return squadDate;
	}

	public void setSquadDate(String squadDate) {
		this.squadDate = squadDate;
	}

	@SuppressWarnings("unchecked")
	public List getGateList() {
		return gateList;
	}

	@SuppressWarnings("unchecked")
	public void setGateList(List gateList) {
		this.gateList = gateList;
	}

	@SuppressWarnings("unchecked")
	public List getLaneList() {
		return laneList;
	}

	@SuppressWarnings("unchecked")
	public void setLaneList(List laneList) {
		this.laneList = laneList;
	}

	@SuppressWarnings("unchecked")
	public List getListAdmin() {
		return listAdmin;
	}

	@SuppressWarnings("unchecked")
	public void setListAdmin(List listAdmin) {
		this.listAdmin = listAdmin;
	}

	@SuppressWarnings("unchecked")
	public List getSquadList() {
		return squadList;
	}

	@SuppressWarnings("unchecked")
	public void setSquadList(List squadList) {
		this.squadList = squadList;
	}

}
