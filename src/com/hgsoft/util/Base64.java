/**
 *CopyRight (c) 曾根宝 (kevin)  广州华工信息软件有限公司 http://www.hgsoft.com.cn
 *Email:rabitt450@163.com
 *转载请注明版权所有
 */
package com.hgsoft.util;

import java.io.IOException;
import java.security.MessageDigest;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


public class Base64 {

	public final static byte[] md5(String s) {
        byte[] md=null;
        try {
            byte[] btInput = s.getBytes();
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            mdInst.update(btInput);
            md = mdInst.digest();
        }
        catch (Exception e) {
            return null;
        }
        return md;
    }
    
    public static String base64Encode(byte[] b){
        return new BASE64Encoder().encode(b);
    }

    public static byte[] base64Decode(String b){
        try {
            return new BASE64Decoder().decodeBuffer(b);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    /*
    public static String md5AndHex(String s){
        byte[] b=md5(s);
        String temp="";
        for (int i=0;i<b.length;i++){
        	temp+=StringUtils.pad(Integer.toHexString(b[i] & 0xff), '0', true, 2);
            //temp+=StringUtils.pad(Integer.toHexString(b[i] & 0xff), 2, '0', true);
        }
        return temp;
    }
    */
    public static String md5AndBase64(String s){
        return base64Encode(md5(s));
    }
	
    public static void main(String[] args) {
    	//System.out.println(md5AndHex("ZwsUcorZkCrsujLiL6T2vQ=="));
        System.out.println(md5AndBase64("123456"));
    	
    }

} 