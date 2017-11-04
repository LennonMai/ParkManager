package com.hgsoft.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.CarSmallType;
import com.hgsoft.entity.CarType;
import com.hgsoft.entity.CardType;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.SystemLog;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CarSmallTypeService;
import com.hgsoft.service.CarTypeService;
import com.hgsoft.service.OwnerIdentityService;
import com.hgsoft.service.ReportService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardTypeService;
import com.opensymphony.xwork2.ActionContext;


/**
 * @author caijunhua
 * @date November 18, 2010
 * @Description 卡信息报表控制器
 */

@Controller
@Scope("prototype")
public class CardInfoReportAction extends BaseAction {
	@Resource
	private ReportService reportService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private AdminService adminService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private CarTypeService carTypeService;
	@Resource
	private CarSmallTypeService carSmallTypeService;
	
	private SystemLog systemlog;
	private Admin admin;
	private Sysparamconf param_parkReport;
	
	private String startTime;
	private String endTime;
	private String jasper;
	private String jasperPDF;
	private String jasperExcel;
	private String parkReport = "parkReport";
	private String parkReport_remark = "用cardInfoReport的那个校区的jsp文件，如果值为hg，就是cardInfoReprot文件夹下的hg文件夹中的jsp，初始值为hg";
	private Integer carType;
	private String parkingSpace;
	private List listCarType;
	
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
	public void setJasper(String jasper) {
		this.jasper = jasper;
	}
	public void setJasperPDF(String jasperPDF) {
		this.jasperPDF = jasperPDF;
	}
	
