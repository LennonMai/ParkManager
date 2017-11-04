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
	 * ���캯��
	 * @param whiteListControlAction
	 */
	public SpecialWhiteListControlThread(){};
	public SpecialWhiteListControlThread(ServletContext context) {
		this.context = context;
	}
	
	public void run() {
		while (true) {
			//ȡ��key��fileName
			if(this.SWL_KEY==null&&this.SWL_InputFileName==null){
				findKEYandINPUTFILENAME();
			}
			if(this.SWL_KEY!=null&&this.SWL_InputFileName!=null){
				monitorHandle(this.SWL_KEY,this.SWL_InputFileName);
			}
			
			// ����3��
			try {
				Thread.sleep(3 * 1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * ��ѯSWL_KEY��SWL_InputFileName����
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
	 * �����ض��ļ�������ļ�������ļ�����ȷ�������⣬���������������־�ļ�
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
			 *�ж��շѴ��� sysConfigHandleĿ¼���������򴴽�
			 */
			if(DIR.exists()){
				//�ж��շѴ����������������õ��ļ�
				if(isExitFile(realPath, inputFileName)){
					readLog.append(formatter.format(new Date())+"\t\t"+"���ڽ����ļ�["+inputFileName+"]..."+"\r\n");
					
					//������ʱĿ¼ ����Ϊ����
					File tempDIR=new File(rootPath+"/temp");
					if(!tempDIR.exists())tempDIR.mkdir();
					String sets = " attrib +H \"" + tempDIR.getAbsolutePath() + "\""; 
					Runtime.getRuntime().exec(sets); 
	
					//��ʱ�ļ�Ŀ¼·��
					String tempPath=tempDIR.getPath();
					
					this.deScore=new DEScore(key);
					
					//���ܺ���������ʱ�ļ�
					tempFile_decrypted=tempPath+File.separator +inputFileName.replace("dll", "temp~");
					
					//�ļ����ܺ�����temp\sysConfig.temp~��ʱ�ļ�
					if (realPath.endsWith(File.separator)){
						this.deScore.decrypt(realPath+inputFileName,tempFile_decrypted);
					}else{
						this.deScore.decrypt(realPath+ File.separator +inputFileName, tempFile_decrypted);
					}
					
					//����ʱ�ļ����
					ReadTempFileToDB(key,this.tempFile_decrypted);
				
					//ɾ��sysConfig.temp~��ʱ�ļ�
					this.deleteFile(tempPath, "sysConfig.temp~");
					
					if(canReadFileState){
						if(dateLinesState){
							readLog.append(formatter.format(new Date())+"\t\t"+"�ļ�["+inputFileName+"]��ʽ��ȷ."+"\r\n");
							
							//�ɹ�����ɾ�� sysConfigHandleĿ¼�µ��ļ�
							this.deleteALLFile(realPath);
							
							//�����ļ�
							String export_tempFile=tempPath+File.separator+"export_"+inputFileName.replace("dll", "temp~");
							//���������ļ�
							ExportDataToTempPath("tb_TestWL",export_tempFile);
							this.deScore.encrypt(export_tempFile, realPath+File.separator+"Back_"+inputFileName);
							
							//ɾ��tempĿ¼�µ��ļ�
							this.deleteALLFile(tempPath);
							//ɾ��tempĿ¼
							this.deleteDIR(tempPath);
							
							readLog.append(formatter.format(new Date())+"\t\t"+"�ļ�["+inputFileName+"]�����ɹ�."+"\r\n");
							readLog.append(formatter.format(new Date())+"\t\t"+"ϵͳ�����ļ���Back_"+inputFileName+"\r\n");
						
						}
						else{
							readLog.append(formatter.format(new Date())+"\t\t"+"�����и�ʽ���淶."+"\r\n");
							
						}

					}
					else{
						readLog.append(formatter.format(new Date())+"\t\t"+"�ļ�["+inputFileName+"]��ʽ����ȷ."+"\r\n");
					}
					
					ExportLog(readLog.toString(),realPath+File.separator+"Log.txt");
					
					//��ɲ��������ò���ֵ
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
			String LineContent=null;//������
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
				//�ж��ļ����Ƿ��п�ʼ�ͽ�����־
				boolean tipStart=false,tipEnd=false;
				while((LineContent=tempBr.readLine())!= null){
					if(LineContent.trim().equals(startTip))tipStart=true;
					if(LineContent.trim().equals(endTip))  tipEnd  =true;	
				}
				if(tipStart==false&&tipEnd==false){
					fileFormateTip=false;
					readLog.append(formatter.format(new Date())+"\t\t"+"�ļ��޿�ʼ��������ʶ [<data>]��[</data>]���ļ���ʽ��������\r\n");
				}
				if(tipStart==true&&tipEnd==false){
					fileFormateTip=false;
					readLog.append(formatter.format(new Date())+"\t\t"+"�ļ���ʼ��ʶ [<data>] ��ȷ��������ʶ[</data>] ȱʧ���ļ���ʽ��������\r\n");
				}
				if(tipStart==false&&tipEnd==true){
					fileFormateTip=false;
					readLog.append(formatter.format(new Date())+"\t\t"+"�ļ���ʼ��ʶ [<data>] ȱʧ��������ʶ[</data>] ��ȷ���ļ���ʽ��������\r\n");
				}
				if(tipStart&&tipEnd){
					fileFormateTip=true;
					readLog.append(formatter.format(new Date())+"\t\t"+"�ļ���ʼ��ʶ [<data>] ��ȷ��������ʶ [</data>] ��ȷ����ʼ��ȡ��һ��...\r\n");
				}
				//System.out.println("fileFormateTip start:"+fileFormateTip);
				
				//��ʼ�ͽ�����־��ȷ���ȡ�ļ�����
				if(fileFormateTip){	
					/**
					 * ��ͷ˳��CardNo	VehPlate	OwnerName	ObuId	FirTime	InvalidateTime	GenTime	VehPlateImage	dataAction	
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
							readLog.append(formatter.format(new Date())+"\t\t"+"�ļ���ͷ����ȷ����ʼ��ȡ������...\r\n");
							break;
						}
					}	
					//System.out.println("canReadFileState:"+canReadFileState);
					
					//�����ͷ��ȷ���ȡ����                    
					if(canReadFileState){
						String[] content = new String[9];
						int count=0;
						while( (LineContent=br.readLine()) != null){
							count++;
							content  = LineContent.split("\t");
							
							if(LineContent.trim().equals(endTip)){
								canReadFileState=true;
								readLog.append(formatter.format(new Date())+"\t\t"+"�ļ���ȡ��ϡ�\r\n");
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
								//���
								SaveOrUpdateOrDelete( CardNo, VehPlate, OwnerName, ObuId, FirTime, InvalidateTime, GenTime, VehPlateImage,dataAction);	
								
								readLog.append(formatter.format(new Date())+"\t\t"+"��ȷ��ȡ������ "+count+" ...\r\n");
								
							}
							else{
								//����
								if(LineContent.equals("")){
									readLog.append(formatter.format(new Date())+"\t\t"+"��ȡ������ --> "+count+" ...\r\n");
								}else{
									readLog.append(formatter.format(new Date())+"\t\t"+"��ȡ����ʽ���淶�������� "+" --> "+count+" ...\r\n");
									dateLinesState=false;
								}
							}

						}
						
						
					}else{
						canReadFileState=false;
						readLog.append(formatter.format(new Date())+"\t\t"+"�ļ���ͷ�в���ȷ����ȡ��������ֹ��\r\n");
					}
					
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}finally{
				//��FileReader �� BufferedReader �ر� 
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
	 * ����̨���Ŀ¼�µ������ļ�
	 * @param realPath
	 */
	public void showFiles(String realPath) {
		File dir = new File(realPath);
		File[] files = dir.listFiles();

		for (int i = 0; i < files.length; i++) {
			// Ŀ¼�µ��ļ�
			if (files[i].isFile()) {
				System.out.println("Ŀ¼�µ��ļ�:"+files[i].getName());
			}

			// Ŀ¼�µ�Ŀ¼
			if (files[i].isDirectory()) {
				System.out.println("Ŀ¼�µ�Ŀ¼"+files[i].getName());
			}
		}

	}

	/**
	 * �ж�Ŀ¼���ļ��Ƿ����
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
	 * ɾ���ļ�
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
	 * ɾ��Ŀ¼
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
	
	//ת�뷽��
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
	 * Getter/Setter����ע��HibernateTemplate
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
