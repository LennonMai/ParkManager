package com.hgsoft.dao;

import groovy.time.BaseDuration.From;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;

import sun.awt.SunToolkit.InfiniteLoop;

import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository
public class CarStopTimeQueryDao {
	@Resource
	private JdbcUtil jdbcUtil;
	@Resource
	private SessionFactory sessionFactory;

	public Session getSession() {
		Session session = sessionFactory.getCurrentSession();
		return session;
	}

	@SuppressWarnings("unchecked")
	public List<Object> findByCondition(Pager pager, Integer stopCount,
			String stopTime, String startTime, String endTime, String carType) {
		StringBuffer conditon = new StringBuffer(0);
		List<Object> list = new ArrayList<Object>();
		String strs = "";
		if (stopCount != null && !"".equals(stopCount)) {
			strs = " having count(vehPlate)>=" + stopCount;
		}
		if (stopTime != null && !"".equals(stopTime)) {
			conditon.append(" datediff(mi, inoptime, optime)/60>='" + stopTime
					+ "' and ");
		}
		if (startTime != null && !"".equals(startTime) && endTime != null
				&& !"".equals(endTime)) {
			conditon.append(" inOptime >='" + startTime + "' and inOptime<'"
					+ endTime + "' and optime>='" + startTime
					+ "' and optime<'" + endTime + "' and ");
		}
		if (carType != null && !"".equals(carType)) {
			if ("0".equals(carType)) {
				conditon.append(" UserCardType in(13,14,15) and ");
			} else {
				conditon.append(" UserCardType not in(13,14,15) and ");
			}
		}
		String conditonString = conditon.toString();
		String sql = "";
		String str = "";
		if (conditonString.length() > 0) {
			str = conditonString.substring(0, conditonString.length() - 4);
			str = " and " + str;
		}
		sql = "select sum(stopCount) as stopCount,MIN(stopTime) as stopTime,carType,groupByMonth,vehplate from (select CASE WHEN UserCardType in(13,14,15) THEN 0 ELSE 1 END as carType,"
				+ " datediff(mi, inoptime, optime)/60 as stopTime,"
				+ "CONVERT(varchar(4), opTime, 120 )+'年'+substring(CONVERT(varchar(10), opTime, 120 ),6,2)+'月' as groupByMonth,"
				+ "count(vehPlate) as stopCount,vehPlate from v_AllOutList where inlistno <> '0' "
				+ str
				+ " group by  CASE WHEN UserCardType in (13,14,15) THEN 0 ELSE 1 END,datediff(mi, inoptime, optime)/60,CONVERT(varchar(4), opTime, 120 )+'年'+substring(CONVERT(varchar(10), opTime, 120 ),6,2)+'月',vehPlate  "
				+ strs+") tt group by carType,groupByMonth,vehplate ";
		int count = jdbcUtil.select("select count(*) from (" + sql + ") t");
		pager.setTotalSize(count);
		String sqls =sql
				+ " order by stopTime desc,stopCount desc";
		Query query = getSession().createSQLQuery(sqls)
				.addScalar("vehPlate", Hibernate.STRING)
				.addScalar("stopTime", Hibernate.INTEGER)
				.addScalar("stopCount", Hibernate.INTEGER)
				.addScalar("carType", Hibernate.INTEGER)
				.addScalar("groupByMonth", Hibernate.STRING)
				.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		if (pager != null) {
			query.setFirstResult((pager.getCurrentPage() - 1)
					* pager.getPageSize());
			query.setMaxResults(pager.getPageSize());
		}
		return query.list();
	}

	//导出
	@SuppressWarnings("unchecked")
	public List exportWhite(String filedString, String fileds, Map map) {
		StringBuffer conditon = new StringBuffer(0);
		List<Object> list = new ArrayList<Object>();
		String strs = "";
		if (map.get("stopCount") != null && !"".equals(map.get("stopCount"))) {
			strs = " having count(vehPlate)>=" + map.get("stopCount");
		}
		if (map.get("stopTime") != null && !"".equals(map.get("stopTime"))) {
			conditon.append(" datediff(mi, inoptime, optime)/60>='"
					+ map.get("stopTime") + "' and ");
		}
		if (map.get("startTime") != null && !"".equals(map.get("startTime"))
				&& map.get("endTime") != null && !"".equals(map.get("endTime"))) {
			conditon.append(" inOptime >='" + map.get("startTime")
					+ "' and inOptime<'" + map.get("endTime")
					+ "' and optime>='" + map.get("startTime")
					+ "' and optime<'" + map.get("endTime") + "' and ");
		}
		if (map.get("carType") != null && !"".equals(map.get("carType"))) {
			if ("0".equals(map.get("carType"))) {
				conditon.append(" UserCardType in(13,14,15) and ");
			} else {
				conditon.append(" UserCardType not in(13,14,15) and ");
			}
		}
		String conditonString = conditon.toString();
		String sql = "";
		String str = "";
		String sBuffString = "";
		String sBuffString1 = "";
		//根据所选导出字段进行分组查询
		if(filedString.length()>0){
		  int a = filedString.indexOf("carType");
		  int b = filedString.indexOf("groupByMonth");
		  int c = filedString.indexOf("vehPlate");
		  int d = filedString.indexOf("stopTime");
		  int e = filedString.indexOf("stopCount");
		  
		  StringBuffer sBuffer = new StringBuffer(" group by ");
		  StringBuffer sBuffer1 = new StringBuffer(" order by ");
		  if (a>=0||b>=0||c>=0) {
		  if (a>=0) {
			sBuffer = sBuffer.append( " carType,"); 
		}
		  if (b>=0) {
			  sBuffer = sBuffer.append( " groupByMonth,"); 
		  }
		  if (c>=0) {
			  sBuffer = sBuffer.append( " vehPlate,"); 
		  }
		  sBuffString = sBuffer.toString();
		  sBuffString = sBuffString.substring(0, sBuffString.length() - 1);
		  }
		//根据所选导出字段进行排序查询
		  if (d>=0||e>=0) {
		  if (d>=0) {
			  sBuffer1 = sBuffer1.append( " stopTime desc,"); 
		  }
		  if (e>=0) {
			  sBuffer1 = sBuffer1.append( " stopCount desc,"); 
		  }
		  sBuffString1 = sBuffer1.toString();
		  sBuffString1 = sBuffString1.substring(0, sBuffString1.length() - 1);
		  }
		}
		
		if (conditonString.length() > 0 || strs.length() > 0) {
			if (conditonString.length() > 0) {
				str = conditonString.substring(0, conditonString.length() - 4);
				str = " and " + str;
			}

			sql = "select "
					+ fileds
					+ " from v_AllOutList where inlistno <> '0' "
					+ str
					+ " group by case when UserCardType in (13,14,15) THEN '校内车'  ELSE '校外车'  END,datediff(mi, inoptime, optime)/60,CONVERT(varchar(4), opTime, 120 )+'年'+substring(CONVERT(varchar(10), opTime, 120 ),6,2)+'月',vehPlate  "
					+ strs;
					if (fileds.length()>0) {
						sql = "select "+filedString+ " from ( "
								+sql
								+ ") t "+sBuffString+" "+sBuffString1;
					}else {
						sql=sql+" order by datediff(mi, inoptime, optime)/60 desc,count(vehplate) desc";
					}
			list = jdbcUtil.selectForList(sql);
		} else {
			list = new ArrayList<Object>();
		}
		return list;
	}
}
