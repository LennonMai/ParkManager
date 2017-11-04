package com.hgsoft.service;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.OtherReportDao;
import com.hgsoft.entity.LaneInformation;

/**
 * ����Service
 * 
 * @author caijunhua
 * 
 */
@Service
public class OtherReportService {
	@Resource
	private OtherReportDao otherReportDao;

	/**
	 * ͨ�з��ձ��� ͨ�з����շ�Ա���� ͨ�з��±��� ����ϸ��Ϣ���� �±����ɷѼ�¼���� ��ͳ��ʱ�䷶Χ����Stream��ʽ��HTML��ʽ�ı���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public JasperPrint fillReport(String sourceFile, String startTime, String endTime, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * ͨ�з��ձ��� ͨ�з����շ�Ա���� ͨ�з��±��� ����ϸ��Ϣ���� �±����ɷѼ�¼���� ��ͳ��ʱ�䷶Χ����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @throws JRException
	 */
	public void pdfStreamFormate(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * ͨ�з���ͳ�Ʊ��� ͨ�зѷ��ŷֳ����ձ��� ���أ�����Stream��ʽ��HTML��ʽ�ı���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public JasperPrint tollsFillReport(String sourceFile, String startTime, String endTime, int areaNoValue, int parkNoValue, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("creator", creator);
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * ͨ�з���ͳ�Ʊ��� ͨ�зѷ��ŷֳ����ձ��� ���أ�����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public void tollsPdfStream(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, int areaNoValue, int parkNoValue, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("creator", creator);
		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * ͨ�з� �� ������ ���˰��ʱ�α������أ���ͳ�ƹ����,����Ա��,����Stream��ʽ��HTML��ʽ�ı���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param pSquadNo
	 *            �����
	 * @param pOperatorNo
	 *            ����Ա��
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public JasperPrint operSquadDatesFillReport(String sourceFile, String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("pSquadNo", pSquadNo);
		parameters.put("pOperatorNo", pOperatorNo);
		parameters.put("creator", creator);
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * ͨ�з� �� ���������˰��ʱ�α������أ���ͳ�ƹ����,����Ա��,����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param pSquadNo
	 *            �����
	 * @param pOperatorNo
	 *            ����Ա��
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public void operSquadDatesPdfStream(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("pSquadNo", pSquadNo);
		parameters.put("pOperatorNo", pOperatorNo);
		parameters.put("creator", creator);
		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}
	
	/**
	 * ͨ�з�  �ֳ�����ʱ�α������أ���ͳ�Ƴ�����,����Stream��ʽ��HTML��ʽ�ı���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param pLaneNo
	 *            ������
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public JasperPrint laneFillReport(String sourceFile, String startTime, String endTime, int areaNoValue, int parkNoValue, String pLaneNo, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("pLaneNo", pLaneNo);
		parameters.put("creator", creator);
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * ͨ�з� �ֳ�����ʱ�α������أ���ͳ�Ƴ�����,����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param pLaneNo
	 *            ������
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public void lanePdfStream(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, int areaNoValue, int parkNoValue, String pLaneNo, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("pLaneNo", pLaneNo);
		parameters.put("creator", creator);
		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * �ɷѿ����׼�¼�������أ���ͳ��ʱ�䷶Χ,��������,����Stream��ʽ��HTML��ʽ�ı���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param tradeType0
	 *            ����
	 * @param tradeType1
	 *            ��ֵ
	 * @param tradeType2
	 *            ����
	 * @param tradeType3
	 *            ����
	 * @param tradeType4
	 *            ����
	 * @param creator
	 *            �Ʊ���
	 * @param accountNo
	 *            �û��˺�
	 * @param userName
	 *            �û���
	 * @param vehPlate
	 *            ���ƺ�
	 * @param cardNo
	 *            ����
	 * @param credentialsNo
	 *            ֤������
	 * @param status
	 *            �˻�״̬
	 * @throws JRException
	 */
	public JasperPrint fillReport(String sourceFile, String startTime, String endTime, String tradeType0, String tradeType1, String tradeType2, String tradeType3, String tradeType4, String creator, Integer accountNo, String userName, String vehPlate, String cardNo, String credentialsNo, Integer status) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("tradeType0", tradeType0);
		parameters.put("tradeType1", tradeType1);
		parameters.put("tradeType2", tradeType2);
		parameters.put("tradeType3", tradeType3);
		parameters.put("tradeType4", tradeType4);
		parameters.put("creator", creator);
		// �������
		StringBuffer sf = new StringBuffer("");
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
		parameters.put("condition", sf.toString());
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * �ɷѿ����׼�¼�������أ���ͳ��ʱ�䷶Χ,��������,����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param tradeType0
	 *            ����
	 * @param tradeType1
	 *            ��ֵ
	 * @param tradeType2
	 *            ����
	 * @param tradeType3
	 *            ����
	 * @param tradeType4
	 *            ����
	 * @param creator
	 *            �Ʊ���
	 * @param accountNo
	 *            �û��˺�
	 * @param userName
	 *            �û���
	 * @param vehPlate
	 *            ���ƺ�
	 * @param cardNo
	 *            ����
	 * @param credentialsNo
	 *            ֤������
	 * @param status
	 *            �˻�״̬
	 * @throws JRException
	 */
	public void pdfStreamFormate(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, String tradeType0, String tradeType1, String tradeType2, String tradeType3, String tradeType4, String creator, Integer accountNo, String userName, String vehPlate, String cardNo, String credentialsNo, Integer status) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		parameters.put("tradeType0", tradeType0);
		parameters.put("tradeType1", tradeType1);
		parameters.put("tradeType2", tradeType2);
		parameters.put("tradeType3", tradeType3);
		parameters.put("tradeType4", tradeType4);
		// �������
		StringBuffer sf = new StringBuffer("");
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
		parameters.put("condition", sf.toString());

		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * ��ӡ�˵��������أ���ͳ��ʱ�䷶Χ,��������,����Stream��ʽ��HTML��ʽ�ı���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param tradeType0
	 *            ����
	 * @param tradeType1
	 *            ��ֵ
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public JasperPrint fillReport(String sourceFile, String startTime, String endTime, String tradeType0, String tradeType1, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("tradeType0", tradeType0);
		parameters.put("tradeType1", tradeType1);
		parameters.put("creator", creator);
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * ��ӡ�˵��������أ���ͳ��ʱ�䷶Χ,��������,����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param tradeType0
	 *            ����
	 * @param tradeType1
	 *            ��ֵ
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public void pdfStreamFormate(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, String tradeType0, String tradeType1, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		parameters.put("tradeType0", tradeType0);
		parameters.put("tradeType1", tradeType1);
		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * ������ ��ͳ��ʱ�䷶Χ����Stream��ʽ��HTML��ʽ�ı��� ͨ�п��쿨�����ǼǱ���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public JasperPrint trafficFlowFillReport(String sourceFile, String startTime, String endTime, int areaNoValue, int parkNoValue, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("creator", creator);
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * ������ ��ͳ��ʱ�䷶Χ����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public void trafficFlowPdfStream(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, int areaNoValue, int parkNoValue, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("creator", creator);
		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * ��ʱ����̬���� ��ͳ��ʱ�䷶Χ����Stream��ʽ��HTML��ʽ�ı���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public JasperPrint fillReport(String sourceFile, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("creator", creator);
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * ��ʱ����̬���� ��ͳ��ʱ�䷶Χ����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @throws JRException
	 */
	public void pdfStreamFormate(InputStream inputStream, OutputStream outputStream, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("creator", creator);
		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * ͨ�п�ʹ�÷��˰౨�� ����Stream��ʽ��HTML��ʽ�ı���
	 * 
	 * @param sourceFile
	 *            ����Դ�ļ�
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param inlistUnionTable
	 *            �����ˮƴ��sql
	 * @param outlistUnionTable
	 *            ������ˮƴ��sql
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public JasperPrint passCardUsedOperSquadFillReport(String sourceFile, String startTime, String endTime, int areaNoValue, int parkNoValue, String inlistUnionTable, String outlistUnionTable, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("inlistUnionTable", inlistUnionTable);
		parameters.put("outlistUnionTable", outlistUnionTable);
		parameters.put("creator", creator);
		return this.otherReportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * ͨ�п�ʹ�÷��˰౨�� ����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 *            ������
	 * @param outStream
	 *            �����
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @param areaNoValue
	 *            ������
	 * @param parkNoValue
	 *            С�����
	 * @param inlistUnionTable
	 *            �����ˮƴ��sql
	 * @param outlistUnionTable
	 *            ������ˮƴ��sql
	 * @param creator
	 *            �Ʊ���
	 * @throws JRException
	 */
	public void passCardUsedOperSquadPdfStream(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, int areaNoValue, int parkNoValue, String inlistUnionTable, String outlistUnionTable, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("inlistUnionTable", inlistUnionTable);
		parameters.put("outlistUnionTable", outlistUnionTable);
		parameters.put("creator", creator);
		this.otherReportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * ��ͳ��ʱ�䷶Χ����Stream��ʽ��PDF��ʽ�ı���
	 * 
	 * @param inputStream
	 * @param outStream
	 * @param startTime
	 *            ��ѯ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @throws JRException
	 */
	public String pdfOrHtmlFormat(String sourceFile, String startTime, String endTime, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		return this.otherReportDao.pdfOrHtmlFormat(sourceFile, parameters, 1);
	}

	// ͨ�п�ʹ�÷��˰౨�� ������ѡ�·�ƴ��inlist��sql���
	public String inlistUnionTable(String startTime, String endTime) {
		// ȡ���ڵ��·�ֵ
		String startYear = startTime.substring(0, 4);
		String endYear = endTime.substring(0, 4);
		String startMonth = startTime.substring(5, 7);
		String endMonth = endTime.substring(5, 7);

		int sy = Integer.parseInt(startYear);
		int ey = Integer.parseInt(endYear);
		int sm = Integer.parseInt(startMonth);
		int em = Integer.parseInt(endMonth);
		StringBuffer inlist = new StringBuffer();
		// �ж�ѡ��ʱ�䣬�����ֲ�ͬ���
		if (sy == ey) { // ���
			if (sm == em) { // �µ�
				if (sm < 10) { // sm
					inlist = inlist.append("select * from tb_InList0" + sm + " union all ");
				} else {
					inlist = inlist.append("select * from tb_InList" + sm + " union all ");
				}
			}
			if (sm < em) { // ��ʼ��С�ڽ�����
				for (int i = sm; i <= em; i++) { // sm-em
					if (i < 10) {
						inlist = inlist.append("select * from tb_InList0" + i + " union all ");
					} else {
						inlist = inlist.append("select * from tb_InList" + i + " union all ");
					}
				}
			}
		}
		if (sy < ey) { // ��ʼ��С�ڽ�����
			if (sm > em) { // ��ʼ�´��ڽ�����
				for (int i = sm; i <= 12; i++) { // sm-12
					if (i < 10) {
						inlist = inlist.append("select * from tb_InList0" + i + " union all ");
					} else {
						inlist = inlist.append("select * from tb_InList" + i + " union all ");
					}
				} // +
				for (int i = 1; i <= em; i++) { // 1-em
					if (i < 10) {
						inlist = inlist.append("select * from tb_InList0" + i + " union all ");
					} else {
						inlist = inlist.append("select * from tb_InList" + i + " union all ");
					}
				}
			}
			if (sm <= em) { // ��ʼ��С�ڵ��ڽ�����
				for (int i = 1; i <= 12; i++) { // 1-12
					if (i < 10) {
						inlist = inlist.append("select * from tb_InList0" + i + " union all ");
					} else {
						inlist = inlist.append("select * from tb_InList" + i + " union all ");
					}
				}
			}
		}
		String inlistUnionTable = inlist.substring(0, inlist.length() - 11);
		return inlistUnionTable;
	}

	// ͨ�п�ʹ�÷��˰౨�� ������ѡ�·�ƴ��outlist��sql���
	public String outlistUnionTable(String startTime, String endTime) {
		// ȡ���ڵ��·�ֵ
		String startYear = startTime.substring(0, 4);
		String endYear = endTime.substring(0, 4);
		String startMonth = startTime.substring(5, 7);
		String endMonth = endTime.substring(5, 7);
		int sy = Integer.parseInt(startYear);
		int ey = Integer.parseInt(endYear);
		int sm = Integer.parseInt(startMonth);
		int em = Integer.parseInt(endMonth);
		StringBuffer outlist = new StringBuffer();

		// �ж�ѡ��ʱ�䣬�����ֲ�ͬ���
		if (sy == ey) { // ���
			if (sm == em) { // �µ�
				if (sm < 10) { // sm
					outlist = outlist.append("select * from tb_OutList0" + sm + " union all ");
				} else {
					outlist = outlist.append("select * from tb_OutList" + sm + " union all ");
				}
			}
			if (sm < em) { // ��ʼ��С�ڽ�����
				for (int i = sm; i <= em; i++) { // sm-em
					if (i < 10) {
						outlist = outlist.append("select * from tb_OutList0" + i + " union all ");
					} else {
						outlist = outlist.append("select * from tb_OutList" + i + " union all ");
					}
				}
			}
		}
		if (sy < ey) { // ��ʼ��С�ڽ�����
			if (sm > em) { // ��ʼ�´��ڽ�����
				for (int i = sm; i <= 12; i++) { // sm-12
					if (i < 10) {
						outlist = outlist.append("select * from tb_OutList0" + i + " union all ");
					} else {
						outlist = outlist.append("select * from tb_OutList" + i + " union all ");
					}
				} // +
				for (int i = 1; i <= em; i++) { // 1-em
					if (i < 10) {
						outlist = outlist.append("select * from tb_OutList0" + i + " union all ");
					} else {
						outlist = outlist.append("select * from tb_OutList" + i + " union all ");
					}
				}
			}
			if (sm <= em) { // ��ʼ��С�ڵ��ڽ�����
				for (int i = 1; i <= 12; i++) { // 1-12
					if (i < 10) {
						outlist = outlist.append("select * from tb_OutList0" + i + " union all ");
					} else {
						outlist = outlist.append("select * from tb_OutList" + i + " union all ");
					}
				}
			}
		}

		String outlistUnionTable = outlist.substring(0, outlist.length() - 11);
		// System.out.println(outlistUnionTable);
		return outlistUnionTable;
	}

	// ����ͨ�зѱ���Ĳ�ѯ����
	public int countTollsTradeDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTollsCollectorDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTollsCollectorDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTollsOperSquadDates(String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo) {
		return otherReportDao.countTollsOperSquadDates(startTime, endTime, areaNoValue, parkNoValue, pSquadNo, pOperatorNo);
	}
	
	public int countTollsLane(String startTime, String endTime, int areaNoValue, int parkNoValue, String pLaneNo) {
		return otherReportDao.countTollsLane(startTime, endTime, areaNoValue, parkNoValue, pLaneNo);
	}

	public int countTollsDayStatistics(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTollsDayStatistics(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTollsGateLaneDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTollsGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTollsTradeMonth(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countPayCardTrade(String startTime, String endTime, String tradeType0, String tradeType1, String tradeType2, String tradeType3, String tradeType4, Integer accountNo, String userName, String vehPlate, String cardNo, String credentialsNo, Integer status) {
		return otherReportDao.countPayCardTrade(startTime, endTime, tradeType0, tradeType1, tradeType2, tradeType3, tradeType4, accountNo, userName, vehPlate, cardNo, credentialsNo, status);
	}

	public int countPrintBill(String startTime, String endTime, String tradeType0, String tradeType1) {
		return otherReportDao.countPrintBill(startTime, endTime, tradeType0, tradeType1);
	}	

	// ���㳵��������Ĳ�ѯ����
	public int countTrafficFlowStatistics(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTrafficFlowStatistics(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTrafficFlowOperSquadDates(String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo) {
		return otherReportDao.countTrafficFlowOperSquadDates(startTime, endTime, areaNoValue, parkNoValue, pSquadNo, pOperatorNo);
	}

	public int countTrafficFlowDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTrafficFlowDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTrafficFlowGateLaneDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTrafficFlowGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTrafficFlowMonth(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTrafficFlowMonth(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTrafficFlowTollsDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countTrafficFlowTollsDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	// ���㿨��Ϣ����Ĳ�ѯ����
	public int countCardInfo(String startTime, String endTime) {
		return otherReportDao.countCardInfo(startTime, endTime);
	}

	public int countCardDynamic() {
		return otherReportDao.countCardDynamic();
	}

	public int countCarMonthBill(String startTime, String endTime) {
		return otherReportDao.countCarMonthBill(startTime, endTime);
	}

	public int countCarMonthBillDay(String startTime, String endTime) {
		return otherReportDao.countCarMonthBillDay(startTime, endTime);
	}

	public int countCarMonthBillDayType(String startTime, String endTime) {
		return otherReportDao.countCarMonthBillDayType(startTime, endTime);
	}
	
	public int countCarMonthParking(String startTime, String endTime) {
		return otherReportDao.countCarMonthParking(startTime, endTime);
	}

	// ����ͨ�п�����Ĳ�ѯ����
	public int countPassCardHandOutIn(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return otherReportDao.countPassCardHandOutIn(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countPassCardUsedOperSquad(String startTime, String endTime, int areaNoValue, int parkNoValue, String inlistUnionTable, String outlistUnionTable) {
		return otherReportDao.countPassCardUsedOperSquad(startTime, endTime, areaNoValue, parkNoValue, inlistUnionTable, outlistUnionTable);
	}

	public OtherReportDao getOtherReportDao() {
		return otherReportDao;
	}
	
	//ͨ����������ȡ ����  ����
	public List<LaneInformation> getLaneInformationByLaneNo(String laneNo) {
		return getOtherReportDao().getLaneInformationByLaneNo(laneNo);
	}
	
}
