package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.hgsoft.util.JdbcUtil;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.AccountAgentExportLog;
import com.hgsoft.util.Pager;


/**
 * ��ͨ���ӿ����ݵ�����־DAO
 * @author caijunhua
 *
 */

@Repository
public class AccountAgentExportLogDao extends BaseDao<AccountAgentExportLog> {
	
	@Resource
	private JdbcUtil jdbcUtil;
	/**
	 * ���ݲ�ѯ������ѯ��ͨ���ӿ����ݵ�����־
	 * @param pager
	 * @param startTime ��ʼʱ��
	 * @param endTime ����ʱ��
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AccountAgentExportLog> findAccountAgentExportLogByHql(Pager pager,String startTime, String endTime,String PackNo) {

		StringBuffer sf = new StringBuffer("from AccountAgentExportLog accountAgentExportLog where");
		List<Object> list = new ArrayList<Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (null != startTime && !"".equals(startTime)) {
			sf.append(" accountAgentExportLog.squadDate >= ? and");
			try {
				list.add(sdf.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (null != endTime && !"".equals(endTime)) {
			sf.append(" accountAgentExportLog.squadDate <= ? and");
			try {
				list.add(sdf.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (null != PackNo && !"all".equals(PackNo)&&!"".equals(PackNo)) {
			
			sf.append(" accountAgentExportLog.packNo = ? and");
			try {
				list.add(PackNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		if(list.size() != 0 ) {
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		} else {
			sf = sf.replace(sf.length() - 6, sf.length(), "");
		}
		
		// ������������Է�ҳ��������
		Long count = this.executeCount(sf.toString(), list.toArray());
		if(pager!=null)
		pager.setTotalSize(count);
		//��ʱ�併������¼����
		return this.executeQuery(pager, sf.toString() + " order by squadDate desc", list.toArray());
	}
	@SuppressWarnings("unchecked")
	public List<String> getPackNo()
	{
		return jdbcUtil.selectForList("select distinct PackNo from tb_AccountAgentExportLog");
		
	}
	
}
