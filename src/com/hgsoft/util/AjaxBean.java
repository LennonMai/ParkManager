package com.hgsoft.util;

import java.io.Serializable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.hgsoft.entity.AreaInformation;
import com.hgsoft.entity.CardGroup;
import com.hgsoft.entity.CardGroupInfo;
import com.hgsoft.entity.CityInformation;
import com.hgsoft.entity.FeeRuleTypeDef;
import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.InOutSignDef;
import com.hgsoft.entity.OBUDate;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.entity.Staff;
import com.hgsoft.entity.StoreCardDate;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.SystemPara;
import com.hgsoft.entity.TimesSignDef;
import com.hgsoft.entity.TollyCardDate;

/** ��JSON-RPC���Զ�̵��õ�AjaxBean 
 *  @author qinzuohai 
 * */

public class AjaxBean implements Serializable {
	private JdbcUtil jdbcUtil;
	private static final long serialVersionUID = 1L;
	private HibernateTemplate hibernateTemplate;
	private AjaxBean ajaxBean;
    
	/**
	 * ��ȡBean����ʼ��ajaxBean����
	 */
	public void init() {
		WebApplicationContext wac = ContextLoader
				.getCurrentWebApplicationContext();
		this.ajaxBean = (AjaxBean) wac.getBean("ajaxBean");
		this.jdbcUtil = (JdbcUtil) wac.getBean("jdbcUtil");
	}



