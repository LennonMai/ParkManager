package com.hgsoft.util;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFComment;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;


public class ExcelUtil<T> {
	
	public void exportExcel(Collection<T> dataset, OutputStream out) {
		exportExcel("EXCEL�ĵ�", null, dataset, out, "yyyy-MM-dd");
	}

	public void exportExcel(String[] headers, Collection<T> dataset,OutputStream out) {
		exportExcel("EXCEL�ĵ�", headers, dataset, out, "yyyy-MM-dd");
	}

	public void exportExcel(String[] headers, Collection<T> dataset,OutputStream out, String pattern) {
		exportExcel("EXCEL�ĵ�", headers, dataset, out, pattern);
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	public void exportExcel(String title, String[] headers,Collection<T> dataset, OutputStream out, String pattern) {

	      // ����һ��������
	      HSSFWorkbook workbook = new HSSFWorkbook();

	      // ����һ�����
	      HSSFSheet sheet = workbook.createSheet(title);

	      // ���ñ��Ĭ���п��Ϊ15���ֽ�
	      sheet.setDefaultColumnWidth((short) 15);

	      // ����һ����ʽ
	      HSSFCellStyle style = workbook.createCellStyle();

	      // ������ʽ
	      style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);//��ͷ�������
	      
          //style.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);

	      style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

	      style.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	      style.setBorderLeft(HSSFCellStyle.BORDER_THIN);

	      style.setBorderRight(HSSFCellStyle.BORDER_THIN);

	      style.setBorderTop(HSSFCellStyle.BORDER_THIN);

	      style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

	      // ����һ������
	      HSSFFont font = workbook.createFont();

	      font.setColor(HSSFColor.VIOLET.index);

	      font.setFontHeightInPoints((short) 12);

	      font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

	      // ������Ӧ�õ���ǰ����ʽ
	      style.setFont(font);

	      // ���ɲ�������һ����ʽ
	      HSSFCellStyle style2 = workbook.createCellStyle();

//	      style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
	      style2.setFillForegroundColor(HSSFColor.WHITE.index);

	      style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

	      style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	      style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);

	      style2.setBorderRight(HSSFCellStyle.BORDER_THIN);

	      style2.setBorderTop(HSSFCellStyle.BORDER_THIN);

