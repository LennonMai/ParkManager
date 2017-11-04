package com.hgsoft.action;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.util.DEScore;
import com.hgsoft.util.JdbcUtil;


/**
 * 
 * @author qinzuohai
 * 
 */
public class SpecialWhiteListControlThread extends Thread {
	
	private HibernateTemplate hibernateTemplate;
	private JdbcUtil jdbc;
	@SuppressWarnings("unused")
	private ServletContext context = null;
	private String SWL_InputFileName=null,SWL_KEY=null;
	private String rootPath = null,realPath = null;
	private DEScore deScore;
	private String tempFile_decrypted=null;
	private boolean canReadFileState=false;
	private StringBuffer readLog=new StringBuffer("");
	private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss.SSS"); 
	private boolean dateLinesState=true;
	private WebApplicationContext wac=null;
	
	/**
	 * 构造函数
	 * @param whiteListControlAction
	 */
	public SpecialWhiteListControlThread(){};
	public SpecialWhiteListControlThread(ServletContext context) {
		this.context = context;
	}
	
	public void run() {
		while (true) {
			//取出key和fileName
			if(this.SWL_KEY==null&&this.SWL_InputFileName==null){
				findKEYandINPUTFILENAME();
			}
			if(this.SWL_KEY!=null&&this.SWL_InputFileName!=null){
				monitorHandle(this.SWL_KEY,this.SWL_InputFileName);
			}
			
			// 休眠3秒
			try {
				Thread.sleep(3 * 1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 查询SWL_KEY，SWL_InputFileName参数
	 */
	@SuppressWarnings("unchecked")
	private void findKEYandINPUTFILENAME(){
		List<Sysparamconf> li =this.getHibernateTemplate().find("from Sysparamconf");
		for(Sysparamconf s:li){
			if(s.getPname().equals("SWL_InputFileName")){
				this.SWL_InputFileName=s.getPvalue();
				//System.out.println(s.getPvalue());
			}
			if(s.getPname().equals("SWL_KEY")){
				this.SWL_KEY=s.getPvalue();
				//System.out.println(s.getPvalue());
			}
			
		}
	}
	
	/**
	 * 监听特定文件夹里的文件，如果文件名正确则解密入库，并出库加密生成日志文件
	 * @param key
	 * @param inputFileName
	 */
	public void monitorHandle(String key,String inputFileName){
		try {

			wac = ContextLoader.getCurrentWebApplicationContext();
			if(wac==null){
				System.out.println("**********\nwebApplicationContext is null , restart Server to handle this problem.\n***********************************************************************");
			}
			rootPath=wac.getServletContext().getRealPath("");
			realPath=wac.getServletContext().getRealPath("/sysConfigHandle");
							
			File DIR=new File(realPath);
			
			/**
			 *判断收费存在 sysConfigHandle目录，不存在则创建
			 */
			if(DIR.exists()){
				//判断收费存在其他参数里配置的文件
				if(isExitFile(realPath, inputFileName)){
					readLog.append(formatter.format(new Date())+"\t\t"+"正在解析文件["+inputFileName+"]..."+"\r\n");
					
					//创建临时目录 设置为隐藏
					File tempDIR=new File(rootPath+"/temp");
					if(!tempDIR.exists())tempDIR.mkdir();
					String sets = " attrib +H \"" + tempDIR.getAbsolutePath() + "\""; 
					Runtime.getRuntime().exec(sets); 
	
					//临时文件目录路径
					String tempPath=tempDIR.getPath();
					
					this.deScore=new DEScore(key);
					
					//解密后待处理的临时文件
					tempFile_decrypted=tempPath+File.separator +inputFileName.replace("dll", "temp~");
					
					//文件解密后，生成temp\sysConfig.temp~临时文件
					if (realPath.endsWith(File.separator)){
						this.deScore.decrypt(realPath+inputFileName,tempFile_decrypted);
					}else{
						this.deScore.decrypt(realPath+ File.separator +inputFileName, tempFile_decrypted);
					}
					
					//读临时文件入库
					ReadTempFileToDB(key,this.tempFile_decrypted);
				
					//删除sysConfig.temp~临时文件
					this.deleteFile(tempPath, "sysConfig.temp~");
					
					if(canReadFileState){
						if(dateLinesState){
							readLog.append(formatter.format(new Date())+"\t\t"+"文件["+inputFileName+"]格式正确."+"\r\n");
							
							//成功入库后删除 sysConfigHandle目录下的文件
							this.deleteALLFile(realPath);
							
							//出库文件
							String export_tempFile=tempPath+File.separator+"export_"+inputFileName.replace("dll", "temp~");
							//出库生成文件
							ExportDataToTempPath("tb_TestWL",export_tempFile);
							this.deScore.encrypt(export_tempFile, realPath+File.separator+"Back_"+inputFileName);
							
							//删除temp目录下的文件
							this.deleteALLFile(tempPath);
							//删除temp目录
							this.deleteDIR(tempPath);
							
							readLog.append(formatter.format(new Date())+"\t\t"+"文件["+inputFileName+"]解析成功."+"\r\n");
							readLog.append(formatter.format(new Date())+"\t\t"+"系统返回文件：Back_"+inputFileName+"\r\n");
						
						}
						else{
							readLog.append(formatter.format(new Date())+"\t\t"+"数据行格式不规范."+"\r\n");
							
						}

					}
					else{
						readLog.append(formatter.format(new Date())+"\t\t"+"文件["+inputFileName+"]格式不正确."+"\r\n");
					}
					
					ExportLog(readLog.toString(),realPath+File.separator+"Log.txt");
					
					//完成操作后，重置参数值
					canReadFileState=false;
					dateLinesState=true;
					readLog=new StringBuffer("");
				
				}else{
					
					//System.out.println("No exit file:"+inputFileName+"!");
				}
				
			}else{
				DIR.mkdir();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void ReadTempFileToDB(String key,String decryptedFile){
		try {
			String startTip="<data>";
			String endTip="</data>";
			boolean fileFormateTip=false;
			String LineContent=null;//行内容
			String CardNo=null;
			String VehPlate=null;
			String OwnerName=null;
			String ObuId=null;
			String FirTime=null;//datetime
			String InvalidateTime=null;//datetime
			String GenTime=null;//datetime
			String VehPlateImage=null;//image
			String dataAction=null;
			
			FileReader reader = new FileReader(decryptedFile);
			FileReader tempReader = new FileReader(decryptedFile);
			BufferedReader br = new BufferedReader(reader);
			BufferedReader tempBr = new BufferedReader(tempReader);
			String[] title = new String[9];
			
			try {
				//判断文件中是否有开始和结束标志
				boolean tipStart=false,tipEnd=false;
				while((LineContent=tempBr.readLine())!= null){
					if(LineContent.trim().equals(startTip))tipStart=true;
					if(LineContent.trim().equals(endTip))  tipEnd  =true;	
				}
				if(tipStart==false&&tipEnd==false){
					fileFormateTip=false;
					readLog.append(formatter.format(new Date())+"\t\t"+"文件无开始、结束标识 [<data>]、[</data>]，文件格式不完整。\r\n");
				}
				if(tipStart==true&&tipEnd==false){
					fileFormateTip=false;
					readLog.append(formatter.format(new Date())+"\t\t"+"文件开始标识 [<data>] 正确，结束标识[</data>] 缺失，文件格式不完整。\r\n");
				}
				if(tipStart==false&&tipEnd==true){
					fileFormateTip=false;
					readLog.append(formatter.format(new Date())+"\t\t"+"文件开始标识 [<data>] 缺失，结束标识[</data>] 正确，文件格式不完整。\r\n");
				}
				if(tipStart&&tipEnd){
					fileFormateTip=true;
					readLog.append(formatter.format(new Date())+"\t\t"+"文件开始标识 [<data>] 正确，结束标识 [</data>] 正确，开始读取下一行...\r\n");
				}
				//System.out.println("fileFormateTip start:"+fileFormateTip);
				
				//开始和结束标志正确则读取文件内容
				if(fileFormateTip){	
					/**
					 * 表头顺序CardNo	VehPlate	OwnerName	ObuId	FirTime	InvalidateTime	GenTime	VehPlateImage	dataAction	
					 */
					LineContent=null;
					while((LineContent=br.readLine())!= null){
						title = LineContent.split("\t");
						if(title[0].trim().equals("CardNo")&&
								title[1].trim().equals("VehPlate")&&
								title[2].trim().equals("OwnerName")&&
								title[3].trim().equals("ObuId")&&
								title[4].trim().equals("FirTime")&&
								title[5].trim().equals("InvalidateTime")&&
								title[6].trim().equals("GenTime")&&
								title[7].trim().equals("VehPlateImage")&&
								title[8].trim().equals("dataAction")){
							canReadFileState=true;
							readLog.append(formatter.format(new Date())+"\t\t"+"文件表头行正确，开始读取数据行...\r\n");
							break;
						}
					}	
					//System.out.println("canReadFileState:"+canReadFileState);
					
					//如果表头正确则读取内容                    
					if(canReadFileState){
						String[] content = new String[9];
						int count=0;
						while( (LineContent=br.readLine()) != null){
							count++;
							content  = LineContent.split("\t");
							
							if(LineContent.trim().equals(endTip)){
								canReadFileState=true;
								readLog.append(formatter.format(new Date())+"\t\t"+"文件读取完毕。\r\n");
								break;
							}
							else if(content.length==9&&
									!content[0].trim().equals("")&&
									!content[1].trim().equals("")&&
									!content[2].trim().equals("")&&
									!content[3].trim().equals("")&&
									!content[4].trim().equals("")&&
									!content[5].trim().equals("")&&
									!content[6].trim().equals("")&&
									!content[7].trim().equals("")&&
									!content[8].trim().equals("")){
								
								canReadFileState=true;
								
								CardNo=content[0].trim();
								VehPlate=content[1].trim();
								OwnerName=content[2].trim();
								ObuId=content[3].trim();
								FirTime=content[4].trim();
								InvalidateTime=content[5].trim();
								GenTime=content[6].trim();
								VehPlateImage=content[7].trim();
								dataAction=content[8].trim();
								//System.out.println("-------------------------------------------------------------------------------------");
								//System.out.println(CardNo+"\t"+VehPlate+"\t\t"+OwnerName+"\t"+ObuId+"\t"+FirTime+"\t"+InvalidateTime+"\t"+GenTime+"\t"+VehPlateImage+"\t"+dataAction);
								//入库
								SaveOrUpdateOrDelete( CardNo, VehPlate, OwnerName, ObuId, FirTime, InvalidateTime, GenTime, VehPlateImage,dataAction);	
								
								readLog.append(formatter.format(new Date())+"\t\t"+"正确读取数据行 "+count+" ...\r\n");
								
							}
							else{
								//空行
								if(LineContent.equals("")){
									readLog.append(formatter.format(new Date())+"\t\t"+"读取到空行 --> "+count+" ...\r\n");
								}else{
									readLog.append(formatter.format(new Date())+"\t\t"+"读取到格式不规范的数据行 "+" --> "+count+" ...\r\n");
									dateLinesState=false;
								}
							}

						}
						
						
					}else{
						canReadFileState=false;
						readLog.append(formatter.format(new Date())+"\t\t"+"文件表头行不正确，读取数据行终止。\r\n");
					}
					
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}finally{
				//将FileReader 、 BufferedReader 关闭 
				try {
					reader.close();
					tempReader.close();
					br.close();
					tempBr.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} 
	}
	/**
	 * 
	 * @param CardNo
	 * @param VehPlate
	 * @param OwnerName
	 * @param ObuId
	 * @param FirTime
	 * @param InvalidateTime
	 * @param GenTime
	 * @param VehPlateImage
	 * @param dataAction
	 */
	public void SaveOrUpdateOrDelete(String CardNo,String VehPlate,String OwnerName,String ObuId,String FirTime,String InvalidateTime,String GenTime,String VehPlateImage,String dataAction){
		//Save
		if(dataAction.equals("1")){
			if(jdbc.selectForList("select * from tb_TestWL where CardNo='"+CardNo+"' and VehPlate='"+VehPlate+"'").isEmpty()){
				//System.out.println("insert:"+CardNo+" "+VehPlate);
				jdbc.save("insert into tb_TestWL(CardNo,VehPlate,OwnerName,ObuId,FirTime,InvalidateTime,GenTime,VehPlateImage)" +
						"values( '"+CardNo   		+"'," +
								"'"+VehPlate 		+"'," +
								"'"+OwnerName		+"'," +
								"'"+ObuId   		+"'," +
								"'"+FirTime			+"'," +
								"'"+InvalidateTime	+"'," +
								"'"+GenTime			+"'," +
								"'"+VehPlateImage	+"')");
				
			}
			// else{
			// //System.out.println("update:"+CardNo+" "+VehPlate);
			// jdbc.update("UPDATE tb_TestWL "+
			// "SET CardNo		  ='"+CardNo+"'"+
			// "   ,VehPlate	  ='"+VehPlate+"'"+
			// "   ,OwnerName	  ='"+OwnerName+"'"+
			// "   ,ObuId	   	  ='"+ObuId+"'"+
			// "   ,FirTime		  ='"+FirTime+"'"+
			// "   ,InvalidateTime='"+InvalidateTime+"'"+
			// "   ,GenTime		  ='"+GenTime+"'"+
			// "   ,VehPlateImage ='"+VehPlateImage+"'"+
			// "WHERE CardNo='"+CardNo+"' and VehPlate='"+VehPlate+"'");
			// }
		}
		//Delete
		if(dataAction.equals("0")){
			//System.out.println("delete:"+CardNo+" "+VehPlate);
			if(!jdbc.selectForList("select * from tb_TestWL where CardNo='"+CardNo+"' and VehPlate='"+VehPlate+"'").isEmpty()){
				jdbc.delete("delete from tb_TestWL where CardNo='"+CardNo+"' and VehPlate='"+VehPlate+"'");
			}
		}
		
	}
	/**
	 * 
	 * @param tableName
	 * @param tempFile
	 */
	public void ExportDataToTempPath(String tableName,String tempFile){
		BufferedWriter bw;
		try {
			bw = new BufferedWriter(new FileWriter(tempFile));
			bw.write(getData(tableName).toString());
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	/**
	 * 
	 * @param Log
	 * @param realPath
	 */
	public void ExportLog(String Log,String realPath){
		BufferedWriter bw;
		try {
			bw = new BufferedWriter(new FileWriter(realPath));
			bw.append(Log);
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 
	 * @param tableName
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String getData(String tableName){
		StringBuffer sql=new StringBuffer("select ");
		StringBuffer txtlist=new StringBuffer("\r\n");
		String sql_U="select name from syscolumns where id in (select id from sysobjects where name = '"+tableName+"') ";
        
		List list_u=jdbc.selectForList(sql_U);
		
		if(!list_u.isEmpty()){
			String[] fields=new String[list_u.size()];
			for(int i=0;i<list_u.toArray().length;i++){
				fields[i]=list_u.toArray()[i].toString().split("=")[1].split("}")[0];
				txtlist.append(list_u.toArray()[i].toString().split("=")[1].split("}")[0]+"\t");
				sql.append(list_u.toArray()[i].toString().split("=")[1].split("}")[0]+",");
			}
			sql = sql.replace(sql.length() - 1, sql.length(), " ");
			sql.append("from "+tableName);
			
			txtlist.append("\r\n\r\n");
			List list=jdbc.selectForList(sql.toString());
		
			if(!list.isEmpty()){
				Iterator it = list.iterator();
				while(it.hasNext()) {
				    Map userMap = (Map) it.next();    
				    for(int i=0;i<fields.length;i++){
				    	txtlist.append(userMap.get(fields[i])+"\t");
				    }
				    txtlist.append("\r\n");
				}
				txtlist.append("\r\n\r\n");
				return txtlist.toString();
			}else{
				return null;
			}
		}else{
			return null;
		}
	}
	
	/**
	 * 操作台输出目录下的所有文件
	 * @param realPath
	 */
	public void showFiles(String realPath) {
		File dir = new File(realPath);
		File[] files = dir.listFiles();

		for (int i = 0; i < files.length; i++) {
			// 目录下的文件
			if (files[i].isFile()) {
				System.out.println("目录下的文件:"+files[i].getName());
			}

			// 目录下的目录
			if (files[i].isDirectory()) {
				System.out.println("目录下的目录"+files[i].getName());
			}
		}

	}

	/**
	 * 判断目录下文件是否存在
	 * @param realPath
	 * @param fileName
	 * @return
	 */
	public boolean isExitFile(String realPath,String fileName){
		File dir = new File(realPath);
		File[] files = dir.listFiles();
		for (int i = 0; i < files.length; i++) {
			if (files[i].isFile()) {
				if(files[i].getName().equals(fileName.trim())){
					return true;
				}
				
			}
		}
		return false;
	}
	
	/**
	 * 删除文件
	 * @param realPath
	 * @param deleteFileName
	 * @return
	 */
	public boolean deleteFile(String realPath,String deleteFileName){
		File dir = new File(realPath);
		File[] files = dir.listFiles();
		//File  temp = null; 
		boolean result;
		for(int i=0;i<files.length;i++){
			if (files[i].isFile()) {
				if(files[i].getName().equals(deleteFileName.trim())){
					// if (realPath.endsWith(File.separator))
					// temp = new File(realPath + files[i]);
					// else
					// temp = new File(realPath + File.separator + files[i]);
					result=files[i].delete();
					if(result)return true;
				}
			}
		}
		return false;
	}
	
	public void deleteALLFile(String realPath){
		File dir = new File(realPath);
		File[] files = dir.listFiles();
		for(int i=0;i<files.length;i++){
			files[i].delete();
			if(files[i].exists()){
				String del=" cmd /c del "+files[i];
				try {
					Runtime.getRuntime().exec(del);
				} catch (IOException e) {
					e.printStackTrace();
				} 
			}
		}
	}
	
	/**
	 * 删除目录
	 * @param realPath
	 * @return
	 */
	public boolean deleteDIR(String realPath){
		File dir = new File(realPath);
		String sets = " attrib +H \"" +realPath + "\""; 
		try {
			Runtime.getRuntime().exec(sets);
		} catch (IOException e) {
			e.printStackTrace();
		} 
		if(dir.isDirectory()){
			dir.delete();
			if(dir.exists()){
				String del = "  cmd /c  rmdir /s/q   " +realPath; 
				try {
					Runtime.getRuntime().exec(del);
				} catch (IOException e) {
					e.printStackTrace();
				} 
			}	
			return true;
		}
		return false;
	}
	
	//转码方法
	public String getGBKSting(String str){
		String getString=null;
		try {
		    getString= new String(str.getBytes("ISO8859-1"),"GBK");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return getString;
	}
	
	/**
	 * Getter/Setter方法注入HibernateTemplate
	 */
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public JdbcUtil getJdbc() {
		return jdbc;
	}

	public void setJdbc(JdbcUtil jdbc) {
		this.jdbc = jdbc;
	}
}
