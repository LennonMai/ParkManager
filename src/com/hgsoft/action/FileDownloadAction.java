package com.hgsoft.action;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;

/**
 * @author caijunhua
 * @date August 25, 2010
 * @Description 系统帮助下载
 */

public class FileDownloadAction implements Action {
	private String fileName;	//初始的通过param指定的文件名属性
	private String inputPath;	//指定要被下载的文件路径
	
	public InputStream getInputStream() throws Exception {
		//通过ServletContext，也就是application来读取数据
		return ServletActionContext.getServletContext().getResourceAsStream(inputPath);
	}
	
	public String execute() throws Exception {
		//文件下载目录路径
		String downloadDir = ServletActionContext.getServletContext().getRealPath("/doc");
		//文件下载路径
		String downloadFile = ServletActionContext.getServletContext().getRealPath(inputPath);
		java.io.File file = new java.io.File(downloadFile);
		downloadFile = file.getCanonicalPath();	//真是文件路径，去掉里面的..等信息
		//发现企图下载不在/download下的文件，就显示空内容
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
	
	//提供转换编码后的供下载用的文件名
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
