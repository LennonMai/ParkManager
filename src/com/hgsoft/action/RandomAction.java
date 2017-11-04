package com.hgsoft.action;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * @author liujiefeng
 * @date May 19, 2010
 * @Description ������֤��ͼƬ
 */

@Controller
@SuppressWarnings("unchecked")
public class RandomAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	public String execute() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");
		int width = 50; // ͼƬ���
		int height = 20; // ͼƬ�߶�
		BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		Graphics graphics = image.createGraphics();
		graphics.setColor(this.getTintColor()); // ������ɫ
		graphics.fillRect(0, 0, width, height);
		graphics.setFont(new Font("Arial", Font.BOLD, 18));
		graphics.setColor(this.getColor()); // �ֵ���ɫ
		String number = String.valueOf(System.currentTimeMillis() % 9000 + 1000); // ������λ�����
		ActionContext.getContext().getSession().put("randomCode", number); // д��session��
		
		graphics.drawString(number, (int) (width * 0.1), (int) (height * 0.8));
		graphics.dispose();
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
		encoder.encode(image);
		response.getOutputStream().flush(); // ˢ�µ�ҳ������ͼƬ
		response.getOutputStream().close(); // �ر�writer
		return null; 
	}
	private Color getTintColor() {
		// int red = (int) (Math.random()*1000%256);
		// int green=(int) (Math.random()*1000%256);
		// int blue= (int) (Math.random()*1000%256);
		return new Color(170,204,255);
	}
	private Color getColor() {
		int[] rvalue=getRandom();
		int red = rvalue[0];
		int blue= rvalue[1];
		int green= red>blue?red-120:blue-120;
		return new Color(red,green,blue);
	}
	
	private int[] getRandom(){
		int[] colorRandom ={0,0} ;
		int random =(int) (Math.random()*1000)%256;
		if(random<127){
			colorRandom[0]=random+126;
			colorRandom[1]=random;
			return colorRandom;
		}
		else {
			colorRandom[0]=random-126;
			colorRandom[1]=random;
			return colorRandom;
		}
	}
}
