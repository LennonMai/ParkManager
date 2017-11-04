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
 * @Description ���������
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
	
	//��־����ʱ�䷶Χ
	private Date data_startTime;
	private Date data_endTime;
	private Date endTime1;
	
	//�����excel�ļ�������
	private String rowsNum;

	private String excelFormat;
	private Integer startFailRefleshNum;	
	//�ϴ����ļ�
	private File excelFile;
	//����ԭʼ���ļ���
	private String excelFileFileName;
	//��Excel�ļ�������Ϻ���Ϣ��ŵ����������
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
	 * ת��ͨ�з��ձ���༭ҳ��
	 * @return
	 */
	public String tollsTradeDay(){
		return "tollsTradeDay";
	}
	/**
	 * ת��ͨ�з��±���༭ҳ��
	 * @return
	 */
	public String tollsTradeMonth(){
		return "tollsTradeMonth";
	}
	/**
	 * ת�������ձ���༭ҳ��
	 * @return
	 */
	public String trafficFlowDay(){
		return "trafficFlowDay";
	}
	/**
	 * ת�������±���༭ҳ��
	 * @return
	 */
	public String trafficFlowMonth(){
		return "trafficFlowMonth";
	}
	/**
	 * ת��ɷѿ����׼�¼����༭ҳ��
	 * @return
	 */
	public String payCardTrade(){
		return "payCardTrade";
	}
	/**
	 * ��ӡ�˵�����༭ҳ��
	 * @return
	 */
	public String printBill(){
		return "printBill";
	}
	/**
	 * �����ˮ��¼��ѯҳ��
	 * @return
	 */
	public String inList(){
		return "inList";
	}
	/**
	 * ������ˮ��¼��ѯҳ��
	 * @return
	 */
	public String outList(){
		return "outList";
	}
	/**
	 * ϵͳ��־��ѯҳ��
	 * @return
	 */
	public String systemLog(){
		adminList = adminService.findAll();
		list = systemLogService.findByPager(pager);
		
		return "systemLog";
	}
	/**
	 * �±����ɷѼ�¼��ѯҳ��
	 * @return
	 */
	public String carMonthBill(){
		//list = systemLogService.findByPager(pager);
		return "carMonthBill";
	}
	
	//��ȡ����С������
	public void getSysparamconf() {
		//��ȡ����С������
		Sysparamconf areaNo = sysparamconfService.getSysparamconfByQname("AreaNo");
		Sysparamconf parkNo = sysparamconfService.getSysparamconfByQname("ParkNo");
		setAreaNo = new Sysparamconf();
		setParkNo = new Sysparamconf();
		if(areaNo == null) {
			setAreaNo.setPname("AreaNo");
			//�����ֵΪ3301
			setAreaNo.setPvalue("4430");
			setAreaNo.setPtype(0);
			setAreaNo.setRemark("������");
			sysparamconfService.save(setAreaNo);
		}
		if(parkNo == null) {
			setParkNo.setPname("ParkNo");
			//�����ֵΪ1
			setParkNo.setPvalue("101");
			setParkNo.setPtype(0);
			setParkNo.setRemark("С�����");
			sysparamconfService.save(setParkNo);
		}
	}
	
	/**
	 * HTML��ʽͨ�з��ձ���
	 * @return
	 */
	public String tollsTradeDayReport(){
		try {
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
	//		String jasper1 = ServletActionContext.getRequest().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽͨ�з��ձ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			JasperPrint print=this.reportService.tollsFillReport(jasper1, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// �Ƿ����ͼƬ����
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// ��������Ƿ���СͼƬ����
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
	        
	        //exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT, "pt");//�������HTML������С���⣬����ӡ����
	        //pt ���� (Typeface Point=1/72in) ��ӡ�ĵ�����С�� px ���� (pixel) ����Ļ����ʾ�ĵ�λ��
	        
	        //��ӡ��ҳ
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        exporter.exportReport();
		} catch (JRException e) {		
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
//	�ڶ��ַ�����ͨ���ļ���ʽ���п��ܳ����ļ���ȡ��ͻ���⣩
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
	 * PDF��ʽͨ�з��ձ���
	 * @return
	 */
	public String tollsTradeDayReportPDF(){
		try{	
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�з��ձ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename=report_tollsTradeDayReportPDF.pdf");
			//ServletActionContext.getResponse().setHeader("Content-Disposition", "inline;filename=report_tollsTradeDayReportPDF.pdf");
			
			//������������IE�����һ���������ص�pdf�ļ�
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
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽͨ�з��±���
	 * @return
	 */
	public String tollsTradeMonthReport(){
		try {
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽͨ�з��±��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
	    
			JasperPrint print=this.reportService.tollsFillReport(jasper1, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// �Ƿ����ͼƬ����
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// ��������Ƿ���СͼƬ����
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
	        
	        //��ӡ��ҳ
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

	        exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��±���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��±���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��±���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽͨ�з��±���
	 * @return
	 */
	public String tollsTradeMonthReportPDF(){
		try{
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�з��±��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename="+"report_tollsTradeMonthReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��±���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��±���IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��±���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ�������ձ���
	 * @return
	 */
	public String trafficFlowDayReport(){
		try {
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countTrafficFlowDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽ�������ձ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
	    
			JasperPrint print=this.reportService.trafficFlowFillReport(jasper1, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
	        //exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML, "");//�����ҳ�õ�
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// �Ƿ����ͼƬ����
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// ��������Ƿ���СͼƬ����
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
	        
	        //��ӡ��ҳ
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

	        exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�������ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�������ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�������ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ�������ձ���
	 * @return
	 */
	public String trafficFlowDayReportPDF(){
		try{
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTrafficFlowDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽ�������ձ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename="+"report_trafficFlowDayReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�������ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�������ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�������ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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
	 * HTML��ʽ�������±���
	 * @return
	 */
	public String trafficFlowMonthReport(){
		try {
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countTrafficFlowMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽ�������±��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			JasperPrint print=this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// �Ƿ����ͼƬ����
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// ��������Ƿ���СͼƬ����
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
	        
	        //��ӡ��ҳ
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

	        exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�������±���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�������±���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�������±���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ�������±���
	 * @return
	 */
	public String trafficFlowMonthReportPDF(){
		try{
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTrafficFlowMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽ�������±��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"report_trafficFlowMonthReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�������±���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�������±���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�������±���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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
	 * HTML��ʽ�ɷѿ����ױ���
	 * @return
	 */
	public String payCardTradeReport(){
		try {
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//ȡ����0,1,2,3,4�ĸ�ֵ
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			String tradeType2 = ids[2];
			String tradeType3 = ids[3];
			String tradeType4 = ids[4];
			
			//�������ɵı����¼����
		    int count = reportService.countPayCardTrade(startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
		    if(count > 10000) {
		    	message = "����HTML��ʽ�ɷѿ����ױ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
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
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
					exporter.setParameter(
							JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
							Boolean.FALSE);// �Ƿ����ͼƬ����
					exporter.setParameter(
							JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
							Boolean.FALSE);// ��������Ƿ���СͼƬ����
					exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
							Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
					
					//��ӡ��ҳ
					String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
			        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
			        		BETWEEN_PAGES_HTML);
					
					exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�ɷѿ����ױ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�ɷѿ����ױ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�ɷѿ����ױ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ�ɷѿ����ױ���
	 * @return
	 */
	public String payCardTradeReportPDF(){
		try{
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);	
			//ȡ����0,1,2,3,4�ĸ�ֵ
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			String tradeType2 = ids[2];
			String tradeType3 = ids[3];
			String tradeType4 = ids[4];
			//OutputStream outputStream = null;
			
			//�������ɵı����¼����
		    int count = reportService.countPayCardTrade(startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
		    //System.out.println("count:"+count);
		    if(count > 20000) {
		    	message = "����PDF��ʽ�ɷѿ����ױ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"report_payCardTradeReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, getCurrentOperator().getName(), account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�ɷѿ����ױ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�ɷѿ����ױ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�ɷѿ����ױ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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
	 * HTML��ʽ��ӡ�˵�����
	 * @return
	 */
	public String printBillReport(){
		try {
			admin=adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//ȡ����0,1,2,3,4�ĸ�ֵ
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			
			//�������ɵı����¼����
		    int count = reportService.countPrintBill(startTime, endTime + " 23:59:59", tradeType0, tradeType1);
		    if(count > 10000) {
		    	message = "����HTML��ӡ�˵����������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			JasperPrint print=this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", tradeType0, tradeType1, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// �Ƿ����ͼƬ����
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// ��������Ƿ���СͼƬ����
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
			
			//��ӡ��ҳ
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

			exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ӡ�˵�����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ӡ�˵�����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ӡ�˵�����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ��ӡ�˵�����
	 * @return
	 */
	public String printBillReportPDF(){
		try{
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			//ȡ����0,1,2,3,4�ĸ�ֵ
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			
			//�������ɵı����¼����
		    int count = reportService.countPrintBill(startTime, endTime + " 23:59:59", tradeType0, tradeType1);
		    if(count > 20000) {
		    	message = "����PDF��ӡ�˵����������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"report_printBillReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", tradeType0, tradeType1, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ӡ�˵�����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ӡ�˵�����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ӡ�˵�����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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
	 * �����ˮ��¼��ѯ
	 * @return
	 */
	public String queryInList(){
//		System.out.println("queryOutList:" + inlist.getCardNo() + "|" + inlist.getVehPlate() + "|" + inlist.getListNo() + "|" + inlist.getVehClass() + "|" + startTime1 + "|" + endTime1);
		list = inListService.findAllInListByHql(pager, inlist.getCardNo(), inlist.getVehPlate(), inlist.getListNo(), inlist.getVehClass(), startTime1, endTime1);
		return "inList";
	}
	/**
	 * ������ˮ��¼��ѯ
	 * @return
	 */
	public String queryOutList(){
//		System.out.println("queryOutList:" + outlist.getCardNo() + "|" + outlist.getVehPlate() + "|" + outlist.getListNo() + "|" + outlist.getVehClass() + "|" + startTime1 + "|" + endTime1);
		list = outListService.findAllOutListByHql(pager, outlist.getCardNo(), outlist.getVehPlate(), outlist.getListNo(), outlist.getVehClass(), startTime1, endTime1);
		return "outList";
	}
	/**
	 * ϵͳ��־��ѯ
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
				|| endTime1 != null) {	//��ѯ������Ϊ��
			list = systemLogService.findAllSystemLogByHql(pager, systemlog.getLogType(), admin.getUsername(),
					systemlog.getLogData(), systemlog.getRemark(), systemlog.getCoverage(), startTime1, endTime1);
			return "systemLog";
		} else {
			return systemLog();	//��ѯ����Ϊ��
		}
	}
	
	/**
	 * ��־����Excel
	 * qinzuohai
	 */
	public String logToExcel()throws ServletException{

	      List<SystemLog> systemlogList= new ArrayList<SystemLog>();
	      systemlogList=systemLogService.findLogByTime(this.getData_startTime(), this.getData_endTime());
	      if(systemlogList.size()<50000){
		      try {
		    	  
		    	  //��Ҫ�ɹ���ȡHttpServletResponse���ܳɹ�������Ӧͷ
		    	  HttpServletResponse response = ServletActionContext.getResponse();
		    	  //response.setContentType("application/octets-stream;charset=gb2312");
		    	  response.setContentType("octets/stream");//�򵥿�������Ϊ��Ϣ��
			      response.addHeader("Content-Disposition", "attachment;filename=systemLog.xls");	      
			      //�ͻ��˲�����
			      response.addHeader("Pragma","no-cache");
			      response.addHeader("Cache-Control","no-cache");
			      
			      ExcelUtil<SystemLog> _excelUtil = new ExcelUtil<SystemLog>();
			      String[] headers = { "��־ID","ʱ��", "��־����", "�û�ID", "��־����", "Ӱ�췶Χ", "��ע"  };
	              OutputStream out = response.getOutputStream();
	              _excelUtil.exportExcel(headers, systemlogList, out);
	              systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�������־��Excel�ļ��ɹ�", "ϵͳ��־��ѯ-��־������Excel", "systemLog.xls");
	              out.close();
	              //reset()--Clears any data that exists in the buffer as well as the status code and headers. 
	              //If the response has been committed, this method throws an IllegalStateException. 
			      response.reset();
	              //response.resetBuffer();
		      }catch (IOException e) {
		    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�����־������Excelʱ�׳���IO�쳣", "ϵͳ��־��ѯ-��־������Excel", "IOException");
				  e.printStackTrace();
		      }
	      }else{
	    	  message="overMaxCount";
	      }

	    return systemLog();
	}

	/**
	 * ����Excel��־
	 * qinzuohai
	 */
	public String importSystemLog(){
		return "importSystemLog";
	}
	
	/**
	 * ��Excel��־���ݵ��뵽���ݿ�
	 */
	//�����ļ����ʹ���������
	public Workbook createWorkBook(InputStream is){
		if(excelFileFileName.toLowerCase().endsWith("xls")){
			try {
				return new HSSFWorkbook(is);
			} catch (IOException e) {
				systemLogService.save(new Date(), 2, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�����Excel��־����ʱ����������IO�쳣", "ϵͳ��־��ѯ-Excel��־���ݵ���ϵͳ", "IOException");
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
	//�ж��Ƿ�������
	public boolean isNumber(String s) {
		String REG_DIGIT="[0-9]*";
		if(s.matches(REG_DIGIT))return true;
		return false;	
	}
	
	//�ж��Ƿ���0��1��2
	public boolean isNumberOneTwoorThree(String s) {
		int REG_DIGIT=Integer.valueOf(s.trim());
		if(REG_DIGIT==0){
			//System.out.println("0��1��2�ж�0��"+s);
			return true;
		}else if(REG_DIGIT==1){
			//System.out.println("0��1��2�ж�1��"+s);
			return true;
		}else if(REG_DIGIT==2){
			//System.out.println("0��1��2�ж�2��"+s);
			return true;
		}
		else return false;	
	}
	
	//����
	public String importSystemLogToExcel() throws Exception{
			Workbook workbook=createWorkBook(new FileInputStream(excelFile));
			Sheet sheet=workbook.getSheetAt(0);	
			excelWorkSheet=new ExcelWorkSheet<SystemLog>();
			//���湤��������
			excelWorkSheet.setSheetName(sheet.getSheetName());
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			StringBuffer canotUpdateID=new StringBuffer("");
		// �����һ��(����ͷ)Ϊ�ջ�Ϊ����ʱ���쳣
		try {
			Row firstRow = sheet.getRow(0);
			Iterator<Cell> iterator = firstRow.iterator();
			// ��������
			List<String> cellNames = new ArrayList<String>();
			while (iterator.hasNext()) {
				cellNames.add(iterator.next().getStringCellValue());
			}
			excelWorkSheet.setColumns(cellNames);
			
		} 
		catch (NullPointerException e) {
			//System.out.println("����������׳��ı�ͷΪ�յ��쳣);
			systemLogService.save(new Date(), 2,getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ��ͷΪ�յĿ�ָ���쳣", "ϵͳ��־��ѯ-Excel��־���ݵ���ϵͳ", "��������׳�NullPointerException");
			e.printStackTrace();
		} 
		catch (IllegalStateException e) {
			//System.out.println("����������׳��ı�ͷΪ���ֵ��쳣);
			systemLogService.save(new Date(), 2, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ��ͷΪ���ֵ��쳣", "ϵͳ��־��ѯ-Excel��־���ݵ���ϵͳ", "��������׳�IllegalStateException");
			e.printStackTrace();
		}
		finally{
			for(int i=1;i<=sheet.getLastRowNum();i++){
				Row row=sheet.getRow(i);		
				try {
					//����0 - 5�ж�Ϊ�ַ�����	,�������ж���Ϊ�գ�Ϊ����ִ����һѭ��	
					row.getCell(0).setCellType(1);
					row.getCell(1).setCellType(1);
					row.getCell(2).setCellType(1);
					row.getCell(3).setCellType(1);
					row.getCell(4).setCellType(1);	
					row.getCell(5).setCellType(1);	
				} 
				//���п�ָ���쳣ʱ�׳��쳣��ִ����һѭ��
				catch (NullPointerException e) {
					//System.out.println("����������׳����쳣 ******"+i);
					e.printStackTrace();
				    continue;
				}
				//����עΪ��ʱ���򴴽�����nullֵ,�������˴�ѭ��
				try {
					row.getCell(6).setCellType(1);
				} catch (NullPointerException e) {
					//System.out.println("����������׳����쳣 ******");
					e.printStackTrace();
					row.createCell(6).setCellValue("null");
					i=i-1;
					continue;
				}
				
				SystemLog systemLog=new SystemLog();
				//sys_idϵͳ��־ID��Ϊ����������ʱset,����ִ����һѭ��
				if(!row.getCell(0).getStringCellValue().equals("")&&isNumber(row.getCell(0).getStringCellValue())){						
					systemLog.setSys_id(Integer.valueOf(row.getCell(0).getStringCellValue()));
					
				}else continue;
				
				//logTime��־ʱ�䲻Ϊ��ʱset,,����ִ����һѭ��
				if(!row.getCell(1).getStringCellValue().equals("")){
					Date date=dateFormat.parse(row.getCell(1).getStringCellValue().trim());
					systemLog.setLogTime(date);
					
				}else continue;
				
				//logType��־���Ͳ�Ϊ������Ϊ0��1��2ʱset,����ִ����һѭ��
				if(!row.getCell(2).getStringCellValue().equals("")&&isNumber(row.getCell(2).getStringCellValue())&&isNumberOneTwoorThree(row.getCell(2).getStringCellValue())){					
					systemLog.setLogType(Integer.valueOf(row.getCell(2).getStringCellValue().trim()));
				
				}else continue;
				
				//Adminϵͳ����Ա��Ϊ��ʱset
				if(!row.getCell(3).getStringCellValue().equals("")){
					systemLog.setOperatorID(Integer.valueOf(row.getCell(3).getStringCellValue().trim()));
					
				}else continue;
				
				//logData��־�������ݲ�Ϊ��set
				if(!row.getCell(4).getStringCellValue().equals("")){
					systemLog.setLogData(row.getCell(4).getStringCellValue());
					
				}else continue;
				
				//coverage��־Ӱ�췶Χ��־���ݲ�Ϊ��set
				systemLog.setCoverage(row.getCell(5).getStringCellValue());
				
				//remark��ע
				systemLog.setRemark(row.getCell(6).getStringCellValue());
				
				excelWorkSheet.getData().add(systemLog);
				//System.out.println("add excelWorkSheet success-:"+systemLog.getSys_id());
			}
			
			List<SystemLog> listData=excelWorkSheet.getData();
			
			int count=0;
			//System.out.println("listData.size():"+listData.size());
			
			for (int i = 0; i < listData.size(); i++) {
				count++;
				
				//��ϵͳ���ݿ��в�������ͬ����־IDʱ�ͱ��������־��¼
				if (systemLogService.ishasSys_id(listData.get(i).getSys_id()) == null) {
					
					//��ϵͳ���ݿ��в�������ͬ����־ID������ʱ���ͱ��������־��¼
					if(systemLogService.ishasLogTime(listData.get(i).getLogTime())==null){
						
						systemLogService.save(listData.get(i));
						// System.out.println("save- ����Excel��־���ݵ�"+listData.get(i).getSys_id()+"�гɹ�"
						// +"--"+listData.get(i).getLogTime()+"--"+listData.get(i).getLogType()+"--"
						// +listData.get(i).getAdmin()+"--"+listData.get(i).getLogData()+"--"+listData.get(i).getCoverage()+"--"+listData.get(i).getRemark());
						
					}
					else{
						try {
							startFailRefleshNum = listData.get(i).getSys_id();
						    systemLogService.update(listData.get(i));
							
						} catch (HibernateOptimisticLockingFailureException e) {
							//System.out.println("�׳��ĸ��²�����HibernateOptimisticLockingFailureException�쳣");
							//excelFormat="noPrimarykey";
							canotUpdateID.append(listData.get(i).getSys_id()+" ");
							//System.out.println("catch canotUpdateID:-"+canotUpdateID+"-");
							e.printStackTrace();
							continue;
						}	
					 }
					
				}
				//��ϵͳ���ݿ��д�����ͬ����־IDʱ�͸��¸�����־��¼
				else {
					startFailRefleshNum = listData.get(i).getSys_id();
				    systemLogService.update(listData.get(i));
					// System.out.println("update-  ����Excel��־���ݵ�"+listData.get(i).getSys_id()+"�гɹ�"
					// +"--"+listData.get(i).getLogTime()+"--"+listData.get(i).getLogType()+"--"
					// +listData.get(i).getAdmin()+"--"+listData.get(i).getLogData()+"--"+listData.get(i).getCoverage()+"--"+listData.get(i).getRemark());						

				}
			}
			
			if(!canotUpdateID.toString().equals("")){
				excelFormat=canotUpdateID.toString();
				systemLogService.save(new Date(), 2, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ�׳���hibernate�Ҳ����������쳣,������־��¼ʱ����ϵͳ�д�����ü�¼��ʱ����ͬ����־��¼����־ID��ƥ�䣬��ƥ����־ID��Ӧ����־��¼Ϊ["+canotUpdateID.toString().split(" ").length+"]��", "ϵͳ��־��ѯ-Excel��־���ݵ���ϵͳ", "HibernateOptimisticLockingFailureException");
			}
			//System.out.println("����ɹ�����"+count);
			
			importExcelProcess="importSuccess";
			//�����������Ϊsheet.getLastRowNum()��countΪ����ɹ���������
			//��rowsNum=0ʱȫ������ɹ����������ʧ�ܵ�����ΪrowsNum
			rowsNum=String.valueOf(sheet.getLastRowNum()-count);
			//System.out.println("rowsNum:"+rowsNum);
			
			if(count!=0){
				message=String.valueOf(count);
			}
			else message="ExcelToDBfail";
		}
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��ɹ���Excel���ݵ���ϵͳ", "ϵͳ��־��ѯ-Excel��־���ݵ���ϵͳ", "t_park_systemLog");
		return importSystemLog();
	}

	//qinzuohai
	public String toDelSystemLog(){return "toDelSystemLog";}
	//�������ڷ�Χɾ����־
	public String delSystemLog(){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		systemLogService.delLogByTime(delStartTime, delEndTime);
		message="delSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��ɹ���"+dateFormat.format(delStartTime)+"��"+dateFormat.format(delEndTime)+"���ڶε���־ɾ��", "ɾ��ϵͳ��־", "t_park_systemLog");
		return "toDelSystemLog";
		}
	
	/**
	 * HTML��ʽ�±����ɷѼ�¼����
	 * @return
	 */
	public String carMonthBillReport(){
		try {
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countCarMonthBill(startTime, endTime);
		    System.out.println("count:"+count);
		    if(count > 10000) {
		    	message = "����HTML��ʽ�±����ɷѼ�¼���������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    
		    System.out.println("startTime:"+startTime+",endTime:"+endTime);
		    
			JasperPrint print=this.reportService.fillReport(jasper1, startTime, endTime, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// �Ƿ����ͼƬ����
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// ��������Ƿ���СͼƬ����
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
	        
	        //��ӡ��ҳ
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

	        exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷѼ�¼����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷѼ�¼����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷѼ�¼����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ�±����ɷѼ�¼����
	 * @return
	 */
	public String carMonthBillReportPDF(){
		try{
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//OutputStream outputStream = null;
			
			//�������ɵı����¼����
		    int count = reportService.countCarMonthBill(startTime, endTime);
		    System.out.println("count:"+count);
		    if(count > 20000) {
		    	message = "����PDF��ʽ�±����ɷѼ�¼���������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"report_carMonthBillReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷѼ�¼����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷѼ�¼����IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷѼ�¼����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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

	// Getters/Setters����
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
