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
 * @Description ���������������
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
	 * ת������ͳ�Ʊ���༭ҳ��
	 * @return
	 */
	public String trafficFlowStatistics(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowStatistics";
	}
	/**
	 * ת������ͳ�Ʊ���༭ҳ��
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
	 * ת�������ձ���༭ҳ��
	 * @return
	 */
	public String trafficFlowDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowDay";
	}
	/**
	 * ת�������ձ���༭ҳ��
	 * @return
	 */
	public String trafficFlowGateLaneDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowGateLaneDay";
	}
	/**
	 * ת�������±���༭ҳ��
	 * @return
	 */
	public String trafficFlowMonth(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowMonth";
	}
	/**
	 * ת����ͨ�з��ձ���༭ҳ��
	 * @return
	 */
	public String trafficFlowTollsDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "trafficFlowTollsDay";
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
	 * HTML��ʽ������ͳ�Ʊ���
	 * @return
	 */
	public String trafficFlowStatisticsReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countTrafficFlowStatistics(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽ������ͳ�Ʊ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
	    
			JasperPrint print = this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, 
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
	        
	        //����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ������ͳ�Ʊ���",
					"�������--����������--������ͳ�Ʊ���", "tb_InListSum��tb_OutListSum");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ������ͳ�Ʊ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ������ͳ�Ʊ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ������ͳ�Ʊ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ������ͳ�Ʊ���
	 * @return
	 */
	public String trafficFlowStatisticsReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTrafficFlowStatistics(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽ������ͳ�Ʊ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowStatisticsReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ������ͳ�Ʊ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ������ͳ�Ʊ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ������ͳ�Ʊ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ���������˰��ʱ�α���
	 * @return
	 */
	public String trafficFlowOperSquadDatesReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
		    int count = reportService.countTrafficFlowOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 10000) {
		    	message = "����HTML���������˰��ʱ�α��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    
			JasperPrint print=this.reportService.operSquadDatesFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, pSquadNo, pOperatorNo, getCurrentOperator().getName());
			
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
			
			//����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ���������˰��ʱ�α���",
					"�������--����������--���������˰��ʱ�α���", "tb_InListSum��tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���������˰��ʱ�α���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���������˰��ʱ�α���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���������˰��ʱ�α���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ���������˰��ʱ�α���
	 * @return
	 */
	public String trafficFlowOperSquadDatesReportPDF() {
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 20000) {
		    	message = "����PDF���������˰��ʱ�α��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowOperSquadDatesReportPDF.pdf");
			
			this.reportService.operSquadDatesPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, pSquadNo, pOperatorNo, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���������˰��ʱ�α���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���������˰��ʱ�α���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���������˰��ʱ�α���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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
	 * HTML��ʽ�������ձ���
	 * @return
	 */
	public String trafficFlowDayReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
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
			
			//����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ�������ձ���",
					"�������--����������--�������ձ���", "tb_InListSum��tb_OutListSum");
			
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
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTrafficFlowDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽ�������ձ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowDayReportPDF.pdf");
			
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
		}
		return null;
	}
	
	/**
	 * HTML��ʽ���������ŷֳ�������
	 * @return
	 */
	public String trafficFlowGateLaneDayReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
			int count = reportService.countTrafficFlowGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
			if(count > 10000) {
				message = "����HTML��ʽ���������ŷֳ������������������ѳ���10000����������ѡ���С�����ڷ�Χ";
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
			
			//����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ���������ŷֳ�������",
					"�������--����������--���������ŷֳ�������", "tb_InListSum��tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���������ŷֳ�������JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���������ŷֳ�������IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���������ŷֳ�������Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ���������ŷֳ�������
	 * @return
	 */
	public String trafficFlowGateLaneDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTrafficFlowGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽ���������ŷֳ������������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowGateLaneDayReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���������ŷֳ�������JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���������ŷֳ�������IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���������ŷֳ�������Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ�������±���
	 * @return
	 */
	public String trafficFlowMonthReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
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
		
			JasperPrint print=this.reportService.trafficFlowFillReport(jasper1, startTime, endTime, 
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
	        
	        //����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ�������±���",
					"�������--����������--�������±���", "tb_InListSum��tb_OutListSum");
	        
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
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTrafficFlowMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽ�������±��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowMonthReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
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
		}
		return null;
	}
	
	/**
	 * HTML��ʽ����ͨ�з��ձ���
	 * @return
	 */
	public String trafficFlowTollsDayReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
			int count = reportService.countTrafficFlowTollsDay(startTime, endTime, areaNoValue, parkNoValue);
			if(count > 10000) {
				message = "����HTML��ʽ����ͨ�з��ձ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
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
			
			//����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ����ͨ�з��ձ���",
					"�������--����������--����ͨ�з��ձ���", "tb_InListSum��tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ͨ�з��ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ͨ�з��ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ͨ�з��ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ����ͨ�з��ձ���
	 * @return
	 */
	public String trafficFlowTollsDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
			int count = reportService.countTrafficFlowTollsDay(startTime, endTime, areaNoValue, parkNoValue);
			if(count > 20000) {
				message = "����PDF��ʽ����ͨ�з��ձ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}
			
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"trafficFlowReport_trafficFlowTollsDayReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ͨ�з��ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ͨ�з��ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ͨ�з��ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	// Getters/Setters����
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
