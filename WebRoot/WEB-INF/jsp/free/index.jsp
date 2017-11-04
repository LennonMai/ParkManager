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
				if(validateResult(r))alert("操作成功！");
				else alert("操作失败！");
				}
			else if(data=="FALSE"){
				alert("非系统卡，不能执行此操作！");
				}
			else if(data=="EXCEPTION"){
				alert("数据处理异常！");
				}
			else {alert("未知卡类型！");}
			CardReader.UnIniReaderCard();
		}
		catch(e){
			alert("读卡失败！");
			//alert(e);
			CardReader.UnIniReaderCard();
			}
		});
}

function read(){
	//if($("#feeDate").val()==''){alert("免费日期不能为空!"); return;}
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
			alert("初始化读卡器失败!");
			CardReader.UnIniReaderCard();
			}
	}catch(e){
		alert("未正确安装控件!");
		CardReader.UnIniReaderCard();
	}
		 } 

function validateResult (result){
	//alert(result);
	if(result==0) return true;
	if(result==-1){alert("初始化读卡器失败!"); CardReader.UnIniReaderCard();return false;}
	else if(result==-2){alert("找不到卡片!");CardReader.UnIniReaderCard();return false;}
	else if(result==-3){alert("获取卡片基本信息失败!");CardReader.UnIniReaderCard();return false;}
	else if(result==-4){alert("写卡信息失败!");CardReader.UnIniReaderCard();return false;}
	else if(result==-6){alert("优惠截至日期小于等于入口流水时间!");CardReader.UnIniReaderCard();return false;}
	else if(result==-10){alert("初始化读卡器失败!");CardReader.UnIniReaderCard();return false;}
	else if(result==-12){alert("串口被占用!");CardReader.UnIniReaderCard();return false;}
	else if(result==-14){alert("加载DLL失败!");CardReader.UnIniReaderCard();return false;}
	else if(result==-15){alert("打开串口失败!");CardReader.UnIniReaderCard();return false;}
	else if(result==-16){alert("读卡器初始化异常!");CardReader.UnIniReaderCard();return false;}
	else if(result<0){alert("操作卡异常!");CardReader.UnIniReaderCard();return false;}
	else return true;
}

</script>
<div class="body-box">
<div class="rhead">
<div class="rpos">当前位置： ${currentPosition}</div>
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
			免费类型：
				<select id="operateType">
					<option value="11">餐饮</option>
					<option value="12">会议</option>
					<option value="13">住宿</option>
				</select>
<!--			&nbsp;&nbsp;-->
<!--			免费日期：-->
<!--				<input id="feeDate" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly = "readonly" >-->
<!--				</input>-->
			&nbsp;&nbsp;
			<input type="button" value=" 操作卡 " onclick="read()" ></input>
			</td>
		</tr>
	</tbody>
</table>
</form>
</div>
</body>
</html>