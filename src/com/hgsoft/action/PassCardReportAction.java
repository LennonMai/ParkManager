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
 * @Description ͨ�п����������
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
	 * ͨ�п��쿨�����ǼǱ����ѯҳ��
	 * @return
	 */
	public String passCardHandOutIn() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "passCardHandOutIn";
	}
	/**
	 * ͨ�п�ʹ�÷��˰౨���ѯҳ��
	 * @return
	 */
	public String passCardUsedOperSquad() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "passCardUsedOperSquad";
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
	 * HTML��ʽͨ�п��쿨�����ǼǱ���
	 * @return
	 */
	public String passCardHandOutInReport() {
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countPassCardHandOutIn(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽͨ�п��쿨�����ǼǱ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
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
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�п��쿨�����ǼǱ���",
					"�������--ͨ�п�����--ͨ�п��쿨�����ǼǱ���", "tb_CardHandOutIn");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�п��쿨�����ǼǱ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�п��쿨�����ǼǱ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�п��쿨�����ǼǱ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽͨ�п��쿨�����ǼǱ���
	 * @return
	 */
	public String passCardHandOutInReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countPassCardHandOutIn(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�п��쿨�����ǼǱ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"passCardReport_passCardHandOutInReportPDF.pdf");
			
			this.reportService.trafficFlowPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�п��쿨�����ǼǱ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�п��쿨�����ǼǱ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�п��쿨�����ǼǱ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽͨ�п�ʹ�÷��˰౨��
	 * @return
	 */
	public String passCardUsedOperSquadReport() {
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�����·�ƴ�ӱ�sql���
		    String inlistUnionTable = reportService.inlistUnionTable(startTime, endTime);
		    String outlistUnionTable = reportService.outlistUnionTable(startTime, endTime);
		    
		    //�������ɵı����¼����
		    int count = reportService.countPassCardUsedOperSquad(startTime, endTime, areaNoValue, parkNoValue,
					inlistUnionTable, outlistUnionTable);
		    if(count > 10000) {
		    	message = "����HTML��ʽͨ�п�ʹ�÷��˰౨�������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
	    
			JasperPrint print = this.reportService.passCardUsedOperSquadFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, inlistUnionTable, outlistUnionTable, getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�п�ʹ�÷��˰౨��",
					"�������--ͨ�п�����--ͨ�п�ʹ�÷��˰౨��", "��ʱ��");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�п�ʹ�÷��˰౨��JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�п�ʹ�÷��˰౨��IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�п�ʹ�÷��˰౨��Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽͨ�п�ʹ�÷��˰౨��
	 * @return
	 */
	public String passCardUsedOperSquadReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin=adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//ȡ���ڵ��·�ֵ
		    String startMonth = startTime.substring(5, 7);
		    String endMonth = endTime.substring(5, 7);
		    
		    //�����·�ƴ�ӱ�sql���
		    String inlistUnionTable = reportService.inlistUnionTable(startTime, endTime);
		    String outlistUnionTable = reportService.outlistUnionTable(startTime, endTime);
			
			//�������ɵı����¼����
		    int count = reportService.countPassCardUsedOperSquad(startTime, endTime, areaNoValue, parkNoValue,
					inlistUnionTable, outlistUnionTable);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�п�ʹ�÷��˰౨�������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename="+"passCardReport_passCardUsedOperSquadReportPDF.pdf");
			
			this.reportService.passCardUsedOperSquadPdfStream(inputStream, outputStream,startTime, endTime,
					areaNoValue, parkNoValue, inlistUnionTable, outlistUnionTable,getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�п�ʹ�÷��˰౨��JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�п�ʹ�÷��˰౨��IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�п�ʹ�÷��˰౨��Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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
