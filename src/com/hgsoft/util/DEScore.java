package com.hgsoft.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Key;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.KeyGenerator;



/**
 * 
 *@author Bruce Qin
 *@version 1.0
 *2011.06.08 
 *
 */
public class DEScore {

	private Key key;

	/**
	 * �����ܳ�
	 * @param str
	 */
	public DEScore(String str) {
		getKey(str);
	}

	/**
	 * ���ݲ�������KEY
	 * @param strKey
	 */
	public void getKey(String strKey) {
		try {
			KeyGenerator keyGenerator = KeyGenerator.getInstance("DES");
			keyGenerator.init(new SecureRandom(strKey.getBytes()));
			this.key = keyGenerator.generateKey();
			keyGenerator = null;
		} catch (Exception e) {
			throw new RuntimeException("Error. Cause: " + e);
		}
	}

	/**
	 * ��DES�㷨����
	 * @param file          �����ܵ��ļ� ����·��
	 * @param encryptedFile ���ܺ���ļ� ����·��
	 * @throws Exception
	 */
	public  void encrypt(String file, String encryptedFile) throws Exception {
		try {
			Cipher cipher = Cipher.getInstance("DES");

			cipher.init(Cipher.ENCRYPT_MODE, this.key);
			InputStream is = new FileInputStream(file);
			OutputStream out = new FileOutputStream(encryptedFile);
			CipherInputStream cis = new CipherInputStream(is, cipher);

			byte[] buffer = new byte[1024];
			int i;
			while ((i = cis.read(buffer)) > 0) {
				out.write(buffer, 0, i);
			}
			cis.close();
			is.close();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * ��DES�㷨�����ļ�
	 * @param file          �����ܵ��ļ� ����·��
	 * @param decryptedFile �ѽ��ܵ��ļ� ����·�� 
	 * @throws Exception
	 */
	public void decrypt(String file, String decryptedFile) throws Exception {
		
		try {
			Cipher cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.DECRYPT_MODE, this.key);
			InputStream is = new FileInputStream(file);
			OutputStream out = new FileOutputStream(decryptedFile);
			CipherOutputStream cos = new CipherOutputStream(out, cipher);
			byte[] buffer = new byte[1024];
			int i;
			while ((i = is.read(buffer)) >= 0) {
				cos.write(buffer, 0, i);
			}
			cos.close();
			out.close();
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	

}
