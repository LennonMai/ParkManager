<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<object id="CardReader" align="top" width="0" height="0" codebase="${basePath}/js/CardOCX.cab" classid="clsid:8E04555F-A0E7-499C-9BAF-948243E48F7A"></object>
<%@ page contentType="text/html; charset=GBK" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<title>list</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>	
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
			<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
</head>
<body>

<script language="javascript">
function isSysCard(cardNo,cardType){
	var operateType = $("#operateType").val();
	var url = "freeAction_isSysCard.do?cardNo="+cardNo+"&cardType="+cardType+"&operateType="+operateType+"&timeStamp="+new Date().getTime();
	jQuery.get(url,function(data){
		try{
			//alert(data);
			var index = data.indexOf(",");
			var feeDate;
			if(index>0){
				feeDate = data.substring(index+1,data.length);
				data = data.substring(0,index);
				}
			if(data=="TRUE"){
				//alert(feeDate);
				var r = CardReader.SetRebateType(operateType,feeDate);
				if(validateResult(r))alert("�����ɹ���");
				else alert("����ʧ�ܣ�");
				}
			else if(data=="FALSE"){
				alert("��ϵͳ��������ִ�д˲�����");
				}
			else if(data=="EXCEPTION"){
				alert("���ݴ����쳣��");
				}
			else {alert("δ֪�����ͣ�");}
			CardReader.UnIniReaderCard();
		}
		catch(e){
			alert("����ʧ�ܣ�");
			//alert(e);
			CardReader.UnIniReaderCard();
			}
		});
}

function read(){
	//if($("#feeDate").val()==''){alert("������ڲ���Ϊ��!"); return;}
	//isSysCard("20015100",01);
	try{
		var result = CardReader.IniReaderCard()+" ";
		if(result==0){
		result=CardReader.GetCardPhyNo()+" ";
		if(validateResult(result)){
				var cardType;
				var cardNo;
				if(validateResult(cardType = (CardReader.GetCardType()+" "))){
					if(validateResult(cardNo = CardReader.GetCardNo()+" ")){
						cardType=cardType.substring(0,cardType.length-1);
						cardNo=cardNo.substring(0,cardNo.length-1);
						if(cardNo.substring(0,3)=='860')
						{
						  cardNo = cardNo.substring(3,12);
						  
						}else{
						  cardNo = cardNo.substring(0,12);
						}
						isSysCard(cardNo,cardType);
					}
					}

				//alert(cardNo);
				
			}
		}
		else {
			alert("��ʼ��������ʧ��!");
			CardReader.UnIniReaderCard();
			}
	}catch(e){
		alert("δ��ȷ��װ�ؼ�!");
		CardReader.UnIniReaderCard();
	}
		 } 

function validateResult (result){
	//alert(result);
	if(result==0) return true;
	if(result==-1){alert("��ʼ��������ʧ��!"); CardReader.UnIniReaderCard();return false;}
	else if(result==-2){alert("�Ҳ�����Ƭ!");CardReader.UnIniReaderCard();return false;}
	else if(result==-3){alert("��ȡ��Ƭ������Ϣʧ��!");CardReader.UnIniReaderCard();return false;}
	else if(result==-4){alert("д����Ϣʧ��!");CardReader.UnIniReaderCard();return false;}
	else if(result==-6){alert("�Żݽ�������С�ڵ��������ˮʱ��!");CardReader.UnIniReaderCard();return false;}
	else if(result==-10){alert("��ʼ��������ʧ��!");CardReader.UnIniReaderCard();return false;}
	else if(result==-12){alert("���ڱ�ռ��!");CardReader.UnIniReaderCard();return false;}
	else if(result==-14){alert("����DLLʧ��!");CardReader.UnIniReaderCard();return false;}
	else if(result==-15){alert("�򿪴���ʧ��!");CardReader.UnIniReaderCard();return false;}
	else if(result==-16){alert("��������ʼ���쳣!");CardReader.UnIniReaderCard();return false;}
	else if(result<0){alert("�������쳣!");CardReader.UnIniReaderCard();return false;}
	else return true;
}

</script>
<div class="body-box">
<div class="rhead">
<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
<div class="clear"></div>
</div>
<form name="myForm" action="account_cardQuery.do" method="post">
<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0"
	border="0">
	<thead class="pn-lthead">
		<tr>
			<th align="left" ></th>
		</tr>
	</thead>
	<tbody class="pn-ltbody">
		<tr>
			
			<td align="center"  valign="middle" >
			������ͣ�
				<select id="operateType">
					<option value="11">����</option>
					<option value="12">����</option>
					<option value="13">ס��</option>
				</select>
<!--			&nbsp;&nbsp;-->
<!--			������ڣ�-->
<!--				<input id="feeDate" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly = "readonly" >-->
<!--				</input>-->
			&nbsp;&nbsp;
			<input type="button" value=" ������ " onclick="read()" ></input>
			</td>
		</tr>
	</tbody>
</table>
</form>
</div>
</body>
</html>