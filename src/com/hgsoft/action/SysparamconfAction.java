package com.hgsoft.action;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.struts2.ServletActionContext;
import org.hibernate.StaleStateException;
import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.util.ExcelUtil;
import com.hgsoft.util.ExcelWorkSheet;
/**
 * 
 * @author qinzuohai
 * ϵͳ��������
 */
@Controller
@Scope("prototype")
public class SysparamconfAction extends BaseAction  {

	@Resource
	private SysparamconfService sysparamconfService;
	private Sysparamconf sysparamconf;
	@Resource
	private SystemLogService systemLogService; 


	private Integer startFailRefleshNum;	
	//excel����ʽ
	private String excelFormat;
	//�����excel�ļ�������
	private String rowsNum;
	//�ϴ����ļ�
	private File excelFile;
	//����ԭʼ���ļ���
	private String excelFileFileName;
	//��Excel�ļ�������Ϻ���Ϣ��ŵ����������
	private ExcelWorkSheet<Sysparamconf> excelWorkSheet;
	
	public String list() {
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("pname");
		session.removeAttribute("pvalue");
		session.removeAttribute("ptype");
		session.removeAttribute("remark");
		
		list = sysparamconfService.findByPager(pager);
		return "list";
	}
	
	// ������������ݿ�
	public String save() {
		if(sysparamconfService.checkPnameByPname(sysparamconf.getPname())==null){
			
			Sysparamconf scTemp=new Sysparamconf();
			scTemp.setPname(sysparamconf.getPname().trim());
			scTemp.setPtype(sysparamconf.getPtype());
			scTemp.setPvalue(sysparamconf.getPvalue().trim());
			scTemp.setRemark(sysparamconf.getRemark().trim());
			
			sysparamconfService.save(scTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Ӳ�����["+sysparamconf.getPname()+"]�ɹ�", "������������-��Ӳ���", "t_park_sysparamconf");
			scTemp=null;
		}
		else{
			message ="hasPname";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Ӳ�����["+sysparamconf.getPname()+"]ʧ�ܣ��Ѿ����ڸò���", "������������-��Ӳ���", "t_park_sysparamconf");
			
			return "add";		
		}
		return list();
	}

	// ��ת����������ҳ��
	public String add() {
		return "add";
	}
	//��ת��Excel��������ļ�ҳ��
    public String toImportExcel(){
    	return "toImportExcel";
    }
	// ���ݲ���idɾ��һ��������¼
	public String delete() {
		sysparamconfService.delete(sysparamconf.getSys_id());
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ�����Ϊ��["+sysparamconf.getSys_id()+"]�Ĳ����ɹ�", "������������-ɾ������", "t_park_sysparamconf");
		message="deleteSuccess";
		return list();
	}

	// �����ݿ��в�ѯ����
	public String query() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.removeAttribute("currentPage");
		session.removeAttribute("pageSize");
		session.removeAttribute("rowIndex");
		session.removeAttribute("pname");
		session.removeAttribute("pvalue");
		session.removeAttribute("ptype");
		session.removeAttribute("remark");
		
		if (!sysparamconf.getPname().equals("")
				|| !sysparamconf.getPvalue().equals("")
				|| sysparamconf.getPtype() != null
				|| !sysparamconf.getRemark().equals("")) {
			
			session.setAttribute("pname", sysparamconf.getPname());
			session.setAttribute("pvalue", sysparamconf.getPvalue());
			session.setAttribute("ptype",sysparamconf.getPtype());
			session.setAttribute("remark",sysparamconf.getRemark());
			
			list = sysparamconfService.queryForAll(pager, sysparamconf
					.getPname(), sysparamconf.getPvalue(), sysparamconf
					.getPtype(), sysparamconf.getRemark());
			return "query";

		} 
		else {
			return list();
		}
	}

	public String edit() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("currentPage", this.pager.getCurrentPage());
		session.setAttribute("pageSize", this.pager.getPageSize());
		session.setAttribute("rowIndex", this.pager.getRowIndex());
		
