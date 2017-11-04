package com.hgsoft.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Account;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.InList;
import com.hgsoft.entity.OutList;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.SystemLog;
import com.hgsoft.entity.User;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.InListService;
import com.hgsoft.service.OutListService;
import com.hgsoft.service.ReportService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.util.ExcelUtil;
import com.hgsoft.util.ExcelWorkSheet;
/**
 * @author caijunhua
 * @date July 22, 2010
 * @Description 报表控制器
 */
@Controller
@Scope("prototype")
public class ReportAction extends BaseAction {
	@Resource
	private ReportService reportService;
	@Resource
	private InListService inListService;
	@Resource
	private OutListService outListService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private AdminService adminService;
	@Resource
	private SysparamconfService sysparamconfService;
	
	private InList inlist;
	private OutList outlist;
	private SystemLog systemlog;
	private Admin admin;
	private User user;
	private Account account;
	private Car car;
	private Sysparamconf setAreaNo;
	private Sysparamconf setParkNo;
	
	private String startTime;
	private String endTime;
	private String tradeType;
	private String jasper;
	private String jasperPDF;
	private Date startTime1;

	private Date delStartTime;
	private Date delEndTime;
	@SuppressWarnings("unchecked")
	private List adminList;
	
	
	private String importExcelProcess;
	
	//日志导出时间范围
	private Date data_startTime;
	private Date data_endTime;
	private Date endTime1;
	
	//导入的excel文件总行数
	private String rowsNum;

