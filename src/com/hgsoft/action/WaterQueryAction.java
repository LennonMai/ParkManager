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
	private String statusOutIn;//出口或入口 1为入口，2为出口
	private String squadDate;//工班日期
	private String squadTime;
	private String squadTime_start;
	private String squadTime_end;
	private String queryStatus;//查询状态 1为快速 2为详细
	//详细查询
	private String spEvent;//特殊事件
	private String ticketType;//通行卷类型
	private String operatorNo;//操作员号
	private String operatorName;//操作员姓名
	private String vehType;//车型
	private String vehClass;//车种
	private String parkNo;
	private String gateNo;
	private String laneNo;
	private String squadNo;//工班号
	private String opTime;//操作时间
	private String timeStatus;
	private String startTime;
	private String endTime;
	private String cashMoneyMin;
	private String cashMoneyMax;
	private String etcMoneyMin;
	private String etcMoneyMax;
	private String userCardType;
	private String cardType;
	private String fuzzySearch;//是否模糊查询
	private WaterQuery waterQuery; //打印流水查询 实例
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
	private String inSrc;//入口图片路径
	private String outSrc;//出口图片路径
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
	 * 处理左位移, Math.pow(2,23)2的23次方,把值转换车2的（value-1）次方,然后转化成二进制,数据库中的值也转化成二进制，然后比较包含是否存在
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
				s = null;//value的值大于31时就不给查询出值，车道中只用到29.正数转为二进制字符串最多31位
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
				while(c<31){//2进制长度不能大于31
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
				while(c<31){//2进制长度不能大于31
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
	 * 获取流水查询数据
	 */
	public String query() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		squadList = squadInformationService.getAllSquadInformation();// 查询所有工班号
		ticketTypeList = cardDynamicService.getAllTicketType();// 通行卷类型
		vehTypeList = cardDynamicService.getAllVehType();// 车型
		vehClassList = cardDynamicService.getAllVehClass();// 车种
		spEventList = cardDynamicService.getAllSpEvent();// 特殊事件
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
		// 处理左移位，为了以流水中的值相对应
		if (null != spEvent && !spEvent.equals("")) {
			temp = removeLeftAndToBin(spEvent);
		}
		//初始化详细查询中的工班日期，值为当前系统工班
		if (null == squadTime  && null == startTime  && null == endTime ) {
			squadTime = format.format(new Date());
		}
		// 判断当查询类型和表都是空的时候，不进行查询，否则就查询
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
	 * 导出流水
	 */
	public String exportWater() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		squadList = squadInformationService.getAllSquadInformation();// 查询所有工班号
		ticketTypeList = cardDynamicService.getAllTicketType();// 通行卷类型
		vehTypeList = cardDynamicService.getAllVehType();// 车型
		vehClassList = cardDynamicService.getAllVehClass();// 车种
		spEventList = cardDynamicService.getAllSpEvent();// 特殊事件
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
		mapCardType.put("0", "无卡");			
		String temp = "";
		// 处理左移位，为了以流水中的值相对应
		if (null != spEvent && !spEvent.equals("")) {
			temp = removeLeftAndToBin(spEvent);
		}
		//初始化详细查询中的工班日期，值为当前系统工班
		if (null == squadTime  && null == startTime  && null == endTime ) {
			squadTime = format.format(new Date());
		}
		// 判断当查询类型和表都是空的时候，不进行查询，否则就查询
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
						+ "用户将流水信息导出到Excel时抛出OutOfMemoryError异常", "流水查询-导出", "OutOfMemoryError");
		    	message = "由于导出的数据量过大，导致堆内存溢出，操作失败！\\n\\n请修改查询条件后重试！\\n\\n提示：您可以修改查询条件缩小查询范围，分批次进行导出。如：缩短时间范围，修改或增加其他查询条件限制等，以减少一次性导出的数据数量。";
		    	return query();				
			}
 		    list = this.setSpEventValues1(list,spEventList);
		}
		
		String titleStr = "";
		HttpServletResponse response = ServletActionContext.getResponse();
		try{
	  	  	response.setContentType("octets/stream");//简单可以设置为信息流
	  	  	SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMddHHmmss");
	  	  	String title = "waterQuery"+format1.format(new Date())+".xls";
		    response.addHeader("Content-Disposition", "attachment;filename="+title);	      
		    //客户端不缓存
		    response.addHeader("Pragma","no-cache");
		    response.addHeader("Cache-Control","no-cache");
		    ExcelUtil<Object[]> excelUtil = new ExcelUtil<Object[]>();
		    String[] headers1 =  {"流水号","小区", "大门","车道","车型","车种", "车牌号", "工班号","工班时间","收费员工号","收费员姓名","操作时间","特殊事件","卡表面号","用户卡类型"};
		    String[] headers2 = {"流水号","小区", "出口大门","出口车道","车型","车种", "车牌号", "工班号","工班时间","收费员工号","收费员姓名","操作时间","特殊事件","卡表面号","用户卡类型","入口大门","入口车道","通行卷类型","支付卡类型","应收现金（元）","ETC金额（元）"};
		    String[] headers = null;
		    if("1".equals(statusOutIn)){//入口
		    	headers = headers1;
		    	titleStr = "入口流水信息";
		    	
		    }else{//出口
		    	headers = headers2;
		    	titleStr = "出口流水信息";
		    }
		    
	        OutputStream out = response.getOutputStream();
	        excelUtil.exportWaterQueryExcel(titleStr, headers, list, out, 5000,map);
	        systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户导出"+titleStr+"文件成功", titleStr+"查询-导出", titleStr+format1.format(new Date())+".xls");
	        out.close();
		}catch (Exception e) {
			systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将"+titleStr+"导出到Excel时抛出的异常", titleStr+"息查询-导出", "Exception");
			e.printStackTrace();
	    }catch(OutOfMemoryError ome){
			systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将" + titleStr + "导出到Excel时抛出OutOfMemoryError异常", "流水查询-导出", "OutOfMemoryError");
	    	response.reset();
	    	message = "由于导出的数据量过大，导致堆内存溢出，操作失败！\\n\\n请修改查询条件后重试！\\n\\n提示：您可以修改查询条件缩小查询范围，分批次进行导出。如：缩短时间范围，修改或增加其他查询条件限制等，以减少一次性导出的数据数量。";
			return query();
		}
		return null;
	}	
	/**
	 * 查询详细信息
	 */
	@SuppressWarnings("unchecked")
	public String show() throws ParseException{
		squadList = squadInformationService.getAllSquadInformation();//查询所有工班号
		ticketTypeList = cardDynamicService.getAllTicketType();
		vehTypeList = cardDynamicService.getAllVehType();
		vehClassList = cardDynamicService.getAllVehClass();
		spEventList = cardDynamicService.getAllSpEvent();
		parkList = parkInformationService.getAllParkInformation();
		areaList = areaInformationService.getAllAreaInformation();
		if(statusOutIn.equals("1")){//查入口流水表
			list = cardDynamicService.getInListByListNo(squadTime,listNo);
			if(!list.isEmpty()){
				Admin admin = adminService.get(getCurrentOperator().getId());
				Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "为查询车道捉拍图片提供路径", "WaterQueryAction中complate()设置vehPlate参数时set（），get（）参数时的异常", admin);
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
		}else{//查出口流水表
			cardTypeList = cardTypeService.getAllCardType();
			list = cardDynamicService.getOutListByListNo(squadTime,listNo);
			list = this.setSpEventValues1(list,spEventList);
			return "outShow";
		}
	}
	/**
	 * 出入口对比
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
		Sysparamconf param_vehPlate = sysparamconfService.queryOrSave("vehPlate", "D:\\Jpeg\\", "为查询车道捉拍图片提供路径", "WaterQueryAction中complate()设置vehPlate参数时set（），get（）参数时的异常", admin);
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
		String time = map.get("InOpTime").toString().substring(0, 10);// 获取出口流水中入口发卡时间
		String inlistNo = map.get("InListNo").toString();// 获得入口流水号
		listInlist = cardDynamicService.getInListByInOpTimeAndListNo(time, inlistNo);// 查询入口流水
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
	 * 组合大门号和车道号的长度
	 */
	public String gateNoAndLaneNo(String temp){
		String str = "";
		String [] ss = {"0000","000","00","0",""};
		str = ss[temp.length()] + temp;
		return str;
	}
	/**
	 * 组合月份或日期
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
		
		spEventList = cardDynamicService.getAllSpEvent();// 特殊事件
		squadList = squadInformationService.getAllSquadInformation();// 查询所有工班号
		if(waterQuery==null||waterQuery.getDhtime()==null||waterQuery.getDltime()==null){
			waterQuery = new WaterQuery();
			waterQuery.setSpEventState(1);//默认查询出口事件
			waterQuery.setTimeState(1);//默认查询出口事件
			waterQuery.setLaneNoState(1);//默认查询出口位置
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//设置默认查询 时间
			Calendar cal = Calendar.getInstance();
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),0,0,0);
			waterQuery.setDltime(cal.getTime());
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),23,59,59);
			waterQuery.setDhtime(cal.getTime());
			return "printList";
		}
		list = cardDynamicService.printQuery(pager,waterQuery);
		//判断如果有用工号查询，则将工号对应的姓名回显
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
