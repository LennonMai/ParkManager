package com.hgsoft.dao;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.SquadLog;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

/**
 * 生成合计数DAO
 * @author caijunhua
 *
 */

@Repository
public class GenerateSumDao extends BaseDao<SquadLog>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	//查询大门总合计数列表
	@SuppressWarnings("unchecked")
	public List queryGateSum(Pager pager,Integer areaNo, Integer parkNo, String gateNo, Date squadDate, String stationYNSum ) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		StringBuffer bf = new StringBuffer("select (select RTRIM(AreaName)  from tb_Area where tb_Area.AreaNo=tb_SquadLog.AreaNo) as AreaName," +
				"(select RTRIM(ParkName) from tb_Park where tb_Park.AreaNo=tb_SquadLog.AreaNo and tb_Park.ParkNo=tb_SquadLog.ParkNo) as ParkName," +
				
				//"(select isnull(SUM(VehCount), 0) from tb_OutList03 where tb_OutList03.AreaNo=tb_SquadLog.AreaNo and tb_OutList03.ParkNo=tb_SquadLog.ParkNo and tb_OutList03.GateNo=tb_SquadLog.GateNo and tb_OutList03.SquadDate='"+format.format(squadDate)+"')  as aa,"+
				//"(select isnull(SUM(cashMoney + etcMoney), 0) from tb_OutList03 where tb_OutList03.AreaNo=tb_SquadLog.AreaNo and tb_OutList03.ParkNo=tb_SquadLog.ParkNo and tb_OutList03.GateNo=tb_SquadLog.GateNo and tb_OutList03.SquadDate='"+format.format(squadDate)+"')  as bb,"+
				//"ISNULL((select SUM(VehCount) from tb_OutList03 where tb_OutList03.AreaNo=tb_SquadLog.AreaNo and tb_OutList03.ParkNo=tb_SquadLog.ParkNo and tb_OutList03.GateNo=tb_SquadLog.GateNo and tb_OutList03.SquadDate='"+format.format(squadDate)+"'),0) as aa," +
				
				
				"ISNULL((select RTRIM(GateName) from tb_GateWay where tb_GateWay.AreaNo=tb_SquadLog.AreaNo and tb_GateWay.ParkNo=tb_SquadLog.ParkNo and tb_GateWay.GateNo=tb_SquadLog.GateNo),'未知') as GateName," +
				"tb_SquadLog.AreaNo,tb_SquadLog.ParkNo,tb_SquadLog.GateNo," +
				"dbo.f_DTtoStr(tb_SquadLog.SquadDate,0) as SquadDate," +
				"SUM(tb_SquadLog.TotalVehCnt) as RecordCnt," +
				"SUM(tb_SquadLog.TotalVehMoney) as MoneySummation ," +
				"'否'  as  StationYNSum" +
				" from " +
				"tb_SquadLog  left join  tb_GateSummation on (tb_SquadLog.AreaNo = tb_GateSummation.AreaNo and  tb_SquadLog.parkno=tb_GateSummation.parkno and  tb_SquadLog.gateno = tb_GateSummation.gateNo and tb_SquadLog.SquadDate = tb_GateSummation.SquadDate)" +
				"where  tb_GateSummation.AreaNo is Null " +
				" and  tb_SquadLog.AreaNo="+areaNo+"" +
				" and  tb_SquadLog.ParkNo="+parkNo+"");
		if(null != gateNo && !gateNo.equals("")) {
			bf.append(" and  tb_SquadLog.GateNo="+Short.parseShort(gateNo)+" and tb_SquadLog.LaneNo in ( select tb_Lane.LaneNo from tb_Lane where tb_Lane.LaneTypeNo = 2 )");
			//bf.append(" and  tb_SquadLog.GateNo="+Short.parseShort(gateNo));
		}
		if(null != squadDate) {
			bf.append(" and   tb_SquadLog.SquadDate='"+format.format(squadDate)+"'");
		}
		bf.append(" group by tb_SquadLog.AreaNo,tb_SquadLog.parkno,tb_SquadLog.gateno,tb_SquadLog.SquadDate " +
				" union " +
				"select  (select RTRIM(AreaName) from tb_Area where tb_Area.AreaNo=tb_GateSummation.AreaNo) as AreaName," +
				"(select RTRIM(ParkName) from tb_Park where tb_Park.AreaNo=tb_GateSummation.AreaNo and tb_Park.ParkNo=tb_GateSummation.ParkNo) as ParkName," +
				
				//"(select isnull(SUM(VehCount), 0) from tb_OutList03 where tb_OutList03.AreaNo=tb_GateSummation.AreaNo and tb_OutList03.ParkNo=tb_GateSummation.ParkNo and tb_OutList03.GateNo=tb_GateSummation.GateNo and tb_OutList03.SquadDate='"+format.format(squadDate)+"')  as aa,"+
				//"(select isnull(SUM(cashMoney + etcMoney), 0) from tb_OutList03 where tb_OutList03.AreaNo=tb_GateSummation.AreaNo and tb_OutList03.ParkNo=tb_GateSummation.ParkNo and tb_OutList03.GateNo=tb_GateSummation.GateNo and tb_OutList03.SquadDate='"+format.format(squadDate)+"')  as bb,"+
				
				"ISNULL((select RTRIM(GateName) from tb_GateWay where tb_GateWay.AreaNo=tb_GateSummation.AreaNo and tb_GateWay.ParkNo=tb_GateSummation.ParkNo and tb_GateWay.GateNo=tb_GateSummation.GateNo),'未知') as GateName," +
				
				"AreaNo,ParkNo,GateNo," +
				"dbo.f_DTtoStr(tb_GateSummation.SquadDate,0) as SquadDate," +
				"RecordCnt," +
				"MoneySummation ," +
				"'是'  as  StationYNSum " +
				" From " +
				" tb_GateSummation " +
				" where tb_GateSummation.AreaNo="+areaNo+"" +
				" and   tb_GateSummation.ParkNo="+parkNo+"");
		if(null != gateNo && !gateNo.equals("")) {
			bf.append(" and  tb_GateSummation.GateNo="+Short.parseShort(gateNo)+"");
		}
		if(null != squadDate) {
			bf.append(" and   tb_GateSummation.SquadDate='"+format.format(squadDate)+"'");
		}
		String sqlTemp = bf.toString();
	//	String sql = "select AreaName,ParkName,aa,bb,GateName,AreaNo,ParkNo,GateNo,SquadDate,RecordCnt,MoneySummation,StationYNSum from ("+sqlTemp+") as tempresult";
	//	string sql="select (isnull(SUM(VehCount), 0)  from ("+sqlTemp+")as tempresult1 ,tb_OutList"+DATEPART(mm,tempresult1.SquadDate);
		String sql = "select AreaName,ParkName,GateName,AreaNo,ParkNo,GateNo,SquadDate,RecordCnt,MoneySummation,StationYNSum from ("+sqlTemp+") as tempresult";
		if(null != stationYNSum && !stationYNSum.equals("") && 1 == Integer.parseInt(stationYNSum)) {
			sql += " where tempresult.StationYNSum  = '否'";
		}
		if(null != stationYNSum && !stationYNSum.equals("") && 2 == Integer.parseInt(stationYNSum)) {
			sql += " where tempresult.StationYNSum  = '是'";
		}
		
		//查询总记录数
		String sqlCount = "select count(*) from ("+sql+") temp";
		
		int count = jdbcUtil.select(sqlCount);
		pager.setTotalSize(count);