		sysparamconf = sysparamconfService.load(sysparamconf.getSys_id());
		return EDIT;
	}

	// �޸�һ����¼
	public String update() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		this.pager.setCurrentPage(session.getAttribute("currentPage").toString().trim());
		this.pager.setPageSize(session.getAttribute("pageSize").toString().trim());
		this.pager.setRowIndex(session.getAttribute("rowIndex").toString().trim());
		
		Sysparamconf temp = sysparamconfService.get(sysparamconf.getSys_id());
		temp.setPname(sysparamconf.getPname().trim());
		temp.setPvalue(sysparamconf.getPvalue().trim());
		temp.setPtype(sysparamconf.getPtype());
		temp.setRemark(sysparamconf.getRemark().trim());
		
		sysparamconfService.update(temp);
		message="updateSuccess";
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��޸Ĳ�����["+sysparamconf.getPname()+"]�ɹ�", "������������-�޸Ĳ���", "t_park_sysparamconf");
		temp=null;
		if(session.getAttribute("pname")!=null
				||session.getAttribute("pvalue")!=null
				||session.getAttribute("ptype")!=null
				||session.getAttribute("remark")!=null){
			if(session.getAttribute("ptype")==null){
				list = sysparamconfService.queryForAll(pager, session.getAttribute("pname").toString(),
						session.getAttribute("pvalue").toString(), 
						null,
						session.getAttribute("remark").toString());
				
				sysparamconf.setPname(session.getAttribute("pname").toString());
				sysparamconf.setPvalue(session.getAttribute("pvalue").toString());
				sysparamconf.setPtype(null);
				sysparamconf.setRemark(session.getAttribute("remark").toString());
			}else{
				list = sysparamconfService.queryForAll(pager, session.getAttribute("pname").toString(),
						session.getAttribute("pvalue").toString(), 
						Integer.parseInt(session.getAttribute("ptype").toString().trim()),
						session.getAttribute("remark").toString());
				
				sysparamconf.setPname(session.getAttribute("pname").toString());
				sysparamconf.setPvalue(session.getAttribute("pvalue").toString());
				sysparamconf.setPtype(Integer.parseInt(session.getAttribute("ptype").toString().trim()));
				sysparamconf.setRemark(session.getAttribute("remark").toString());
			}
			return "query";
		}else{
			list = sysparamconfService.findByPager(pager);
			return "list";
		}
	}

	
	/**
	 * ��Excel���ݵ��뵽���ݿ⿪ʼ 
	 */
	//�����ļ����ʹ���������
	public Workbook createWorkBook(InputStream is){
		if(excelFileFileName.toLowerCase().endsWith("xls")){
			try {
				return new HSSFWorkbook(is);
			} catch (IOException e) {
				systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ����������IO�쳣", "������������-Excel���ݵ���", "IOException");
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
	//�ж��Ƿ���0��1
	public boolean isNumberOneorTwo(String s) {
		String REG_DIGIT="[0-1]";
		if(s.matches(REG_DIGIT))return true;
		return false;	
	}
	//�жϲ����Ƿ���ϱ�ʶ���淶
	public boolean validatePname(String input) {
		if(!String.valueOf(input.charAt(0)).equals("$")){
			int pos = 0;
			if (Character.isJavaIdentifierStart(input.charAt(pos))) {
				while (++pos < input.length()) {
					if (!Character.isJavaIdentifierPart(input.charAt(pos))) {
						return false;
					}
				}
				return true;
			}
		}
		return false;
	}

	
	//����
	public String excelDataToDB() throws Exception{
			Workbook workbook=createWorkBook(new FileInputStream(excelFile));
			Sheet sheet=workbook.getSheetAt(0);	
			excelWorkSheet=new ExcelWorkSheet<Sysparamconf>();
			//���湤��������
			excelWorkSheet.setSheetName(sheet.getSheetName());
			
		// �����һ��Ϊ�ջ�Ϊ����ʱ���쳣
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
			//System.out.println("����������׳��ı�ͷΪ�յ��쳣 ******");
			systemLogService.save(new Date(), 2,getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ��ͷΪ�յĿ�ָ���쳣", "������������-Excel���ݵ���", "��������׳�NullPointerException");
			e.printStackTrace();
		} 
		catch (IllegalStateException e) {
			//System.out.println("����������׳��ı�ͷΪ���ֵ��쳣 ******");
			systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ��ͷΪ���ֵ��쳣", "������������-Excel���ݵ���", "��������׳�IllegalStateException");
			e.printStackTrace();
		}
		finally{
			String team=null;
			for(int i=1;i<=sheet.getLastRowNum();i++){
				Row row=sheet.getRow(i);		
				try {
					//����1 - 4�ж�Ϊ�ַ�����	,�������ж���Ϊ�գ�Ϊ����ִ����һѭ��	
					row.getCell(0).setCellType(1);
					row.getCell(1).setCellType(1);
					row.getCell(2).setCellType(1);
					row.getCell(3).setCellType(1);			
				} 
				//���п�ָ���쳣ʱ�׳��쳣��ִ����һѭ��
				catch (NullPointerException e) {
					//System.out.println("����������׳����쳣 ******");
					e.printStackTrace();
				    continue;
				}
				//����עΪ��ʱ���򴴽�����nullֵ,�������˴�ѭ��
				try {
					row.getCell(4).setCellType(1);
				} catch (NullPointerException e) {
					//System.out.println("����������׳����쳣 ******");
					e.printStackTrace();
					row.createCell(4).setCellValue("null");
					i=i-1;
					continue;
				}
				
				Sysparamconf sysparamconf=new Sysparamconf();
				if(!row.getCell(0).getStringCellValue().equals("")&&isNumber(row.getCell(0).getStringCellValue())){						
					sysparamconf.setSys_id(Integer.valueOf(row.getCell(0).getStringCellValue()));
				}else continue;
				
				if(!row.getCell(1).getStringCellValue().equals("")&&validatePname(row.getCell(1).getStringCellValue())==true){					
					sysparamconf.setPname(row.getCell(1).getStringCellValue());
				}else continue;
				
				if(!row.getCell(2).getStringCellValue().equals("")){					
					sysparamconf.setPvalue(row.getCell(2).getStringCellValue());
				}else continue;
				
				if(!row.getCell(3).getStringCellValue().equals("")&&isNumber(row.getCell(3).getStringCellValue())&&isNumberOneorTwo(row.getCell(3).getStringCellValue())){			
					sysparamconf.setPtype(Integer.valueOf(row.getCell(3).getStringCellValue()));
				}else continue;
				
				if(row.getCell(4).getStringCellValue().equals("null")){
					team="";
					sysparamconf.setRemark(team);
				}else sysparamconf.setRemark(row.getCell(4).getStringCellValue());
				
				excelWorkSheet.getData().add(sysparamconf);
			}
			
			List<Sysparamconf> listData=excelWorkSheet.getData();
			try{
				int count=0;
				for (int i = 0; i < listData.size(); i++) {
					count++;
					if (sysparamconfService.checkPnameByPname(listData.get(i).getPname()) == null) {
						sysparamconfService.save(listData.get(i));
						//System.out.println("�����ڲ�����  Excel���ݵ����"+listData.get(i).getSys_id()+"�гɹ���");
					} else {
						startFailRefleshNum=listData.get(i).getSys_id();
						sysparamconfService.update(listData.get(i));
						//System.out.println("���ڲ�����  Excel���ݵ����"+listData.get(i).getSys_id()+"�гɹ���");
					}

				}
				rowsNum=String.valueOf(sheet.getLastRowNum()-count);
				if(count!=0){
					message=String.valueOf(count);
				}else message="ExcelToDBfail";
			}
			catch (StaleStateException e){
				//System.out.println("����������׳��ĸ�������ʱ�Ҳ����������쳣1 ******");
				excelFormat="noThisFormate";
				systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ�׳��ĵ��������Ѵ��ڵ����ݿ���û�ж�Ӧ��ŵ��쳣", "������������-Excel���ݵ���", "StaleStateException");
				e.printStackTrace();
			}
			catch (HibernateOptimisticLockingFailureException e){
				//System.out.println("����������׳��ĸ�������ʱ�Ҳ����������쳣 2******");
				excelFormat="noPrimarykey";
				systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ�׳���hibernate�Ҳ����������쳣,���²���ʱ�����Excel�������ҳ��ı�Ų���Ӧ", "������������-Excel���ݵ���", "HibernateOptimisticLockingFailureException");
				e.printStackTrace();
			}
			catch (UncategorizedSQLException e){
				//System.out.println("����������׳��ĸ�������ʱ�Ҳ����������쳣 3******");
				excelFormat="noThisFormate";
				systemLogService.save(new Date(), 2, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û���Excel��������ʱ�׳���ӳ�����������еı���Ӧ���쳣", "������������-Excel���ݵ���", "UncategorizedSQLException");
				e.printStackTrace();
			}	
			
		}
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��ɹ���Excel���ݵ���ϵͳ", "������������-Excel���ݵ���ϵͳ", "t_park_sysparamconf");
		return "toImportExcel";
	}
	/**
	 * ��Excel���ݵ��뵽���ݿ���� 
	 */
	
	
	/**
	 * �����ݵ�����Excel�п�ʼ 
	 */
	public String dataToExcel()throws ServletException{
	      List<Sysparamconf> sysparamconfList= new ArrayList<Sysparamconf>();
	      sysparamconfList=sysparamconfService.findAll();
	      try {
	    	  
	    	  //��Ҫ�ɹ���ȡHttpServletResponse���ܳɹ�������Ӧͷ
	    	  HttpServletResponse response = ServletActionContext.getResponse();
	    	  //response.setContentType("application/octets-stream;charset=gb2312");
	    	  response.setContentType("octets/stream");//�򵥿�������Ϊ��Ϣ��
		      response.addHeader("Content-Disposition", "attachment;filename=OtherParameterInfo.xls");	      
		      //�ͻ��˲�����
		      response.addHeader("Pragma","no-cache");
		      response.addHeader("Cache-Control","no-cache");
		      ExcelUtil<Sysparamconf> excelUtil = new ExcelUtil<Sysparamconf>();
		      String[] headers = { "���", "������", "����ֵ", "���", "��ע" };
              OutputStream out = response.getOutputStream();
              excelUtil.exportExcel(headers, sysparamconfList, out);
              //System.out.println("Excel�����ɹ���");
		      systemLogService.save(new Date(), 1,this.getCurrentOperator() ,  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�����������Excel�ļ��ɹ�", "������������-���ݵ�����Excel", "OtherParameterInfo.xls");
              out.close();
              //reset()--Clears any data that exists in the buffer as well as the status code and headers. 
              //If the response has been committed, this method throws an IllegalStateException. 
		      response.reset();
              //response.resetBuffer();
            
	      }catch (IOException e) {
	    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û������ݵ�����Excelʱ�׳���IO�쳣", "������������-���ݵ�����Excel", "IOException");
			  e.printStackTrace();
	      }
	    return "dataToExcel";
	}
	/**
	 * �����ݵ�����Excel�н���
	 */
	
	
	// Getters/Setters����
	public Sysparamconf getSysparamconf() {
		return sysparamconf;
	}

	public void setSysparamconf(Sysparamconf sysparamconf) {
		this.sysparamconf = sysparamconf;
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

	public ExcelWorkSheet<Sysparamconf> getExcelWorkSheet() {
		return excelWorkSheet;
	}

	public void setExcelWorkSheet(ExcelWorkSheet<Sysparamconf> excelWorkSheet) {
		this.excelWorkSheet = excelWorkSheet;
	}
	public String getRowsNum() {
		return rowsNum;
	}

	public void setRowsNum(String rowsNum) {
		this.rowsNum = rowsNum;
	}
	public String getExcelFormat() {
		return excelFormat;
	}

	public void setExcelFormat(String excelFormat) {
		this.excelFormat = excelFormat;
	}
	public Integer getStartFailRefleshNum() {
		return startFailRefleshNum;
	}

	public void setStartFailRefleshNum(Integer startFailRefleshNum) {
		this.startFailRefleshNum = startFailRefleshNum;
	}
}
