package com.hgsoft.action;

import java.io.OutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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
import com.hgsoft.entity.CardType;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.entity.SpEventCode;
import com.hgsoft.entity.SquadInformation;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.TicketTypeCode;
import com.hgsoft.entity.UserCardType;
import com.hgsoft.entity.VehClassCode;
import com.hgsoft.entity.VehTypeCode;
import com.hgsoft.entity.WaterQuery;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.AreaInformationService;
import com.hgsoft.service.CardDynamicService;
import com.hgsoft.service.CardTypeService;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardTypeService;
import com.hgsoft.util.ExcelUtil;

@Controller
@Scope("prototype")
public class WaterQueryAction extends BaseAction {
	
	private String cardNo;//
	private String vehPlate;
	private String listNo;
	private String statusOutIn;//���ڻ���� 1Ϊ��ڣ�2Ϊ����
	private String squadDate;//��������
	private String squadTime;
	private String squadTime_start;
	private String squadTime_end;
	private String queryStatus;//��ѯ״̬ 1Ϊ���� 2Ϊ��ϸ
	//��ϸ��ѯ
	private String spEvent;//�����¼�
	private String ticketType;//ͨ�о�����
	private String operatorNo;//����Ա��
	private String operatorName;//����Ա����
	private String vehType;//����
	private String vehClass;//����
	private String parkNo;
	private String gateNo;
	private String laneNo;
	private String squadNo;//�����
	private String opTime;//����ʱ��
	private String timeStatus;
	private String startTime;
	private String endTime;
	private String cashMoneyMin;
	private String cashMoneyMax;
	private String etcMoneyMin;
	private String etcMoneyMax;
	private String userCardType;
	private String cardType;
	private String fuzzySearch;//�Ƿ�ģ����ѯ
	private WaterQuery waterQuery; //��ӡ��ˮ��ѯ ʵ��
	@SuppressWarnings("unchecked")private List areaList;
	@SuppressWarnings("unchecked")private List parkList;
	@SuppressWarnings("unchecked")private List gateList;
	@SuppressWarnings("unchecked")private List laneList;
	@SuppressWarnings("unchecked")private List squadList;
	@SuppressWarnings("unchecked")private List ticketTypeList;
	@SuppressWarnings("unchecked")private List vehTypeList;
	@SuppressWarnings("unchecked")private List vehClassList;
	@SuppressWarnings("unchecked")private List spEventList;
	@SuppressWarnings("unchecked")private List listInlist;
	@SuppressWarnings("unchecked")private List cardTypeList;
	@SuppressWarnings("unchecked")private List userCardTypeList;
	private String inSrc;//���ͼƬ·��
	private String outSrc;//����ͼƬ·��
	private AllInList allInList;
	private AllOutList allOutList;
	@Resource private CardDynamicService cardDynamicService;
	@Resource private ParkInformationService parkInformationService;
	@Resource private GatewayInformationService gatewayInformationService;
	@Resource private LaneInformationService laneInformationService;
	@Resource private SquadInformationService squadInformationService;
	@Resource private AreaInformationService areaInformationService;
	@Resource private SysparamconfService  sysparamconfService;
	@Resource private AdminService adminService;
	@Resource private CardTypeService cardTypeService;
	@Resource private UserCardTypeService userCardTypeService;
	@Resource private SystemLogService systemLogService;
	/**
	 * ������λ��, Math.pow(2,23)2��23�η�,��ֵת����2�ģ�value-1���η�,Ȼ��ת���ɶ�����,���ݿ��е�ֵҲת���ɶ����ƣ�Ȼ��Ƚϰ����Ƿ����
	 * @return
	 */
	public String removeLeftAndToBin(String value){
		String s="";	
		int a =0;
		if(!value.equals("0")){	
			 a = Integer.parseInt(value)-1;
			if(a<=23){
				int tempInt =  1<<a;//(int) Math.pow(2, a);
				s = Integer.toBinaryString(tempInt).toString();
				//s = String.valueOf(tempInt);
			} else if(a>23&&a<31){
				int c=a%23;
				int tempInt =(1<<c)*(1<<23);//(int) Math.pow(2, c)*(int) Math.pow(2, 23);
				s = Integer.toBinaryString(tempInt).toString();
				//s = String.valueOf(tempInt);
			} else{
				s = null;//value��ֵ����31ʱ�Ͳ�����ѯ��ֵ��������ֻ�õ�29.����תΪ�������ַ������31λ
			}
		} else {
			return "0";
		}
		return s;
	}	
	@SuppressWarnings("unchecked")
	public List setSpEventValues(List tempList,List spEventCodeTempList){
		String tempString = "",s = "";
		SpEventCode spEventCode;
		int b,c,d,e,f=0;
		Object[] a;
		List list = new ArrayList();
		for(int i=0;i<tempList.size();i++){
			a =(Object[])(tempList.get(i));
			if(a[13]!=null){
				b=(Integer) a[13];
				a[13]=null;
				f=0;
				tempString = Integer.toBinaryString(b);
				c = tempString.length();
				while(c<31){//2���Ƴ��Ȳ��ܴ���31
					tempString = "0"+tempString;
					c = tempString.length();
				}
				for(int j=0;j<spEventCodeTempList.size();j++){					
					spEventCode = (SpEventCode)spEventCodeTempList.get(j);
					s = removeLeftAndToBin(spEventCode.getSpEventNo().toString());
					d = s.length();
					e = 31 - d +1;
					String indexString = s.substring(0, 1);
					if(s.indexOf("1")==-1){
						if(tempString.indexOf("1")==-1){
							a[13]=spEventCode.getSpEventName();
							break;
						}
					}else{
						if(indexString.equals(tempString.substring(e-1, e))){
							if(f==0){
								a[13]=spEventCode.getSpEventName().trim();
								f=1;
							}else{
								a[13]=a[13]+"/"+spEventCode.getSpEventName().trim();;
							}
							
						}
					}					
				}
				
				
			}
			list.add(a);
		}
		return list;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List setSpEventValues1(List tempList,List spEventCodeTempList) {
		String tempString = "",s = "";
		SpEventCode spEventCode;
		int b,c,d,e,f=0;
		List list = new ArrayList();
		Iterator it = tempList.iterator();    
		while(it.hasNext()) {    
		    Map carPartStatusMap = (Map) it.next();    
		    if(carPartStatusMap.get("SpEvent") != null){
		    	Object o = carPartStatusMap.get("SpEvent");
		    	b = Integer.parseInt(String.valueOf(o));
				f=0;
				tempString = Integer.toBinaryString(b);
				c = tempString.length();
				while(c<31){//2���Ƴ��Ȳ��ܴ���31
					tempString = "0"+tempString;
					c = tempString.length();
				}
				for(int j=0;j<spEventCodeTempList.size();j++){					
					spEventCode = (SpEventCode)spEventCodeTempList.get(j);
					s = removeLeftAndToBin(spEventCode.getSpEventNo().toString());
					d = s.length();
					e = 31 - d +1;
					String indexString = s.substring(0, 1);
					if(s.indexOf("1")==-1){
						if(tempString.indexOf("1")==-1){
							carPartStatusMap.put("SpEvent", spEventCode.getSpEventName().trim());
							break;
						}
					}else{
						if(indexString.equals(tempString.substring(e-1, e))){
							if(f==0){
								carPartStatusMap.put("SpEvent", spEventCode.getSpEventName().trim());
								f=1;
							}else{
								carPartStatusMap.put("SpEvent",carPartStatusMap.put("SpEvent", spEventCode.getSpEventName().trim())+"/"+spEventCode.getSpEventName().trim());
							}						
						}
					}				
				}	
			}
			list.add(carPartStatusMap);
		} 
		return list;
	}	
	/**
	 * ��ȡ��ˮ��ѯ����
	 */
	public String query() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		squadList = squadInformationService.getAllSquadInformation();// ��ѯ���й����
		ticketTypeList = cardDynamicService.getAllTicketType();// ͨ�о�����
		vehTypeList = cardDynamicService.getAllVehType();// ����
		vehClassList = cardDynamicService.getAllVehClass();// ����
		spEventList = cardDynamicService.getAllSpEvent();// �����¼�
		parkList = parkInformationService.getAllParkInformation();
		if(null != parkNo && !parkNo.equals("")){
			gateList = gatewayInformationService.getGatewayInformationByParkNo(Short.valueOf(parkNo));
		}
		if(null != parkNo && !parkNo.equals("") && null != gateNo && !gateNo.equals("")){
			laneList = laneInformationService.getLaneInformationByParkNoAndGateNo(Short.valueOf(parkNo), Short.valueOf(gateNo));
		}
		userCardTypeList = userCardTypeService.getAllUserCardType();
		cardTypeList = cardTypeService.getAllCardType();
		String temp = "";
		// ��������λ��Ϊ������ˮ�е�ֵ���Ӧ
		if (null != spEvent && !spEvent.equals("")) {
			temp = removeLeftAndToBin(spEvent);
		}
		//��ʼ����ϸ��ѯ�еĹ������ڣ�ֵΪ��ǰϵͳ����
		if (null == squadTime  && null == startTime  && null == endTime ) {
			squadTime = format.format(new Date());
		}
		// �жϵ���ѯ���ͺͱ��ǿյ�ʱ�򣬲����в�ѯ������Ͳ�ѯ
		if (null == queryStatus || queryStatus.equals("") && null == statusOutIn || statusOutIn.equals("")) {
			queryStatus = "1";
			statusOutIn = "2";
		} else {
			list = cardDynamicService.waterQuery(pager, cardNo, vehPlate, listNo, statusOutIn, squadDate, temp, 
					ticketType, operatorNo, operatorName, vehType, vehClass, parkNo, gateNo, laneNo, squadNo, 
					opTime, queryStatus, timeStatus, squadTime_start,squadTime_end, startTime, endTime,cashMoneyMin,cashMoneyMax,etcMoneyMin,etcMoneyMax,fuzzySearch,userCardType,cardType,"1");
		    list = this.setSpEventValues(list,spEventList);
		}
		return "waterQuery";
	}
	/**
	 * ������ˮ
	 */
	public String exportWater() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		squadList = squadInformationService.getAllSquadInformation();// ��ѯ���й����
		ticketTypeList = cardDynamicService.getAllTicketType();// ͨ�о�����
		vehTypeList = cardDynamicService.getAllVehType();// ����
		vehClassList = cardDynamicService.getAllVehClass();// ����
		spEventList = cardDynamicService.getAllSpEvent();// �����¼�
		parkList = parkInformationService.getAllParkInformation();
		if(null != parkNo && !parkNo.equals("")){
			gateList = gatewayInformationService.getGatewayInformationByParkNo(Short.valueOf(parkNo));
		}
		if(null != parkNo && !parkNo.equals("") && null != gateNo && !gateNo.equals("")){
			laneList = laneInformationService.getLaneInformationByParkNoAndGateNo(Short.valueOf(parkNo), Short.valueOf(gateNo));
		}
		userCardTypeList = userCardTypeService.getAllUserCardType();
		cardTypeList = cardTypeService.getAllCardType();
		