//		System.out.println(count);
		
		//执行分页
		//int start = (pager.getCurrentPage()-1)*pager.getPageSize() + 1;
		//int end = pager.getCurrentPage()*pager.getPageSize();
		
		//sql2008
//		String sql1 = "select * from (select ROW_NUMBER() OVER(ORDER BY SquadDate asc) AS rownum,AreaName,ParkName,GateName,AreaNo,ParkNo,GateNo,SquadDate,RecordCnt,MoneySummation,StationYNSum from ("+sql+") temp1";
		//sql2000
		/*String sql1 = "select * from (select (select count(*) from ("+sql+") s1 " +  
            " where  s1.SquadDate <= s2.SquadDate) as rownum,AreaName,ParkName,GateName,AreaNo,ParkNo,GateNo,SquadDate,RecordCnt,MoneySummation,StationYNSum from ("+sql+") s2";*/
//		sql1 += ") t where rownum between "+ start +" and "+ end;
//		sql += " and rownum between "+ (pager.getCurrentPage()-1)*pager.getPageSize()+" and "+ pager.getCurrentPage()*pager.getPageSize()+") ";
//		System.out.println(sql1);
		
		List incorrectList = jdbcUtil.selectForList(sql);

		//执行分页
		pager.setTotalSize(incorrectList.size());
		int startIndex = (pager.getCurrentPage() - 1) * pager.getPageSize();
		int endIndex = pager.getPageSize();
		if (!incorrectList.isEmpty()) {
			if (pager != null) {
				// IndexOutOfBoundsException - 非法的端点值 (startIndex < 0 ||
				// endIndex > size || startIndex > endIndex)
				try {
					if (endIndex > incorrectList.size()) {
						endIndex = incorrectList.size();
						// System.out.println("1 -
						// endIndex>incorrectList.size()-----startIndex-"
						// + startIndex + " endIndex-" + endIndex);
						return incorrectList.subList(startIndex, endIndex);

					} else if (startIndex >= endIndex) {
						endIndex = startIndex + endIndex;
						if (incorrectList.size() >= endIndex) {

							// System.out.println("2 -1 startIndex >=
							// endIndex-----startIndex-"
							// + startIndex + " endIndex-" + endIndex);
							return incorrectList.subList(startIndex, endIndex);
						}
						if (incorrectList.size() < endIndex) {
							endIndex = incorrectList.size();
							// System.out.println("2 -2 startIndex >=
							// endIndex-----startIndex-"
							// + startIndex + " endIndex-" + endIndex);
							return incorrectList.subList(startIndex, endIndex);
						}

					} else {
						// System.out.println("3 - right-----startIndex-" +
						// startIndex
						// + " endIndex-" + endIndex);

						return incorrectList.subList(startIndex, endIndex);
					}

				} catch (IndexOutOfBoundsException e) {
					e.printStackTrace();
				}

			}
		}
		return null;

	}
	
	
	
	//查询车道合计数列表
	@SuppressWarnings("unchecked")
	public List queryLaneSum(Integer areaNo, Integer parkNo, String gateNo, Date squadDate) {				
		//String tb_outList="tb_outList"+month;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String squadDateTemp = "";		
		squadDateTemp = format.format(squadDate);
		String squadDateTempOne = squadDateTemp.toString();
		String month = squadDateTempOne.substring(5, 7);	
		Short gateNoTemp = null;
		if(null != gateNo) {
			gateNoTemp = Short.parseShort(gateNo);
		}
		StringBuffer bf = new StringBuffer("select (select RTRIM(AreaName) from tb_Area where tb_Area.AreaNo=tb_SquadLog.AreaNo) as AreaName," +
				"(select RTRIM(ParkName) from tb_Park where tb_Park.AreaNo=tb_SquadLog.AreaNo and tb_Park.ParkNo=tb_SquadLog.ParkNo) as ParkName," +
				"(select RTRIM(GateName) from tb_GateWay where tb_GateWay.AreaNo=tb_SquadLog.AreaNo and tb_GateWay.ParkNo=tb_SquadLog.ParkNo and tb_GateWay.GateNo=tb_SquadLog.GateNo) as GateName," +
				
				"(select isnull(SUM(VehCount), 0) from tb_OutList"+month+" where AreaNo=tb_SquadLog.AreaNo and ParkNo=tb_SquadLog.ParkNo and GateNo=tb_SquadLog.GateNo and LaneNo=tb_SquadLog.LaneNo and SquadNo=tb_SquadLog.SquadNo and SquadDate='"+format.format(squadDate)+"')  as count,"+
				"(select isnull(SUM(cashMoney + etcMoney), 0) from tb_OutList"+month+" where AreaNo=tb_SquadLog.AreaNo and ParkNo=tb_SquadLog.ParkNo and GateNo=tb_SquadLog.GateNo and LaneNo=tb_SquadLog.LaneNo and SquadNo=tb_SquadLog.SquadNo and SquadDate='"+format.format(squadDate)+"')  as money,"+
				
				"tb_SquadLog.AreaNo,tb_SquadLog.ParkNo,tb_SquadLog.GateNo," +
				"tb_SquadLog.LaneNo, dbo.f_DTtoStr(tb_SquadLog.SquadDate,0) as SquadDate,tb_SquadLog.SquadNo," +
				"rtrim((select  tb_LaneType.LaneTypeName from  tb_Lane left join tb_LaneType on tb_Lane.LaneTypeNo = tb_LaneType.LaneTypeNo where tb_Lane.laneNo = tb_SquadLog.LaneNo)) as LaneType," +
				"Sum(isnull(tb_SquadLog.Totalvehcnt,0)) as TVCount,SUM(isnull(tb_SquadLog.TotalVehMoney,0)) as TVMoney," +
				" '否' as LaneYNSum    from  (dbo.tb_SquadLog  left join dbo.tb_LaneSummation " +
				"  on (tb_SquadLog.AreaNo = tb_LaneSummation.AreaNo and tb_SquadLog.ParkNo = tb_LaneSummation.ParkNo and " +
				"tb_SquadLog.GateNo = tb_LaneSummation.GateNo and tb_SquadLog.LaneNo = tb_LaneSummation.LaneNo and " +
				"tb_SquadLog.squaddate = tb_LaneSummation.squaddate and tb_SquadLog.squadNo = tb_LaneSummation.squadNo)) " +
				" Where tb_SquadLog.AreaNo="+areaNo+"" +
				" and  tb_SquadLog.ParkNo="+parkNo+"" +
				" and  tb_SquadLog.LaneNo in ( select tb_Lane.LaneNo from tb_Lane where tb_Lane.LaneTypeNo = 2 ) " +
				" and  tb_LaneSummation.AreaNo is Null " +
				" and tb_SquadLog.squaddate= '"+squadDateTemp+"'" +
				" and  tb_SquadLog.GateNo="+gateNoTemp+"" +
				" group by  tb_SquadLog.AreaNo,tb_SquadLog.ParkNo,tb_SquadLog.SquadDate,tb_SquadLog.GateNo,tb_SquadLog.LaneNo,tb_SquadLog.SquadNo " +
				" union " +
				"Select (select RTRIM(AreaName) from tb_Area where tb_Area.AreaNo=L.AreaNo) as AreaName," +
				"(select RTRIM(ParkName) from tb_Park where tb_Park.AreaNo=L.AreaNo and tb_Park.ParkNo=L.ParkNo) as ParkName," +
				"(select RTRIM(GateName) from tb_GateWay where tb_GateWay.AreaNo=L.AreaNo and tb_GateWay.ParkNo=L.ParkNo and tb_GateWay.GateNo=L.GateNo) as GateName," +
				
				"(select isnull(SUM(VehCount), 0) from tb_OutList"+month+" where AreaNo=L.AreaNo and ParkNo=L.ParkNo and GateNo=L.GateNo and LaneNo=L.LaneNo and SquadNo=L.SquadNo and SquadDate='"+format.format(squadDate)+"')  as count,"+
				"(select isnull(SUM(cashMoney + etcMoney), 0) from tb_OutList"+month+" where AreaNo=L.AreaNo and ParkNo=L.ParkNo and GateNo=L.GateNo and LaneNo=L.LaneNo and SquadNo=L.SquadNo and SquadDate='"+format.format(squadDate)+"')  as money,"+
				
				
				"AreaNo,ParkNo,GateNo," +
				"LaneNo, dbo.f_DTtoStr(SquadDate,0) as SquadDate,SquadNo," +
				"rtrim((select  tb_LaneType.LaneTypeName from  tb_Lane left join tb_LaneType on tb_Lane.LaneTypeNo = tb_LaneType.LaneTypeNo where tb_Lane.laneNo = L.LaneNo)) as LaneType," +
				"RecordCnt as TVCount , MoneySummation as TVMoney," +
				"'是' as LaneYNSum  " +
				"From  tb_LaneSummation L " +
				" Where L.AreaNo= "+areaNo+"" +
				" and   L.ParkNo= "+parkNo+"" +
				" and   L.LaneNo in ( select tb_Lane.LaneNo from tb_Lane where tb_Lane.LaneTypeNo = 2 ) " +
				" and L.squaddate= '"+squadDateTemp+"'" +
				" and  L.GateNo="+gateNoTemp+"");
		String sqlTemp = bf.toString();
		String sql = " select * from ("+sqlTemp+") as tempresult  Order  By SquadDate,LaneNo,SquadNo";
//		System.out.println(sql);
		List resultList = jdbcUtil.selectForList(sql);
		
		return resultList;
	}
	
	//查询没合计车道总列表
	@SuppressWarnings("unchecked")
	public List queryLaneNotSum(Integer areaNo, Integer parkNo, String gateNo, Date squadDate) {
		List result = new ArrayList();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String squadDateTemp = "";
		if(null != squadDate) {
			squadDateTemp = format.format(squadDate);
		}
		Short gateNoTemp = null;
		if(null != gateNo) {
			gateNoTemp = Short.parseShort(gateNo);
		}
		StringBuffer bf = new StringBuffer("select (select RTRIM(AreaName) from tb_Area where tb_Area.AreaNo=tb_SquadLog.AreaNo) as AreaName," +
				"(select RTRIM(ParkName) from tb_Park where tb_Park.AreaNo=tb_SquadLog.AreaNo and tb_Park.ParkNo=tb_SquadLog.ParkNo) as ParkName," +
				"(select RTRIM(GateName) from tb_GateWay where tb_GateWay.AreaNo=tb_SquadLog.AreaNo and tb_GateWay.ParkNo=tb_SquadLog.ParkNo and tb_GateWay.GateNo=tb_SquadLog.GateNo) as GateName," +
				"tb_SquadLog.GateNo," +
				"tb_SquadLog.LaneNo, dbo.f_DTtoStr(tb_SquadLog.SquadDate,0) as SquadDate,tb_SquadLog.SquadNo," +
				"rtrim((select  tb_LaneType.LaneTypeName from  tb_Lane left join tb_LaneType on tb_Lane.LaneTypeNo = tb_LaneType.LaneTypeNo where tb_Lane.laneNo = tb_SquadLog.LaneNo)) as LaneType," +
				"Sum(isnull(tb_SquadLog.Totalvehcnt,0)) as TVCount,SUM(isnull(tb_SquadLog.TotalVehMoney,0)) as TVMoney," +
				" '否' as LaneYNSum    from  (dbo.tb_SquadLog  left join dbo.tb_LaneSummation " +
				"  on (tb_SquadLog.AreaNo = tb_LaneSummation.AreaNo and tb_SquadLog.ParkNo = tb_LaneSummation.ParkNo and " +
				"tb_SquadLog.GateNo = tb_LaneSummation.GateNo and tb_SquadLog.LaneNo = tb_LaneSummation.LaneNo and " +
				"tb_SquadLog.squaddate = tb_LaneSummation.squaddate and tb_SquadLog.squadNo = tb_LaneSummation.squadNo)) " +
				" Where tb_SquadLog.AreaNo="+areaNo+"" +
				" and  tb_SquadLog.ParkNo="+parkNo+"" +
				" and  tb_SquadLog.LaneNo in ( select tb_Lane.LaneNo from tb_Lane where tb_Lane.LaneTypeNo = 2 ) " +
				" and  tb_LaneSummation.AreaNo is Null " +
				" and tb_SquadLog.squaddate= '"+squadDateTemp+"'" +
				" and  tb_SquadLog.GateNo="+gateNoTemp+"" +
				" group by  tb_SquadLog.AreaNo,tb_SquadLog.ParkNo,tb_SquadLog.SquadDate,tb_SquadLog.GateNo,tb_SquadLog.LaneNo,tb_SquadLog.SquadNo ");
		String sql = bf.toString();
		List resultList = jdbcUtil.selectForList(sql);
		if(resultList.size() != 0){
			//areaName,parkName,GateName,AreaNo,ParkNo,GateNo,LaneNo,SquadDate,SquadNo,LaneType,TVCount,TVMoney,LaneYNSum
			Iterator it = resultList.iterator();
			while(it.hasNext()){
				Map map = (Map) it.next();
				//System.out.println("squadDate.getMonth():"+squadDate.getMonth()+1);
				Calendar cal = Calendar.getInstance();
				cal.setTime(squadDate);
				int month = cal.get(Calendar.MONTH)+1;
				String str = "";
				if(month < 10) {
					str="0"+month;
				}else{
					str = String.valueOf(month);
				}
				//String month = "";
				Short laneNo = (Short) map.get("LaneNo");
				Short squadNo = (Short) map.get("SquadNo");
				
				//计算中心数据
				List temp = countCenterLaneData(str,  areaNo,  parkNo, gateNo,  laneNo.toString(),  squadDate,  squadNo.toString());
				List resultTemp = new ArrayList();
				Map tempMap = (Map) temp.get(0);
				resultTemp.add(map.get("GateName"));
				resultTemp.add(map.get("LaneNo"));
				resultTemp.add(map.get("SquadDate"));
				resultTemp.add(map.get("SquadNo"));
				resultTemp.add(map.get("LaneType"));
				resultTemp.add(map.get("TVCount"));
				resultTemp.add(map.get("TVMoney"));
				resultTemp.add(tempMap.get("ListCount"));
				resultTemp.add(tempMap.get("ListCashM"));
				resultTemp.add(tempMap.get("ListETCM"));
//				resultTemp.add(map.get("AreaNo"));
//				resultTemp.add(map.get("ParkNo"));
				
				int tc = (Integer)map.get("TVCount");
				int lc = (Integer)tempMap.get("ListCount");
				BigDecimal tm = new BigDecimal(map.get("TVMoney").toString());
				BigDecimal lm = new BigDecimal(tempMap.get("ListCashM").toString());
				BigDecimal lem = new BigDecimal(tempMap.get("ListETCM").toString());
				BigDecimal lmm = lm.add(lem);
				
				String status = "1";	//数据不一致
				if(tc == lc && tm.toString().equals(lmm.toString())) {
					status = "0";	//数据一致
				}
				resultTemp.add(status);
				
				result.add(resultTemp);
			}
		}
		
		return result;
	}
	