	      style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);

	      style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

	      // ������һ������
	      HSSFFont font2 = workbook.createFont();

	      font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);

	      // ������Ӧ�õ���ǰ����ʽ
	      style2.setFont(font2);

	      

	      // ����һ����ͼ�Ķ���������
	      HSSFPatriarch patriarch = sheet.createDrawingPatriarch();

	      // ����ע�͵Ĵ�С��λ��
	      HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));

	      // ����ע������
	      comment.setString(new HSSFRichTextString(""));

	      // ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	      comment.setAuthor(" - qinzuohai");

	      //������������
	      HSSFRow row = sheet.createRow(0);

	      for (short i = 0; i < headers.length; i++) {

	         HSSFCell cell = row.createCell(i);

	         cell.setCellStyle(style);

	         //���ɱ�ͷ������
	         HSSFRichTextString text = new HSSFRichTextString(headers[i]);

	         cell.setCellValue(text);

	      }

	      //�����������ݣ�����������
	      Iterator<T> it = dataset.iterator();

	      int index = 0;

	      while (it.hasNext()) {

	         index++;

	         row = sheet.createRow(index);

	         T t = (T) it.next();

	         //���÷��䣬����javabean���Ե��Ⱥ�˳�򣬶�̬����getXxx()�����õ�����ֵ
	         Field[] fields = t.getClass().getDeclaredFields();

	         for (short i = 0; i < fields.length; i++) {

	            HSSFCell cell = row.createCell(i);

	            cell.setCellStyle(style2);

	            Field field = fields[i];

	            String fieldName = field.getName();

	            String getMethodName = "get"

	                   + fieldName.substring(0, 1).toUpperCase()

	                   + fieldName.substring(1);

	            try {
	            	Object value; 
	                Class tCls = t.getClass(); 
                    //System.out.println(" ȡ��POJOl�����                           --- "+tCls.toString());
                    
	                Method getMethod = tCls.getMethod(getMethodName,new Class[]{});
	                //System.out.println(" ȡ��POJO��getter����              --- :"+getMethod.getName()+"-");
	                
	                //
	                if(getMethod.getName().equals("getOperatorID")){
	                	//Admin admin=(Admin)getMethod.invoke(t, new Object[]{});
	                	//System.out.println("-----------------"+getMethod.invoke(t, new Object[]{}));
	                	 value = getMethod.invoke(t, new Object[]{});
	                }else{
	                	 value = getMethod.invoke(t, new Object[] {});
	 	                //System.out.println(" ͨ��getter������ȡ����ֵ     --- "+value);
	                }
    
	                //�ж�ֵ�����ͺ����ǿ������ת��
	                String textValue = null;

					// if (value instanceof Integer) {
					// int intValue = (Integer) value;
					// cell.setCellValue(intValue);
					// } else {
					// // �����������Ͷ������ַ����򵥴���
					// textValue = value.toString();
					// }
	                if(value==null){
	                	value="";
	                }
					textValue = value.toString();
					HSSFRichTextString richString = new HSSFRichTextString(
							textValue);

					HSSFFont font3 = workbook.createFont();

					font3.setColor(HSSFColor.BLUE.index);

					richString.applyFont(font3);

					cell.setCellValue(richString);

	            } catch (SecurityException e) {

	                e.printStackTrace();

	            } catch (NoSuchMethodException e) {
	                e.printStackTrace();

	            } catch (IllegalArgumentException e) {
	                e.printStackTrace();
	            } catch (IllegalAccessException e) {
	                e.printStackTrace();

	            } catch (InvocationTargetException e) {
	                e.printStackTrace();

	            } finally {
	                //������Դ
	            }

	         }

	      }
	      try {
	         workbook.write(out);

	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	   }

	
	//����������  ��
	@SuppressWarnings({ "unchecked", "deprecation" })
	public void exportExcel(String title, String[] headers,Collection<Map> dataset, OutputStream out, String pattern,int sheetCount,Map<String,String> mapUserType,Map<String,String>mapRuleType) {
		  HSSFWorkbook workbook = new HSSFWorkbook();// ����һ��������
	      int index = 0;
	      int currSheet = 0;
	      int rows = 0;
	      HSSFSheet sheet = workbook.createSheet(title+currSheet);// ����һ�����
	      sheet.setDefaultColumnWidth((short) 15);// ���ñ��Ĭ���п��Ϊ15���ֽ�
	      HSSFCellStyle style = workbook.createCellStyle();// ����һ����ʽ
	      // ������ʽ
	      style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);//��ͷ�������
	      style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	      style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      // ����һ������
	      HSSFFont font = workbook.createFont();
	      font.setColor(HSSFColor.VIOLET.index);
	      font.setFontHeightInPoints((short) 12);
	      font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	      // ������Ӧ�õ���ǰ����ʽ
	      style.setFont(font);
	      // ���ɲ�������һ����ʽ
	      HSSFCellStyle style2 = workbook.createCellStyle();
	      style2.setFillForegroundColor(HSSFColor.WHITE.index);
	      style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	      style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	      // ������һ������
	      HSSFFont font2 = workbook.createFont();
	      font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	      
	      HSSFFont font3 = workbook.createFont();
          font3.setColor(HSSFColor.BLUE.index);
          
	      // ������Ӧ�õ���ǰ����ʽ
	      style2.setFont(font2);
	      // ����һ����ͼ�Ķ���������
	      HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
	      // ����ע�͵Ĵ�С��λ��
	      HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	      // ����ע������
	      comment.setString(new HSSFRichTextString(""));
	      // ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	      comment.setAuthor(" - kevin");
	      //������������
	      HSSFRow row = sheet.createRow(0);
	      for (short i = 0; i < headers.length; i++) {
	         HSSFCell cell = row.createCell(i);
	         cell.setCellStyle(style);
	         //���ɱ�ͷ������
	         HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	         cell.setCellValue(text);
	      }
	      //�����������ݣ�����������
	      Iterator<Map> it = dataset.iterator();
	      while (it.hasNext()) {
	         if(index>0 && index%sheetCount==0){
	        	 currSheet ++;
	        	 rows = 0;
	        	 sheet = workbook.createSheet(title+currSheet);
	        	 sheet.setDefaultColumnWidth((short) 15);
	        	 patriarch = sheet.createDrawingPatriarch();
	        	 // ����ע�͵Ĵ�С��λ��
	   	      	comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	   	      	// ����ע������
	   	      	comment.setString(new HSSFRichTextString(""));
	   	      	// ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	   	      	comment.setAuthor(" - kevin");
	   	      	//������������
	   	      	row = sheet.createRow(0);
	   	      	for (short i = 0; i < headers.length; i++) {
	   	      		HSSFCell cell = row.createCell(i);
	   	      		cell.setCellStyle(style);
	   	      		//���ɱ�ͷ������
	   	      		HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	   	      		cell.setCellValue(text);
	   	      	}
	         }
	         index++;
	         rows++;
	         row = sheet.createRow(rows);
	         //CardNO,VehPlate,OwnerName,OBUID,FirTime,InvaliDateTime,CARDTYPE,Status,HasVehPic,FeeRuleType
	         Map map = it.next();
	         int temp = 0;
	         for(Object o:map.keySet()){
	        	 String value = "";
		         HSSFCell cell = row.createCell(temp);
		         cell.setCellStyle(style2);
		         Object tempO = map.get(o);
		         if(null != tempO){
		        	 value = tempO.toString();
		         }
	             //value = map.get(o).toString();
	             if(temp == 4){
	            	 if(value.length()>0){
	            		 value = value.substring(0, value.length()-10);
	            	 }
	             }
	             if(temp == 5){
	            	 if(value.length()>0){
	            		 value = value.substring(0, value.length()-10);
	            	 }
	             }
	             if(temp == 6){
	            	 value = mapUserType.get(value);
	             }
	             if(temp == 7){
	            	 if(value.equals("0")){
	            		 value="����";
	            	 }
	            	 if(value.equals("1")){
	            		 value="��ʧ";
	            	 }
	            	 if(value.equals("9")){
	            		 value="δ�ɷ�";
	            	 }
	             }
	             if(temp == 8){
	            	 if(value.equals("0")){
	            		 value="��";
	            	 }
	            	 if(value.equals("1")){
	            		 value="��";
	            	 }
	             }
	             if(temp == 9){
	            	 value = mapRuleType.get(value);
	             }
	             HSSFRichTextString richString = new HSSFRichTextString(value);
	             richString.applyFont(font3);
	             cell.setCellValue(richString);
	             temp++;
	         }
	      }
	      try {
	         workbook.write(out);
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	   }
	
	
	//���������� 
	@SuppressWarnings({ "unchecked", "deprecation" })
	public void expExcel(String title, String[] headers,Collection<Map> dataset, OutputStream out,int sheetCount,Map<String,String> mapUserType,Map<String,String>mapRuleType) {
		  HSSFWorkbook workbook = new HSSFWorkbook();// ����һ��������
	      int index = 0;
	      int currSheet = 0;
	      int rows = 0;
	      HSSFSheet sheet = workbook.createSheet(title+currSheet);// ����һ�����
	      sheet.setDefaultColumnWidth((short) 18);// ���ñ��Ĭ���п��Ϊ15���ֽ�
	      HSSFCellStyle style = workbook.createCellStyle();// ����һ����ʽ
	      // ������ʽ
	      style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);//��ͷ�������
	      style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	      style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      // ����һ������
	      HSSFFont font = workbook.createFont();
	      font.setColor(HSSFColor.VIOLET.index);
	      font.setFontHeightInPoints((short) 12);
	      font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	      // ������Ӧ�õ���ǰ����ʽ
	      style.setFont(font);
	      // ���ɲ�������һ����ʽ
	      HSSFCellStyle style2 = workbook.createCellStyle();
	      style2.setFillForegroundColor(HSSFColor.WHITE.index);
	      style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	      style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	      // ������һ������
	      HSSFFont font2 = workbook.createFont();
	      font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	      
	      HSSFFont font3 = workbook.createFont();
          font3.setColor(HSSFColor.BLUE.index);
          
	      // ������Ӧ�õ���ǰ����ʽ
	      style2.setFont(font2);
	      // ����һ����ͼ�Ķ���������
	      HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
	      // ����ע�͵Ĵ�С��λ��
	      HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	      // ����ע������
	      comment.setString(new HSSFRichTextString(""));
	      // ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	      comment.setAuthor(" - kevin");
	      //������������
	      HSSFRow row = sheet.createRow(0);
	      for (short i = 0; i < headers.length; i++) {
	         HSSFCell cell = row.createCell(i);
	         cell.setCellStyle(style);
	         //���ɱ�ͷ������
	         HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	         cell.setCellValue(text);
	      }
	      //�����������ݣ�����������
	      Iterator<Map> it = dataset.iterator();
	      while (it.hasNext()) {
	         if(index>0 && index%sheetCount==0){
	        	 currSheet ++;
	        	 rows = 0;
	        	 sheet = workbook.createSheet(title+currSheet);
	        	 sheet.setDefaultColumnWidth((short) 15);
	        	 patriarch = sheet.createDrawingPatriarch();
	        	 // ����ע�͵Ĵ�С��λ��
	   	      	comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	   	      	// ����ע������
	   	      	comment.setString(new HSSFRichTextString(""));
	   	      	// ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	   	      	comment.setAuthor(" - kevin");
	   	      	//������������
	   	      	row = sheet.createRow(0);
	   	      	for (short i = 0; i < headers.length; i++) {
	   	      		HSSFCell cell = row.createCell(i);
	   	      		cell.setCellStyle(style);
	   	      		//���ɱ�ͷ������
	   	      		HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	   	      		cell.setCellValue(text);
	   	      	}
	         }
	         index++;
	         rows++;
	         row = sheet.createRow(rows);
	         Map map = it.next();
	         int temp = 0;
	         for(Object o:map.keySet()){
	        	 String value = "";
		         HSSFCell cell = row.createCell(temp);
		         cell.setCellStyle(style2);
		         Object tempO = map.get(o);
		         if(null != tempO){
		        	 value = tempO.toString();
		         }
	             HSSFRichTextString richString = new HSSFRichTextString(value);
	             richString.applyFont(font3);
	             cell.setCellValue(richString);
	             temp++;
	         }
	      }
	      try {
	         workbook.write(out);
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	   }
	
	//����IC��  ��
	@SuppressWarnings({ "unchecked", "deprecation" })
	public void exportICCardExcel(String title, String[] headers,Collection<Map> dataset, OutputStream out, String pattern,int sheetCount,Map<String,String> mapUserCardType,Map<String,String>mapCardType) {
		HSSFWorkbook workbook = new HSSFWorkbook();// ����һ��������
	      int index = 0;
	      int currSheet = 0;
	      int rows = 0;
	      HSSFSheet sheet = workbook.createSheet(title+currSheet);// ����һ�����
	      sheet.setDefaultColumnWidth((short) 15);// ���ñ��Ĭ���п��Ϊ15���ֽ�
	      HSSFCellStyle style = workbook.createCellStyle();// ����һ����ʽ
	      // ������ʽ
	      style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);//��ͷ�������
	      style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	      style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      // ����һ������
	      HSSFFont font = workbook.createFont();
	      font.setColor(HSSFColor.VIOLET.index);
	      font.setFontHeightInPoints((short) 12);
	      font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	      // ������Ӧ�õ���ǰ����ʽ
	      style.setFont(font);
	      // ���ɲ�������һ����ʽ
	      HSSFCellStyle style2 = workbook.createCellStyle();
	      style2.setFillForegroundColor(HSSFColor.WHITE.index);
	      style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	      style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	      // ������һ������
	      HSSFFont font2 = workbook.createFont();
	      font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	      
	      HSSFFont font3 = workbook.createFont();
        font3.setColor(HSSFColor.BLUE.index);
        
	      // ������Ӧ�õ���ǰ����ʽ
	      style2.setFont(font2);
	      // ����һ����ͼ�Ķ���������
	      HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
	      // ����ע�͵Ĵ�С��λ��
	      HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	      // ����ע������
	      comment.setString(new HSSFRichTextString(""));
	      // ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	      comment.setAuthor(" - kevin");
	      //������������
	      HSSFRow row = sheet.createRow(0);
	      for (short i = 0; i < headers.length; i++) {
	         HSSFCell cell = row.createCell(i);
	         cell.setCellStyle(style);
	         //���ɱ�ͷ������
	         HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	         cell.setCellValue(text);
	      }
	      //�����������ݣ�����������
	      Iterator<Map> it = dataset.iterator();
	      while (it.hasNext()) {
	         if(index>0 && index%sheetCount==0){
	        	 currSheet ++;
	        	 rows = 0;
	        	 sheet = workbook.createSheet(title+currSheet);
	        	 sheet.setDefaultColumnWidth((short) 15);
	        	 patriarch = sheet.createDrawingPatriarch();
	        	 // ����ע�͵Ĵ�С��λ��
	   	      	comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	   	      	// ����ע������
	   	      	comment.setString(new HSSFRichTextString(""));
	   	      	// ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	   	      	comment.setAuthor(" - kevin");
	   	      	//������������
	   	      	row = sheet.createRow(0);
	   	      	for (short i = 0; i < headers.length; i++) {
	   	      		HSSFCell cell = row.createCell(i);
	   	      		cell.setCellStyle(style);
	   	      		//���ɱ�ͷ������
	   	      		HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	   	      		cell.setCellValue(text);
	   	      	}
	         }
	         index++;
	         rows++;
	         row = sheet.createRow(rows);
	         //CardNO,VehPlate,OwnerName,OBUID,FirTime,InvaliDateTime,CARDTYPE,Status,HasVehPic,FeeRuleType
	         Map map = it.next();
	         int temp = 0;
	         for(Object o:map.keySet()){
	        	 String value = "";
		         HSSFCell cell = row.createCell(temp);
		         cell.setCellStyle(style2);
	             value = map.get(o).toString();
	             if(temp == 1){
	            	 if(value.length()>0){
	            		 value = mapCardType.get(value);
	            	 }
	             }
	             if(temp == 2){
	            	 if(value.length()>0){
	            		 value = mapUserCardType.get(value);
	            	 }
	             }
	             if(temp == 3){
	            	 if(value.equals("0")){
	            		 value="����";
	            	 }
	            	 if(value.equals("1")){
	            		 value="��ʧ";
	            	 }
	            	 if(value.equals("2")){
	            		 value="��ʧ";
	            	 }
	            	 if(value.equals("3")){
	            		 value="��";
	            	 }
	             }
	             if(temp == 4){
	            	 value = value.substring(0,19);
	             }
	             HSSFRichTextString richString = new HSSFRichTextString(value);
	             richString.applyFont(font3);
	             cell.setCellValue(richString);
	             temp++;
	         }
	      }
	      try {
	         workbook.write(out);
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	}
	//����������ˮ��Ϣ  
	@SuppressWarnings({ "unchecked", "deprecation" })
	public void exportWaterQueryExcel(String title, String[] headers,Collection<Map> dataset, OutputStream out, int sheetCount,Map<Integer,Map<String,String>> colMap) {
		 try{
		  HSSFWorkbook workbook = new HSSFWorkbook();// ����һ��������
	      int index = 0;
	      int currSheet = 0;
	      int rows = 0;
	      HSSFSheet sheet = workbook.createSheet(title+currSheet);// ����һ�����
	      sheet.setDefaultColumnWidth((short) 20);// ���ñ��Ĭ���п��Ϊ15���ֽ�
	      HSSFCellStyle style = workbook.createCellStyle();// ����һ����ʽ
	      // ������ʽ
	      style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);//��ͷ�������
	      style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	      style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      // ����һ������
	      HSSFFont font = workbook.createFont();
	      font.setColor(HSSFColor.VIOLET.index);
	      font.setFontHeightInPoints((short) 12);
	      font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	      // ������Ӧ�õ���ǰ����ʽ
	      style.setFont(font);
	      // ���ɲ�������һ����ʽ
	      HSSFCellStyle style2 = workbook.createCellStyle();
	      style2.setFillForegroundColor(HSSFColor.WHITE.index);
	      style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	      style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	      // ������һ������
	      HSSFFont font2 = workbook.createFont();
	      font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	      
	      HSSFFont font3 = workbook.createFont();
	      font3.setColor(HSSFColor.BLUE.index);
        
	      // ������Ӧ�õ���ǰ����ʽ
	      style2.setFont(font2);
	      // ����һ����ͼ�Ķ���������
	      HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
	      // ����ע�͵Ĵ�С��λ��
	      HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	      // ����ע������
	      comment.setString(new HSSFRichTextString(""));
	      // ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	      comment.setAuthor(" - kevin");
	      //������������
	      HSSFRow row = sheet.createRow(0);
	      for (short i = 0; i < headers.length; i++) {
	         HSSFCell cell = row.createCell(i);
	         cell.setCellStyle(style);
	         //���ɱ�ͷ������
	         HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	         cell.setCellValue(text);
	      }
	      //�����������ݣ�����������
	      Iterator<Map> it = dataset.iterator();
	      Map map = null;
	      int temp = 0;
	      while (it.hasNext()) {
	         if(index>0 && index%sheetCount==0){
	        	 currSheet ++;
	        	 rows = 0;
	        	 sheet = workbook.createSheet(title+currSheet);
	        	 sheet.setDefaultColumnWidth((short) 15);
	        	 patriarch = sheet.createDrawingPatriarch();
	        	 // ����ע�͵Ĵ�С��λ��
	   	      	comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	   	      	// ����ע������
	   	      	comment.setString(new HSSFRichTextString(""));
	   	      	// ����ע�����ߣ�������ƶ�����Ԫ�����ǿ�����״̬���п���������.
	   	      	comment.setAuthor(" - kevin");
	   	      	//������������
	   	      	row = sheet.createRow(0);
	   	      	for (short i = 0; i < headers.length; i++) {
	   	      		HSSFCell cell = row.createCell(i);
	   	      		cell.setCellStyle(style);
	   	      		//���ɱ�ͷ������
	   	      		HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	   	      		cell.setCellValue(text);
	   	      	}
	         }
	         index++;
	         rows++;
	         row = sheet.createRow(rows);
	         map = it.next();
	         temp = 0;
	         for(Object o:map.keySet()){
	        	 String value = "";
		         HSSFCell cell = row.createCell(temp);
		         cell.setCellStyle(style2);
		         Object tempO = map.get(o);
		         if(null != tempO){
		        	 value = tempO.toString();
		         }
		         
		         for(int key : colMap.keySet()){
		        	 if(temp == key){
		        		 if(value.length()>0){
		        			 value = colMap.get(key).get(value);
		        		 }
		        	 }
		         }
		         
	             HSSFRichTextString richString = new HSSFRichTextString(value);
	             richString.applyFont(font3);
	             cell.setCellValue(richString);
	             temp++;
	         }
	      }
	         workbook.write(out);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	}
	
	/*public static void main(String[] args) {

	      // ����
		  ExcelUtil<Sysparamconf> ex = new ExcelUtil<Sysparamconf>();
	      String[] headers = { "���", "������", "����ֵ", "���", "��ע" };
	      List<Sysparamconf> sysparamconfList = new ArrayList<Sysparamconf>();
	    
	      try {
	    	  sysparamconfList.add(new Sysparamconf(01,"ϵͳ��","С����������",1,"ϵͳ˵��" ));
	    	  sysparamconfList.add(new Sysparamconf(02,"����","����20%",0,"�������" ));
		      OutputStream out = new FileOutputStream("E:"+"����������Ϣ.xls");
		      ex.exportExcel(headers, sysparamconfList, out);
	          out.close();
		      JOptionPane.showMessageDialog(null, "Excel�����ɹ�D��-- ����������Ϣ.xls!");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}*/
}