		Map<String,String> mapPark = new HashMap<String,String>();
		Map<String,String> mapVehType = new HashMap<String, String>();
		Map<String,String> mapVehClass = new HashMap<String,String>();
		Map<String,String> mapSquad = new HashMap<String,String>();
		Map<String,String> mapUserCardType = new HashMap<String, String>();
		Map<String,String> mapTicketType = new HashMap<String,String>();
		Map<String,String> mapCardType = new HashMap<String,String>();
		if(!parkList.isEmpty()){ 
			for(int i=0;i<parkList.size();i++){
				ParkInformation temp = (ParkInformation) parkList.get(i);
				mapPark.put(temp.getParkNo().toString(), temp.getParkName());
			}
		}
		if(!vehTypeList.isEmpty()) {
			for(int i=0;i<vehTypeList.size();i++) {
				VehTypeCode temp = (VehTypeCode) vehTypeList.get(i);
				mapVehType.put(temp.getVehTypeNo().toString(), temp.getVehTypeName());
			}
		}
		if(!vehClassList.isEmpty()) {
			for(int i=0;i<vehClassList.size();i++) {
				VehClassCode temp = (VehClassCode) vehClassList.get(i);
				mapVehClass.put(temp.getVehClassNo().toString(), temp.getVehClassName());
			}
		}
		if(!squadList.isEmpty()) {
			for(int i=0;i<squadList.size();i++) {
				SquadInformation temp = (SquadInformation) squadList.get(i);
				mapSquad.put(temp.getSquadNo().toString(), temp.getSquadName());
			}
		}
		if(!userCardTypeList.isEmpty()) {
			for(int i=0;i<userCardTypeList.size();i++) {
				UserCardType temp = (UserCardType) userCardTypeList.get(i);
				mapUserCardType.put(temp.getUserCardType().toString(), temp.getTypeName());
			}
		}
		if(!ticketTypeList.isEmpty()) {
			for(int i=0;i<ticketTypeList.size();i++) {
				TicketTypeCode temp = (TicketTypeCode) ticketTypeList.get(i);
				mapTicketType.put(temp.getTicketTypeNo().toString(), temp.getTicketTypeName());
			}
		}
		if(!cardTypeList.isEmpty()) {
			for(int i=0;i<cardTypeList.size();i++) {
				CardType temp = (CardType) cardTypeList.get(i);
				mapCardType.put(temp.getCardType().toString(),temp.getTypeName());
			}
		}
		Map<Integer,Map<String,String>> map = new HashMap<Integer, Map<String,String>>();
		map.put(1, mapPark);
		map.put(4, mapVehType);
		map.put(5, mapVehClass);
		map.put(7, mapSquad);
		map.put(14, mapUserCardType);
		map.put(17, mapTicketType);
		map.put(18, mapCardType);
		mapCardType.put("0", "�޿�");			
		String temp = "";
		// ��������λ��Ϊ������ˮ�е�ֵ���Ӧ
		if (null != spEvent && !spEvent.equals("")) {
			temp = removeLeftAndToBin(spEvent);
		}
		//��ʼ����ϸ��ѯ�еĹ������ڣ�ֵΪ��ǰϵͳ����
		if (null == squadTime  && null == startTime  && null == endTime ) {
			squadTime = format.format(new Date());
		}
		// �жϵ���ѯ���ͺͱ��ǿյ�ʱ�򣬲����в�ѯ������Ͳ�ѯ
		if (null == queryStatus || queryStatus.equals("") && null == statusOutIn || statusOutIn.equals("")) {
			queryStatus = "1";
			statusOutIn = "2";
		} else {
			try{
				list = cardDynamicService.waterQuery(pager, cardNo, vehPlate, listNo, statusOutIn, squadDate, temp, 
						ticketType, operatorNo, operatorName, vehType, vehClass, parkNo, gateNo, laneNo, squadNo, 
						opTime, queryStatus, timeStatus, squadTime_start,squadTime_end, startTime, endTime,cashMoneyMin,cashMoneyMax,etcMoneyMin,etcMoneyMax,fuzzySearch,userCardType,cardType,"2");
			}catch(OutOfMemoryError ome){
				systemLogService.save(new Date(), 2, getCurrentOperator(), "["
						+ this.getCurrentOperator().getId() + "]"
						+ this.getCurrentOperator().getUsername()
						+ "�û�����ˮ��Ϣ������Excelʱ�׳�OutOfMemoryError�쳣", "��ˮ��ѯ-����", "OutOfMemoryError");
		    	message = "���ڵ��������������󣬵��¶��ڴ����������ʧ�ܣ�\\n\\n���޸Ĳ�ѯ���������ԣ�\\n\\n��ʾ���������޸Ĳ�ѯ������С��ѯ��Χ�������ν��е������磺����ʱ�䷶Χ���޸Ļ�����������ѯ�������Ƶȣ��Լ���һ���Ե���������������";
		    	return query();				
			}
 		    list = this.setSpEventValues1(list,spEventList);
		}
		
