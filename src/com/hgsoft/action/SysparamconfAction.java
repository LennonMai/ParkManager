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
 * 系统参数配置
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
	//excel表格格式
	private String excelFormat;
	//导入的excel文件总行数
	private String rowsNum;
	//上传的文件
	private File excelFile;
	//保存原始的文件名
	private String excelFileFileName;
	//将Excel文件解析完毕后，信息存放到这个对象中
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
	
	// 保存参数到数据库
	public String save() {
		if(sysparamconfService.checkPnameByPname(sysparamconf.getPname())==null){
			
			Sysparamconf scTemp=new Sysparamconf();
			scTemp.setPname(sysparamconf.getPname().trim());
			scTemp.setPtype(sysparamconf.getPtype());
			scTemp.setPvalue(sysparamconf.getPvalue().trim());
			scTemp.setRemark(sysparamconf.getRemark().trim());
			
			sysparamconfService.save(scTemp);
			result = Result.SUCCESS;
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加参数：["+sysparamconf.getPname()+"]成功", "其他参数配置-添加参数", "t_park_sysparamconf");
			scTemp=null;
		}
		else{
			message ="hasPname";
			systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户添加参数：["+sysparamconf.getPname()+"]失败，已经存在该参数", "其他参数配置-添加参数", "t_park_sysparamconf");
			
			return "add";		
		}
		return list();
	}

	// 跳转至参数增加页面
	public String add() {
		return "add";
	}
	//跳转到Excel导入浏览文件页面
    public String toImportExcel(){
    	return "toImportExcel";
    }
	// 根据参数id删除一条参数记录
	public String delete() {
		sysparamconfService.delete(sysparamconf.getSys_id());
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除编号为：["+sysparamconf.getSys_id()+"]的参数成功", "其他参数配置-删除参数", "t_park_sysparamconf");
		message="deleteSuccess";
		return list();
	}

	// 从数据库中查询数据
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

	// 修改一条记录
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
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户修改参数：["+sysparamconf.getPname()+"]成功", "其他参数配置-修改参数", "t_park_sysparamconf");
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
	 * 将Excel数据导入到数据库开始 
	 */
	//根据文件类型创建工作簿
	public Workbook createWorkBook(InputStream is){
		if(excelFileFileName.toLowerCase().endsWith("xls")){
			try {
				return new HSSFWorkbook(is);
			} catch (IOException e) {
				systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时创建工作簿IO异常", "其他参数配置-Excel数据导入", "IOException");
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
	//判断是否是0或1
	public boolean isNumberOneorTwo(String s) {
		String REG_DIGIT="[0-1]";
		if(s.matches(REG_DIGIT))return true;
		return false;	
	}
	//判断参数是否符合标识符规范
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

	
	//导入
	public String excelDataToDB() throws Exception{
			Workbook workbook=createWorkBook(new FileInputStream(excelFile));
			Sheet sheet=workbook.getSheetAt(0);	
			excelWorkSheet=new ExcelWorkSheet<Sysparamconf>();
			//保存工作单名称
			excelWorkSheet.setSheetName(sheet.getSheetName());
			
		// 处理第一行为空或为数字时的异常
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
			//System.out.println("程序本身设计抛出的表头为空的异常 ******");
			systemLogService.save(new Date(), 2,getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时表头为空的空指针异常", "其他参数配置-Excel数据导入", "程序设计抛出NullPointerException");
			e.printStackTrace();
		} 
		catch (IllegalStateException e) {
			//System.out.println("程序本身设计抛出的表头为数字的异常 ******");
			systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时表头为数字的异常", "其他参数配置-Excel数据导入", "程序设计抛出IllegalStateException");
			e.printStackTrace();
		}
		finally{
			String team=null;
			for(int i=1;i<=sheet.getLastRowNum();i++){
				Row row=sheet.getRow(i);		
				try {
					//设置1 - 4列都为字符串型	,且这四列都不为空，为空则执行下一循环	
					row.getCell(0).setCellType(1);
					row.getCell(1).setCellType(1);
					row.getCell(2).setCellType(1);
					row.getCell(3).setCellType(1);			
				} 
				//当有空指针异常时抛出异常，执行下一循环
				catch (NullPointerException e) {
					//System.out.println("程序本身设计抛出的异常 ******");
					e.printStackTrace();
				    continue;
				}
				//当备注为空时，则创建并赋null值,重新做此次循环
				try {
					row.getCell(4).setCellType(1);
				} catch (NullPointerException e) {
					//System.out.println("程序本身设计抛出的异常 ******");
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
						//System.out.println("不存在参数名  Excel数据导入第"+listData.get(i).getSys_id()+"行成功！");
					} else {
						startFailRefleshNum=listData.get(i).getSys_id();
						sysparamconfService.update(listData.get(i));
						//System.out.println("存在参数名  Excel数据导入第"+listData.get(i).getSys_id()+"行成功！");
					}

				}
				rowsNum=String.valueOf(sheet.getLastRowNum()-count);
				if(count!=0){
					message=String.valueOf(count);
				}else message="ExcelToDBfail";
			}
			catch (StaleStateException e){
				//System.out.println("程序本身设计抛出的更新数据时找不到主键的异常1 ******");
				excelFormat="noThisFormate";
				systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时抛出的当参数名已存在但数据库里没有对应序号的异常", "其他参数配置-Excel数据导入", "StaleStateException");
				e.printStackTrace();
			}
			catch (HibernateOptimisticLockingFailureException e){
				//System.out.println("程序本身设计抛出的更新数据时找不到主键的异常 2******");
				excelFormat="noPrimarykey";
				systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时抛出的hibernate找不到主键的异常,更新参数时导入的Excel中序号与页面的编号不对应", "其他参数配置-Excel数据导入", "HibernateOptimisticLockingFailureException");
				e.printStackTrace();
			}
			catch (UncategorizedSQLException e){
				//System.out.println("程序本身设计抛出的更新数据时找不到主键的异常 3******");
				excelFormat="noThisFormate";
				systemLogService.save(new Date(), 2, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将Excel导入数据时抛出的映射的类和数据中的表不对应的异常", "其他参数配置-Excel数据导入", "UncategorizedSQLException");
				e.printStackTrace();
			}	
			
		}
		systemLogService.save(new Date(), 1, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户成功将Excel数据导入系统", "其他参数配置-Excel数据导入系统", "t_park_sysparamconf");
		return "toImportExcel";
	}
	/**
	 * 将Excel数据导入到数据库结束 
	 */
	
	
	/**
	 * 将数据导出到Excel中开始 
	 */
	public String dataToExcel()throws ServletException{
	      List<Sysparamconf> sysparamconfList= new ArrayList<Sysparamconf>();
	      sysparamconfList=sysparamconfService.findAll();
	      try {
	    	  
	    	  //需要成功获取HttpServletResponse才能成功配置响应头
	    	  HttpServletResponse response = ServletActionContext.getResponse();
	    	  //response.setContentType("application/octets-stream;charset=gb2312");
	    	  response.setContentType("octets/stream");//简单可以设置为信息流
		      response.addHeader("Content-Disposition", "attachment;filename=OtherParameterInfo.xls");	      
		      //客户端不缓存
		      response.addHeader("Pragma","no-cache");
		      response.addHeader("Cache-Control","no-cache");
		      ExcelUtil<Sysparamconf> excelUtil = new ExcelUtil<Sysparamconf>();
		      String[] headers = { "编号", "参数名", "参数值", "类别", "备注" };
              OutputStream out = response.getOutputStream();
              excelUtil.exportExcel(headers, sysparamconfList, out);
              //System.out.println("Excel导出成功！");
		      systemLogService.save(new Date(), 1,this.getCurrentOperator() ,  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户导出参数到Excel文件成功", "其他参数配置-数据导出到Excel", "OtherParameterInfo.xls");
              out.close();
              //reset()--Clears any data that exists in the buffer as well as the status code and headers. 
              //If the response has been committed, this method throws an IllegalStateException. 
		      response.reset();
              //response.resetBuffer();
            
	      }catch (IOException e) {
	    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将数据导出到Excel时抛出的IO异常", "其他参数配置-数据导出到Excel", "IOException");
			  e.printStackTrace();
	      }
	    return "dataToExcel";
	}
	/**
	 * 将数据导出到Excel中结束
	 */
	
	
	// Getters/Setters方法
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
