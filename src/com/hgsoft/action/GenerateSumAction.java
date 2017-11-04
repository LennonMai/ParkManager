package com.hgsoft.action;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.GenerateSumService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date December 07, 2010
 * @Description 生成合计数
 */

@Controller
@Scope("prototype")
public class GenerateSumAction extends BaseAction {
	@Resource
	private GenerateSumService generateSumService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private GatewayInformationService gatewayInformationService;
	@Resource
	private SystemLogService systemLogService;	
	private Sysparamconf setAreaNo;
	private Sysparamconf setParkNo;	
	@SuppressWarnings("unchecked")
	public List listGateSum;
	@SuppressWarnings("unchecked")
	public List listGate;	
	public String listSumAllLane;	
	private String areaNo;	//区域
	private String parkNo;	//小区
	private String gateNo;	//大门
	private String gateNoTemp;	//大门
	private Date squadDate;	//工班日期
	private String  squadDateTemp;	//工班日期
	

	private String squadDatejs;
	private String stationYNSum;	//是否合计
	private String stationYNSumTemp;	//是否合计
	private String gateName;	//大门名称
	private String laneNo;	//车道号
	private String squadNo;	//工班号
	private String laneType;	//车道类型
	
	private String tvCount;	//车道记录数
	private String tvMoney;	//车道通行费
	
	private String buttonStatus;	//判断车道中心数据是否一致
	private String listButtonStatus;	//判断车道中心数据是否一致
	
	
	
	//读取区域、小区参数
	public void getSysparamconf() {
		//读取区域、小区参数
		Sysparamconf areaNo = sysparamconfService.getSysparamconfByQname("AreaNo");
		Sysparamconf parkNo = sysparamconfService.getSysparamconfByQname("ParkNo");
		setAreaNo = new Sysparamconf();
		setParkNo = new Sysparamconf();
		if(areaNo == null) {
			setAreaNo.setPname("AreaNo");
			//浙大数值为3301
			setAreaNo.setPvalue("4430");
			setAreaNo.setPtype(0);
			setAreaNo.setRemark("区域编号");
			sysparamconfService.save(setAreaNo);
		}
		if(parkNo == null) {
			setParkNo.setPname("ParkNo");
			//浙大数值为1
			setParkNo.setPvalue("101");
			setParkNo.setPtype(0);
			setParkNo.setRemark("小区编号");
			sysparamconfService.save(setParkNo);
		}
	}
   //根据子字符串获取该子字符串后面的字符串
	public String getSubString(String s, String s1) {
		int a = s.indexOf(s1);		
		return s.substring(a + 1);
	}

