package com.hgsoft.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;


import com.hgsoft.entity.CardDynamic;
import com.hgsoft.service.CardDynamicService;

@Controller
@Scope("prototype")
public class InterfaceAction extends BaseAction {
	private String vehplate;
	private int size;
//	private String inListNo;
//	private String squadDate;
	@Resource
	private CardDynamicService cardDynamicService;
	//@Resource
	//private SysparamconfService sysparamconfService;

	//��ƥ��λ����ѯδ���տ��ĳ���
	public String getNoRecycleCard() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		List<CardDynamic> data = null;
		String resultStr = "";
		List<CardDynamic> list = new ArrayList<CardDynamic>();
		if (vehplate != null && vehplate.length() > 1 && size != 0) {
			data = this.cardDynamicService.queryAllNoRecycle();
			if (data != null && !data.isEmpty()) {
				String veh = "";
				// ������ѯ����������Ϣ
				for (CardDynamic cardDynamic : data) {
					// ����ÿһ�����Ƚϣ����ϵ���ӵ�list
					veh = cardDynamic.getVehPlate().trim();
					boolean flag = getFlag(veh.substring(1, veh.length()),vehplate.substring(1, vehplate.length()), size);
					if (flag) {
						list.add(cardDynamic);
					}
				}
			}
			// �����ϵ�����ƴ���ַ�������
			if (!list.isEmpty()) {
				for (int i = 0; i < list.size(); i++) {
					CardDynamic cardDynamic = list.get(i);
					resultStr += cardDynamic.getInListNo().trim() + "\t"
							+ cardDynamic.getCardNo().trim() + "\t"
							+ cardDynamic.getVehPlate().trim() + "\t"
							+ sdf.format(cardDynamic.getOpTime()) + "\t"
							+ cardDynamic.getLaneNo() + "\t"
							+ cardDynamic.getGateNo();
					if (i != list.size() - 1) {
						resultStr += "\r\n";
					}
				}
			}
		}
		outMessage(resultStr);
		return null;
	}

	//��ѯͼƬ
/*	public String getInListImage() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String inSrc = "";
		boolean rightDate = false;
		if(squadDate != null && !"".equals(squadDate)){
			try {
				sdf.parse(squadDate);
				rightDate = true;
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				rightDate = false;
			}
		}
		if (inListNo != null && !"".equals(inListNo.trim()) && rightDate) {
			list = cardDynamicService.getInListByListNo(squadDate, inListNo);
			if (!list.isEmpty()) {
				Admin admin = new Admin();
				admin.setId(300000001);
				Sysparamconf param_vehPlate = sysparamconfService
						.queryOrSave(
								"vehPlate",
								"D:\\Jpeg\\",
								"Ϊ��ѯ����׽��ͼƬ�ṩ·��",
								"WaterQueryAction��complate()����vehPlate����ʱset������get��������ʱ���쳣",
								admin);
				Calendar cal = Calendar.getInstance();
				Map map = (Map) list.get(0);
				String squadTime = map.get("SquadDate").toString();
				try {
					cal.setTime(sdf.parse(squadTime));
				} catch (ParseException e) {
					e.printStackTrace();
					return null;
				}
				String tempInGateNo = map.get("GateNo").toString();
				String tempInLaneNo = map.get("LaneNo").toString();
				tempInGateNo = gateNoAndLaneNo(tempInGateNo);
				tempInLaneNo = gateNoAndLaneNo(tempInLaneNo);
				String month = monthAndDay(String.valueOf((cal
						.get(Calendar.MONTH) + 1)));
				String day = monthAndDay(String.valueOf(cal
						.get(Calendar.DAY_OF_MONTH)));
				inSrc = param_vehPlate.getPvalue() + tempInGateNo
						+ tempInLaneNo + File.separatorChar + cal.get(Calendar.YEAR) + month
						+ File.separatorChar + day + File.separatorChar + map.get("listNo") + ".jpg";
			}
		}
		outMessage("".equals(inSrc)?"":GetImageStr(inSrc));
		return null;
	}*/

	// ƥ�䷵��true
	private boolean getFlag(String str1, String str2, int size) {
		if (str1 == null || str2 == null || str1.length() == 0
				|| str2.length() == 0)
			return false;
		// ��������ȡ���ƺŽ϶̵��ַ�����
		int nums = str1.length() < str2.length() ? str1.length() : str2
				.length();
		// ƥ��������ܳ����������ĳ��Ƴ���
		size = str2.length() < size ? str2.length() : size;
		int matchSize = 0;
		str1 = str1.toUpperCase();
		str2 = str2.toUpperCase();
		for (int i = 0; i < nums; i++) {
			if (str1.charAt(i) == str2.charAt(i)) {
				matchSize++;
			}
			if (matchSize >= size)
				break;
		}
		if (matchSize >= size)
			return true;
		else
			return false;
	}

	protected void outMessage(String message) {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html; charset=GBK");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(message.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
/*    public String GetImageStr(String imgFilePath) {// ��ͼƬ�ļ�ת��Ϊ�ֽ������ַ��������������Base64���봦��
        byte[] data = null;
        
        // ��ȡͼƬ�ֽ�����
        InputStream in = null;
        try {
            in = new FileInputStream(imgFilePath);
            data = new byte[in.available()];
            in.read(data);
            in.close();
            // ���ֽ�����Base64����
            BASE64Encoder encoder = new BASE64Encoder();
            return encoder.encode(data);// ����Base64��������ֽ������ַ���
        } catch (IOException e) {
        	e.printStackTrace();
            return "";
        } finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
    }*/
	/**
	 * ��ϴ��źźͳ����ŵĳ���
	 */
/*	public String gateNoAndLaneNo(String temp){
		String str = "";
		String [] ss = {"0000","000","00","0",""};
		str = ss[temp.length()] + temp;
		return str;
	}*/
	/**
	 * ����·ݻ�����
	 */
/*	public String monthAndDay(String temp){
		String str="";
		String [] ss={"00","0",""};
		str = ss[temp.length()]+temp; 
		return str;
	}*/
	public void setVehplate(String vehplate) {
		this.vehplate = vehplate;
	}

	public void setSize(int size) {
		this.size = size;
	}

/*	public String getInListNo() {
		return inListNo;
	}

	public void setInListNo(String inListNo) {
		this.inListNo = inListNo;
	}

	public String getSquadDate() {
		return squadDate;
	}

	public void setSquadDate(String squadDate) {
		this.squadDate = squadDate;
	}*/
}