	/**
	 * 卡详细信息查询页面
	 * @return
	 */
	public String cardInfo() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		param_parkReport = sysparamconfService.queryOrSave(parkReport, "hg", parkReport_remark, "CardInfoReportAction中cardInfo()设置parkReport参数时set（），get（）参数时的异常", admin);
		return "cardInfo";
	}
	
	
	/**
	 * 临时卡动态报表查询页面
	 * @return
	 */
	public String cardDynamic() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "cardDynamic";
	}
	/**
	 * 月保车缴费记录报表查询页面
	 * @return
	 */
	public String carMonthBill() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "carMonthBill";
	}
	/**
	 * 月保车缴费日统计报表查询页面
	 * @return
	 */
	public String carMonthBillDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "carMonthBillDay";
	}
	/**
	 * 月保车缴费日类型统计报表查询页面
	 * @return
	 */
	public String carMonthBillDayType() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "carMonthBillDayType";
	}
	/**
	 * 月租卡缴费报表查询页面
	 * @return
	 */
	public String carMonthParking(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "carMonthParking";
	}
	
	/**
	 * HTML格式卡详细信息报表
	 * @return
	 */
	public String cardInfoReport() {
		try {
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			
			String temp = "/WEB-INF/jsp/report/cardInfoReport/"+param_parkReport.getPvalue()+"/jasper/cardInfoReport.jasper";
			String jasper1 = ServletActionContext.getServletContext().getRealPath(temp);
			//String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countCardInfo(startTime, endTime + " 23:59:59");
		    if(count > 10000) {
		    	message = "生成HTML格式卡详细信息报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
	        Admin admin = this.getCurrentOperator();
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式卡详细信息报表",
					"报表管理--卡信息报表--卡详细信息报表", "tb_usercardinfo");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式卡详细信息报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式卡详细信息报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式卡详细信息报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式卡详细信息报表
	 * @return
	 */
	public String cardInfoReportPDF() {
		try{
			admin = adminService.get(getCurrentOperator().getId());
			String jasperPDF = "/WEB-INF/jsp/report/cardInfoReport/"+param_parkReport.getPvalue()+"/jasper/cardInfoReport.jasper";
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countCardInfo(startTime, endTime + " 23:59:59");
		    if(count > 20000) {
		    	message = "生成PDF格式卡详细信息报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_cardInfoReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式卡详细信息报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式卡详细信息报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式卡详细信息报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式临时卡动态报表
	 * @return
	 */
	public String cardDynamicReport() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
//		    int count = reportService.countCardDynamic();
//		    if(count > 10000) {
//		    	message = "生成HTML格式临时卡动态报表数据量过大，已超过10000条，请重新选择较小的日期范围";
//		    	return ERROR;
//		    }
		    
			JasperPrint print = this.reportService.fillReport(jasper1, getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成HTML格式临时卡动态报表",
					"报表管理--卡信息报表--临时卡动态报表", "tb_CardDynamic");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式临时卡动态报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式临时卡动态报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式临时卡动态报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式临时卡动态报表
	 * @return
	 */
	public String cardDynamicReportPDF() {
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
//		    int count = reportService.countCardDynamic();
//		    if(count > 20000) {
//		    	message = "生成PDF格式临时卡动态报表数据量过大，已超过20000条，请重新选择较小的日期范围";
//		    	return ERROR;
//		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_cardDynamicReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式临时卡动态报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式临时卡动态报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式临时卡动态报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式月保车缴费记录报表
	 * @return
	 */
	public String carMonthBillReport() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
			int count = reportService.countCarMonthBill(startTime, endTime + " 23:59:59");
			if(count > 10000) {
				message = "生成HTML格式月保车缴费记录报表数据量过大，已超过10000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式月保车缴费记录报表",
					"报表管理--卡信息报表--月保车缴费记录报表", "tb_userCardBill");
			
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
	public String carMonthBillReportPDF() {
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countCarMonthBill(startTime, endTime + " 23:59:59");
		    if(count > 20000) {
		    	message = "生成PDF格式月保车缴费记录报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_carMonthBillReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
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
		}
		return null;
	}
	
	/**
	 * HTML格式月保车缴费日统计报表
	 * @return
	 */
	public String carMonthBillDayReport() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
			int count = reportService.countCarMonthBillDay(startTime, endTime + " 23:59:59");
			if(count > 10000) {
				message = "生成HTML格式月保车缴费日统计报表数据量过大，已超过10000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式月保车缴费日统计报表",
					"报表管理--卡信息报表--月保车缴费日统计报表", "tb_userCardBill");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费日统计报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费日统计报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费日统计报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式月保车缴费日统计报表
	 * @return
	 */
	public String carMonthBillDayReportPDF() {
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
			int count = reportService.countCarMonthBillDay(startTime, endTime + " 23:59:59");
			if(count > 20000) {
				message = "生成PDF格式月保车缴费日统计报表数据量过大，已超过20000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_carMonthBillDayReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费日统计报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费日统计报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费日统计报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * HTML格式月保车缴费日类型统计报表
	 * @return
	 */
	public String carMonthBillDayTypeReport() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
			int count = reportService.countCarMonthBillDayType(startTime, endTime + " 23:59:59");
			if(count > 10000) {
				message = "生成HTML格式月保车缴费日类型统计报表数据量过大，已超过10000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式月保车缴费日类型统计报表",
					"报表管理--卡信息报表--月保车缴费日类型统计报表", "tb_userCardBill");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费日类型统计报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费日类型统计报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月保车缴费日类型统计报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式月保车缴费日类型统计报表
	 * @return
	 */
	public String carMonthBillDayTypeReportPDF() {
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
			int count = reportService.countCarMonthBillDayType(startTime, endTime + " 23:59:59");
			if(count > 20000) {
				message = "生成PDF格式月保车缴费日类型统计报表数据量过大，已超过20000条，请重新选择较小的日期范围";
				return ERROR;
			}
			
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_carMonthBillDayTypeReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费日类型统计报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费日类型统计报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月保车缴费日类型统计报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式月租卡缴费报表
	 * @return
	 */
	public String carMonthParkingReport(){
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countCarMonthParking(startTime, endTime + " 23:59:59");
		    if(count > 10000) {
		    	message = "生成HTML格式月租卡缴费报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    
			JasperPrint print=this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
			systemLogService.save(new Date(), 2, admin, "HTML格式月租卡缴费报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月租卡缴费报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式月租卡缴费报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式月租卡缴费报表
	 * @return
	 */
	public String carMonthParkingReportPDF(){
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countCarMonthParking(startTime, endTime + " 23:59:59");
		    if(count > 20000) {
		    	message = "生成PDF格式月租卡缴费报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_carMonthParkingReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月租卡缴费报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月租卡缴费报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式月租卡缴费报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * EXCEL格式月租卡缴费报表
	 * 
	 * @return
	 */
	public String carMonthParkingReportExcel() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext()
					.getRealPath(jasperExcel);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");

			// 计算生成的报表记录条数
			int count = reportService.countCarMonthParking(startTime, endTime + " 23:59:59");
			if (count > 20000) {
				message = "生成EXCEL格式月租卡缴费报表数据量过大，已超过20000条，请重新选择较小的日期范围";
				return ERROR;
			}

			JasperPrint print = this.reportService.fillReport(jasper1,
					startTime, endTime + " 23:59:59", getCurrentOperator().getName());

			/*
			 * 设置头信息
			 */
			ServletActionContext.getResponse().setContentType(
					"application/vnd.ms-excel");
			String fileName = new String(
					"cardInfoReport_carMonthParkingReportExcel.xls".getBytes("GBK"),
					"ISO8859_1");
			ServletActionContext.getResponse().setHeader("Content-disposition",
					"attachment; filename=" + fileName);

			OutputStream ouputStream = ServletActionContext.getResponse()
					.getOutputStream();
			JRXlsExporter exporter = new JRXlsExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM,
					ouputStream);
			exporter.setParameter(
					JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					Boolean.TRUE);
			exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET,
					Boolean.FALSE);
			exporter.setParameter(
					JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,
					Boolean.FALSE);
			exporter.exportReport();
			ouputStream.flush();
			ouputStream.close();

		} catch (JRException e) {
			systemLogService
					.save(new Date(), 2, admin, "Excel格式月租卡缴费报表JRException异常", e
							.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "Excel格式月租卡缴费报表IO异常", e
					.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin,
					"Excel格式月租卡缴费报表Runtime Exception异常", e.getMessage(),
					"Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 卡详细信息查询页面(多条件查询车辆类型，停车场)
	 * @return
	 */
	public String cardInfoInCarType() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		listCarType = carTypeService.getAllCarType();
		param_parkReport = sysparamconfService.queryOrSave(parkReport, "hg", parkReport_remark, "CardInfoReportAction中cardInfo()设置parkReport参数时set（），get（）参数时的异常", admin);
		return "cardInfoInCarType";
	}
	
	
	/**
	 * HTML格式卡详细信息报表(多条件查询车辆类型，停车场)
	 * @return
	 */
	public String cardInfoReportInCarType(){
		try{
			admin = adminService.get(getCurrentOperator().getId());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			
			String temp = "/WEB-INF/jsp/report/cardInfoReport/"+param_parkReport.getPvalue()+"/jasper/cardInfoReportInCarType.jasper";
			String jasper1 = ServletActionContext.getServletContext().getRealPath(temp);
			//String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countCardInfoInCartype(startTime, endTime + " 23:59:59", carType, parkingSpace);
		    if(count > 10000) {
		    	message = "生成HTML格式卡详细信息报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    String carTypeName = "";
		    if(carType!=null && !carType.equals("")){
		    	CarType type = carTypeService.getCarTypeByCarType(carType);
			    carTypeName = type.getCarTypeName();
		    }
		    
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName(), carType, parkingSpace, carTypeName);
			
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
	        Admin admin = this.getCurrentOperator();
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式卡详细信息报表",
					"报表管理--卡信息报表--卡详细信息报表", "tb_usercardinfo");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式卡详细信息报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式卡详细信息报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式卡详细信息报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 根据车辆类型异步查询车辆类型小分类
	 * */
	public String findCarSmallType(){
		ServletResponse response = ServletActionContext.getResponse();
		List list = carSmallTypeService.findSmallTypeByCarType(carType);
		if(list==null){
			return null;
		}
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw =null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
			pw.print("<CarSmallTypes>");
			for(int i=0; i<list.size(); i++){
				CarSmallType carSmallType = (CarSmallType) list.get(i);
				
				pw.print("<CarSmallType id='" + carSmallType.getCarSmallType() + "' name='" +carSmallType.getCarSmallName() + "' />");
			}
			pw.print("</CarSmallTypes>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String cardInfoReportInCarTypePDF(){
		try {
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasperPDF = "/WEB-INF/jsp/report/cardInfoReport/"+param_parkReport.getPvalue()+"/jasper/cardInfoReportInCarType.jasper";
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countCardInfoInCartype(startTime, endTime + " 23:59:59", carType, parkingSpace);
			if(count > 20000) {
			    	message = "生成PDF格式卡详细信息报表数据量过大，已超过20000条，请重新选择较小的日期范围";
			    	return ERROR;
			    }
			 String carTypeName = "";
			    if(carType!=null && !carType.equals("")){
			    	CarType type = carTypeService.getCarTypeByCarType(carType);
				    carTypeName = type.getCarTypeName().trim();
			    }
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_cardInfoReportInCarTypePDF.pdf");
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName(), carType, parkingSpace, carTypeName);
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
			
		}  catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式卡详细信息报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式卡详细信息报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式卡详细信息报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
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
	public Sysparamconf getParam_parkReport() {
		return param_parkReport;
	}
	public void setParam_parkReport(Sysparamconf param_parkReport) {
		this.param_parkReport = param_parkReport;
	}
	public void setJasperExcel(String jasperExcel) {
		this.jasperExcel = jasperExcel;
	}
	public Integer getCarType() {
		return carType;
	}
	public void setCarType(Integer carType) {
		this.carType = carType;
	}
	public String getParkingSpace() {
		return parkingSpace;
	}
	public void setParkingSpace(String parkingSpace) {
		this.parkingSpace = parkingSpace;
	}
	public List getListCarType() {
		return listCarType;
	}
	public void setListCarType(List listCarType) {
		this.listCarType = listCarType;
	}
	
	
}
