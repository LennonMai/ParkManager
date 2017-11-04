package com.hgsoft.action;


import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.AllInList;
import com.hgsoft.entity.AllOutList;
import com.hgsoft.entity.CardDynamic;
import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.IdentifyResult;
import com.hgsoft.entity.InList;
import com.hgsoft.entity.InListForAuto;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.LoseCardHis;
import com.hgsoft.entity.OutList;
import com.hgsoft.entity.OutListForAuto;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CardDynamicService;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.IdentifyResultService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.LoseCardHisService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.SendParaService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;



@Controller
@Scope("prototype")
public class LostCardAction extends BaseAction {
	//��ѯ����
	private String startTime;//��ʼʱ��
	private String endTime;//����ʱ��
	private String squadDate;//��������	
	private String OutSquadDate;//tb_LoseCardHis��������ʷ��¼���г��ڹ����
	private String cardNo;//�������
	private String cardOpTime;//������ʱ��
	private String status;//״̬
	private String vehPlate;//���ƺ�
	private String owner;
	private String queryCardNo;
/*	private String startTimeTemp;//��ѯ������ֵ
	private String endTimeTemp;//��ѯ������ֵ
	private String cardNoTemp;//��ѯ������ֵ
	private String statusTemp;//��ѯ������ֵ
	private String vehPlateTemp;//��ѯ������ֵ
*/	//��ó�����Ϣ
	private String days;//�������
	private String backNums;//���ؼ�¼��
	private int nextRecord;
	private int preRecord;
	private int totalRecord;
	private int currRecord;
	//״̬ȷ��
	private String listNo;
	private AllInList allInList;
	private CardDynamic cardDynamic;
	private List<AllOutList> allOutList;
	private String imagSrc;
	private String outSrc;
	private Date opTime;
	//������ˮ�ź������ˮ��
	private String inListNo;
	private String outListNo;
	private InList inList;
	private OutList outList;
	private LoseCardHis loseCardHis;
	private String areaNo;
	//��ѯ��ʶ��ͼƬȷ��
	private String parkNo;
	private String gateNo;
	private String laneNo;
	@SuppressWarnings("unchecked")
	private List parkList;
	@SuppressWarnings("unchecked")
	private List gateList;
	@SuppressWarnings("unchecked")
	private List gates;
	@SuppressWarnings("unchecked")
	private List laneList;
	@SuppressWarnings("unchecked")
	private List listInlist;
	private String sign;
	private IdentifyResult identifyResult;
	private String listTable;