//	//根据大门名称查大门编号
//	public int queryGateNo(String gateName) {
//		String sql = "select gateNo from tb_gateway where gateName='"+gateName+"'";
//		int gateNo = jdbcUtil.select(sql);
//		System.out.println("__________"+sql);
//		return gateNo;
//	}
	
	//计算中心数据
	@SuppressWarnings("unchecked")
	public List countCenterLaneData(String month, Integer areaNo, Integer parkNo,
			String gateNo, String laneNo, Date squadDate, String squadNo) {
		if(null != month) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String squadDateTemp = "";
			if(null != squadDate) {
				squadDateTemp = format.format(squadDate);
			}
			StringBuffer bf = new StringBuffer("Select count(*) as ListCount," +
					"isnull(sum(CashMoney),0) as ListCashM," +
					"isnull(sum(ETCMoney),0) as ListETCM" +
					" From tb_OutList"+month+"" +
					" Where AreaNo ="+areaNo+"" +
					" and ParkNo ="+parkNo+"" +
					" and GateNo ="+gateNo+"" +
					" and LaneNo ="+laneNo+"" +
					" and SquadDate ='"+squadDateTemp+"'" +
					" and SquadNo ="+squadNo+"");
			String sql = bf.toString();
//			System.out.println(sql);
			List resultList = jdbcUtil.selectForList(sql);
			
			return resultList;
		} else {
			return null;
		}
	}
	
	//生成车道合计数
	public boolean generateLaneSum(String areaNo, String parkNo, String gateNo, String laneNo, String squadDate,
			String squadNo, String laneTypeNo, String recordCnt, String moneySummation) {
		if(null != squadDate) {
			squadDate = "'" + squadDate + " 00:00:00'";
		}
		if(null != areaNo && null != parkNo && null != gateNo && null != laneNo
				&& null != squadDate && null != squadNo ) {
			StringBuffer bf = new StringBuffer("insert into tb_Lanesummation( AreaNo, ParkNo, GateNo, LaneNo, SquadDate, SquadNo, LaneTypeNo, RecordCnt, MoneySummation)" +
					"values(" +
					areaNo+"," +
					parkNo+"," +
					gateNo+"," +
					laneNo+"," +
					squadDate+"," +
					squadNo+"," +
					laneTypeNo+"," +
					recordCnt+"," +
					moneySummation+")");
			String sql = bf.toString();
//			System.out.println(sql);
			jdbcUtil.update(sql);
			
			return true;
		} else {
			return false;
		}
	}
	
	//生成大门合计数
	public boolean generateGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		if(null != areaNo && null != parkNo && null != gateNo && null != squadDate) {
			StringBuffer bf = new StringBuffer("Insert into tb_GateSummation " +
					"Select AreaNo,ParkNo,GateNo,0," +
					"sum(RecordCnt) as RecordSum," +
					"sum(MoneySummation) as TollSum,SquadDate,GetDate() " +
					"From tb_LaneSummation " +
					" Where AreaNo="+areaNo+"" +
					" and ParkNo="+parkNo+"" +
					" and GateNo="+gateNo+"" +
					" and SquadDate='"+squadDate+"'" +
					" Group by AreaNo,ParkNo,GateNo,SquadDate");
			String sql = bf.toString();
//			System.out.println(sql);
			jdbcUtil.update(sql);
			
			return true;
		} else {
			return false;
		}
		
	}
	
	//查询车道合计数是否存在
	@SuppressWarnings("unchecked")
	public int selectLaneSum(String areaNo, String parkNo, String gateNo, String laneNo,
			String squadDate, String squadNo) {
		StringBuffer bf = new StringBuffer("select * from tb_LaneSummation " +
				" where areaNo="+areaNo+"" +
				" and parkNo="+parkNo+"" +
				" and gateNo="+gateNo+"" +
				" and laneNo="+laneNo+"" +
				" and squadDate='"+squadDate+"'" +
				" and squadNo="+squadNo);
		String sql = bf.toString();
//		System.out.println(sql);
		List resultList = jdbcUtil.selectForList(sql);
		int size = resultList.size();
		return size;
	}
	//选择车道重新合计时先删除之前合计生成的数据
	public void deleteLaneSum(String areaNo, String parkNo, String gateNo, String laneNo,
			String squadDate, String squadNo) {
		StringBuffer bf = new StringBuffer("delete from tb_LaneSummation " +
				" where areaNo="+areaNo+"" +
				" and parkNo="+parkNo+"" +
				" and gateNo="+gateNo+"" +
				" and laneNo="+laneNo+"" +
				" and squadDate='"+squadDate+"'" +
				" and squadNo="+squadNo);
		String sql = bf.toString();
		jdbcUtil.update(sql);		
	}
	//全部车道重新合计时先删除之前合计生成的数据
	public void deleteAllLaneSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		StringBuffer bf = new StringBuffer("delete from tb_LaneSummation " +
				" where areaNo="+areaNo+"" +
				" and parkNo="+parkNo+"" +
				" and gateNo="+gateNo+"" +				
				" and squadDate='"+squadDate+"'");
		String sql = bf.toString();
		jdbcUtil.update(sql);	
	}
	
	//查询大门合计数是否存在
	@SuppressWarnings("unchecked")
	public int selectGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		StringBuffer bf = new StringBuffer("select * from tb_GateSummation " +
				" where areaNo="+areaNo+"" +
				" and parkNo="+parkNo+"" +
				" and gateNo="+gateNo+"" +
				" and squadDate='"+squadDate+"'");
		String sql = bf.toString();
		List resultList = jdbcUtil.selectForList(sql);
		int size = resultList.size();
		return size;
	}
	//大门重新合计时先删除之前合计生成的数据
	public void deleteGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		StringBuffer bf = new StringBuffer("delete from tb_GateSummation " +
				" where areaNo="+areaNo+"" +
				" and parkNo="+parkNo+"" +
				" and gateNo="+gateNo+"" +
				" and squadDate='"+squadDate+"'");
		String sql = bf.toString();
		jdbcUtil.update(sql);		
	}
	
	
	//计算工班数
	public int countSquad() {
		String sql = "select count(distinct squadNo) as squadCount from tb_squad";
		int squadCount = jdbcUtil.select(sql);
		return squadCount;
	}
	
	//计算大门出口车道数
	public int countLane(String gateNo) {
		String sql = "select count(laneNo) as laneCount from tb_Lane " +
				" where laneTypeNo = 2 and gateNo="+gateNo;
		int outLane = jdbcUtil.select(sql);
		return outLane;
	}
	
	//计算已经合计的大门车道数
	public int countLaneSummation(String areaNo, String parkNo, String gateNo, String squadDate) {
		StringBuffer bf = new StringBuffer("select count(*) as laneSumCount from tb_LaneSummation " +
				" where areaNo="+areaNo+""+
				" and parkNo="+parkNo+"" +
				" and gateNo="+gateNo+"" +
				" and laneNo in (select tb_Lane.laneNo from tb_Lane where tb_Lane.LaneTypeNo=2)" +
				" and squadDate='"+squadDate+"'");
		String sql = bf.toString();
		int squadLane = jdbcUtil.select(sql);
		return squadLane;
	}
	
	//计算车道工班表中的记录数
	public int countSquadLog(String areaNo, String parkNo, String gateNo, String squadDate) {
		StringBuffer bf = new StringBuffer("select distinct tb.* from(select laneno, squadno " +
				" from tb_squadlog "+
				" where areaNo="+areaNo+"" +
				" and parkNo="+parkNo+"" +
				" and laneNo in (select tb_Lane.laneNo from tb_Lane where tb_Lane.LaneTypeNo=2)" +
				" and gateNo="+gateNo+""+
				" and squadDate='"+squadDate+"') tb");
		String temp = bf.toString();
		String sql = "select count(*) from ("+temp+") t";
		int squadLogCount = jdbcUtil.select(sql);
		return squadLogCount;
	}
	
	//把做了合计数的站、工班信息，写入报表未统计信息表
	public void insertSunInfo(String areaNo, String parkNo, String gateNo, String squadDate, String squadNo) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		StringBuffer bf = new StringBuffer("begin delete from tb_SumInfo " +
				" where areaNo="+areaNo+"" +
				" and parkNo="+parkNo+"" +
				" and gateNo="+gateNo+"" +
				" and squadDate='"+squadDate+"'" +
				" and squadNo="+squadNo+"" +
				" end" +
				" begin " +
				" insert into tb_SumInfo values(" +
				""+areaNo+"," +
				""+parkNo+"," +
				""+gateNo+"," +
				"'"+squadDate+"'," +
				""+squadNo+"," +
				"'"+format.format(new Date())+"') " +
				" end");
		String sql = bf.toString();
//		System.out.println(sql);
		jdbcUtil.update(sql);
	}
}