		String titleStr = "";
		HttpServletResponse response = ServletActionContext.getResponse();
		try{
	  	  	response.setContentType("octets/stream");//�򵥿�������Ϊ��Ϣ��
	  	  	SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMddHHmmss");
	  	  	String title = "waterQuery"+format1.format(new Date())+".xls";
		    response.addHeader("Content-Disposition", "attachment;filename="+title);	      
		    //�ͻ��˲�����
		    response.addHeader("Pragma","no-cache");
		    response.addHeader("Cache-Control","no-cache");
		    ExcelUtil<Object[]> excelUtil = new ExcelUtil<Object[]>();
		    String[] headers1 =  {"��ˮ��","С��", "����","����","����","����", "���ƺ�", "�����","����ʱ��","�շ�Ա����","�շ�Ա����","����ʱ��","�����¼�","�������","�û�������"};
		    String[] headers2 = {"��ˮ��","С��", "���ڴ���","���ڳ���","����","����", "���ƺ�", "�����","����ʱ��","�շ�Ա����","�շ�Ա����","����ʱ��","�����¼�","�������","�û�������","��ڴ���","��ڳ���","ͨ�о�����","֧��������","Ӧ���ֽ�Ԫ��","ETC��Ԫ��"};
		    String[] headers = null;
		    if("1".equals(statusOutIn)){//���
		    	headers = headers1;
		    	titleStr = "�����ˮ��Ϣ";
		    	
		    }else{//����
		    	headers = headers2;
		    	titleStr = "������ˮ��Ϣ";
		    }
		    
	        OutputStream out = response.getOutputStream();
	        excelUtil.exportWaterQueryExcel(titleStr, headers, list, out, 5000,map);
	        systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�����"+titleStr+"�ļ��ɹ�", titleStr+"��ѯ-����", titleStr+format1.format(new Date())+".xls");
	        out.close();
		}catch (Exception e) {
			systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���"+titleStr+"������Excelʱ�׳����쳣", titleStr+"Ϣ��ѯ-����", "Exception");
			e.printStackTrace();
	    }catch(OutOfMemoryError ome){
			systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���" + titleStr + "������Excelʱ�׳�OutOfMemoryError�쳣", "��ˮ��ѯ-����", "OutOfMemoryError");
	    	response.reset();
	    	message = "���ڵ��������������󣬵��¶��ڴ����������ʧ�ܣ�\\n\\n���޸Ĳ�ѯ���������ԣ�\\n\\n��ʾ���������޸Ĳ�ѯ������С��ѯ��Χ�������ν��е������磺����ʱ�䷶Χ���޸Ļ�����������ѯ�������Ƶȣ��Լ���һ���Ե���������������";
			return query();
		}
		return null;
	}	
	/**
	 * ��ѯ��ϸ��Ϣ
	 */
	@SuppressWarnings("unchecked")
	public String show() throws ParseException{
		squadList = squadInformationService.getAllSquadInformation();//��ѯ���й����
		ticketTypeList = cardDynamicService.getAllTicketType();
		vehTypeList = cardDynamicService.getAllVehType();
		vehClassList = cardDynamicService.getAllVehClass();
		spEventList = cardDynamicService.getAllSpEvent();
		parkList = parkInformationService.getAllParkInformation();
		areaList = areaInformationService.getAllAreaInformation();
		if(statusOutIn.equals("1")){//�������ˮ��
			list = cardDynamicService.getInListByListNo(squadTime,listNo);
			if(!list.isEmpty()){
				Admin admin = adminService.get(getCurrentOperator().getId());
				Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "Ϊ��ѯ����׽��ͼƬ�ṩ·��", "WaterQueryAction��complate()����vehPlate����ʱset������get��������ʱ���쳣", admin);
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Calendar cal = Calendar.getInstance();
				Map map = (Map) list.get(0);
				String time1 = map.get("SquadDate").toString();
				cal.setTime(format1.parse(time1));
				String tempInGateNo = map.get("GateNo").toString();
				String tempInLaneNo = map.get("LaneNo").toString();
				tempInGateNo = gateNoAndLaneNo(tempInGateNo);
				tempInLaneNo = gateNoAndLaneNo(tempInLaneNo);
				String month1 = monthAndDay(String.valueOf((cal.get(Calendar.MONTH) + 1)));
				String day1 = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
				inSrc = param_vehPlate.getPvalue() + tempInGateNo + tempInLaneNo + "\\" + cal.get(Calendar.YEAR) + month1 + "\\" + day1 + "\\" + map.get("listNo") + ".jpg";
				//System.out.println(inSrc);
				list = this.setSpEventValues1(list,spEventList);
			}
			return "inShow";
		}else{//�������ˮ��
			cardTypeList = cardTypeService.getAllCardType();
			list = cardDynamicService.getOutListByListNo(squadTime,listNo);
			list = this.setSpEventValues1(list,spEventList);
			return "outShow";
		}
	}
	/**
	 * ����ڶԱ�
	 */
	@SuppressWarnings("unchecked")
	public String complate() throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		areaList = areaInformationService.getAllAreaInformation();
		parkList = parkInformationService.getAllParkInformation();
		ticketTypeList = cardDynamicService.getAllTicketType();
		vehTypeList = cardDynamicService.getAllVehType();
		vehClassList = cardDynamicService.getAllVehClass();
		Admin admin = adminService.get(getCurrentOperator().getId());
		Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "Ϊ��ѯ����׽��ͼƬ�ṩ·��", "WaterQueryAction��complate()����vehPlate����ʱset������get��������ʱ���쳣", admin);
		Calendar cal = Calendar.getInstance();
		list = cardDynamicService.getOutListByListNo(squadTime, listNo);
		Map map = (Map) list.get(0);
		cal.setTime(format.parse(squadTime));
		String tempOutGateNo = map.get("GateNo").toString();
		String tempOutLaneNo = map.get("LaneNo").toString();
		tempOutGateNo = gateNoAndLaneNo(tempOutGateNo);
		tempOutLaneNo = gateNoAndLaneNo(tempOutLaneNo);
		String month = monthAndDay(String.valueOf((cal.get(Calendar.MONTH) + 1)));
		String day = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
		outSrc = param_vehPlate.getPvalue()+ tempOutGateNo + tempOutLaneNo + "\\" + cal.get(Calendar.YEAR) + month + "\\" + day + "\\" + listNo + ".jpg";
		String time = map.get("InOpTime").toString().substring(0, 10);// ��ȡ������ˮ����ڷ���ʱ��
		String inlistNo = map.get("InListNo").toString();// ��������ˮ��
		listInlist = cardDynamicService.getInListByInOpTimeAndListNo(time, inlistNo);// ��ѯ�����ˮ
		if (!listInlist.isEmpty()) {
			Map map1 = (Map) listInlist.get(0);
			String time1 = map1.get("SquadDate").toString();
			cal.setTime(format1.parse(time1));
			String tempInGateNo = map1.get("GateNo").toString();
			String tempInLaneNo = map1.get("LaneNo").toString();
			tempInGateNo = gateNoAndLaneNo(tempInGateNo);
			tempInLaneNo = gateNoAndLaneNo(tempInLaneNo);
			String month1 = monthAndDay(String.valueOf((cal.get(Calendar.MONTH) + 1)));
			String day1 = monthAndDay(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
			inSrc = param_vehPlate.getPvalue() + tempInGateNo + tempInLaneNo + "\\" + cal.get(Calendar.YEAR) + month1 + "\\" + day1 + "\\" + inlistNo + ".jpg";
		}
		return "complate";
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
	
	
	public String printList(){
		parkList = parkInformationService.getAllParkInformation();
		if(null != parkNo && !parkNo.equals("")){
			gateList = gatewayInformationService.getGatewayInformationByParkNo(Short.valueOf(parkNo));
		}
		if(null != parkNo && !parkNo.equals("") && null != gateNo && !gateNo.equals("")){
			laneList = laneInformationService.getLaneInformationByParkNoAndGateNo(Short.valueOf(parkNo), Short.valueOf(gateNo));
		}
		
		spEventList = cardDynamicService.getAllSpEvent();// �����¼�
		squadList = squadInformationService.getAllSquadInformation();// ��ѯ���й����
		if(waterQuery==null||waterQuery.getDhtime()==null||waterQuery.getDltime()==null){
			waterQuery = new WaterQuery();
			waterQuery.setSpEventState(1);//Ĭ�ϲ�ѯ�����¼�
			waterQuery.setTimeState(1);//Ĭ�ϲ�ѯ�����¼�
			waterQuery.setLaneNoState(1);//Ĭ�ϲ�ѯ����λ��
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//����Ĭ�ϲ�ѯ ʱ��
			Calendar cal = Calendar.getInstance();
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),0,0,0);
			waterQuery.setDltime(cal.getTime());
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),23,59,59);
			waterQuery.setDhtime(cal.getTime());
			return "printList";
		}
		list = cardDynamicService.printQuery(pager,waterQuery);
		//�ж�������ù��Ų�ѯ���򽫹��Ŷ�Ӧ����������
		if(waterQuery!=null&&waterQuery.getOperatorNo()!=null&&list!=null&&list.size()>0)
			waterQuery.setOperatorName(((WaterQuery)list.get(0)).getOperatorName());
	
