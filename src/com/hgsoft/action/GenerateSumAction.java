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
 * @Description ���ɺϼ���
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
	private String areaNo;	//����
	private String parkNo;	//С��
	private String gateNo;	//����
	private String gateNoTemp;	//����
	private Date squadDate;	//��������
	private String  squadDateTemp;	//��������
	

	private String squadDatejs;
	private String stationYNSum;	//�Ƿ�ϼ�
	private String stationYNSumTemp;	//�Ƿ�ϼ�
	private String gateName;	//��������
	private String laneNo;	//������
	private String squadNo;	//�����
	private String laneType;	//��������
	
	private String tvCount;	//������¼��
	private String tvMoney;	//����ͨ�з�
	
	private String buttonStatus;	//�жϳ������������Ƿ�һ��
	private String listButtonStatus;	//�жϳ������������Ƿ�һ��
	
	
	
	//��ȡ����С������
	public void getSysparamconf() {
		//��ȡ����С������
		Sysparamconf areaNo = sysparamconfService.getSysparamconfByQname("AreaNo");
		Sysparamconf parkNo = sysparamconfService.getSysparamconfByQname("ParkNo");
		setAreaNo = new Sysparamconf();
		setParkNo = new Sysparamconf();
		if(areaNo == null) {
			setAreaNo.setPname("AreaNo");
			//�����ֵΪ3301
			setAreaNo.setPvalue("4430");
			setAreaNo.setPtype(0);
			setAreaNo.setRemark("������");
			sysparamconfService.save(setAreaNo);
		}
		if(parkNo == null) {
			setParkNo.setPname("ParkNo");
			//�����ֵΪ1
			setParkNo.setPvalue("101");
			setParkNo.setPtype(0);
			setParkNo.setRemark("С�����");
			sysparamconfService.save(setParkNo);
		}
	}
   //�������ַ�����ȡ�����ַ���������ַ���
	public String getSubString(String s, String s1) {
		int a = s.indexOf(s1);		
		return s.substring(a + 1);
	}

	//��ת���ɺϼ����б�ҳ��
	public String list() {
		listGate = gatewayInformationService.getAllGatewayInformation();	//����
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
	
	//��ѯ�����ܺϼ����б�
	public String queryGateSum() {
		// ��ȡ����С������	
		getSysparamconf();
		int areaNo = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
		int parkNo = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
		listGate = gatewayInformationService.getAllGatewayInformation(); // ����				
		// �����ܺϼ����б�
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
			// ȡ���Ŷ���
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
	
	//��ѯ�����ϼ����б�
	public String queryLaneSum() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		squadDatejs = format.format(squadDate);
		list = generateSumService.queryLaneSum(Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNo, squadDate);
		return EDIT;
	}
	
	//�ϼ�ѡ�г���
	@SuppressWarnings("unchecked")
	public String sumLane() {
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String squadDateTempone = (format.format(squadDate)).toString();
		String month = squadDateTempone.substring(5, 7);
		
		//��ѯ�����ϼ����Ƿ����
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
				
				temp.put("status", "0"); // ��������������һ��
				buttonStatus = "0"; // ����һ�£���ť����
			} else {
				temp.put("status", "1"); // �������������ݲ�һ��
				buttonStatus = "1"; // ���ݲ�һ�£���ť������
			}
		} else {
			buttonStatus = "1";
		}
		return "sumLane";
	}
	
	//�ϼ�ȫ������
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
		buttonStatus = "0";	//����һ�£���ť����
		if(list.size()!=0) {
			//List t = (List) list.get(0);
			for(int i=0;i<list.size();i++) {
				List temp = (List) list.get(i);
				String str = (String) temp.get(10);
				if(str.equals("1")) {
					buttonStatus = "1";	//���ݲ�һ�£���ť������
					break;
				}
			}
		} else{
			buttonStatus = "1";
		}
		return "sumAllLane";
	}
	
	//����ȫ�������ϼ���
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
		
		//����ϵͳ��־
		Admin admin = this.getCurrentOperator();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			squadDate = format.parse(squadDatejs);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û����ɹ�������Ϊ"+format.format(squadDate)+"���еĳ����ϼ���",
				"�������--ҵ����--���ɺϼ���", "tb_LaneSummation");
		
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
	
	//����ѡ�г����ϼ���
	public String generateOneLaneSum() {
		String laneTypeNo = "2";	//���ڱ���
		generateSumService.deleteLaneSum(areaNo, parkNo, gateNo, laneNo, squadDatejs, squadNo);
		generateSumService.generateLaneSum(areaNo, parkNo, gateNo, laneNo, squadDatejs, squadNo, laneTypeNo, tvCount, tvMoney);		
		generateSumService.insertSunInfo(areaNo, parkNo, gateNo, squadDatejs, squadNo);
		
		//����ϵͳ��־
		Admin admin = this.getCurrentOperator();
		systemLogService.save(new Date(), 1, admin,
				"["+admin.getId()+"]"+admin.getUsername()+"�û����ɹ�������Ϊ"+squadDatejs+"��������Ϊ"+laneNo+"�ĳ����ϼ���",
				"�������--ҵ����--���ɺϼ���", "tb_LaneSummation");
		
		result = Result.SUCCESS1;
		return queryLaneSum();
	}
	
	//���ɲ�ѯ�������д��źϼ���
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
		// ����
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
				areaNoTemp = getSubString(temp1[3], "=");// ����
				parkNoTemp = getSubString(temp1[4], "=");// С��
				gateNoTempTwo = getSubString(temp1[5], "=");// ����
				dateTemp = getSubString(temp1[6], "=");// ����ʱ��
				date = sdfTemp.parse(getSubString(temp1[6], "="));
				stationYNSumTempTwo=getSubString(temp1[9], "=").substring(0, 1);

				if (stationYNSumTempTwo.equals("��")) {
					int squadCount = generateSumService.countSquad(); // ������
					int laneCount = generateSumService.countLane(gateNoTempTwo); // ������
					int laneSumCount = generateSumService.countLaneSummation(areaNoTemp, parkNoTemp, gateNoTempTwo, dateTemp); // ���ų����Ѻϼ���
					if (squadCount * laneCount != laneSumCount) {
						generateSumService.deleteAllLaneSum(areaNoTemp, parkNoTemp, gateNoTempTwo, dateTemp);
						int squadLogCount = generateSumService.countSquadLog(areaNoTemp, parkNoTemp, gateNoTempTwo, dateTemp); // ���������¼��
						if (squadLogCount == squadCount * laneCount) {
							listTemp = generateSumService.queryLaneNotSum(Integer.parseInt(areaNoTemp), Integer.parseInt(parkNoTemp), gateNoTempTwo, date);
							//list = generateSumService.queryLaneNotSum(Integer.parseInt(areaNo), Integer.parseInt(parkNo), gateNo, squadDate);
							listStringTemp = listTemp.toString();
							buttonStatus = "0"; // ����һ�£���ť����
							if (listTemp.size() != 0) {
								// List t = (List) list.get(0);
								for (int i = 0; i < listTemp.size(); i++) {
									List temp = (List) listTemp.get(i);
									String str = (String) temp.get(10);
									if (str.equals("1")) {
										buttonStatus = "1"; // ���ݲ�һ�£���ť������																	
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
								//���ɴ��źϼ���	
								generateSumService.generateGateSum(areaNo, parkNo, gateNoTempTwo, dateTemp);
							} else {
								buttonStatus = "1";
								list = listTemp;
								return "sumAllLane";
							}

						}else if (squadLogCount == laneSumCount) {
							result = Result.FAIL2; // �ù������ڵĲ��ֹ�������δ�ϴ����Ƿ�ǿ�������ܺϼ�����					     	
							gateNo = gateNoTempTwo;							
							squadDate = date;							
							stationYNSum = stationYNSumTemp;
							return queryGateSum();
				
						} else {
							result = Result.FAIL3; // �ù������ڵĲ��ֹ�������δ�ϴ��������ϴ������ݻ�ûȫ�����꣡
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
						// ���ɴ��źϼ���
						generateSumService.generateGateSum(areaNo, parkNo, gateNoTempTwo, dateTemp);

					}
				}

			}
		}
		result = Result.SUCCESS; // �ù������ڵĲ��ֹ�������δ�ϴ��������ϴ������ݻ�ûȫ�����꣡
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
		
	//����ѡ�д��źϼ���
	@SuppressWarnings("unchecked")
	public String generateGateSum() {
		
		//��ѯ�ô��źϼ����Ƿ����
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		int size = generateSumService.selectGateSum(areaNo, parkNo, gateNo, squadDatejs);
		if(size > 0) {
			generateSumService.deleteGateSum(areaNo, parkNo, gateNo, squadDatejs);
			
		}
		//�ж������Ƿ�û���ϴ�
		int squadCount = generateSumService.countSquad();	//������
		int laneCount = generateSumService.countLane(gateNo);	//������
		int laneSumCount = generateSumService.countLaneSummation(areaNo, parkNo, gateNo, squadDatejs);	//���ų����Ѻϼ���
		if(squadCount * laneCount != laneSumCount) {			
			int squadLogCount = generateSumService.countSquadLog(areaNo, parkNo, gateNo, squadDatejs);	//���������¼��	
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
				buttonStatus = "0";	//����һ�£���ť����
				if(list.size()!=0) {
					//List t = (List) list.get(0);
					for(int i=0;i<list.size();i++) {
						List temp = (List) list.get(i);
						String str = (String) temp.get(10);
						if(str.equals("1")) {
							buttonStatus = "1";	//���ݲ�һ�£���ť������					
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
				 
				/*result = Result.FAIL1;	//�ù������ڵĹ���ϼ�����ûȫ�����꣬������������ĺϼ�����
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
				result = Result.FAIL2;	//�ù������ڵĲ��ֹ�������δ�ϴ����Ƿ�ǿ�������ܺϼ�����
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
				result = Result.FAIL3;	//�ù������ڵĲ��ֹ�������δ�ϴ��������ϴ������ݻ�ûȫ�����꣡
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
			//���ɴ��źϼ���
			generateSumService.generateGateSum(areaNo, parkNo, gateNo, squadDatejs);
			
			//����ϵͳ��־
			Admin admin = this.getCurrentOperator();
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û����ɹ�������Ϊ"+squadDatejs+"�Ĵ��źϼ���",
					"�������--ҵ����--���ɺϼ���", "tb_GateSummation");
			
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

	//��ת��ӡ�����ϼ�����Ϣ
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
	
	//��ת��ӡ���źϼ�����Ϣ
	public String printGateSum() {
		//��ȡ����С������
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

	
	// Getters/Setters����
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
