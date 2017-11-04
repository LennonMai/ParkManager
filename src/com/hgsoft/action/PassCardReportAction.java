package com.hgsoft.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.hgsoft.service.AdminService;
import com.hgsoft.service.ReportService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date November 24, 2010
 * @Description 通行卡报表控制器
 */

@Controller
@Scope("prototype")
public class PassCardReportAction extends BaseAction {
	@Resource
	private ReportService reportService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private AdminService adminService;
	@Resource
	private SysparamconfService sysparamconfService;
	
	private SystemLog systemlog;
	private Admin admin;
	private Sysparamconf setAreaNo;
	private Sysparamconf setParkNo;
	
	private String startTime;
	private String endTime;
	private String jasper;
	private String jasperPDF;
	
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
	 * 通行卡领卡交卡登记报表查询页面
	 * @return
	 */
	public String passCardHandOutIn() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "passCardHandOutIn";
	}
	/**
	 * 通行卡使用分人班报表查询页面
	 * @return
	 */
	public String passCardUsedOperSquad() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "passCardUsedOperSquad";
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
	 * HTML格式通行卡领卡交卡登记报表
	 * @return
	 */
	public String passCardHandOutInReport() {
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countPassCardHandOutIn(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML格式通行卡领卡交卡登记报表数据量过大，已超过10000条，请重新选择较小的日期范围";
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
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行卡领卡交卡登记报表",
					"报表管理--通行卡报表--通行卡领卡交卡登记报表", "tb_CardHandOutIn");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行卡领卡交卡登记报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行卡领卡交卡登记报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行卡领卡交卡登记报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式通行卡领卡交卡登记报表
	 * @return
	 */
	public String passCardHandOutInReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countPassCardHandOutIn(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式通行卡领卡交卡登记报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"passCardReport_passCardHandOutInReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行卡领卡交卡登记报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行卡领卡交卡登记报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行卡领卡交卡登记报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式通行卡使用分人班报表
	 * @return
	 */
	public String passCardUsedOperSquadReport() {
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //根据月份拼接表sql语句
		    String inlistUnionTable = reportService.inlistUnionTable(startTime, endTime);
		    String outlistUnionTable = reportService.outlistUnionTable(startTime, endTime);
		    
		    //计算生成的报表记录条数
		    int count = reportService.countPassCardUsedOperSquad(startTime, endTime, areaNoValue, parkNoValue,
					inlistUnionTable, outlistUnionTable);
		    if(count > 10000) {
		    	message = "生成HTML格式通行卡使用分人班报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
	    
			JasperPrint print = this.reportService.passCardUsedOperSquadFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, inlistUnionTable, outlistUnionTable, getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行卡使用分人班报表",
					"报表管理--通行卡报表--通行卡使用分人班报表", "临时表");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行卡使用分人班报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行卡使用分人班报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行卡使用分人班报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式通行卡使用分人班报表
	 * @return
	 */
	public String passCardUsedOperSquadReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//取日期的月份值
		    String startMonth = startTime.substring(5, 7);
		    String endMonth = endTime.substring(5, 7);
		    
		    //根据月份拼接表sql语句
		    String inlistUnionTable = reportService.inlistUnionTable(startTime, endTime);
		    String outlistUnionTable = reportService.outlistUnionTable(startTime, endTime);
			
			//计算生成的报表记录条数
		    int count = reportService.countPassCardUsedOperSquad(startTime, endTime, areaNoValue, parkNoValue,
					inlistUnionTable, outlistUnionTable);
		    if(count > 20000) {
		    	message = "生成PDF格式通行卡使用分人班报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename="+"passCardReport_passCardUsedOperSquadReportPDF.pdf");
			
			this.reportService.passCardUsedOperSquadPdfStream(inputStream, outputStream,startTime, endTime,
					areaNoValue, parkNoValue, inlistUnionTable, outlistUnionTable,getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行卡使用分人班报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行卡使用分人班报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行卡使用分人班报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
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
