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

import com.hgsoft.dao.ReportDao;
import com.hgsoft.entity.LaneInformation;
import com.hgsoft.entity.ParkInformation;

/**
 * 报表Service
 * 
 * @author caijunhua
 * 
 */
@Service
public class ReportService {
	@Resource
	private ReportDao reportDao;

	/**
	 * 通行费日报表 通行费日收费员报表 通行费月报表 卡详细信息报表 月保车缴费记录报表 按统计时间范围生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public JasperPrint fillReport(String sourceFile, String startTime, String endTime, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 通行费日报表 通行费日收费员报表 通行费月报表 卡详细信息报表 月保车缴费记录报表 按统计时间范围生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @throws JRException
	 */
	public void pdfStreamFormate(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * 通行费日统计报表 通行费分门分车道日报表 重载：生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public JasperPrint tollsFillReport(String sourceFile, String startTime, String endTime, int areaNoValue, int parkNoValue, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("creator", creator);
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 通行费日统计报表 通行费分门分车道日报表 重载：生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public void tollsPdfStream(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, int areaNoValue, int parkNoValue, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("creator", creator);
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * 通行费 和 车流量 分人班分时段报表重载：按统计工班号,操作员号,生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param pSquadNo
	 *            工班号
	 * @param pOperatorNo
	 *            操作员号
	 * @param creator
	 *            制表人
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
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 通行费 和 车流量分人班分时段报表重载：按统计工班号,操作员号,生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param pSquadNo
	 *            工班号
	 * @param pOperatorNo
	 *            操作员号
	 * @param creator
	 *            制表人
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
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}
	
	/**
	 * 通行费  分车道分时段报表重载：按统计车道号,生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param pLaneNo
	 *            车道号
	 * @param creator
	 *            制表人
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
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 通行费 分车道分时段报表重载：按统计车道号,生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param pLaneNo
	 *            车道号
	 * @param creator
	 *            制表人
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
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * 缴费卡交易记录报表重载：按统计时间范围,交易类型,生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param tradeType0
	 *            消费
	 * @param tradeType1
	 *            充值
	 * @param tradeType2
	 *            冲正
	 * @param tradeType3
	 *            销户
	 * @param tradeType4
	 *            其他
	 * @param creator
	 *            制表人
	 * @param accountNo
	 *            用户账号
	 * @param userName
	 *            用户名
	 * @param vehPlate
	 *            车牌号
	 * @param cardNo
	 *            卡号
	 * @param credentialsNo
	 *            证件号码
	 * @param status
	 *            账户状态
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
		// 组合条件
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
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 缴费卡交易记录报表重载：按统计时间范围,交易类型,生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param tradeType0
	 *            消费
	 * @param tradeType1
	 *            充值
	 * @param tradeType2
	 *            冲正
	 * @param tradeType3
	 *            销户
	 * @param tradeType4
	 *            其他
	 * @param creator
	 *            制表人
	 * @param accountNo
	 *            用户账号
	 * @param userName
	 *            用户名
	 * @param vehPlate
	 *            车牌号
	 * @param cardNo
	 *            卡号
	 * @param credentialsNo
	 *            证件号码
	 * @param status
	 *            账户状态
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
		// 组合条件
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

		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * 打印账单报表重载：按统计时间范围,交易类型,生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param tradeType0
	 *            消费
	 * @param tradeType1
	 *            充值
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public JasperPrint fillReport(String sourceFile, String startTime, String endTime, String tradeType0, String tradeType1, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("tradeType0", tradeType0);
		parameters.put("tradeType1", tradeType1);
		parameters.put("creator", creator);
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 打印账单报表重载：按统计时间范围,交易类型,生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param tradeType0
	 *            消费
	 * @param tradeType1
	 *            充值
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public void pdfStreamFormate(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, String tradeType0, String tradeType1, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		parameters.put("tradeType0", tradeType0);
		parameters.put("tradeType1", tradeType1);
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * 车流量 按统计时间范围生成Stream形式的HTML格式的报表 通行卡领卡交卡登记报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public JasperPrint trafficFlowFillReport(String sourceFile, String startTime, String endTime, int areaNoValue, int parkNoValue, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("creator", creator);
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 车流量 按统计时间范围生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public void trafficFlowPdfStream(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, int areaNoValue, int parkNoValue, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("creator", creator);
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * 临时卡动态报表 按统计时间范围生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public JasperPrint fillReport(String sourceFile, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("creator", creator);
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 临时卡动态报表 按统计时间范围生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @throws JRException
	 */
	public void pdfStreamFormate(InputStream inputStream, OutputStream outputStream, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("creator", creator);
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * 通行卡使用分人班报表 生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param inlistUnionTable
	 *            入口流水拼接sql
	 * @param outlistUnionTable
	 *            出口流水拼接sql
	 * @param creator
	 *            制表人
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
		return this.reportDao.fillReport(sourceFile, parameters);
	}

	/**
	 * 通行卡使用分人班报表 生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param inlistUnionTable
	 *            入口流水拼接sql
	 * @param outlistUnionTable
	 *            出口流水拼接sql
	 * @param creator
	 *            制表人
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
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	/**
	 * 按统计时间范围生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 * @param outStream
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @throws JRException
	 */
	public String pdfOrHtmlFormat(String sourceFile, String startTime, String endTime, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		return this.reportDao.pdfOrHtmlFormat(sourceFile, parameters, 1);
	}
	
	/**
	 * 通行费 应收现金分人班分时段报表重载：按统计工班号,操作员号,生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param pSquadNo
	 *            工班号
	 * @param pOperatorNo
	 *            操作员号
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public JasperPrint cashMoneyOperSquadDatesFillReport(String sourceFile, String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("pSquadNo", pSquadNo);
		parameters.put("pOperatorNo", pOperatorNo);
		parameters.put("creator", creator);
		return this.reportDao.fillReport(sourceFile, parameters);
	}
	/**
	 * 通行费 应收现金分人班分时段报表重载：按统计工班号,操作员号,生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param areaNoValue
	 *            区域编号
	 * @param parkNoValue
	 *            小区编号
	 * @param pSquadNo
	 *            工班号
	 * @param pOperatorNo
	 *            操作员号
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public void cashMoneyOperSquadDatesPdfStream(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo, String creator) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("areaNoValue", areaNoValue);
		parameters.put("parkNoValue", parkNoValue);
		parameters.put("pSquadNo", pSquadNo);
		parameters.put("pOperatorNo", pOperatorNo);
		parameters.put("creator", creator);
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}

	// 通行卡使用分人班报表 根据所选月份拼接inlist的sql语句
	public String inlistUnionTable(String startTime, String endTime) {
		// 取日期的月份值
		String startYear = startTime.substring(0, 4);
		String endYear = endTime.substring(0, 4);
		String startMonth = startTime.substring(5, 7);
		String endMonth = endTime.substring(5, 7);

		int sy = Integer.parseInt(startYear);
		int ey = Integer.parseInt(endYear);
		int sm = Integer.parseInt(startMonth);
		int em = Integer.parseInt(endMonth);
		StringBuffer inlist = new StringBuffer();
		// 判断选择时间，共四种不同情况
		if (sy == ey) { // 年等
			if (sm == em) { // 月等
				if (sm < 10) { // sm
					inlist = inlist.append("select * from tb_InList0" + sm + " union all ");
				} else {
					inlist = inlist.append("select * from tb_InList" + sm + " union all ");
				}
			}
			if (sm < em) { // 开始月小于结束月
				for (int i = sm; i <= em; i++) { // sm-em
					if (i < 10) {
						inlist = inlist.append("select * from tb_InList0" + i + " union all ");
					} else {
						inlist = inlist.append("select * from tb_InList" + i + " union all ");
					}
				}
			}
		}
		if (sy < ey) { // 开始年小于结束年
			if (sm > em) { // 开始月大于结束月
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
			if (sm <= em) { // 开始月小于等于结束月
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

	// 通行卡使用分人班报表 根据所选月份拼接outlist的sql语句
	public String outlistUnionTable(String startTime, String endTime) {
		// 取日期的月份值
		String startYear = startTime.substring(0, 4);
		String endYear = endTime.substring(0, 4);
		String startMonth = startTime.substring(5, 7);
		String endMonth = endTime.substring(5, 7);
		int sy = Integer.parseInt(startYear);
		int ey = Integer.parseInt(endYear);
		int sm = Integer.parseInt(startMonth);
		int em = Integer.parseInt(endMonth);
		StringBuffer outlist = new StringBuffer();

		// 判断选择时间，共四种不同情况
		if (sy == ey) { // 年等
			if (sm == em) { // 月等
				if (sm < 10) { // sm
					outlist = outlist.append("select * from tb_OutList0" + sm + " union all ");
				} else {
					outlist = outlist.append("select * from tb_OutList" + sm + " union all ");
				}
			}
			if (sm < em) { // 开始月小于结束月
				for (int i = sm; i <= em; i++) { // sm-em
					if (i < 10) {
						outlist = outlist.append("select * from tb_OutList0" + i + " union all ");
					} else {
						outlist = outlist.append("select * from tb_OutList" + i + " union all ");
					}
				}
			}
		}
		if (sy < ey) { // 开始年小于结束年
			if (sm > em) { // 开始月大于结束月
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
			if (sm <= em) { // 开始月小于等于结束月
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

	// 计算通行费报表的查询条数
	public int countTollsTradeDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTollsCollectorDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTollsCollectorDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTollsOperSquadDates(String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo) {
		return reportDao.countTollsOperSquadDates(startTime, endTime, areaNoValue, parkNoValue, pSquadNo, pOperatorNo);
	}
	
	public int countTollsLane(String startTime, String endTime, int areaNoValue, int parkNoValue, String pLaneNo) {
		return reportDao.countTollsLane(startTime, endTime, areaNoValue, parkNoValue, pLaneNo);
	}

	public int countTollsDayStatistics(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTollsDayStatistics(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTollsGateLaneDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTollsGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTollsTradeMonth(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countPayCardTrade(String startTime, String endTime, String tradeType0, String tradeType1, String tradeType2, String tradeType3, String tradeType4, Integer accountNo, String userName, String vehPlate, String cardNo, String credentialsNo, Integer status) {
		return reportDao.countPayCardTrade(startTime, endTime, tradeType0, tradeType1, tradeType2, tradeType3, tradeType4, accountNo, userName, vehPlate, cardNo, credentialsNo, status);
	}

	public int countPrintBill(String startTime, String endTime, String tradeType0, String tradeType1) {
		return reportDao.countPrintBill(startTime, endTime, tradeType0, tradeType1);
	}

	// 计算车流量报表的查询条数
	public int countTrafficFlowStatistics(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTrafficFlowStatistics(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTrafficFlowOperSquadDates(String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo) {
		return reportDao.countTrafficFlowOperSquadDates(startTime, endTime, areaNoValue, parkNoValue, pSquadNo, pOperatorNo);
	}

	public int countTrafficFlowDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTrafficFlowDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTrafficFlowGateLaneDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTrafficFlowGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTrafficFlowMonth(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTrafficFlowMonth(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countTrafficFlowTollsDay(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countTrafficFlowTollsDay(startTime, endTime, areaNoValue, parkNoValue);
	}

	// 计算卡信息报表的查询条数
	public int countCardInfo(String startTime, String endTime) {
		return reportDao.countCardInfo(startTime, endTime);
	}

	public int countCardDynamic() {
		return reportDao.countCardDynamic();
	}

	public int countCarMonthBill(String startTime, String endTime) {
		return reportDao.countCarMonthBill(startTime, endTime);
	}

	public int countCarMonthBillDay(String startTime, String endTime) {
		return reportDao.countCarMonthBillDay(startTime, endTime);
	}

	public int countCarMonthBillDayType(String startTime, String endTime) {
		return reportDao.countCarMonthBillDayType(startTime, endTime);
	}
	
	public int countCarMonthParking(String startTime, String endTime) {
		return reportDao.countCarMonthParking(startTime, endTime);
	}

	// 计算通行卡报表的查询条数
	public int countPassCardHandOutIn(String startTime, String endTime, int areaNoValue, int parkNoValue) {
		return reportDao.countPassCardHandOutIn(startTime, endTime, areaNoValue, parkNoValue);
	}

	public int countPassCardUsedOperSquad(String startTime, String endTime, int areaNoValue, int parkNoValue, String inlistUnionTable, String outlistUnionTable) {
		return reportDao.countPassCardUsedOperSquad(startTime, endTime, areaNoValue, parkNoValue, inlistUnionTable, outlistUnionTable);
	}

	public ReportDao getReportDao() {
		return reportDao;
	}
	
	//通过车道类型取 出口  车道
	public List<LaneInformation> getLaneInformationByLaneNo(String laneNo) {
		return getReportDao().getLaneInformationByLaneNo(laneNo);
	}
	
	//取所有小区信息
	public List<ParkInformation> getAllParkInformation() {
		return getReportDao().getAllParkInformation();
	}
	
	public int countTollsCashMoneyOperSquadDates(String startTime, String endTime, int areaNoValue, int parkNoValue, String pSquadNo, String pOperatorNo) {
		return reportDao.countTollsCashMoneyOperSquadDates(startTime, endTime, areaNoValue, parkNoValue, pSquadNo, pOperatorNo);
	}
	
	
	// 根据车辆类型计算卡信息报表的查询条数
	public int countCardInfoInCartype(String startTime, String endTime, Integer carType, String parkingSpace) {
		return reportDao.countCardInfoInCarType(startTime, endTime, carType, parkingSpace);
	}
		
	/**
	 * 打印卡信息报表重载：按统计时间范围,车辆类型,生成Stream形式的HTML格式的报表
	 * 
	 * @param sourceFile
	 *            输入源文件
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param carType
	 *            车辆类型
	 * @param parkingSpace
	 *            停车位
	 * @param creator
	 *            制表人
	 * @throws JRException
	 */
	public JasperPrint fillReport(String sourceFile, String startTime, String endTime,String creator, Integer carType, String parkingSpace, String carTypeName) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		
		//parameters.put("carType", carType);
		//parameters.put("parkingSpace", parkingSpace);
		StringBuffer sb = new StringBuffer();
		if(carType!=null && !carType.equals("")){
			sb.append(" and carType=").append(carType);
			if(parkingSpace!=null && !parkingSpace.equals("")){
				sb.append(" and parkingSpace='").append(parkingSpace).append("' ");
			}
			parameters.put("condition", sb.toString());
			parameters.put("cTypeName", carTypeName);
		}else{
			parameters.put("cTypeName", "全部");
			parameters.put("condition", "");
		}
		return this.reportDao.fillReport(sourceFile, parameters);
	}
	
	/**
	 * 卡详细信息报表 按统计时间范围,车辆类型生成Stream形式的PDF格式的报表
	 * 
	 * @param inputStream
	 *            输入流
	 * @param outStream
	 *            输出流
	 * @param startTime
	 *            查询开始时间
	 * @param endTime
	 *            结束时间
	 * @param carType
	 *            车辆类型
	 * @param parkingSpace
	 *            停车位
	 * @param creator
	 *            制表人        
	 * @throws JRException
	 */
	public void pdfStreamFormate(InputStream inputStream, OutputStream outputStream, String startTime, String endTime, String creator, Integer carType, String parkingSpace, String carTypeName) throws JRException {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("startTime", startTime);
		parameters.put("endTime", endTime);
		parameters.put("creator", creator);
		StringBuffer sb = new StringBuffer();
		if(carType!=null && !carType.equals("")){
			sb.append(" and carType=").append(carType);
			if(parkingSpace!=null && !parkingSpace.equals("")){
				sb.append(" and parkingSpace='").append(parkingSpace).append("' ");
			}
			parameters.put("condition", sb.toString());
			parameters.put("cTypeName", carTypeName);
		}else{
			parameters.put("cTypeName", "全部");
			parameters.put("condition", "");
		}
		this.reportDao.PdfStreamFormate(inputStream, outputStream, parameters, 1);
	}
		
}