//		System.out.println(list.size());
		return "printList";
	}
	
	
	public String print(){
		return "print";
	}
	public AllInList getAllInList() {
		return allInList;
	}
	public void setAllInList(AllInList allInList) {
		this.allInList = allInList;
	}
	public AllOutList getAllOutList() {
		return allOutList;
	}
	public void setAllOutList(AllOutList allOutList) {
		this.allOutList = allOutList;
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

	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
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
	public String getStatusOutIn() {
		return statusOutIn;
	}
	public void setStatusOutIn(String statusOutIn) {
		this.statusOutIn = statusOutIn;
	}
	public String getFuzzySearch() {
		return fuzzySearch;
	}
	public void setFuzzySearch(String fuzzySearch) {
		this.fuzzySearch = fuzzySearch;
	}
	public String getSquadDate() {
		return squadDate;
	}
	public void setSquadDate(String squadDate) {
		this.squadDate = squadDate;
	}
	public String getSpEvent() {
		return spEvent;
	}
	public void setSpEvent(String spEvent) {
		this.spEvent = spEvent;
	}
	public String getTicketType() {
		return ticketType;
	}
	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}
	public String getOperatorNo() {
		return operatorNo;
	}
	public void setOperatorNo(String operatorNo) {
		this.operatorNo = operatorNo;
	}
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	public String getVehType() {
		return vehType;
	}
	public void setVehType(String vehType) {
		this.vehType = vehType;
	}
	public String getVehClass() {
		return vehClass;
	}
	public void setVehClass(String vehClass) {
		this.vehClass = vehClass;
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
	public String getSquadNo() {
		return squadNo;
	}
	public void setSquadNo(String squadNo) {
		this.squadNo = squadNo;
	}
	public String getOpTime() {
		return opTime;
	}
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	public String getQueryStatus() {
		return queryStatus;
	}
	public void setQueryStatus(String queryStatus) {
		this.queryStatus = queryStatus;
	}

	public String getTimeStatus() {
		return timeStatus;
	}
	public void setTimeStatus(String timeStatus) {
		this.timeStatus = timeStatus;
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
	public String getInSrc() {
		return inSrc;
	}
	public void setInSrc(String inSrc) {
		this.inSrc = inSrc;
	}
	public String getOutSrc() {
		return outSrc;
	}
	public void setOutSrc(String outSrc) {
		this.outSrc = outSrc;
	}
	@SuppressWarnings("unchecked")
	public List getSquadList() {
		return squadList;
	}
	@SuppressWarnings("unchecked")
	public void setSquadList(List squadList) {
		this.squadList = squadList;
	}
	@SuppressWarnings("unchecked")
	public List getTicketTypeList() {
		return ticketTypeList;
	}
	@SuppressWarnings("unchecked")
	public void setTicketTypeList(List ticketTypeList) {
		this.ticketTypeList = ticketTypeList;
	}
	@SuppressWarnings("unchecked")
	public List getVehTypeList() {
		return vehTypeList;
	}
	@SuppressWarnings("unchecked")
	public void setVehTypeList(List vehTypeList) {
		this.vehTypeList = vehTypeList;
	}
	@SuppressWarnings("unchecked")
	public List getVehClassList() {
		return vehClassList;
	}
	@SuppressWarnings("unchecked")
	public void setVehClassList(List vehClassList) {
		this.vehClassList = vehClassList;
	}
	@SuppressWarnings("unchecked")
	public List getSpEventList() {
		return spEventList;
	}
	@SuppressWarnings("unchecked")
	public void setSpEventList(List spEventList) {
		this.spEventList = spEventList;
	}
	public String getSquadTime() {
		return squadTime;
	}

	public void setSquadTime(String squadTime) {
		this.squadTime = squadTime;
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
	public List getAreaList() {
		return areaList;
	}
	@SuppressWarnings("unchecked")
	public void setAreaList(List areaList) {
		this.areaList = areaList;
	}
	@SuppressWarnings("unchecked")
	public List getCardTypeList() {
		return cardTypeList;
	}
	@SuppressWarnings("unchecked")
	public void setCardTypeList(List cardTypeList) {
		this.cardTypeList = cardTypeList;
	}
	@SuppressWarnings("unchecked")
	public List getUserCardTypeList() {
		return userCardTypeList;
	}
	@SuppressWarnings("unchecked")
	public void setUserCardTypeList(List userCardTypeList) {
		this.userCardTypeList = userCardTypeList;
	}
	public String getUserCardType() {
		return userCardType;
	}
	public void setUserCardType(String userCardType) {
		this.userCardType = userCardType;
	}
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public WaterQuery getWaterQuery() {
		return waterQuery;
	}
	public void setWaterQuery(WaterQuery waterQuery) {
		this.waterQuery = waterQuery;
	}
	public String getSquadTime_start() {
		return squadTime_start;
	}
	public void setSquadTime_start(String squadTime_start) {
		this.squadTime_start = squadTime_start;
	}
	public String getSquadTime_end() {
		return squadTime_end;
	}
	public void setSquadTime_end(String squadTime_end) {
		this.squadTime_end = squadTime_end;
	}
	public String getCashMoneyMin() {
		return cashMoneyMin;
	}
	public void setCashMoneyMin(String cashMoneyMin) {
		this.cashMoneyMin = cashMoneyMin;
	}
	public String getCashMoneyMax() {
		return cashMoneyMax;
	}
	public void setCashMoneyMax(String cashMoneyMax) {
		this.cashMoneyMax = cashMoneyMax;
	}
	public String getEtcMoneyMin() {
		return etcMoneyMin;
	}
	public void setEtcMoneyMin(String etcMoneyMin) {
		this.etcMoneyMin = etcMoneyMin;
	}
	public String getEtcMoneyMax() {
		return etcMoneyMax;
	}
	public void setEtcMoneyMax(String etcMoneyMax) {
		this.etcMoneyMax = etcMoneyMax;
	}
	
}