	@Resource private CardDynamicService cardDynamicService;
	@Resource private LoseCardHisService loseCardHisService;
	@Resource private IdentifyResultService identifyResultService;
	@Resource private ParkInformationService parkInformationService;
	@Resource private GatewayInformationService gatewayInformationService;
	@Resource private LaneInformationService laneInformationService;
	@Resource private SystemLogService systemLogService;
	@Resource private SysparamconfService sysparamconfService;
	@Resource private AdminService adminService;
	@Resource private SendParaService sendParaService;
	/**
	 * ��ѯδ������ʱ��
	 * @return
	 */
	public String queryCardDynamic(){
		list = cardDynamicService.queryCardDynamic(pager,startTime,endTime,cardNo,status,vehPlate);
		return "cardDynamic";
	}
	/**
	 * ״̬ȷ��
	 */
	public String cardDynamicOk(){
		parkList = parkInformationService.getAllParkInformation();
		gateList = gatewayInformationService.getAllGatewayInformation();
		cardDynamic = cardDynamicService.getByCardNo(queryCardNo);
		cardDynamic.setVehPlate(cardDynamic.getVehPlate().trim());//ȥ�����ƺŵ����ҿո�
		Admin admin = adminService.get(getCurrentOperator().getId());
		Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "Ϊ��ѯ����׽��ͼƬ�ṩ·��", "LostCardAction��cardDynamicOk()����vehPlate����ʱset������get��������ʱ���쳣", admin);
		String tempInGateNo = cardDynamic.getGateNo().toString();
		String tempInLaneNo = cardDynamic.getLaneNo().toString();
		tempInGateNo = gateNoAndLaneNo(tempInGateNo);
		tempInLaneNo = gateNoAndLaneNo(tempInLaneNo);
		Calendar cal = Calendar.getInstance();
		cal.setTime(cardDynamic.getSquadDate());
		String month = monthAndDay(String.valueOf((cal.get(Calendar.MONTH) + 1)));
		String day = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
		imagSrc = param_vehPlate.getPvalue() + tempInGateNo + tempInLaneNo + "\\" + cal.get(Calendar.YEAR) + month + "\\" + day + "\\" + cardDynamic.getInListNo() + ".jpg";
		return "ok";
	}
	
	/**
	 * �첽��ó�����Ϣ�����ƺš�����ʱ�䣩
	 */
	public String queryByOpTimeAndVehPlate() throws ParseException{
		try {
			vehPlate=java.net.URLDecoder.decode(vehPlate,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		list =  cardDynamicService.queryByOpTimeAndVehPlate(opTime,days,backNums,vehPlate);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<allOutLists>");
		if(!list.isEmpty()){
			int size = list.size();
			Admin admin = adminService.get(getCurrentOperator().getId());
			Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "Ϊ��ѯ����׽��ͼƬ�ṩ·��", "LostCardAction��queryByOpTimeAndVehPlate()����vehPlate����ʱset������get��������ʱ���쳣", admin);
			for(int i= 0 ;i < size; i ++ ){
				Object[] o = (Object[])(list.get(i));
				Calendar cal = Calendar.getInstance();
				cal.setTime((Date)o[10]);//��������
				String tempGateNo = o[3].toString();//���ű��
				String tempLaneNo = o[5].toString();
				String listNo = o[0].toString();
				tempGateNo = gateNoAndLaneNo(tempGateNo);
				tempLaneNo = gateNoAndLaneNo(tempLaneNo);
				String month = monthAndDay(String.valueOf((cal.get(Calendar.MONTH)+1)));
				String day = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
				String pic = null;
				if(null != param_vehPlate){
					pic = param_vehPlate.getPvalue()+tempGateNo+tempLaneNo+"\\"
					+cal.get(Calendar.YEAR)+month+"\\"
					+ day +"\\" + listNo+".jpg";
				}
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				ParkInformation p = parkInformationService.getParkInformationByParkNo(Short.valueOf(o[2].toString()));
				pw.print("<allOutList listNo='"+listNo+"'" +
						" parkName='"+p.getParkName()+"'" +
						" cardNo='"+o[15]+"'" +
						" gateName='"+o[5]+"'" +
						" vehplate='"+o[8]+"'" +
						" laneNo='"+o[5].toString()+"'" +
						" opTime='"+format.format(format.parse(o[13].toString()))+"'" +
						" operatorName='"+o[12]+"'" +
						" outRemark=''" +
						" pic='"+pic+"'/>");
			}
		}/*else{
			pw.print("<allOutList listNo=''" +
					" parkName=''" +
					" cardNo=''" +
					" gateName=''" +
					" vehplate=''" +
					" laneNo=''" +
					" opTime=''" +
					" operatorName=''" +
					" outRemark='' " +
					" pic=''/>");
		}*/
		pw.print("</allOutLists>");
		return null;
	}
	/**
	 *���³��ƺţ�ͨ��Ajax��
	 */
	public String updateVehPlate(){
		HttpServletResponse response = ServletActionContext.getResponse();
		boolean flag = true;
		cardDynamic = cardDynamicService.getByCardNo(cardNo);
		try {
			vehPlate=java.net.URLDecoder.decode(vehPlate,"utf-8"); 
		} catch (UnsupportedEncodingException e2) {
			e2.printStackTrace();
		}
		cardDynamic.setVehPlate(vehPlate);
		try {
			cardDynamicService.update(cardDynamic);
		} catch (RuntimeException e1) {
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]LostCardAction��updateVehPlate()�����޸ĳ��ƺ�ʱ�����쳣",e1.getMessage(), "Exception");
			flag = false;
		}
		if(flag){
			//�·������� V_LoseCardList
			sendParaService.sendParaToLane("V_LoseCardList");
			message = "���ƺ��޸ĳɹ�";
			//д��־
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"�û��޸ĳ��ƺ�Ϊ��"+cardDynamic.getVehPlate(),"��ˮ��ѯ-������ѯ-δ������ʱ����ѯ", "tb_CardDynamic");
		}else{
			message = "���ƺ��޸�ʧ��";
		}
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<massages>");
		pw.print("<massage content='"+message+"' />");
		pw.print("</massages>");
		return null;
	}
	/**
	 * ����״̬��ͨ��Ajax��
	 */
	public String updateStatus(){
		HttpServletResponse response = ServletActionContext.getResponse();
		boolean flag = true;
		cardDynamic = cardDynamicService.getByCardNo(cardNo);
		cardDynamic.setStatus(Short.parseShort(status));
		try {
			cardDynamicService.update(cardDynamic);
			if("13".equals(status) || "16".equals(status)){
				loseCardHisService.deleteByCardNoAndOpTime(cardNo, cardOpTime);
				AllOutList out = null;
				if(!"".equals(outListNo) && null != outListNo) {
					out = loseCardHisService.getByOutListNo(outListNo);
				}
				LoseCardHis his = new LoseCardHis();
				his.setCardNo(cardNo);
				his.setCardStatus(cardDynamic.getStatus());
				his.setGateNo(cardDynamic.getGateNo());
				his.setLaneNo(cardDynamic.getLaneNo());
				his.setListNo(cardDynamic.getInListNo());
				his.setOperatorName(cardDynamic.getOperatorName());
				his.setOperatorNo(cardDynamic.getOperatorNo());
				his.setOpTime(cardDynamic.getOpTime());
				his.setOwner(cardDynamic.getOwner());
				his.setParkNo(cardDynamic.getParkNo());
				his.setSquadDate(cardDynamic.getSquadDate());
				his.setVehPlate(cardDynamic.getVehPlate());
				if("13".equals(status)) {
					his.setOutRemark("�˹�ȷ�϶���");
				} else if("16".equals(status)) {
					his.setOutRemark("�˹�ȷ���ѷ���");
				} else {
					his.setOutRemark("");
				}
				if(null != out){
					his.setOutGateNo(out.getGateNo());
					his.setOutLaneNo(out.getLaneNo());
					his.setOutListNo(outListNo);
					his.setOutOperatorName(out.getOperatorName());
					his.setOutOperatorNo(out.getOperatorNo());
					his.setOutOpTime(out.getOpTime());
					his.setOutParkNo(out.getParkNo());
					his.setOutSquadDate(out.getSquadDate());
				}
				loseCardHisService.saveHis(his);
			}

		} catch (RuntimeException e1) {
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]LostCardAction��updateStatus()�޸�״̬ʱ�����쳣",e1.getMessage(), "Exception");
			
			flag = false;
		}
		if(flag){
			//�·������� V_LoseCardList
			sendParaService.sendParaToLane("V_LoseCardList");
			message = "��״̬�޸ĳɹ�";
			//д��־
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"�û��޸Ŀ�״̬Ϊ��"+cardDynamic.getStatus(),"��ˮ��ѯ-������ѯ-δ������ʱ����ѯ", "tb_CardDynamic");
		}else{
			message = "��״̬�޸�ʧ��";
		}
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<massages>");
		pw.print("<massage content='"+message+"' />");
		pw.print("</massages>");
		return null;
	}
	//============================������ʷ��¼===============================
	/**
	 * ��ѯ��������ʷ��¼
	 */
	public String queryHistory(){
		list = loseCardHisService.query(pager, startTime, endTime, cardNo, vehPlate, owner);
		return "history";
	}
	/**
	 * ���������ˮ�źͳ�����ˮ�ŵó����ڶ������ڶ���
	 */
	@SuppressWarnings("unchecked")
	public String historyMessage() throws ParseException {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Admin admin = adminService.get(getCurrentOperator().getId());
		parkList = parkInformationService.getAllParkInformation();
		Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "Ϊ��ѯ����׽��ͼƬ�ṩ·��", "LostCardAction��historyMessage()����vehPlate����ʱset������get��������ʱ���쳣", admin);
		Calendar cal = Calendar.getInstance();
		if (squadDate != null && !squadDate.equals("")) {
			listInlist = cardDynamicService.getInListByListNo(squadDate.substring(0, 10), inListNo);// �����ˮ
			if (!listInlist.isEmpty()) {
				Map map1 = (Map) listInlist.get(0);
				cal.setTime(format1.parse(squadDate));
				String tempInGateNo = map1.get("GateNo").toString();
				String tempInLaneNo = map1.get("LaneNo").toString();
				tempInGateNo = gateNoAndLaneNo(tempInGateNo);
				tempInLaneNo = gateNoAndLaneNo(tempInLaneNo);
				String month1 = monthAndDay(String.valueOf((cal.get(Calendar.MONTH) + 1)));
				String day1 = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
				imagSrc = param_vehPlate.getPvalue() + tempInGateNo + tempInLaneNo + "\\" + cal.get(Calendar.YEAR) + month1 + "\\" + day1 + "\\" + inListNo + ".jpg";
			} 
		}
		if (OutSquadDate != null && !OutSquadDate.equals("")) {
			list = cardDynamicService.getOutListByListNo(OutSquadDate.substring(0, 10), outListNo);// ������ˮ
			if (!list.isEmpty()) {
				Map map = (Map) list.get(0);
				cal.setTime(format1.parse(OutSquadDate));
				String tempOutGateNo = map.get("GateNo").toString();
				String tempOutLaneNo = map.get("LaneNo").toString();
				tempOutGateNo = gateNoAndLaneNo(tempOutGateNo);
				tempOutLaneNo = gateNoAndLaneNo(tempOutLaneNo);
				String month = monthAndDay(String.valueOf((cal.get(Calendar.MONTH) + 1)));
				String day = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
				outSrc = param_vehPlate.getPvalue() + tempOutGateNo + tempOutLaneNo + "\\" + cal.get(Calendar.YEAR) + month + "\\" + day + "\\" + outListNo + ".jpg";
			} 
		}
		loseCardHis = loseCardHisService.get(cardNo, opTime);
		return "message";
	}
	//============================��ʶ��ͼƬȷ��================================
	/**
	 * ��һ����ʶ��ͼƬ��ѯ������ѯ���ݳ�����
	 */
	public String indentifyFrame(){
		if(null == sign || sign.equals("")){
			sign = "1";
		}
		parkList = parkInformationService.getAllParkInformation();
		return "identify";
	}
	/**
	 * ��ѯ��ʶ��ͼƬȷ��
	 */
	public String queryIndentify(){
		if(null == sign || sign.equals("")){
			sign = "1";
		}
		list = identifyResultService.query(pager,startTime,endTime,parkNo,gateNo,laneNo,sign);
		parkList = parkInformationService.getAllParkInformation();
		gates = gatewayInformationService.getAllGatewayInformation();
		if(null != parkNo && !parkNo.equals("")){
			gateList = gatewayInformationService.getGatewayInformationByParkNo(Short.parseShort(parkNo));
		}
		if(null != parkNo && !parkNo.equals("") && null != gateNo && !gateNo.equals("")){
			laneList = laneInformationService.getLaneInformationByParkNoAndGateNo(Short.parseShort(parkNo), Short.parseShort(gateNo));
		}
		return "identify";
	}
	/**
	 * �����޸ĳ��ƺ�
	 */
	public String toUpdateIdentify(){
		Admin admin = adminService.get(getCurrentOperator().getId());
		Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "Ϊ��ѯ����׽��ͼƬ�ṩ·��", "LostCardAction��toUpdateIdentify()����vehPlate����ʱset������get��������ʱ���쳣", admin);
		Calendar cal = Calendar.getInstance();
		identifyResult = identifyResultService.getById(listNo);
		identifyResult.setVehPlate(identifyResult.getVehPlate().trim());
		if(sign.equals("1")){
			InListForAuto inAuto = identifyResultService.getInAutoByListNo(listTable);
			if(null != inAuto){
				if(null != param_vehPlate){
					cal.setTime(inAuto.getSquadDate());
					String tempGateNo = inAuto.getGateNo().toString();
					String tempLaneNo = inAuto.getLaneNo().toString();
					tempGateNo = gateNoAndLaneNo(tempGateNo);
					tempLaneNo = gateNoAndLaneNo(tempLaneNo);
					String month = monthAndDay(String.valueOf((cal.get(Calendar.MONTH)+1)));
					String day = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
					imagSrc = param_vehPlate.getPvalue()+tempGateNo+tempLaneNo+"\\"
						+cal.get(Calendar.YEAR)+month+"\\"
						+ day+"\\" + inAuto.getListNo()+".jpg";
				}
			}
		}else{
			OutListForAuto outAuto = identifyResultService.getOutAutoByListNo(listTable);
			if(null != outAuto){
				if(null != param_vehPlate){
					cal.setTime(outAuto.getSquadDate());
					String tempGateNo = outAuto.getGateNo().toString();
					String tempLaneNo = outAuto.getLaneNo().toString();
					tempGateNo = gateNoAndLaneNo(tempGateNo);
					tempLaneNo = gateNoAndLaneNo(tempLaneNo);
					String month = monthAndDay(String.valueOf((cal.get(Calendar.MONTH)+1)));
					String day = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
					imagSrc = param_vehPlate.getPvalue()+tempGateNo+tempLaneNo+"\\"
						+cal.get(Calendar.YEAR)+month+"\\"
						+ day +"\\" + outAuto.getListNo()+".jpg";
				}
			}
		}
		return "updateIdentify";
	}
	/**
	 * �޸ĳ��ƺ�
	 */
	public String updateIdentify(){
		IdentifyResult result = identifyResultService.getById(identifyResult.getListNo());
		result.setVehPlate(identifyResult.getVehPlate());
		try {
			identifyResultService.update(result);
		} catch (RuntimeException e) {
			Admin logAdmin = this.getCurrentOperator();
			systemLogService.save(new Date(), 2, logAdmin,"["+logAdmin.getId()+"]LostCardAction��updateIdentify()�޸ĳ��ƺ�ʱ�����쳣",e.getMessage(), "Exception");
			message = "2";
			return queryIndentify();
		}
		//д��־
		Admin logAdmin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, logAdmin, "["+logAdmin.getId()+"]"+logAdmin.getUsername()+"�û��޸ĳ��ƺ�Ϊ��"+result.getVehPlate(),"��ˮ��ѯ-������ѯ-��ʶ��ͼƬȷ��", "tb_IdentifyResult");
		message = "1";
		return queryIndentify();
	}
	/**
	 * �첽��ȡС����Ϣ
	 */
	@SuppressWarnings("unchecked")
	public String ajaxPark(){
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = parkInformationService.getAllParkInformationByAreaNo(Short.parseShort(areaNo));
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		pw.print("<parks>");
		for (int i = 0; i < tempList.size(); i++) {
			ParkInformation information = (ParkInformation) tempList.get(i);
			pw.print("<park id='" + information.getParkNo() + "' name='" + information.getParkName() + "' />");
		}
		pw.print("</parks>");
		return null;
	}
	
	/**
	 * �첽���С��������Ϣ
	 */
	@SuppressWarnings("unchecked")
	public String ajaxGate(){
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = gatewayInformationService.getGatewayInformationByParkNo(Short.parseShort(parkNo));
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
	 */
	@SuppressWarnings("unchecked")
	public String ajaxLane(){
		HttpServletResponse response = ServletActionContext.getResponse();
		List tempList = laneInformationService.getLaneInformationByParkNoAndGateNo(Short.parseShort(parkNo), Short.parseShort(gateNo));
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
	/**
	 * ��ͼƬ
	 */
	public void readImg(){
		int BUFFER_SIZE = 16 * 1024;
		HttpServletResponse response = ServletActionContext.getResponse();
		String file_name= imagSrc;
		//System.out.println("+++"+file_name);
		file_name = file_name.replace("\\", "/");
		//System.out.println("=================���ͼƬ·��:"+file_name);
		File file = new File(file_name);
		if(file.exists()){
			InputStream in = null;
			OutputStream out = null;
			try {
				in = new BufferedInputStream(new FileInputStream(file),BUFFER_SIZE);
				out = response.getOutputStream();
				byte[] buffer = new byte[BUFFER_SIZE];
				int i;
				while ((i = in.read(buffer)) > 0) {
					out.write(buffer, 0, i);
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				if (null != in) {
					try {
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (null != out) {
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	/**
	 * ��ϴ��źźͳ����ŵĳ���
	 */
	public String gateNoAndLaneNo(String temp){
		String str = "";
		String [] ss = {"0000","000","00","0",""};
		str = ss[temp.length()] + temp;
		return str;
	}
	/**
	 * ����·ݻ�����
	 */
	public String monthAndDay(String temp){
		String str="";
		String [] ss={"00","0",""};
		str = ss[temp.length()]+temp; 
		return str;
	}
	
	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getVehPlate() {
		return vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}
	public String getListNo() {
		return listNo;
	}
	public void setListNo(String listNo) {
		this.listNo = listNo;
	}
	public AllInList getAllInList() {
		return allInList;
	}
	public void setAllInList(AllInList allInList) {
		this.allInList = allInList;
	}
	public CardDynamic getCardDynamic() {
		return cardDynamic;
	}
	public void setCardDynamic(CardDynamic cardDynamic) {
		this.cardDynamic = cardDynamic;
	}
	
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public Date getOpTime() {
		return opTime;
	}
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public String getInListNo() {
		return inListNo;
	}
	public void setInListNo(String inListNo) {
		this.inListNo = inListNo;
	}
	public String getOutListNo() {
		return outListNo;
	}
	public void setOutListNo(String outListNo) {
		this.outListNo = outListNo;
	}
	public InList getInList() {
		return inList;
	}
	public void setInList(InList inList) {
		this.inList = inList;
	}
	public OutList getOutList() {
		return outList;
	}
	public void setOutList(OutList outList) {
		this.outList = outList;
	}
	public LoseCardHis getLoseCardHis() {
		return loseCardHis;
	}
	public void setLoseCardHis(LoseCardHis loseCardHis) {
		this.loseCardHis = loseCardHis;
	}
	public String getParkNo() {
		return parkNo;
	}
	public void setParkNo(String parkNo) {
		this.parkNo = parkNo;
	}
	public String getGateNo() {
		return gateNo;
	}
	public void setGateNo(String gateNo) {
		this.gateNo = gateNo;
	}
	public String getLaneNo() {
		return laneNo;
	}
	public void setLaneNo(String laneNo) {
		this.laneNo = laneNo;
	}
	@SuppressWarnings("unchecked")
	public List getParkList() {
		return parkList;
	}
	@SuppressWarnings("unchecked")
	public void setParkList(List parkList) {
		this.parkList = parkList;
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
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public IdentifyResult getIdentifyResult() {
		return identifyResult;
	}
	public void setIdentifyResult(IdentifyResult identifyResult) {
		this.identifyResult = identifyResult;
	}
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getBackNums() {
		return backNums;
	}
	public void setBackNums(String backNums) {
		this.backNums = backNums;
	}
	public int getNextRecord() {
		return nextRecord;
	}
	public void setNextRecord(int nextRecord) {
		this.nextRecord = nextRecord;
	}
	public int getPreRecord() {
		return preRecord;
	}
	public void setPreRecord(int preRecord) {
		this.preRecord = preRecord;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getCurrRecord() {
		return currRecord;
	}
	public void setCurrRecord(int currRecord) {
		this.currRecord = currRecord;
	}
	public List<AllOutList> getAllOutList() {
		return allOutList;
	}
	public void setAllOutList(List<AllOutList> allOutList) {
		this.allOutList = allOutList;
	}
	public String getImagSrc() {
		return imagSrc;
	}
	public void setImagSrc(String imagSrc) {
		this.imagSrc = imagSrc;
	}
	public String getOutSrc() {
		return outSrc;
	}
	public void setOutSrc(String outSrc) {
		this.outSrc = outSrc;
	}
	public String getListTable() {
		return listTable;
	}
	public void setListTable(String listTable) {
		this.listTable = listTable;
	}
	public String getAreaNo() {
		return areaNo;
	}
	public void setAreaNo(String areaNo) {
		this.areaNo = areaNo;
	}
	public String getSquadDate() {
		return squadDate;
	}
	public void setSquadDate(String squadDate) {
		this.squadDate = squadDate;
	}
	/*public String getStartTimeTemp() {
		return startTimeTemp;
	}
	public void setStartTimeTemp(String startTimeTemp) {
		this.startTimeTemp = startTimeTemp;
	}
	public String getEndTimeTemp() {
		return endTimeTemp;
	}
	public void setEndTimeTemp(String endTimeTemp) {
		this.endTimeTemp = endTimeTemp;
	}
	public String getCardNoTemp() {
		return cardNoTemp;
	}
	public void setCardNoTemp(String cardNoTemp) {
		this.cardNoTemp = cardNoTemp;
	}
	public String getStatusTemp() {
		return statusTemp;
	}
	public void setStatusTemp(String statusTemp) {
		this.statusTemp = statusTemp;
	}
	public String getVehPlateTemp() {
		return vehPlateTemp;
	}
	public void setVehPlateTemp(String vehPlateTemp) {
		this.vehPlateTemp = vehPlateTemp;
	}*/

	public String getOutSquadDate() {
		return OutSquadDate;
	}
	public void setOutSquadDate(String outSquadDate) {
		OutSquadDate = outSquadDate;
	}
	@SuppressWarnings("unchecked")
	public List getListInlist() {
		return listInlist;
	}
	@SuppressWarnings("unchecked")
	public void setListInlist(List listInlist) {
		this.listInlist = listInlist;
	}
	@SuppressWarnings("unchecked")
	public List getGates() {
		return gates;
	}
	@SuppressWarnings("unchecked")
	public void setGates(List gates) {
		this.gates = gates;
	}
	public String getQueryCardNo() {
		return queryCardNo;
	}
	public void setQueryCardNo(String queryCardNo) {
		this.queryCardNo = queryCardNo;
	}
	public String getCardOpTime() {
		return cardOpTime;
	}
	public void setCardOpTime(String cardOpTime) {
		this.cardOpTime = cardOpTime;
	}
}
