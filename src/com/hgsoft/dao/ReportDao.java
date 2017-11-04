package com.hgsoft.dao;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.ParkInformation;

/**
 * 报表DAO
 * @author caijunhua
 *
 */
@Repository
@SuppressWarnings("unchecked")
public class ReportDao {
	@Resource
	SessionFactory sessionFactory;
	
	public Session getSession(){
		Session session = sessionFactory.getCurrentSession();
		return session;
	}
	
	/**
	 * 
	 * 生成Stream形式的HTML格式报表
	 * @param sourceFile 输入源文件
	 * @param parameters 所需参数
	 * @throws JRException
	 */	
	@SuppressWarnings("deprecation")
	public JasperPrint fillReport(String sourceFile,Map<String,Object> parameters) throws JRException{
		return JasperFillManager.fillReport(sourceFile,parameters,sessionFactory.getCurrentSession().connection());
	}
	/**
	 * 生成Stream形式的PDF格式报表
	 * @param inputStream 输入源
	 * @param outStream  输出源
	 * @param parameters 所需参数
	 * @param conn 0为Empty dataSource,1为有Connection
	 * @throws JRException
	 */
	@SuppressWarnings("deprecation")
	public void PdfStreamFormate(InputStream inputStream,OutputStream outStream,Map<String,Object> parameters,int conn) throws JRException{
		if(conn == 0)
		  JasperRunManager.runReportToPdfStream(inputStream,outStream,parameters,new JREmptyDataSource());
		else if(conn == 1){
		  JasperRunManager.runReportToPdfStream(inputStream,outStream,parameters,sessionFactory.getCurrentSession().connection());
		}
	}
	
	/**
	 * 生成pdf或Html格式报表,Connection为Empty dataSource的方法
	 * @param sourceFile 原文件
	 * @param destFile 生成的目标文件
	 * @param parameters 所需参数
	 * @param format 0为生成pdf，1为生成Html
	 * @throws JRException
	 */
	@SuppressWarnings("deprecation")
	public String pdfOrHtmlFormat(String sourceFile,Map<String,Object> parameters,int format) throws JRException{
		if(format == 0)
		  return JasperRunManager.runReportToPdfFile(sourceFile, parameters, sessionFactory.getCurrentSession().connection());	
		else if(format == 1)
		  return JasperRunManager.runReportToHtmlFile(sourceFile, parameters, sessionFactory.getCurrentSession().connection());
		else
		  return null;
	}
	
	//公共方法，计算通行费报表记录条数
	public int executeTollsCount(String hql, Object... values) { 	
    	Query query = getSession().createSQLQuery("select count(*) from (select count(*) as count " + hql + ") as temp"); 
    	for (int i = 0; values != null && i < values.length; i++) {    
            query.setParameter(i, values[i]);  
        }
    	int count = 0;
    	if(query.list().size() != 0) {
    		count = (Integer)query.list().get(0);
    	}
    	return count;
    }
	
	//公共方法，计算报表记录条数
	public int executeCount(String hql, Object... values) { 	
    	Query query = getSession().createSQLQuery("select count(*) " + hql); 
    	for (int i = 0; values != null && i < values.length; i++) {    
            query.setParameter(i, values[i]);  
        }
    	int count = 0;
    	if(query.list().size() != 0) {
    		count = (Integer)query.list().get(0);
    	}
    	return count;
    } 
	
