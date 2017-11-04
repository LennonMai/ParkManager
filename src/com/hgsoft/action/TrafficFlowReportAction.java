package com.hgsoft.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.SystemLog;
import com.hgsoft.service.OperatorService;
import com.hgsoft.service.ReportService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date October 27, 2010
 * @Description 车流量报表控制器
 */

@Controller
@Scope("prototype")
public class TrafficFlowReportAction extends BaseAction {
	@Resource
	private ReportService reportService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private OperatorService operatorService;
	@Resource
	private SquadInformationService squadInformationService;
	
	private SystemLog systemlog;
	private Admin admin;
	private Sysparamconf setAreaNo;
	private Sysparamconf setParkNo;
	private String startTime;
	private String endTime;
	private String pSquadNo;
	private String pOperatorNo;
	private String jasper;
	private String jasperPDF;
	
	@SuppressWarnings("unchecked")
	private List squadList;
	@SuppressWarnings("unchecked")
	public List getSquadList() {
		return squadList;
	}
	
	public String getStartTime() {
		return startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public void setPSquadNo(String squadNo) {
		pSquadNo = squadNo;
	}
	public void setPOperatorNo(String operatorNo) {
		pOperatorNo = operatorNo;
	}
	public void setJasper(String jasper) {
		this.jasper = jasper;
	}
	public void setJasperPDF(String jasperPDF) {
		this.jasperPDF = jasperPDF;
	}
	
	/**
	 * 转向车流量统计报表编辑页面
	 * @return
	 */
	public String trafficFlowStatistics(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowStatistics";
	}
	/**
	 * 转向车流量统计报表编辑页面
	 * @return
	 */
	public String trafficFlowOperSquadDates(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		list = operatorService.getAllOperator();
		squadList = squadInformationService.getAllSquadInformation();
		return "trafficFlowOperSquadDates";
	}
	/**
	 * 转向车流量日报表编辑页面
	 * @return
	 */
	public String trafficFlowDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowDay";
	}
	/**
	 * 转向车流量日报表编辑页面
	 * @return
	 */
	public String trafficFlowGateLaneDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowGateLaneDay";
	}
	/**
	 * 转向车流量月报表编辑页面
	 * @return
	 */
	public String trafficFlowMonth(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowMonth";
	}
	/**
	 * 转向车流通行费日报表编辑页面
	 * @return
	 */
	public String trafficFlowTollsDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowTollsDay";
	}
	
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
	
	/**
	 * HTML格式车流量统计报表
	 * @return
	 */
	public String trafficFlowStatisticsReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countTrafficFlowStatistics(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML格式车流量统计报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
	    
			JasperPrint print = this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// 是否去除行间的空白
	        //exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML, "");//处理分页用的
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 是否输出图片到行
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 输出引擎是否用小图片矫正
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// 输出引擎是否强制包装异常文字
	        
	        //打印分页
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

	        exporter.exportReport();
	        
	        //插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式车流量统计报表",
					"报表管理--车流量报表--车流量统计报表", "tb_InListSum和tb_OutListSum");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量统计报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量统计报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量统计报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式车流量统计报表
	 * @return
	 */
	public String trafficFlowStatisticsReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTrafficFlowStatistics(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式车流量统计报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowStatisticsReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量统计报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量统计报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量统计报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式车流量分人班分时段报表
	 * @return
	 */
	public String trafficFlowOperSquadDatesReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
		    int count = reportService.countTrafficFlowOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 10000) {
		    	message = "生成HTML车流量分人班分时段报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    
			JasperPrint print=this.reportService.operSquadDatesFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, pSquadNo, pOperatorNo, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

			exporter.exportReport();
			
			//插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式车流量分人班分时段报表",
					"报表管理--车流量报表--车流量分人班分时段报表", "tb_InListSum和tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量分人班分时段报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量分人班分时段报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量分人班分时段报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式车流量分人班分时段报表
	 * @return
	 */
	public String trafficFlowOperSquadDatesReportPDF() {
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 20000) {
		    	message = "生成PDF车流量分人班分时段报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowOperSquadDatesReportPDF.pdf");
			
			this.reportService.operSquadDatesPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, pSquadNo, pOperatorNo, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量分人班分时段报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量分人班分时段报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量分人班分时段报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}/*finally {
			if(outputStream == null) {
				try {
					outputStream.flush();
					outputStream.close();
				} catch (IOException e) {
//					String simplename = e.getClass().getSimpleName();
//					if(!"ClientAbortException".equals(simplename)){
						e.printStackTrace();
//					}
				}
			}
		}*/
		return null;
	}
	
	/**
	 * HTML格式车流量日报表
	 * @return
	 */
	public String trafficFlowDayReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
			int count = reportService.countTrafficFlowDay(startTime, endTime, areaNoValue, parkNoValue);
			if(count > 10000) {
				message = "生成HTML格式车流量日报表数据量过大，已超过10000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			JasperPrint print=this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
					//exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML, "");//处理分页用的
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
			exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
					BETWEEN_PAGES_HTML);
			
			exporter.exportReport();
			
			//插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式车流量日报表",
					"报表管理--车流量报表--车流量日报表", "tb_InListSum和tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式车流量日报表
	 * @return
	 */
	public String trafficFlowDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTrafficFlowDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式车流量日报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowDayReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式车流量分门分车道报表
	 * @return
	 */
	public String trafficFlowGateLaneDayReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
			int count = reportService.countTrafficFlowGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
			if(count > 10000) {
				message = "生成HTML格式车流量分门分车道报表数据量过大，已超过10000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			JasperPrint print=this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
					//exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML, "");//处理分页用的
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
			exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
					BETWEEN_PAGES_HTML);
			
			exporter.exportReport();
			
			//插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式车流量分门分车道报表",
					"报表管理--车流量报表--车流量分门分车道报表", "tb_InListSum和tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量分门分车道报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量分门分车道报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量分门分车道报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式车流量分门分车道报表
	 * @return
	 */
	public String trafficFlowGateLaneDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTrafficFlowGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式车流量分门分车道报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowGateLaneDayReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量分门分车道报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量分门分车道报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量分门分车道报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式车流量月报表
	 * @return
	 */
	public String trafficFlowMonthReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countTrafficFlowMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML格式车流量月报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			JasperPrint print=this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// 是否去除行间的空白
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 是否输出图片到行
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 输出引擎是否用小图片矫正
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// 输出引擎是否强制包装异常文字
	        
	        //打印分页
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

	        exporter.exportReport();
	        
	        //插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式车流量月报表",
					"报表管理--车流量报表--车流量月报表", "tb_InListSum和tb_OutListSum");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量月报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量月报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流量月报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式车流量月报表
	 * @return
	 */
	public String trafficFlowMonthReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTrafficFlowMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式车流量月报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowMonthReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量月报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量月报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流量月报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式车流通行费日报表
	 * @return
	 */
	public String trafficFlowTollsDayReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
			int count = reportService.countTrafficFlowTollsDay(startTime, endTime, areaNoValue, parkNoValue);
			if(count > 10000) {
				message = "生成HTML格式车流通行费日报表数据量过大，已超过10000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			JasperPrint print=this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
							Boolean.TRUE);// 输出引擎是否强制包装异常文字
					
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
			exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
							BETWEEN_PAGES_HTML);
					
			exporter.exportReport();
			
			//插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式车流通行费日报表",
					"报表管理--车流量报表--车流通行费日报表", "tb_InListSum和tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流通行费日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流通行费日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式车流通行费日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式车流通行费日报表
	 * @return
	 */
	public String trafficFlowTollsDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
			int count = reportService.countTrafficFlowTollsDay(startTime, endTime, areaNoValue, parkNoValue);
			if(count > 20000) {
				message = "生成PDF格式车流通行费日报表数据量过大，已超过20000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowTollsDayReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流通行费日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流通行费日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式车流通行费日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	// Getters/Setters方法
	public SystemLog getSystemlog() {
		return systemlog;
	}
	public void setSystemlog(SystemLog systemlog) {
		this.systemlog = systemlog;
	}
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

}
