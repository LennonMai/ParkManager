package com.hgsoft.dao;
/**
 *Copyright (c) 曾根宝 (kevin)  广州华工信息软件有限公司 http://www.hgsoft.com.cn
 *Email:rabitt450@163.com
 *转载请注明版权所有
 */
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.IdentifyResult;
import com.hgsoft.entity.InListForAuto;
import com.hgsoft.entity.OutListForAuto;
import com.hgsoft.util.Pager;


@Repository
public class IdentifyResultDao extends BaseDao<IdentifyResult>{
	/**
	 * 分页查询再识别图片确认
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager,String startTime,String endTime,String parkNo,String gateNo,String laneNo, String sign){
		//sign = "1" 表示使用inHql
		//sign = "2" 表示使用outHql
		String inHql = "from IdentifyResult identifyResult,InListForAuto inAuto where 1=1 and identifyResult.listNo = inAuto.listNo ";
		String outHql = "from IdentifyResult identifyResult,OutListForAuto outAuto where identifyResult.listNo = outAuto.listNo ";
		StringBuffer sb = new StringBuffer(0);
		StringBuffer sb1 = new StringBuffer(0);
		List resultList = new ArrayList();
		List list = new ArrayList();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(null != startTime && !startTime.equals("")){
			sb.append(" and inAuto.opTime >= ?");
			sb1.append(" and outAuto.opTime >= ?");
			try {
				list.add(format.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != endTime && !endTime.equals("")){
			sb.append(" and inAuto.opTime <= ?");
			sb1.append(" and outAuto.opTime <= ?");
			try {
				list.add(format.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != parkNo && !parkNo.equals("")){
			sb.append(" and inAuto.parkNo = ?");
			sb1.append(" and outAuto.parkNo = ?");
			list.add(Short.parseShort(parkNo));
		}
		if(null != gateNo && !gateNo.equals("")){
			sb.append(" and inAuto.gateNo = ?");
			sb1.append(" and outAuto.gateNo = ?" );
			list.add(Short.parseShort(gateNo));
		}
		if(null != laneNo && !laneNo.equals("")){
			sb.append(" and inAuto.laneNo = ?");
			sb1.append(" and outAuto.laneNo = ?");
			list.add(Short.parseShort(laneNo));
		}
		if(sign.equals("1")){
			Long count = this.executeCount(inHql + sb.toString(), list.toArray());
			pager.setTotalSize(count);
			List temp = this.executeQuery(pager, inHql + sb.toString()+" order by inAuto.opTime desc", list.toArray());
			Iterator it = temp.iterator();
			while(it.hasNext()){
				Object[] obj = (Object[]) it.next();
				IdentifyResult result = (IdentifyResult) obj[0];
				InListForAuto auto = (InListForAuto) obj[1];
				Object[] ay = new Object[]{result,auto};
				resultList.add(ay);
			}
		}else{
			Long count = this.executeCount(outHql + sb1.toString(), list.toArray());
			pager.setTotalSize(count);
			List temp = this.executeQuery(pager, outHql + sb1.toString()+" order by outAuto.opTime desc", list.toArray());
			Iterator it = temp.iterator();
			while(it.hasNext()){
				Object[] obj = (Object[]) it.next();
				IdentifyResult result = (IdentifyResult) obj[0];
				OutListForAuto auto = (OutListForAuto) obj[1];
				Object[] ay = new Object[]{result,auto};
				resultList.add(ay);
			}
		}
		return resultList;
	}
	
	@SuppressWarnings("unchecked")
	public IdentifyResult getById(String listNo){
		String hql = "from IdentifyResult result where result.listNo = ?";
		List list = this.executeQuery(hql, listNo);
		if(list.size() != 0){
			IdentifyResult result = (IdentifyResult) list.get(0);
			return result;
		}
		return null;
	}
	/**
	 * 获得InListForAuto表中的一个对象
	 */
	@SuppressWarnings("unchecked")
	public InListForAuto getInAutoByListNo(String listNo){
		String hql = "from InListForAuto inAuto where inAuto.listNo = ?";
		List list = this.executeQuery(hql, listNo);
		if(list.size() != 0){
			InListForAuto inAuto = (InListForAuto) list.get(0);
			return inAuto;
		}
		return null;
	}
	/**
	 * 获得OutListForAuto表中的一个对象
	 */
	@SuppressWarnings("unchecked")
	public OutListForAuto getOutAutoByListNo(String listNo){
		String hql = "from OutListForAuto outAuto where outAuto.listNo = ?";
		List list = this.executeQuery(hql, listNo);
		if(list.size() != 0){
			OutListForAuto outAuto = (OutListForAuto) list.get(0);
			return outAuto;
		}
		return null;
	}
}
