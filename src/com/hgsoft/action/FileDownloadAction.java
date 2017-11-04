package com.hgsoft.action;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;

/**
 * @author caijunhua
 * @date August 25, 2010
 * @Description ϵͳ��������
 */

public class FileDownloadAction implements Action {
	private String fileName;	//��ʼ��ͨ��paramָ�����ļ�������
	private String inputPath;	//ָ��Ҫ�����ص��ļ�·��
	
	public InputStream getInputStream() throws Exception {
		//ͨ��ServletContext��Ҳ����application����ȡ����
		return ServletActionContext.getServletContext().getResourceAsStream(inputPath);
	}
	
	public String execute() throws Exception {
		//�ļ�����Ŀ¼·��
		String downloadDir = ServletActionContext.getServletContext().getRealPath("/doc");
		//�ļ�����·��
		String downloadFile = ServletActionContext.getServletContext().getRealPath(inputPath);
		java.io.File file = new java.io.File(downloadFile);
		downloadFile = file.getCanonicalPath();	//�����ļ�·����ȥ�������..����Ϣ
		//������ͼ���ز���/download�µ��ļ�������ʾ������
		if(!downloadFile.startsWith(downloadDir)) {
			return null;
		}
		return SUCCESS;
	}
	
	public void setInputPath(String value) {
		inputPath = value;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	//�ṩת�������Ĺ������õ��ļ���
	public String getDownloadFileName() {
		String downFileName = fileName;
		try {
			downFileName = new String(downFileName.getBytes(),"ISO8859-1");
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return downFileName;
	}
	
}