	private String excelFormat;
	private Integer startFailRefleshNum;	
	//上传的文件
	private File excelFile;
	//保存原始的文件名
	private String excelFileFileName;
	//将Excel文件解析完毕后，信息存放到这个对象中
	private ExcelWorkSheet<SystemLog> excelWorkSheet;
	
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	/**
	 * 转向通行费日报表编辑页面
	 * @return
	 */
	public String tollsTradeDay(){
		return "tollsTradeDay";
	}
	/**
	 * 转向通行费月报表编辑页面
	 * @return
	 */
	public String tollsTradeMonth(){
		return "tollsTradeMonth";
	}
	/**
	 * 转向车流量日报表编辑页面
	 * @return
	 */
	public String trafficFlowDay(){
		return "trafficFlowDay";
	}
	/**
	 * 转向车流量月报表编辑页面
	 * @return
	 */
	public String trafficFlowMonth(){
		return "trafficFlowMonth";
	}
	/**
	 * 转向缴费卡交易记录报表编辑页面
	 * @return
	 */
	public String payCardTrade(){
		return "payCardTrade";
	}
	/**
	 * 打印账单报表编辑页面
	 * @return
	 */
	public String printBill(){
		return "printBill";
	}
	/**
	 * 入口流水记录查询页面
	 * @return
	 */
	public String inList(){
		return "inList";
	}
	/**
	 * 出口流水记录查询页面
	 * @return
	 */
	public String outList(){
		return "outList";
	}
	/**
	 * 系统日志查询页面
	 * @return
	 */
	public String systemLog(){
		adminList = adminService.findAll();
		list = systemLogService.findByPager(pager);
		
		return "systemLog";
	}
	/**
	 * 月保车缴费记录查询页面
	 * @return
	 */
	public String carMonthBill(){
		//list = systemLogService.findByPager(pager);
		return "carMonthBill";
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
	 * HTML格式通行费日报表
	 * @return
	 */
	public String tollsTradeDayReport(){
		try {
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
	//		String jasper1 = ServletActionContext.getRequest().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML格式通行费日报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			JasperPrint print=this.reportService.tollsFillReport(jasper1, startTime, endTime,
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
	        
	        //exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT, "pt");//解决生成HTML报表缩小问题，但打印会变大
	        //pt 点数 (Typeface Point=1/72in) 打印的点数大小。 px 像数 (pixel) 在屏幕上显示的单位。
	        
	        //打印分页
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        exporter.exportReport();
		} catch (JRException e) {		
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
//	第二种方法：通过文件方式（有可能出现文件读取冲突问题）
//	@SuppressWarnings("deprecation")
//	public String tollsTradeDayReport(){
//		HttpServletRequest request = ServletActionContext.getRequest();
//		HttpServletResponse response = ServletActionContext.getResponse();
//		String jasper1 = request.getRealPath(jasper);
//		//String jasper1 = request.getRealPath("/WEB-INF/jsp/report/jasper/tollsTradeDayReport.jasper");
//		//String html="/"+System.currentTimeMillis()+".html";
//		try {
//			String destFile = this.reportService.pdfOrHtmlFormat(jasper1, startTime, endTime, operator.getName());
//			//this.reportService.pdfOrHtmlFormat(jasper1, request.getRealPath(html), startTime, endTime, operator.getName());
//			response..sendRedirect(destFile);
//		} catch (JRException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return null;
//	}
	/**
	 * PDF格式通行费日报表
	 * @return
	 */
	public String tollsTradeDayReportPDF(){
		try{	
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式通行费日报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename=report_tollsTradeDayReportPDF.pdf");
			//ServletActionContext.getResponse().setHeader("Content-Disposition", "inline;filename=report_tollsTradeDayReportPDF.pdf");
			
			//按照以下设置IE浏览器一定可以下载到pdf文件
			/*response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");   
	        response.setHeader("Pragma", "public");     
	        response.setContentType("APPLICATION/OCTET-STREAM;charset=GBK");  
	        response.setContentType("application/x-msdownload");  
	        response.setCharacterEncoding("GBK"); */
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式通行费月报表
	 * @return
	 */
	public String tollsTradeMonthReport(){
		try {
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML格式通行费月报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
	    
			JasperPrint print=this.reportService.tollsFillReport(jasper1, startTime, endTime,
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
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费月报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费月报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费月报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式通行费月报表
	 * @return
	 */
	public String tollsTradeMonthReportPDF(){
		try{
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式通行费月报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename="+"report_tollsTradeMonthReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费月报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费月报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费月报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式车流量日报表
	 * @return
	 */
	public String trafficFlowDayReport(){
		try {
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
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
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTrafficFlowDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式车流量日报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename="+"report_trafficFlowDayReportPDF.pdf");
			
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
		}/*finally {
			if(outputStream == null) {
				try {
					outputStream.flush();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}*/
		return null;
	}
	
	/**
	 * HTML格式车流量月报表
	 * @return
	 */
	public String trafficFlowMonthReport(){
		try {
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
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
		
			JasperPrint print=this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			
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
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTrafficFlowMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式车流量月报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"report_trafficFlowMonthReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
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
		}/*finally {
			if(outputStream == null) {
				try {
					outputStream.flush();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}*/
		return null;
	}
	
	/**
	 * HTML格式缴费卡交易报表
	 * @return
	 */
	public String payCardTradeReport(){
		try {
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//取出如0,1,2,3,4的各值
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			String tradeType2 = ids[2];
			String tradeType3 = ids[3];
			String tradeType4 = ids[4];
			
			//计算生成的报表记录条数
		    int count = reportService.countPayCardTrade(startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
		    if(count > 10000) {
		    	message = "生成HTML格式缴费卡交易报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			JasperPrint print=this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", tradeType0, tradeType1, 
					tradeType2, tradeType3, tradeType4, getCurrentOperator().getName(), account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
			
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
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式缴费卡交易报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式缴费卡交易报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式缴费卡交易报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式缴费卡交易报表
	 * @return
	 */
	public String payCardTradeReportPDF(){
		try{
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);	
			//取出如0,1,2,3,4的各值
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			String tradeType2 = ids[2];
			String tradeType3 = ids[3];
			String tradeType4 = ids[4];
			//OutputStream outputStream = null;
			
			//计算生成的报表记录条数
		    int count = reportService.countPayCardTrade(startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
		    //System.out.println("count:"+count);
		    if(count > 20000) {
		    	message = "生成PDF格式缴费卡交易报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"report_payCardTradeReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, getCurrentOperator().getName(), account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式缴费卡交易报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式缴费卡交易报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式缴费卡交易报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}/*finally {
			if(outputStream == null) {
				try {
					outputStream.flush();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}*/
		return null;
	}
	
	/**
	 * HTML格式打印账单报表
	 * @return
	 */
	public String printBillReport(){
		try {
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//取出如0,1,2,3,4的各值
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			
			//计算生成的报表记录条数
		    int count = reportService.countPrintBill(startTime, endTime + " 23:59:59", tradeType0, tradeType1);
		    if(count > 10000) {
		    	message = "生成HTML打印账单报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			JasperPrint print=this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", tradeType0, tradeType1, getCurrentOperator().getName());
			
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
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式打印账单报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式打印账单报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式打印账单报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式打印账单报表
	 * @return
	 */
	public String printBillReportPDF(){
		try{
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			//取出如0,1,2,3,4的各值
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			
			//计算生成的报表记录条数
		    int count = reportService.countPrintBill(startTime, endTime + " 23:59:59", tradeType0, tradeType1);
		    if(count > 20000) {
		    	message = "生成PDF打印账单报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"report_printBillReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", tradeType0, tradeType1, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式打印账单报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式打印账单报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式打印账单报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
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
	 * 入口流水记录查询
	 * @return
	 */
	public String queryInList(){
//		System.out.println("queryOutList:" + inlist.getCardNo() + "|" + inlist.getVehPlate() + "|" + inlist.getListNo() + "|" + inlist.getVehClass() + "|" + startTime1 + "|" + endTime1);
		list = inListService.findAllInListByHql(pager, inlist.getCardNo(), inlist.getVehPlate(), inlist.getListNo(), inlist.getVehClass(), startTime1, endTime1);
		return "inList";
	}
	/**
	 * 出口流水记录查询
	 * @return
	 */
	public String queryOutList(){
//		System.out.println("queryOutList:" + outlist.getCardNo() + "|" + outlist.getVehPlate() + "|" + outlist.getListNo() + "|" + outlist.getVehClass() + "|" + startTime1 + "|" + endTime1);
		list = outListService.findAllOutListByHql(pager, outlist.getCardNo(), outlist.getVehPlate(), outlist.getListNo(), outlist.getVehClass(), startTime1, endTime1);
		return "outList";
	}
	/**
	 * 系统日志查询
	 * @return
	 */
	public String querySystemLog(){
		adminList = adminService.findAll();
		if (systemlog.getLogType() != null
				|| !admin.getUsername().equals("")
				|| !systemlog.getLogData().equals("")
				|| !systemlog.getRemark().equals("")
				|| !systemlog.getCoverage().equals("")
				|| startTime1 != null
				|| endTime1 != null) {	//查询条件不为空
			list = systemLogService.findAllSystemLogByHql(pager, systemlog.getLogType(), admin.getUsername(),
					systemlog.getLogData(), systemlog.getRemark(), systemlog.getCoverage(), startTime1, endTime1);
			return "systemLog";
		} else {
			return systemLog();	//查询条件为空
		}
	}
	
	/**
	 * 日志导出Excel
	 * qinzuohai
	 */
	public String logToExcel()throws ServletException{

	      List<SystemLog> systemlogList= new ArrayList<SystemLog>();
	      systemlogList=systemLogService.findLogByTime(this.getData_startTime(), this.getData_endTime());
	      if(systemlogList.size()<50000){
		      try {
		    	  
		    	  //需要成功获取HttpServletResponse才能成功配置响应头
		    	  HttpServletResponse response = ServletActionContext.getResponse();
		    	  //response.setContentType("application/octets-stream;charset=gb2312");
		    	  response.setContentType("octets/stream");//简单可以设置为信息流
			      response.addHeader("Content-Disposition", "attachment;filename=systemLog.xls");	      
			      //客户端不缓存
			      response.addHeader("Pragma","no-cache");
			      response.addHeader("Cache-Control","no-cache");
			      
			      ExcelUtil<SystemLog> _excelUtil = new ExcelUtil<SystemLog>();
			      String[] headers = { "日志ID","时间", "日志类型", "用户ID", "日志内容", "影响范围", "备注"  };
	              OutputStream out = response.getOutputStream();
	              _excelUtil.exportExcel(headers, systemlogList, out);
	              systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户导出日志到Excel文件成功", "系统日志查询-日志导出到Excel", "systemLog.xls");
	              out.close();
	              //reset()--Clears any data that exists in the buffer as well as the status code and headers. 
	              //If the response has been committed, this method throws an IllegalStateException. 
			      response.reset();
	              //response.resetBuffer();
		      }catch (IOException e) {
		    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将日志导出到Excel时抛出的IO异常", "系统日志查询-日志导出到Excel", "IOException");
				  e.printStackTrace();
		      }
	      }else{
	    	  message="overMaxCount";
	      }

	    return systemLog();
	}

	/**
	 * 导入Excel日志
	 * qinzuohai
	 */
	public String importSystemLog(){
		return "importSystemLog";
	}
	
	/**
	 * 将Excel日志数据导入到数据库
	 */
	//根据文件类型创建工作簿
	public Workbook createWorkBook(InputStream is){
		if(excelFileFileName.toLowerCase().endsWith("xls")){
			try {
				return new HSSFWorkbook(is);
			} catch (IOException e) {
				systemLogService.save(new Date(), 2, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户导入Excel日志数据时创建工作簿IO异常", "系统日志查询-Excel日志数据导入系统", "IOException");
				e.printStackTrace();
			}
		}
		// if(excelFileFileName.toLowerCase().endsWith("xlsx")){
		// try {
		// return new XSSFWorkbook(is);
		// } catch (IOException e) {
		// e.printStackTrace();
		// }
		// }
		return null;
	}
	//判断是否是数字
	public boolean isNumber(String s) {
		String REG_DIGIT="[0-9]*";
		if(s.matches(REG_DIGIT))return true;
		return false;	
	}
	
	//判断是否是0、1、2
	public boolean isNumberOneTwoorThree(String s) {
		int REG_DIGIT=Integer.valueOf(s.trim());
		if(REG_DIGIT==0){
			//System.out.println("0、1、2判断0："+s);
			return true;
		}else if(REG_DIGIT==1){
			//System.out.println("0、1、2判断1："+s);
			return true;
		}else if(REG_DIGIT==2){
			//System.out.println("0、1、2判断2："+s);
			return true;
		}
		else return false;	
	}
	
	//导入
	public String importSystemLogToExcel() throws Exception{
			Workbook workbook=createWorkBook(new FileInputStream(excelFile));
			Sheet sheet=workbook.getSheetAt(0);	
			excelWorkSheet=new ExcelWorkSheet<SystemLog>();
			//保存工作单名称
			excelWorkSheet.setSheetName(sheet.getSheetName());
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			StringBuffer canotUpdateID=new StringBuffer("");
		// 处理第一行(即表头)为空或为数字时的异常
		try {
			Row firstRow = sheet.getRow(0);
			Iterator<Cell> iterator = firstRow.iterator();
			// 保存列名
			List<String> cellNames = new ArrayList<String>();
			while (iterator.hasNext()) {
				cellNames.add(iterator.next().getStringCellValue());
			}
			excelWorkSheet.setColumns(cellNames);
			
		} 
		catch (NullPointerException e) {
			//System.out.println("程序本身设计抛出的表头为空的异常);
			systemLogService.save(new Date(), 2,getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时表头为空的空指针异常", "系统日志查询-Excel日志数据导入系统", "程序设计抛出NullPointerException");
			e.printStackTrace();
		} 
		catch (IllegalStateException e) {
			//System.out.println("程序本身设计抛出的表头为数字的异常);
			systemLogService.save(new Date(), 2, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时表头为数字的异常", "系统日志查询-Excel日志数据导入系统", "程序设计抛出IllegalStateException");
			e.printStackTrace();
		}
		finally{
			for(int i=1;i<=sheet.getLastRowNum();i++){
				Row row=sheet.getRow(i);		
				try {
					//设置0 - 5列都为字符串型	,且这六列都不为空，为空则执行下一循环	
					row.getCell(0).setCellType(1);
					row.getCell(1).setCellType(1);
					row.getCell(2).setCellType(1);
					row.getCell(3).setCellType(1);
					row.getCell(4).setCellType(1);	
					row.getCell(5).setCellType(1);	
				} 
				//当有空指针异常时抛出异常，执行下一循环
				catch (NullPointerException e) {
					//System.out.println("程序本身设计抛出的异常 ******"+i);
					e.printStackTrace();
				    continue;
				}
				//当备注为空时，则创建并赋null值,重新做此次循环
				try {
					row.getCell(6).setCellType(1);
				} catch (NullPointerException e) {
					//System.out.println("程序本身设计抛出的异常 ******");
					e.printStackTrace();
					row.createCell(6).setCellValue("null");
					i=i-1;
					continue;
				}
				
				SystemLog systemLog=new SystemLog();
				//sys_id系统日志ID不为空且是数字时set,否则执行下一循环
				if(!row.getCell(0).getStringCellValue().equals("")&&isNumber(row.getCell(0).getStringCellValue())){						
					systemLog.setSys_id(Integer.valueOf(row.getCell(0).getStringCellValue()));
					
				}else continue;
				
				//logTime日志时间不为空时set,,否则执行下一循环
				if(!row.getCell(1).getStringCellValue().equals("")){
					Date date=dateFormat.parse(row.getCell(1).getStringCellValue().trim());
					systemLog.setLogTime(date);
					
				}else continue;
				
				//logType日志类型不为空且是为0、1、2时set,否则执行下一循环
				if(!row.getCell(2).getStringCellValue().equals("")&&isNumber(row.getCell(2).getStringCellValue())&&isNumberOneTwoorThree(row.getCell(2).getStringCellValue())){					
					systemLog.setLogType(Integer.valueOf(row.getCell(2).getStringCellValue().trim()));
				
				}else continue;
				
				//Admin系统操作员不为空时set
				if(!row.getCell(3).getStringCellValue().equals("")){
					systemLog.setOperatorID(Integer.valueOf(row.getCell(3).getStringCellValue().trim()));
					
				}else continue;
				
				//logData日志具体内容不为空set
				if(!row.getCell(4).getStringCellValue().equals("")){
					systemLog.setLogData(row.getCell(4).getStringCellValue());
					
				}else continue;
				
				//coverage日志影响范围日志内容不为空set
				systemLog.setCoverage(row.getCell(5).getStringCellValue());
				
				//remark备注
				systemLog.setRemark(row.getCell(6).getStringCellValue());
				
				excelWorkSheet.getData().add(systemLog);
				//System.out.println("add excelWorkSheet success-:"+systemLog.getSys_id());
			}
			
			List<SystemLog> listData=excelWorkSheet.getData();
			
			int count=0;
			//System.out.println("listData.size():"+listData.size());
			
			for (int i = 0; i < listData.size(); i++) {
				count++;
				
				//当系统数据库中不存在相同的日志ID时就保存该条日志记录
				if (systemLogService.ishasSys_id(listData.get(i).getSys_id()) == null) {
					
					//当系统数据库中不存在相同的日志ID和日期时，就保存该条日志记录
					if(systemLogService.ishasLogTime(listData.get(i).getLogTime())==null){
						
						systemLogService.save(listData.get(i));
						// System.out.println("save- 导入Excel日志数据第"+listData.get(i).getSys_id()+"行成功"
						// +"--"+listData.get(i).getLogTime()+"--"+listData.get(i).getLogType()+"--"
						// +listData.get(i).getAdmin()+"--"+listData.get(i).getLogData()+"--"+listData.get(i).getCoverage()+"--"+listData.get(i).getRemark());
						
					}
					else{
						try {
							startFailRefleshNum = listData.get(i).getSys_id();
						    systemLogService.update(listData.get(i));
							
						} catch (HibernateOptimisticLockingFailureException e) {
							//System.out.println("抛出的更新操作的HibernateOptimisticLockingFailureException异常");
							//excelFormat="noPrimarykey";
							canotUpdateID.append(listData.get(i).getSys_id()+" ");
							//System.out.println("catch canotUpdateID:-"+canotUpdateID+"-");
							e.printStackTrace();
							continue;
						}	
					 }
					
				}
				//当系统数据库中存在相同的日志ID时就更新该条日志记录
				else {
					startFailRefleshNum = listData.get(i).getSys_id();
				    systemLogService.update(listData.get(i));
					// System.out.println("update-  导入Excel日志数据第"+listData.get(i).getSys_id()+"行成功"
					// +"--"+listData.get(i).getLogTime()+"--"+listData.get(i).getLogType()+"--"
					// +listData.get(i).getAdmin()+"--"+listData.get(i).getLogData()+"--"+listData.get(i).getCoverage()+"--"+listData.get(i).getRemark());						

				}
			}
			
			if(!canotUpdateID.toString().equals("")){
				excelFormat=canotUpdateID.toString();
				systemLogService.save(new Date(), 2, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时抛出的hibernate找不到主键的异常,更新日志记录时发现系统中存在与该记录的时间相同的日志记录但日志ID不匹配，不匹配日志ID对应的日志记录为["+canotUpdateID.toString().split(" ").length+"]条", "系统日志查询-Excel日志数据导入系统", "HibernateOptimisticLockingFailureException");
			}
			//System.out.println("导入成功数："+count);
			
			importExcelProcess="importSuccess";
			//导入的总行数为sheet.getLastRowNum()，count为导入成功的总条数
			//当rowsNum=0时全部导入成功，否则存在失败的条数为rowsNum
			rowsNum=String.valueOf(sheet.getLastRowNum()-count);
			//System.out.println("rowsNum:"+rowsNum);
			
			if(count!=0){
				message=String.valueOf(count);
			}
			else message="ExcelToDBfail";
		}
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户成功将Excel数据导入系统", "系统日志查询-Excel日志数据导入系统", "t_park_systemLog");
		return importSystemLog();
	}

	//qinzuohai
	public String toDelSystemLog(){return "toDelSystemLog";}
	//根据日期范围删除日志
	public String delSystemLog(){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		systemLogService.delLogByTime(delStartTime, delEndTime);
		message="delSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户成功将"+dateFormat.format(delStartTime)+"到"+dateFormat.format(delEndTime)+"日期段的日志删除", "删除系统日志", "t_park_systemLog");
		return "toDelSystemLog";
		}
	
	/**
	 * HTML格式月保车缴费记录报表
	 * @return
	 */
	public String carMonthBillReport(){
		try {
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countCarMonthBill(startTime, endTime);
		    System.out.println("count:"+count);
		    if(count > 10000) {
		    	message = "生成HTML格式月保车缴费记录报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    
		    System.out.println("startTime:"+startTime+",endTime:"+endTime);
		    
			JasperPrint print=this.reportService.fillReport(jasper1, startTime, endTime, getCurrentOperator().getName());
			
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
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费记录报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费记录报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费记录报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式月保车缴费记录报表
	 * @return
	 */
	public String carMonthBillReportPDF(){
		try{
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//OutputStream outputStream = null;
			
			//计算生成的报表记录条数
		    int count = reportService.countCarMonthBill(startTime, endTime);
		    System.out.println("count:"+count);
		    if(count > 20000) {
		    	message = "生成PDF格式月保车缴费记录报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"report_carMonthBillReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费记录报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费记录报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费记录报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}/*finally {
			if(outputStream == null) {
				try {
					outputStream.flush();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}*/
		return null;
	}

	// Getters/Setters方法
	public void setJasper(String jasper) {
		this.jasper = jasper;
	}
	public InList getInlist() {
		return inlist;
	}
	public void setInlist(InList inlist) {
		this.inlist = inlist;
	}
	public OutList getOutlist() {
		return outlist;
	}
	public void setOutlist(OutList outlist) {
		this.outlist = outlist;
	}
	public Date getStartTime1() {
		return startTime1;
	}
	public void setStartTime1(Date startTime1) {
		this.startTime1 = startTime1;
	}
	public Date getEndTime1() {
		return endTime1;
	}
	public void setEndTime1(Date endTime1) {
		this.endTime1 = endTime1;
	}
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
	public void setJasperPDF(String jasperPDF) {
		this.jasperPDF = jasperPDF;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	public Date getData_startTime() {
		return data_startTime;
	}
	public void setData_startTime(Date data_startTime) {
		this.data_startTime = data_startTime;
	}
	public Date getData_endTime() {
		return data_endTime;
	}
	public void setData_endTime(Date data_endTime) {
		this.data_endTime = data_endTime;
	}
	public String getRowsNum() {
		return rowsNum;
	}
	public void setRowsNum(String rowsNum) {
		this.rowsNum = rowsNum;
	}
	public Integer getStartFailRefleshNum() {
		return startFailRefleshNum;
	}
	public void setStartFailRefleshNum(Integer startFailRefleshNum) {
		this.startFailRefleshNum = startFailRefleshNum;
	}
	public File getExcelFile() {
		return excelFile;
	}
	public void setExcelFile(File excelFile) {
		this.excelFile = excelFile;
	}
	public String getExcelFileFileName() {
		return excelFileFileName;
	}
	public void setExcelFileFileName(String excelFileFileName) {
		this.excelFileFileName = excelFileFileName;
	}
	public String getExcelFormat() {
		return excelFormat;
	}
	public void setExcelFormat(String excelFormat) {
		this.excelFormat = excelFormat;
	}
	
	public Date getDelStartTime() {
		return delStartTime;
	}
	public void setDelStartTime(Date delStartTime) {
		this.delStartTime = delStartTime;
	}
	public Date getDelEndTime() {
		return delEndTime;
	}
	public void setDelEndTime(Date delEndTime) {
		this.delEndTime = delEndTime;
	}
	public String getImportExcelProcess() {
		return importExcelProcess;
	}
	public void setImportExcelProcess(String importExcelProcess) {
		this.importExcelProcess = importExcelProcess;
	}
	@SuppressWarnings("unchecked")
	public List getAdminList() {
		return adminList;
	}
	@SuppressWarnings("unchecked")
	public void setAdminList(List adminList) {
		this.adminList = adminList;
	}
}