	//计算生成通行费日报表记录条数
	public int countTollsTradeDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
//		StringBuffer sf = new StringBuffer("from tb_AccountTrade ac left join tb_Operator op on ac.operatorID=op.operatorNo where tradeType=0 and ac.tradeTime>=? and ac.tradeTime<=? group by substring(tradeTime,0,11),operatorName order by substring(tradeTime,0,11),operatorName");
//		StringBuffer sf = new StringBuffer("from tb_OutListSum where SquadDate>=? and SquadDate<=? group by SquadDate order by SquadDate desc");
		StringBuffer sf = new StringBuffer("from tb_OutListSum as a " +
                    " where a.AreaNo=? and a.ParkNo=?  and  (a.SquadDate between ? and ?) " +
                    " group by a.SquadDate ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		int count = executeTollsCount(sf.toString(), obj.toArray());
//		Query query = getSession().createSQLQuery("select count(*) " + sf);
//		for(int i = 0; i < obj.toArray().length; i++) {
//			query.setParameter(i, obj.toArray()[i]);
//		}
//		int count = 0;
//		if(query.list().size() != 0) {
//			count = (Integer)query.list().get(0);
//		}
		return count;
	}
	//计算生成通行费日收费员报表记录条数
	public int countTollsCollectorDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
//		StringBuffer sf = new StringBuffer("from tb_OutListSum where SquadDate>=? and SquadDate<=? group by SquadDate,OperatorName order by SquadDate desc,OperatorName");
		StringBuffer sf = new StringBuffer("from tb_OutListSum as a " +
                " where a.AreaNo=? and a.ParkNo=?  and  (a.SquadDate between ? and ?) " +
                " group by a.SquadDate,a.OperatorNo,a.OperatorName ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeTollsCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成通行费分人班分时段报表记录条数
	public int countTollsOperSquadDates(String startTime, String endTime, int areaNoValue, int parkNoValue,
			String pSquadNo, String pOperatorNo) {
		StringBuffer sf = new StringBuffer("from tb_OutListSum as a left join tb_handinmoney as b " +
                        "on a.SquadDate=b.SquadDate and a.OperatorNo=b.OperatorNo "+
                    "where a.AreaNo=? and a.ParkNo=? and a.SquadDate between ? and ? " +
                        "and a.SquadNo in("+pSquadNo+") and a.OperatorNo in("+pOperatorNo+") " +
                    "group by a.SquadDate ,a.SquadNo,a.OperatorNo,a.OperatorName ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		int count = executeTollsCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成通行费分车道分时段报表记录条数
		public int countTollsLane(String startTime, String endTime, int areaNoValue,int parkNoValue,String pLaneNo) {
			StringBuffer sf = new StringBuffer("from tb_OutListSum as a left join tb_HandInMoney as b " +
					"on a.LaneNo=b.LaneNo " +
					"where a.AreaNo=? and a.ParkNo=? " +
					"and a.LaneNo in("+pLaneNo+") " +
					"and a.SquadDate between ? and ? " +
					"group by a.LaneNo,a.SquadDate,a.ParkNo ");
			List<Object> obj = new ArrayList<Object>();
			obj.add(areaNoValue);
			obj.add(parkNoValue);
			obj.add(startTime);
			obj.add(endTime);
			int count = executeTollsCount(sf.toString(), obj.toArray());
			return count;
		}
	//计算生成通行费日统计报表记录条数
	public int countTollsDayStatistics(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		StringBuffer sf = new StringBuffer("FROM tb_OutListSum " +
                    "where AreaNo=? and ParkNo=? and SquadDate between ? and ? " +
                    "group by SquadDate ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeTollsCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成通行费分门分车道报表记录条数
	public int countTollsGateLaneDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		StringBuffer sf = new StringBuffer("FROM tb_outlistsum as a left join tb_handinmoney as b  on a.SquadDate=b.SquadDate " + 
                        "and a.OperatorNo=b.OperatorNo " + 
                    "where a.AreaNo=? and a.ParkNo=? and a.SquadDate between ? and ? " + 
                    "GROUP BY  a.GateNo,a.SquadDate,a.LaneNo,a.SquadNo ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeTollsCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成通行费月报表记录条数
	public int countTollsTradeMonth(String startTime, String endTime, int areaNoValue, int parkNoValue) {
//		StringBuffer sf = new StringBuffer("from tb_AccountTrade ac left join tb_Operator op on ac.operatorID=op.operatorNo where tradeType=0 and ac.tradeTime>=? and ac.tradeTime<=? group by substring(tradeTime,0,8),operatorName order by substring(tradeTime,0,8),operatorName");
//		StringBuffer sf = new StringBuffer("from tb_OutListSum where SquadDate>=? and SquadDate<=? group by CONVERT(varchar(7),SquadDate,23),OperatorName order by CONVERT(varchar(7),SquadDate,23) desc,OperatorName");
		StringBuffer sf = new StringBuffer("from tb_OutListSum  as a left join tb_handinmoney as b " +
                        " on a.SquadDate=b.SquadDate and a.OperatorNo=b.OperatorNo " +
                    " where a.AreaNo=? and a.ParkNo=?  and  a.SquadDate between ? and ? " +
                    " group by a.SquadDate,a.OperatorName ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeTollsCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成缴费卡交易报表记录条数
	public int countPayCardTrade(String startTime, String endTime, String tradeType0, String tradeType1,
			String tradeType2, String tradeType3, String tradeType4, Integer accountNo,
			String userName, String vehPlate, String cardNo, String credentialsNo, Integer status) {
		StringBuffer sf = new StringBuffer("from v_AccountTrade a " +
				"left join t_park_account acc on a.accountNo=acc.sys_id " +
				"left join t_park_user u on acc.user_id = u.sys_id " +
				"where tradeType in ("+tradeType0+","+tradeType1+","+tradeType2+","+tradeType3+","+tradeType4+") " +
				"and tradeTime>=? and tradeTime<=?");
		
		// 组合条件
		if (accountNo != null) {
			sf.append(" and accountNo=" + accountNo);
		}
		if (!userName.equals("")) {
			sf.append(" and userName='" + userName + "'");
		}
		if (!vehPlate.equals("")) {
			sf.append(" and vehPlate='" + vehPlate + "'");
		}
		if (!cardNo.equals("")) {
			sf.append(" and a.cardNo='" + cardNo + "'");
		}
		if (!credentialsNo.equals("")) {
			sf.append(" and credentialsNo='" + credentialsNo + "'");
		}
		if (status != null) {
			sf.append(" and status=" + status);
		}
		
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成打印账单报表记录条数
	public int countPrintBill(String startTime, String endTime,String tradeType0,String tradeType1) {
		StringBuffer sf = new StringBuffer("from v_AccountTrade a " +
				"left join t_park_account acc on a.accountNo=acc.sys_id " +
				"left join t_park_user u on acc.user_id = u.sys_id " +
				"where tradeType in ("+tradeType0+","+tradeType1+") and tradeTime>=? and tradeTime<=?");
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	
	
	//计算生成车流量统计报表记录条数
	public int countTrafficFlowStatistics(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		StringBuffer sf = new StringBuffer("from ("+
                        "select GateNo,LaneNo,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
                        "sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
                        "sum (case when vehclass = 3 and UserCardType = 13 then vehcountsum else 0 end )"+
                        "    as vehyezhucountsum,"+
                        "sum (case when vehclass = 3 and UserCardType = 14 then vehcountsum else 0 end )"+
                        "    as vehyuezucountsum,"+
                        "sum (case vehclass when 5 then vehcountsum else 0 end ) as vehunpaycountsum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
                        "sum (case vehclass when 9 then vehcountsum when 4 then vehcountsum else 0 end )"+
                        "    as vehnoknowncountsum "+
                        "from tb_inlistsum "+
                        "where tb_InListSum.AreaNo=? and tb_InListSum.ParkNo=? "+
                        "and tb_InListSum.SquadDate between ? and ? "+
                        "group by  GateNo,LaneNo "+
                        "union "+
                        "select GateNo,LaneNo,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
                        "sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
                        "sum (case when vehclass = 3 and UserCardType = 13 then vehcountsum else 0 end )"+
                        "    as vehyezhucountsum,"+
                        "sum (case when vehclass = 3 and UserCardType = 14 then vehcountsum else 0 end )"+
                        "    as vehyuezucountsum,"+
                        "sum (case vehclass when 5 then vehcountsum else 0 end ) as vehunpaycountsum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
                        "sum (case vehclass when 9 then vehcountsum when 4 then vehcountsum else 0 end )"+
                        "    as vehnoknowncountsum "+
                        "from tb_outlistsum "+
                        "where tb_outlistsum.AreaNo=? and tb_outlistsum.ParkNo=? "+
                        "and tb_OutListSum.SquadDate between ? and ? "+
                        "group by  GateNo,LaneNo"+
                    ") as tempdb ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成车流量分人班分时段报表记录条数
	public int countTrafficFlowOperSquadDates(String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo) {
		StringBuffer sf = new StringBuffer("from (" +
                        "select SquadDate,LaneNo,squadNo, operatorNo, operatorName,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
                        "sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
                        "sum (case vehclass when 3 then vehcountsum else 0 end ) as vehcampuscountsum,"+
                        "sum (case vehclass when 4 then vehcountsum else 0 end ) as vehcheduicountsum,"+
                        "sum (case vehclass when 5 then vehcountsum else 0 end ) as vehunpaycountsum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
                        "sum (case vehclass when 9 then vehcountsum else 0 end ) as vehnoknowncountsum "+
                        "from tb_inlistsum "+
                        "where tb_InListSum.AreaNo=? and tb_InListSum.ParkNo=?"+
                        "    and tb_InListSum.SquadDate between ? and ?"+
                        "    and tb_inlistsum.SquadNo in("+pSquadNo+")"+
                        "    and tb_inlistsum.OperatorNo in("+pOperatorNo+")"+
                        "group by  squaddate, LaneNo, squadNo, operatorNo, operatorName "+
                        "union "+
                        "select SquadDate, LaneNo,squadNo, operatorNo, operatorName ,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
                        "sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
                        "sum (case vehclass when 3 then vehcountsum else 0 end ) as vehcampuscountsum,"+
                        "sum (case vehclass when 4 then vehcountsum else 0 end ) as vehcheduicountsum,"+
                        "sum (case vehclass when 5 then vehcountsum else 0 end ) as vehunpaycountsum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
                        "sum (case vehclass when 9 then vehcountsum else 0 end ) as vehnoknowncountsum "+
                        "from tb_outlistsum "+
                        "where tb_outlistsum.AreaNo=? and tb_outlistsum.ParkNo=?"+
                        "    and tb_outlistsum.SquadDate between ? and ?"+
                        "    and tb_outlistsum.SquadNo in("+pSquadNo+")"+
                        "    and tb_outlistsum.OperatorNo in("+pOperatorNo+") "+
                        "group by  squaddate, LaneNo, squadNo, operatorNo, operatorName"+
                    ") as tempdb ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成车流量日报表记录条数
	public int countTrafficFlowDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		StringBuffer sf = new StringBuffer("from (select SquadDate,GateNo,LaneNo,sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
				"sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
				"sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
				"sum (case vehclass when 7 then vehcountsum else 0 end ) as vehpayCardcountsum from tb_inlistsum "+
				"where tb_InListSum.AreaNo=? and tb_InListSum.ParkNo=? "+
				"and tb_InListSum.SquadDate between ? and ? "+
				"group by SquadDate,GateNo,LaneNo union "+
				"select SquadDate,GateNo,LaneNo,"+
				"sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
				"sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
				"sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
				"sum (case vehclass when 7 then vehcountsum else 0 end ) as vehpayCardcountsum from tb_outlistsum "+
				"where tb_outlistsum.AreaNo=? and tb_outlistsum.ParkNo=? "+
				"and tb_OutListSum.SquadDate between ? and ? "+
		"group by SquadDate,GateNo,LaneNo) as tempdb");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成车流量分门分车道报表记录条数
	public int countTrafficFlowGateLaneDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		StringBuffer sf = new StringBuffer("from ("+
                        "select GateNo,SquadDate,LaneNo,squadNo ,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
                        "sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
                        "sum (case vehclass when 3 then vehcountsum else 0 end ) as vehcampuscountsum,"+
                        "sum (case vehclass when 4 then vehcountsum else 0 end ) as vehcheduicountsum,"+
                        "sum (case vehclass when 5 then vehcountsum else 0 end ) as vehunpaycountsum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
                        "sum (case vehclass when 9 then vehcountsum else 0 end ) as vehnoknowncountsum "+
                        "from tb_inlistsum "+
                        "where tb_InListSum.AreaNo=? and tb_InListSum.ParkNo=?"+
                        "    and tb_InListSum.SquadDate between ? and ? "+
                        "group by  GateNo,squaddate ,LaneNo, squadNo "+
                        "union "+
                        "select GateNo,SquadDate,LaneNo,squadNo ,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
                        "sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
                        "sum (case vehclass when 3 then vehcountsum else 0 end ) as vehcampuscountsum,"+
                        "sum (case vehclass when 4 then vehcountsum else 0 end ) as vehcheduicountsum,"+
                        "sum (case vehclass when 5 then vehcountsum else 0 end ) as vehunpaycountsum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
                        "sum (case vehclass when 9 then vehcountsum else 0 end ) as vehnoknowncountsum "+
                        "from tb_outlistsum "+
                        "where tb_outlistsum.AreaNo=? and tb_outlistsum.ParkNo=?"+
                        "    and tb_outlistsum.SquadDate between ? and ? "+
                        "group by  GateNo,squaddate ,LaneNo, squadNo"+
                    ") as tempdb ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成车流量月报表记录条数
	public int countTrafficFlowMonth(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		StringBuffer sf = new StringBuffer("from ("+
                        "select CONVERT(VARCHAR(7),SquadDate,121) as SquadDate,GateNo,LaneNo,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
                        "sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
                        "sum (case vehclass when 3 then vehcountsum else 0 end ) as vehcampuscountsum,"+
                        "sum (case vehclass when 4 then vehcountsum else 0 end ) as vehcheduicountsum,"+
                        "sum (case vehclass when 5 then vehcountsum else 0 end ) as vehunpaycountsum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
                        "sum (case vehclass when 9 then vehcountsum else 0 end ) as vehnoknowncountsum "+
                        "from tb_inlistsum "+
                        "where tb_InListSum.AreaNo=? and tb_InListSum.ParkNo=? "+
                        "and tb_InListSum.SquadDate between ? and ? "+
                        "group by CONVERT(VARCHAR(7),SquadDate,121),GateNo,LaneNo "+
                        "union "+
                        "select CONVERT(VARCHAR(7),SquadDate,121) as SquadDate,GateNo,LaneNo,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) as vehgoodcountsum,"+
                        "sum (case vehclass when 2 then vehcountsum else 0 end ) as vehfreecountsum,"+
                        "sum (case vehclass when 3 then vehcountsum else 0 end ) as vehcampuscountsum,"+
                        "sum (case vehclass when 4 then vehcountsum else 0 end ) as vehcheduicountsum,"+
                        "sum (case vehclass when 5 then vehcountsum else 0 end ) as vehunpaycountsum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) as vehetccountsum,"+
                        "sum (case vehclass when 9 then vehcountsum else 0 end ) as vehnoknowncountsum "+
                        "from tb_outlistsum "+
                        "where tb_outlistsum.AreaNo=? and tb_outlistsum.ParkNo=? "+
                        "and tb_OutListSum.SquadDate between ? and ? "+
                        "group by CONVERT(VARCHAR(7),SquadDate,121),GateNo,LaneNo"+
                    ") as tempdb");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成车流通行费日报表记录条数
	public int countTrafficFlowTollsDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		StringBuffer sf = new StringBuffer("from ( "+
                        "select GateNo,SquadDate,LaneNo, "+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) "+
                        "    as Vehcashcountsum,"+
                        "0 as CashcashMoneySum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) "+
                        "    as Vehetccountsum,"+
                        "0 as CashETCMoneySum "+
                        "from tb_inlistsum "+
                        "where tb_InListSum.AreaNo=? and tb_InListSum.ParkNo=? "+
                        "    and tb_InListSum.SquadDate between ? and ? "+
                        "group by  GateNo,squaddate ,LaneNo "+
                        "union all "+
                        "select GateNo,SquadDate,LaneNo,"+
                        "sum (case vehclass when 1 then vehcountsum else 0 end ) "+
                        "    as Vehcashcountsum,"+
                        "sum (case vehclass when 1 then CashMoneySum else 0 end ) "+
                        "    as CashcashMoneySum,"+
                        "sum (case vehclass when 6 then vehcountsum else 0 end ) "+
                        "    as Vehetccountsum,"+
                        "sum (case vehclass when 6 then ETCMoneySum else 0 end ) "+
                        "    as CashETCMoneySum "+
                        "from tb_outlistsum "+
                        "where tb_outlistsum.AreaNo=? and tb_outlistsum.ParkNo=? "+
                        "    and tb_outlistsum.SquadDate between ? and ? "+
                        "group by  GateNo,squaddate ,LaneNo "+
                    ") as tempdb ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	
	
	
	//计算发卡详细情况报表记录条数
	public int countCardInfo(String startTime, String endTime) {
		StringBuffer sf = new StringBuffer("from tb_usercardinfo tb "+
                    "where registertime between ? and ? ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算临时卡动态报表记录条数
	public int countCardDynamic() {
		StringBuffer sf = new StringBuffer("From tb_CardDynamic");
		List<Object> obj = new ArrayList<Object>();
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成月保车缴费记录报表记录条数
	public int countCarMonthBill(String startTime, String endTime) {
		StringBuffer sf = new StringBuffer("from tb_userCardBill uc left join tb_Operator op on uc.Operator=op.OperatorNO where OpTime>=? and OpTime<=?");
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成月保车缴费日统计报表记录条数
	public int countCarMonthBillDay(String startTime, String endTime) {
		StringBuffer sf = new StringBuffer(" from (select CONVERT(varchar(10), uc.OpTime, 23)as opTime,sum(uc.Amount) as account,sum(Money) as money " +
									" from tb_UserCardBill uc " +
									" where OpTime>=? and OpTime<=? " +
									" group by CONVERT(varchar(10), uc.OpTime, 23) ) t ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成月保车缴费日类型统计报表记录条数
	public int countCarMonthBillDayType(String startTime, String endTime) {
		StringBuffer sf = new StringBuffer("from (select CONVERT(varchar(10), uc.OpTime, 23)as opTime,c.TypeName,sum(uc.Amount) as account,sum(Money) as money " +
									" from tb_UserCardBill uc " +
									" left join tb_UserCardInfo u on uc.UserRecNo=u.RecNO " +
									" left join tb_CardType c on u.UserCardtype=c.CardType " +
									" where OpTime>=? and OpTime<=? " +
									" group by CONVERT(varchar(10), uc.OpTime, 23),u.UserCardType,c.TypeName ) t ");
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算生成月租卡缴费记录条数
	public int countCarMonthParking(String startTime, String endTime) {
		StringBuffer sf = new StringBuffer("from tb_UserCardBill uc,tb_UserCardInfo ui " +
				"where uc.UserRecNo=ui.RecNo and OpTime>=? and OpTime<=?");
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	
	
	//计算通行卡领卡交卡登记报表记录条数
	public int countPassCardHandOutIn(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		StringBuffer sf = new StringBuffer("from tb_CardHandOutIn ch, tb_Squad s , tb_GateWay g "+
                    "where SquadDate between ? and ? "+
                    "    and ch.SquadNo=s.SquadNo and g.AreaNo=? and g.ParkNo=? "+
                    "    and  g.ParkNo=ch.ParkNo and g.GateNo=ch.GateNo");
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	//计算通行卡使用分人班报表记录条数
	public int countPassCardUsedOperSquad(String startTime, String endTime, int areaNoValue, int parkNoValue,
			String inlistUnionTable, String outlistUnionTable) {
		StringBuffer sf = new StringBuffer("from"+
                    "("+
                    "    select SquadDate, OperatorName, SquadNo, AreaNo, ParkNo, GateNo, LaneNo,"+
                    "    count(1) CardSum, '发出' Type "+
                    "    from (" + inlistUnionTable + ") as inlist "+
                    "    where SquadDate between ? and ? and tickettype=1 "+
                    "    group by SquadDate, OperatorName, SquadNo, AreaNo, ParkNo, GateNo, LaneNo "+
                    "    union "+
                    "    select SquadDate, OperatorName, SquadNo, AreaNo, ParkNo, GateNo, LaneNo,"+
                    "    count(1) CardSum, '收回' Type "+
                    "    from (" + outlistUnionTable + ") as outlist "+
                    "    where SquadDate between ? and ? and tickettype=1 "+
                    "    group by SquadDate, OperatorName, SquadNo, AreaNo, ParkNo, GateNo, LaneNo"+
                    ") t, tb_Squad s, tb_GateWay g "+
                    "where t.SquadNo=s.SquadNo and t.AreaNo=? and t.ParkNo=? and t.AreaNo=g.AreaNo "+
                    "    and t.ParkNo=g.ParkNo and t.GateNo=g.GateNo");
		List<Object> obj = new ArrayList<Object>();
		obj.add(startTime);
		obj.add(endTime);
		obj.add(startTime);
		obj.add(endTime);
		obj.add(areaNoValue);
		obj.add(parkNoValue);
		
		int count = executeCount(sf.toString(), obj.toArray());
		return count;
	}
	
	//通过车道类型取 出口  车道
		@SuppressWarnings("unchecked")
		public List<LaneInformation> getLaneInformationByLaneNo(String laneNo) {
			String hql="from LaneInformation laneInformation where laneTypeNo!=1";
			List resultList = this.getSession().createQuery(hql).list();
			if(resultList.isEmpty()) {
				return null;
			} else {
				return resultList;
			}
		}
		
		//取所有小区信息
		@SuppressWarnings("unchecked")
		public List<ParkInformation> getAllParkInformation() {
			String hql="from ParkInformation parkInfo";
			List resultList = this.getSession().createQuery(hql).list();
			if(resultList.isEmpty()) {
				return null;
			} else {
				return resultList;
			}
		}
		
		//计算生成通行费应收现金分人班分时段报表记录条数
		public int countTollsCashMoneyOperSquadDates(String startTime, String endTime, int areaNoValue, int parkNoValue,
				String pSquadNo, String pOperatorNo) {
				StringBuffer sf = new StringBuffer("from tb_OutListSum as a "+
                    "where a.AreaNo=? and a.ParkNo=? and a.SquadDate between ? and ? "+
                    "and a.SquadNo in("+pSquadNo+") and a.OperatorNo in("+pOperatorNo+") "+
                    "group by a.SquadDate,a.SquadNo,a.OperatorNo,a.OperatorName");
			List<Object> obj = new ArrayList<Object>();
			obj.add(areaNoValue);
			obj.add(parkNoValue);
			obj.add(startTime);
			obj.add(endTime);
			int count = executeTollsCount(sf.toString(), obj.toArray());
			return count;
		}
		
		//计算发卡详细情况报表记录条数
		public int countCardInfoInCarType(String startTime, String endTime, Integer carType, String parkingSpace) {
			StringBuffer sf = new StringBuffer("from tb_usercardinfo tb "+
	                    "where registertime between ? and ? ");
			if(carType!=null && !carType.equals("")){
				sf.append(" and CarType =").append(carType);	
				if(parkingSpace!=null && !parkingSpace.equals("")){
					sf.append(" and parkingSpace ='").append(parkingSpace).append("'");	
				}
			}
			List<Object> obj = new ArrayList<Object>();
			obj.add(startTime);
			obj.add(endTime);
			
			int count = executeCount(sf.toString(), obj.toArray());
			return count;
		}
	
}
