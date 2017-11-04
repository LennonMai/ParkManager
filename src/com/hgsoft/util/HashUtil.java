package com.hgsoft.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

//生成MD5编码
public class HashUtil {
	public static String getMD5String(String src) {
		String s = src;
		if(s == null) s = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.reset();
			md.update(s.getBytes());
			byte[] messageDigest = md.digest();
			
			//将指定byte数组转换成16进制字符串
			StringBuffer hexString = new StringBuffer();
			for (int i=0;i<messageDigest.length;i++) {
				String hex = Integer.toHexString(messageDigest[i] & 0xFF);
				if (hex.length() == 1) {   
	                hex = '0' + hex;   
	            }
				hexString.append(hex.toUpperCase());
			}

			s = hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return s;
	}
}