	//跳转生成合计数列表页面
	public String list() {
		listGate = gatewayInformationService.getAllGatewayInformation();	//大门
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String nowdate = format.format(new Date());
		try {
			squadDate = format.parse(nowdate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		stationYNSum="1";
		listButtonStatus="1";
		return "list";
	}
	
	//查询大门总合计数列表
	public String queryGateSum() {
		// 读取区域、小区参数	
		getSysparamconf();
		int areaNo = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
		int parkNo = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
		listGate = gatewayInformationService.getAllGatewayInformation(); // 大门				
		// 大门总合计数列表
		if (squadDate==null && "".equals(gateNo) && "".equals(stationYNSum)) {
			list = generateSumService.queryGateSum(pager, areaNo, parkNo, gateNo, squadDate, stationYNSum);
			return "list";
		} else {			
			list = generateSumService.queryGateSum(pager, areaNo, parkNo, gateNo, squadDate, stationYNSum);			
			gateNoTemp=gateNo;
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if(null!=squadDate){
				squadDateTemp=format.format(squadDate);
			}			
			stationYNSumTemp=stationYNSum;
			// 取大门对象
			// gatewayInformation =
			// gatewayInformationService.LoadGatewayInfo(Short.parseShort(gateNo));
			// Iterator it = list.iterator();
			// while(it.hasNext()) {
			// Map obj = (Map)it.next();
			// String ar = (String) obj.get("AreaName");
			// System.out.println(ar);
			// }
			if(list==null){
				listButtonStatus="1";
			}else{
				listButtonStatus="0";
			}
			return "list";
		}
	}
	
	//查询车道合计数列表
	public String queryLaneSum() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		squadDatejs = format.format(squadDate);
		list = generateSumService.queryLaneSum(Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNo, squadDate);
		return EDIT;
	}
	
	//合计选中车道
	@SuppressWarnings("unchecked")
	public String sumLane() {
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String squadDateTempone = (format.format(squadDate)).toString();
		String month = squadDateTempone.substring(5, 7);
		
		//查询车道合计数是否存在
		int size = generateSumService.selectLaneSum(areaNo, parkNo, gateNo, laneNo, squadDateTempone, squadNo);
		if(size > 0) {
			generateSumService.deleteLaneSum(areaNo, parkNo, gateNo, laneNo, squadDateTempone, squadNo);
			/*result = Result.FAIL4;
			gateNo=gateNoTemp;
			try {
				squadDate=format.parse(squadDateTemp);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			stationYNSum=stationYNSumTemp;
			return queryGateSum();*/
		}
		
		list = generateSumService.countCenterLaneData(month, Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNo, laneNo, squadDate, squadNo);
		if (list.size() != 0) {
			Map temp = (Map) list.get(0);
//			Integer listAllM = (Integer) temp.get("ListCashM") + (Integer) temp.get("ListETCM");
			BigDecimal listAllM = (BigDecimal) (new BigDecimal(temp.get("ListCashM").toString())).add(new BigDecimal(temp.get("ListETCM").toString()));
			if ((Integer) temp.get("ListCount") == Integer.parseInt(tvCount) && listAllM.toString().equals(tvMoney)) {
				
				temp.put("status", "0"); // 车道与中心数据一致
				buttonStatus = "0"; // 数据一致，按钮可用
			} else {
				temp.put("status", "1"); // 车道与中心数据不一致
				buttonStatus = "1"; // 数据不一致，按钮不可用
			}
		} else {
			buttonStatus = "1";
		}
		return "sumLane";
	}
	
	//合计全部车道
	@SuppressWarnings("unchecked")
	public String sumAllLane() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			squadDate = format.parse(squadDatejs);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//int size = generateSumService.selectLaneSum(areaNo, parkNo, gateNo, squadDatejs);
		//if(size > 0) {
			generateSumService.deleteAllLaneSum(areaNo, parkNo, gateNo, squadDatejs);
			/*result = Result.FAIL4;
			gateNo=gateNoTemp;
			try {
				squadDate=format.parse(squadDateTemp);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			stationYNSum=stationYNSumTemp;
			return queryGateSum();*/
		//}
		list = generateSumService.queryLaneNotSum(Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNo, squadDate);
		buttonStatus = "0";	//数据一致，按钮可用
		if(list.size()!=0) {
			//List t = (List) list.get(0);
			for(int i=0;i<list.size();i++) {
				List temp = (List) list.get(i);
				String str = (String) temp.get(10);
				if(str.equals("1")) {
					buttonStatus = "1";	//数据不一致，按钮不可用
					break;
				}
			}
		} else{
			buttonStatus = "1";
		}
		return "sumAllLane";
	}
	
	//生成全部车道合计数
	public String generateLaneSum() {
		String[] temp = listSumAllLane.split("],");
		for(int i=0; i<temp.length; i++) {
			String[] temp1 = temp[i].split(",");
			String laneNo = temp1[1].trim();
			String squadDate = temp1[2].trim();
			String squadNo = temp1[3].trim();
			String laneTypeNo = "2";
			String recordCnt = temp1[5].trim();
			String moneySummation = temp1[6].trim();
			generateSumService.generateLaneSum(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo, laneTypeNo, recordCnt, moneySummation);
			generateSumService.insertSunInfo(areaNo, parkNo, gateNo, squadDate, squadNo);
		}
		
		//插入系统日志
		Admin admin = this.getCurrentOperator();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			squadDate = format.parse(squadDatejs);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户生成工班日期为"+format.format(squadDate)+"所有的车道合计数",
				"报表管理--业务处理--生成合计数", "tb_LaneSummation");
		