	/** ȡ�ó��б��롢������������ */
	public String[][] getCityNo_CityName() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("unchecked")
			List<CityInformation> list = this.ajaxBean.getHibernateTemplate().find(
					"from CityInformation cityInfo");
			int i = 1;
			if (list != null) {
				options = new String[list.size()+1][2];
				options[0][0] = "";
				options[0][1] = "- ��ѡ�� -";
				Iterator<CityInformation> it = list.iterator();
				while (it.hasNext()) {
					CityInformation cityInformation=it.next();
					options[i][0] = cityInformation.getCityNo().toString();
					options[i][1] = cityInformation.getCityName().toString();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	/** ȡ��������롢������������ */
	public String[][] getAreaNo_AreaName() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("unchecked")
			List<AreaInformation> list = this.ajaxBean.getHibernateTemplate().find(
					"from AreaInformation areaInfo");
			int i = 1;
			if (list != null) {
				options = new String[list.size()+1][2];
				options[0][0] = "";
				options[0][1] = "- ��ѡ�� -";
				Iterator<AreaInformation> it = list.iterator();
				while (it.hasNext()) {
					AreaInformation areaInformation=it.next();
					options[i][0] = areaInformation.getAreaNo().toString();
					options[i][1] = areaInformation.getAreaName().toString();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	/** ȡ��С�����롢С���������� */
	public String[][] getParkNo_ParkName() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("unchecked")
			List<ParkInformation> list = this.ajaxBean.getHibernateTemplate().find(
					" from ParkInformation parkInfo");
			int i = 1;
			if (list != null) {
				options = new String[list.size()+1][2];
				options[0][0] = "";
				options[0][1] = "- ��ѡ�� -";
				Iterator<ParkInformation> it = list.iterator();
				while (it.hasNext()) {
					ParkInformation parkInformation=it.next();
					options[i][0] = parkInformation.getParkNo().toString().trim();
					options[i][1] = parkInformation.getParkName().toString().trim();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	/**����С�������ȡС������ */
	public String getParkNameByParkNo(String parkNo) {
        this.init();
		String parkName = null;
		try {
			@SuppressWarnings("unchecked")
			List<ParkInformation> list = this.ajaxBean.getHibernateTemplate().find(
					" from ParkInformation parkInfo where parkInfo.parkNo='"+Short.valueOf(parkNo.trim())+"'");
			if (list != null) {
				parkName=list.get(0).getParkName().toString();
				}
			else {
				parkName="";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		//System.out.println("parkNo:"+parkNo+"--parkName:"+parkName);
		return parkName;
	}
	
	/** ȡ�ô��ű��롢������������ */
	public String[][] getGateNo_GateName() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("unchecked")
			List<GatewayInformation> list = this.ajaxBean.getHibernateTemplate().find(
					"from GatewayInformation gatewayInfo");
			int i = 1;
			if (list != null) {
				options = new String[list.size()+1][2];
				options[0][0] = "";
				options[0][1] = "- ��ѡ�� -";
				Iterator<GatewayInformation> it = list.iterator();
				while (it.hasNext()) {
					GatewayInformation gatewayInformation=it.next();
					options[i][0] = gatewayInformation.getGateNo().toString();
					options[i][1] = gatewayInformation.getGateName().toString();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	/** ���ݴ��ű����ȡ�������� */
	public String getGateNameByGateNo(String gateNo) throws IndexOutOfBoundsException{
        this.init();
		String gateName = null;
		try {
			@SuppressWarnings("unchecked")
			List<GatewayInformation> list = this.ajaxBean.getHibernateTemplate().find(
					"from GatewayInformation gatewayInfo where gatewayInfo.gateNo='"+Short.valueOf(gateNo.trim())+"'");
	
			if (!list.isEmpty()) {
				gateName=list.get(0).getGateName().toString();
			} else {
				gateName="";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		//System.out.println("gateNo:"+gateNo+"--gateName:"+gateName);
		return gateName;
	}
	
	
	/**
	 * ��ͨ����Ч�������� ����
	 */
	
	public String[][] getDate_StoreCardTollyCardOBU() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("unchecked")
			List<StoreCardDate> listStore = this.ajaxBean.getHibernateTemplate().find(
					" from StoreCardDate storeCardDate");
			@SuppressWarnings("unchecked")
			List<TollyCardDate> listTolly = this.ajaxBean.getHibernateTemplate().find(
					" from TollyCardDate tollyCardDate");
			@SuppressWarnings("unchecked")
			List<OBUDate> listOBU = this.ajaxBean.getHibernateTemplate().find(
					" from OBUDate oBUDate");
			if (listStore != null|| listTolly!= null|| listOBU!= null) {
				options = new String[3][2];
				options[0][0] = "StoreCard";
				options[0][1] = listStore.get(0).getFirTime().toString();
				options[1][0] = "TollyCard";
				options[1][1] = listTolly.get(0).getFirTime().toString();
				options[2][0] = "OBU";
				options[2][1] = listOBU.get(0).getFirTime().toString();
				
			} else {
				options = new String[3][2];
				options[0][0] = "StoreCard";
				options[0][1] = "";
				options[1][0] = "TollyCard";
				options[1][1] = "";
				options[2][0] = "OBU";
				options[2][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	/** ȡ��ϵͳ������-1��������� */
	public String[][] getGroupName() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("rawtypes")
			List list = this.ajaxBean.getHibernateTemplate().find(
					"select systemPara.item from SystemPara systemPara where systemPara.paraClass='-1'");
			int i = 1;
			String temp=null;
			
			if (list != null) {
				options = new String[list.size()+1][2];
				options[0][0] = "";
				options[0][1] = "- ��ѡ�� -";
				@SuppressWarnings("rawtypes")
				Iterator it = list.iterator();
				while (it.hasNext()) {
					temp=it.next().toString().trim();
					options[i][0] = temp;
					options[i][1] = temp;
					
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	/** ����������Ʋ�ѯ������-1���ļ�ֵ�ͼ���*/
	public String[][] getItemsByGroupName(String groupName ) {
	
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings({ "unchecked" })
			List<SystemPara> list = this.ajaxBean.getHibernateTemplate().find(
					"from SystemPara systemPara where systemPara.paraClass='1' and systemPara.sendControl='1' and systemPara.groupName='"+groupName.toString().trim()+"'");
			int i = 0;
			if (!list.isEmpty()) {
				options = new String[list.size()][2];
				Iterator<SystemPara> it = list.iterator();
				while (it.hasNext()) {
					SystemPara systemPara=it.next();
					options[i][0] = systemPara.getItem();
					options[i][1] = systemPara.getItemValue();
					//System.out.println("--"+groupName+":"+systemPara.getItemValue()+"-"+systemPara.getItem());
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	//chenfuyuan
/*	@SuppressWarnings("unchecked")
	public String[][] getCardGroupName() {
		this.init();
		String[][] options = null;
		try {
			List list = this.ajaxBean.getHibernateTemplate().find("from CardGroup cardGroup,CardGroupInfo cardGroupInfo where cardGroup.groupNo=cardGroupInfo.groupNo");			
			int i = 0;
			if (list != null) {
				options = new String[list.size()][2];
				Iterator iterator = list.iterator();
				while (iterator.hasNext()) {
					Object[] o = (Object[]) iterator.next();
					CardGroup cardGroup = (CardGroup) o[0];
					CardGroupInfo cardGroupInfo = (CardGroupInfo) o[1];
					options[i][0] = cardGroup.getCardNo().toString().trim();
					options[i][1] = cardGroupInfo.getGroupName().toString().trim();
					i++;				
				}
				
			} else {
				options = new String[1][2];
				options[0][0] = "0";
				options[0][1] = " ";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}*/
	@SuppressWarnings("unchecked")
	public String[][] getCardGroupName(String cardNo) {
		this.init();
		String[][] options = null;
		try {
			List list = this.ajaxBean.getHibernateTemplate().find("from CardGroup cardGroup,CardGroupInfo cardGroupInfo where cardGroup.groupNo=cardGroupInfo.groupNo and cardGroup.laneGroupNo=1 and cardGroup.cardNo='"+cardNo+"'");
			int i = 0;
			if (!list.isEmpty()) {
				options = new String[list.size()][2];
				Iterator iterator = list.iterator();
				while (iterator.hasNext()) {
					Object[] o = (Object[]) iterator.next();
					CardGroup cardGroup = (CardGroup) o[0];
					CardGroupInfo cardGroupInfo = (CardGroupInfo) o[1];
					options[i][0] = cardGroup.getCardNo().toString().trim();
					options[i][1] = cardGroupInfo.getGroupName().toString().trim();
					i++;				
				}
				
			} else {
				options = new String[1][2];
				options[0][0] = "0";
				options[0][1] = "δ���� ";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	@SuppressWarnings("unchecked")
	public String[][] getStaffNameAndStaffAddress(String cardNo) {
		this.init();
		String[][] options = null;
		try {
			List list = this.ajaxBean.getHibernateTemplate().find("from Staff staff where staff.cardNo='"+cardNo+"'");
			int i = 0;
			options = new String[1][2];
			if (!list.isEmpty()) {
				
				Staff staff = (Staff)list.get(0);
				options[i][0] = staff.getStaffName();
				options[i][1] = staff.getStaffAddress();				
			} else {
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	@SuppressWarnings("unchecked")
	public String[][] getUseLane(Short areaNo,Short parkNo,Short gateNo,Short laneNo){
		this.init();
		String[][] options = null;
		try {
			List list = this.ajaxBean.getHibernateTemplate().find("from LaneUse laneUse where laneUse.areaNo="+areaNo+" and laneUse.parkNo="+parkNo+" and laneUse.gateNo="+gateNo+" and laneUse.laneNo="+laneNo);
			int i = 0;
			options = new String[1][1];
			if (!list.isEmpty()) {				
				options[i][0] = "YES";
				
			} else {
				options[0][0] = "NO";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}

	@SuppressWarnings("unchecked")
	public String[][] getCountAndMoney(Short areaNo,Short parkNo,Short gateNo,String squadDate) {
		this.init();
		String[][] options = null;
		String squadDateTemp = squadDate.toString();
		String month = squadDateTemp.substring(5, 7);
		try {
			String sql = "SELECT isnull(SUM(VehCount), 0) AS Count, isnull(SUM(cashMoney + etcMoney), 0) AS Money" +
			" FROM tb_OutList"+month+" WHERE AreaNO = "+areaNo+" and ParkNo = "+parkNo+" and GateNo = "+gateNo+" and SquadDate = '"+squadDateTemp+"'";
		//System.out.println(sql);
		    List list = jdbcUtil.selectForList(sql);
			
			
			
		//	List list = this.ajaxBean.getHibernateTemplate().find("from CardGroup cardGroup,CardGroupInfo cardGroupInfo where cardGroup.groupNo=cardGroupInfo.groupNo and cardGroup.laneGroupNo=1 and cardGroup.cardNo='"+cardNo+"'");
			int i = 0;
			if (!list.isEmpty()) {
				options = new String[list.size()][3];
				Iterator iterator = list.iterator();
				while (iterator.hasNext()) {					
					options[i][0] = areaNo.toString().trim()+parkNo.toString().trim()+gateNo.toString().trim()+squadDate.toString().trim();
					Map map=(Map)iterator.next();
					options[i][1] = map.get("Count").toString();
					options[i][2] = map.get("Money").toString();
					i++;				
				}
				
			} else {
				options = new String[1][3];
				options[0][0] = "0";
				options[0][1] = "û���� ";
				options[0][2] = "û���� ";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	
	//��ȡ�շ����ͺͳ��������
	public String[][] getFeeRuleType_Name() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("unchecked")
			List<FeeRuleTypeDef> list = this.ajaxBean.getHibernateTemplate().find(
					"from FeeRuleTypeDef  feeRuleTypeDef");
			int i = 1;
			if (list != null) {
				options = new String[list.size()+1][2];
				options[0][0] = "";
				options[0][1] = "- ��ѡ�� -";
				Iterator<FeeRuleTypeDef> it = list.iterator();
				while (it.hasNext()) {
					FeeRuleTypeDef feeRuleTypeDef=it.next();
					
					options[i][0] = feeRuleTypeDef.getFeeRuleType().toString();
					options[i][1] = feeRuleTypeDef.getName().toString();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	//��ȡʱ���־
	public String[][] getTimesSign() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("unchecked")
			List<TimesSignDef> list = this.ajaxBean.getHibernateTemplate().find(
					"from TimesSignDef  timesSignDef");
			int i = 1;
			if (list != null) {
				options = new String[list.size()+1][2];
				options[0][0] = "";
				options[0][1] = "- ��ѡ�� -";
				Iterator<TimesSignDef> it = list.iterator();
				while (it.hasNext()) {
					TimesSignDef timesSignDef=it.next();
					
					options[i][0] = timesSignDef.getTimesSign().toString();
					options[i][1] = timesSignDef.getTimesSign().toString();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	//��ȡ����ڱ�־
	public String[][] getInOutSign() {
        this.init();
		String[][] options = null;
		try {
			@SuppressWarnings("unchecked")
			List<InOutSignDef> list = this.ajaxBean.getHibernateTemplate().find(
					"from InOutSignDef  inOutSignDef");
			int i = 1;
			if (list != null) {
				options = new String[list.size()+1][2];
				options[0][0] = "";
				options[0][1] = "- ��ѡ�� -";
				Iterator<InOutSignDef> it = list.iterator();
				while (it.hasNext()) {
					InOutSignDef inOutSignDef=it.next();
					
					options[i][0] = inOutSignDef.getInOutSign().toString();
					options[i][1] = inOutSignDef.getInOutSign().toString();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "";
				options[0][1] = "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	//�����շ�����ȡ�ó��������
	public String get_Name(Integer feeRuleType) {
        this.init();
		try {
			@SuppressWarnings("unchecked")
			List<FeeRuleTypeDef> list = this.ajaxBean.getHibernateTemplate().find(
					"from FeeRuleTypeDef  feeRuleTypeDef where feeRuleTypeDef.feeRuleType='"+feeRuleType+"'");
			
			if (list != null) {
				return list.get(0).getName();
			} else {
				return "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "";
	}
	
	//���ݼ�ֵ��ȡ����
	public String getItemByitemValue(String itemValue) {
        this.init();
        String _null="��������ͼ��Ŀ¼";
		try {
			@SuppressWarnings("unchecked")
			List<SystemPara> list = this.ajaxBean.getHibernateTemplate().find(
					"from SystemPara  systemPara where systemPara.itemValue='"+itemValue.trim()+"'");
			//System.out.println(itemValue+"----------"+list.size());
			if(list.size()!=0){
				return list.get(0).getItem();
			}
			else{
				return _null;			
			} 
		} catch (IndexOutOfBoundsException ex) {
			ex.printStackTrace();
		}
		return "";
	}
	
	//��ѯ���������е�ϵͳ��־��ʱ�������
	public String[][] findSysLogBackupTask_TIME() {
        this.init();
		String[][] options = null;
		String hql=null;
		String pname="TIME_sysLogBackupTask";
		try {
			hql=" from Sysparamconf sysparamconf where sysparamconf.pname='"+pname+"'";
			@SuppressWarnings("unchecked")
			List<Sysparamconf> list = this.ajaxBean.getHibernateTemplate().find(hql);
			int i = 0;
			if (!list.isEmpty()) {
				options = new String[list.size()][2];
				Iterator<Sysparamconf> it = list.iterator();
				while (it.hasNext()) {
					Sysparamconf sysparamconf=it.next();
					options[i][0] = sysparamconf.getPvalue().toString().trim();
					options[i][1] = sysparamconf.getRemark().toString().trim();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "δ��������";
				options[0][1] = "δ��������";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	public String[][] findSysLogBackupTask_PATH() {
        this.init();
		String[][] options = null;
		String hql=null;
		String pname="filePath_sysLogBackupTask";
		try {
			hql=" from Sysparamconf sysparamconf where sysparamconf.pname='"+pname+"'";
			@SuppressWarnings("unchecked")
			List<Sysparamconf> list = this.ajaxBean.getHibernateTemplate().find(hql);
			int i = 0;
			if (!list.isEmpty()) {
				options = new String[list.size()][2];
				Iterator<Sysparamconf> it = list.iterator();
				while (it.hasNext()) {
					Sysparamconf sysparamconf=it.next();
					options[i][0] = sysparamconf.getPvalue().toString().trim();
					options[i][1] = sysparamconf.getRemark().toString().trim();
					i++;
				}
			} else {
				options = new String[1][2];
				options[0][0] = "δ��������";
				options[0][1] = "δ��������";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	public String deleteTask() {
        this.init();
		String options = null;
		String hql1,hql2,sql1,sql2;
		String[] pname={"TIME_sysLogBackupTask","filePath_sysLogBackupTask"};
		hql1="from Sysparamconf sysparamconf where sysparamconf.pname='"+pname[0]+"'";
		hql2="from Sysparamconf sysparamconf where sysparamconf.pname='"+pname[1]+"'";
		sql1="delete from t_park_sysparamconf where Pname='"+pname[0]+"'";
		sql2="delete from t_park_sysparamconf where Pname='"+pname[1]+"'";
		try {
			if(!this.ajaxBean.getHibernateTemplate().find(hql1).isEmpty()&&!this.ajaxBean.getHibernateTemplate().find(hql2).isEmpty()){
				this.jdbcUtil.delete(sql1);
				this.jdbcUtil.delete(sql2);
				options="deleteTaskSuccess";
			}else{
				options="deleteTaskFail";
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return options;
	}
	
	/**
	 * Getter/Setter����ע��HibernateTemplate
	 */
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	
	/*public static void main(String[] arg){
		ClassPathXmlApplicationContext cxa=new ClassPathXmlApplicationContext("applicationContext.xml");
		AjaxBean ajaxBean= (AjaxBean) cxa.getBean("ajaxBean");
		String groupName="AdvCode";
		System.out.println(ajaxBean.getHibernateTemplate().find(
				"from SystemPara systemPara where systemPara.paraClass='1' and systemPara.groupName='"+groupName.toString().trim()+"'"));
		
		
	
	}*/
	
}