		result = Result.SUCCESS2;
		gateNo=gateNoTemp;
		try {
			if(!"".equals(squadDateTemp)){
				squadDate=format.parse(squadDateTemp);	
			}			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		stationYNSum=stationYNSumTemp;
		return queryGateSum();
 	}
	
	//生成选中车道合计数
	public String generateOneLaneSum() {
		String laneTypeNo = "2";	//出口编码
		generateSumService.deleteLaneSum(areaNo, parkNo, gateNo, laneNo, squadDatejs, squadNo);
		generateSumService.generateLaneSum(areaNo, parkNo, gateNo, laneNo, squadDatejs, squadNo, laneTypeNo, tvCount, tvMoney);		
		generateSumService.insertSunInfo(areaNo, parkNo, gateNo, squadDatejs, squadNo);
		
		//插入系统日志
		Admin admin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"用户生成工班日期为"+squadDatejs+"，车道号为"+laneNo+"的车道合计数",
				"报表管理--业务处理--生成合计数", "tb_LaneSummation");
		
		result = Result.SUCCESS1;
		return queryLaneSum();
	}
	
	//生成查询出来所有大门合计数
	@SuppressWarnings("unchecked")
	public String generateAllGateSum() throws ParseException {
		Date date = null;
		List listTemp = null;
		List listAllGate =null;
		String listStringTemp = null;
		String areaNoTemp = null;
		String parkNoTemp = null;
		String gateNoTempTwo = null;
		String dateTemp = null;
		String stationYNSumTempTwo=null;
		getSysparamconf();
		String areaNo = sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue();
		String parkNo = sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue();
		// listGate = gatewayInformationService.getAllGatewayInformation(); //
		// 大门
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sdfTemp = new SimpleDateFormat("yyyy-MM-dd");
		try {
			if (!"".equals(squadDateTemp)) {
				squadDate = sdf.parse(squadDateTemp);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		listAllGate = generateSumService.queryGateSum(pager, Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNoTemp, squadDate, stationYNSumTemp);
		if (listAllGate!=null) {
			String listString = listAllGate.toString();
			String[] tempOne = listString.split("},");
			for (int j = 0; j < tempOne.length; j++) {
				String[] temp1 = tempOne[j].split(",");
				areaNoTemp = getSubString(temp1[3], "=");// 区域
				parkNoTemp = getSubString(temp1[4], "=");// 小区
				gateNoTempTwo = getSubString(temp1[5], "=");// 大门
				dateTemp = getSubString(temp1[6], "=");// 工班时间
				date = sdfTemp.parse(getSubString(temp1[6], "="));
				stationYNSumTempTwo=getSubString(temp1[9], "=").substring(0, 1);

				if (stationYNSumTempTwo.equals("否")) {
					int squadCount = generateSumService.countSquad(); // 工班数
					int laneCount = generateSumService.countLane(gateNoTempTwo); // 车道数
					int laneSumCount = generateSumService.countLaneSummation(areaNoTemp, parkNoTemp, gateNoTempTwo, dateTemp); // 大门车道已合计数
					if (squadCount * laneCount != laneSumCount) {
						generateSumService.deleteAllLaneSum(areaNoTemp, parkNoTemp, gateNoTempTwo, dateTemp);
						int squadLogCount = generateSumService.countSquadLog(areaNoTemp, parkNoTemp, gateNoTempTwo, dateTemp); // 车道工班记录数
						if (squadLogCount == squadCount * laneCount) {
							listTemp = generateSumService.queryLaneNotSum(Integer.parseInt(areaNoTemp), Integer.parseInt(parkNoTemp), gateNoTempTwo, date);
							//list = generateSumService.queryLaneNotSum(Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNo, squadDate);
							listStringTemp = listTemp.toString();
							buttonStatus = "0"; // 数据一致，按钮可用
							if (listTemp.size() != 0) {
								// List t = (List) list.get(0);
								for (int i = 0; i < listTemp.size(); i++) {
									List temp = (List) listTemp.get(i);
									String str = (String) temp.get(10);
									if (str.equals("1")) {
										buttonStatus = "1"; // 数据不一致，按钮不可用																	
										list = listTemp;//generateSumService.queryLaneNotSum(Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNoTempTwo, date);										
										return "sumAllLane";
									}
								}
								String[] temp = listStringTemp.split("],");
								for (int i = 0; i < temp.length; i++) {
									String[] temp3 = temp[i].split(",");
									String laneNo = temp3[1].trim();
									String squadDate = temp3[2].trim();
									String squadNo = temp3[3].trim();
									String laneTypeNo = "2";
									String recordCnt = temp3[5].trim();
									String moneySummation = temp3[6].trim();								
									generateSumService.generateLaneSum(areaNo, parkNo, gateNoTempTwo, laneNo, squadDate, squadNo, laneTypeNo, recordCnt, moneySummation);
									generateSumService.insertSunInfo(areaNo, parkNo, gateNoTempTwo, squadDate, squadNo);
																	
								}
								//生成大门合计数	
								generateSumService.generateGateSum(areaNo, parkNo, gateNoTempTwo, dateTemp);
							} else {
								buttonStatus = "1";
								list = listTemp;
								return "sumAllLane";
							}

						}else if (squadLogCount == laneSumCount) {
							result = Result.FAIL2; // 该工班日期的部分工班数据未上传，是否强制生成总合计数？					     	
							gateNo = gateNoTempTwo;							
							squadDate = date;							
							stationYNSum = stationYNSumTemp;
							return queryGateSum();
				
						} else {
							result = Result.FAIL3; // 该工班日期的部分工班数据未上传，且已上传的数据还没全部做完！
					/*		gateNo = gateNoTemp;
							try {
								if (!"".equals(squadDateTemp)) {
									squadDate = sdf.parse(squadDateTemp);
								}
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							stationYNSum = stationYNSumTemp;
							return queryGateSum();*/
							gateNo = gateNoTempTwo;							
							squadDate = date;							
							stationYNSum = stationYNSumTemp;							
							return queryGateSum();
						}
					} else {
						// 生成大门合计数
						generateSumService.generateGateSum(areaNo, parkNo, gateNoTempTwo, dateTemp);

					}
				}

			}
		}
		result = Result.SUCCESS; // 该工班日期的部分工班数据未上传，且已上传的数据还没全部做完！
		gateNo = gateNoTemp;
		try {
			if (!"".equals(squadDateTemp)) {
				squadDate = sdf.parse(squadDateTemp);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		stationYNSum = "";
		return queryGateSum();
	}
		
	//生成选中大门合计数
	@SuppressWarnings("unchecked")
	public String generateGateSum() {
		
		//查询该大门合计数是否存在
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		int size = generateSumService.selectGateSum(areaNo, parkNo, gateNo, squadDatejs);
		if(size > 0) {
			generateSumService.deleteGateSum(areaNo, parkNo, gateNo, squadDatejs);
			
		}
		//判断数据是否没有上传
		int squadCount = generateSumService.countSquad();	//工班数
		int laneCount = generateSumService.countLane(gateNo);	//车道数
		int laneSumCount = generateSumService.countLaneSummation(areaNo, parkNo, gateNo, squadDatejs);	//大门车道已合计数
		if(squadCount * laneCount != laneSumCount) {			
			int squadLogCount = generateSumService.countSquadLog(areaNo, parkNo, gateNo, squadDatejs);	//车道工班记录数	
			if(squadLogCount == squadCount * laneCount) {
			try { 
				   if(squadDatejs.length()<12){
					   squadDatejs=squadDatejs+" 00:00:00";
				   }			   
					squadDate = format.parse(squadDatejs);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				//int size = generateSumService.selectLaneSum(areaNo, parkNo, gateNo, squadDatejs);
				//if(size > 0) {
					generateSumService.deleteAllLaneSum(areaNo, parkNo, gateNo,squadDatejs);
					/*result = Result.FAIL4;
					gateNo=gateNoTemp;
					try {
						squadDate=format.parse(squadDateTemp);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					stationYNSum=stationYNSumTemp;
					return queryGateSum();*/
				//}
				list = generateSumService.queryLaneNotSum(Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNo, squadDate);
				String listString=list.toString();
				buttonStatus = "0";	//数据一致，按钮可用
				if(list.size()!=0) {
					//List t = (List) list.get(0);
					for(int i=0;i<list.size();i++) {
						List temp = (List) list.get(i);
						String str = (String) temp.get(10);
						if(str.equals("1")) {
							buttonStatus = "1";	//数据不一致，按钮不可用					
							return "sumAllLane";
						}
					}
						
							String[] tempOne = listString.split("],");
							for(int j=0; j<tempOne.length; j++) {
								String[] temp1 = tempOne[j].split(",");
								String laneNo = temp1[1].trim();
								String squadDate = temp1[2].trim();
								String squadNo = temp1[3].trim();
								String laneTypeNo = "2";
								String recordCnt = temp1[5].trim();
								String moneySummation = temp1[6].trim();
								generateSumService.generateLaneSum(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo, laneTypeNo, recordCnt, moneySummation);
								generateSumService.insertSunInfo(areaNo, parkNo, gateNo, squadDate, squadNo);
						
					}
				} else{
					buttonStatus = "1";
					return "sumAllLane";
				}
				
				/*function sumAllLane() {
					window.location.href="generateSum_sumAllLane.do?areaNo="+${areaNo}+"&parkNo="+${parkNo}
						+"&gateNo="+${gateNo}+"&squadDatejs="+'${squadDatejs}'+"&gateNoTemp="+'${gateNoTemp}'+"&squadDateTemp="+'${squadDateTemp}'+"&stationYNSumTemp="+'${stationYNSumTemp}';
				}*/
				 
				/*result = Result.FAIL1;	//该工班日期的工班合计数还没全部做完，请先做各工班的合计数！
				*/
				/*gateNo=gateNoTemp;
				try {
					if(!"".equals(squadDateTemp)){
						squadDate=format.parse(squadDateTemp);	
					}	
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				stationYNSum=stationYNSumTemp;
				return queryGateSum();*/
				return generateGateSum();
			}
			if(squadLogCount == laneSumCount) {
				result = Result.FAIL2;	//该工班日期的部分工班数据未上传，是否强制生成总合计数？
				gateNo=gateNoTemp;
				try {
					if(!"".equals(squadDateTemp)){
						squadDate=format.parse(squadDateTemp);	
					}	
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				stationYNSum=stationYNSumTemp;
				return queryGateSum();
			}
			else {
				result = Result.FAIL3;	//该工班日期的部分工班数据未上传，且已上传的数据还没全部做完！
				gateNo=gateNoTemp;
				try {
					if(!"".equals(squadDateTemp)){
						squadDate=format.parse(squadDateTemp);	
					}	
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				stationYNSum=stationYNSumTemp;
				return queryGateSum();
			}
		} else {
			//生成大门合计数
			generateSumService.generateGateSum(areaNo, parkNo, gateNo, squadDatejs);
			
			//插入系统日志
			Admin admin = this.getCurrentOperator();
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成工班日期为"+squadDatejs+"的大门合计数",
					"报表管理--业务处理--生成合计数", "tb_GateSummation");
			
			result = Result.SUCCESS;
		}
		
		gateNo=gateNoTemp;
		try {
			if(!"".equals(squadDateTemp)){
				squadDate=format.parse(squadDateTemp);	
			}	
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		stationYNSum=stationYNSumTemp;
		
		return queryGateSum();
	}
	
	public String getGateNoTemp() {
		return gateNoTemp;
	}

	public void setGateNoTemp(String gateNoTemp) {
		this.gateNoTemp = gateNoTemp;
	}

	

	public String getStationYNSumTemp() {
		return stationYNSumTemp;
	}

	public void setStationYNSumTemp(String stationYNSumTemp) {
		this.stationYNSumTemp = stationYNSumTemp;
	}

	//跳转打印车道合计数信息
	public String printLaneSum() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			squadDate = format.parse(squadDatejs);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		list = generateSumService.queryLaneSum(Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNo, squadDate);
		return "printEdit";
	}
	
	//跳转打印大门合计数信息
	public String printGateSum() {
		//读取区域、小区参数
		getSysparamconf();
		int areaNo = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
		int parkNo = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(!"".equals(squadDateTemp)){
			try {
				squadDate=format.parse(squadDateTemp);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		list = generateSumService.queryGateSum(pager, areaNo, parkNo, gateNo, squadDate, stationYNSum);
		return "printList";
	}

	
	// Getters/Setters方法
	@SuppressWarnings("unchecked")
	public List getListGateSum() {
		return listGateSum;
	}
	@SuppressWarnings("unchecked")
	public void setListGateSum(List listGateSum) {
		this.listGateSum = listGateSum;
	}

	public String getGateNo() {
		return gateNo;
	}

	public void setGateNo(String gateNo) {
		this.gateNo = gateNo;
	}


	public String getStationYNSum() {
		return stationYNSum;
	}

	public void setStationYNSum(String stationYNSum) {
		this.stationYNSum = stationYNSum;
	}

	public Date getSquadDate() {
		return squadDate;
	}

	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}

	
	@SuppressWarnings("unchecked")
	public List getListGate() {
		return listGate;
	}

	public String getGateName() {
		return gateName;
	}

	public void setGateName(String gateName) {
		this.gateName = gateName;
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


	public String getTvCount() {
		return tvCount;
	}

	public void setTvCount(String tvCount) {
		this.tvCount = tvCount;
	}

	public String getTvMoney() {
		return tvMoney;
	}

	public void setTvMoney(String tvMoney) {
		this.tvMoney = tvMoney;
	}

	public String getLaneType() {
		return laneType;
	}

	public void setLaneType(String laneType) {
		this.laneType = laneType;
	}

	public String getAreaNo() {
		return areaNo;
	}

	public void setAreaNo(String areaNo) {
		this.areaNo = areaNo;
	}

	public String getParkNo() {
		return parkNo;
	}

	public void setParkNo(String parkNo) {
		this.parkNo = parkNo;
	}

	public String getSquadDatejs() {
		return squadDatejs;
	}

	public void setSquadDatejs(String squadDatejs) {
		this.squadDatejs = squadDatejs;
	}

	public String getButtonStatus() {
		return buttonStatus;
	}

	public void setButtonStatus(String buttonStatus) {
		this.buttonStatus = buttonStatus;
	}

	public String getListSumAllLane() {
		return listSumAllLane;
	}

	public void setListSumAllLane(String listSumAllLane) {
		this.listSumAllLane = listSumAllLane;
	}

	public String getSquadDateTemp() {
		return squadDateTemp;
	}

	public void setSquadDateTemp(String squadDateTemp) {
		this.squadDateTemp = squadDateTemp;
	}
	public String getListButtonStatus() {
		return listButtonStatus;
	}
	public void setListButtonStatus(String listButtonStatus) {
		this.listButtonStatus = listButtonStatus;
	}
	
}
