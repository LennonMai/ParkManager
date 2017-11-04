<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>��ӷ�������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasPriceBase"){
			alert("�Ѵ��ڸ÷��ʣ�");
		    }
		function back(){
			window.location.href = "priceBase_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="priceBase_savePriceBase.do">
				<br/><span style="color: red">&nbsp;*������</span>
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                  
					 <tr>
						<td class="pn-flabel pn-flabel-h">���ʰ汾��</td>
						<td colspan="4" class="pn-fcontent"><input type="text" class="required versonNoFormat" name="priceBase.verNo" value="${priceBase.verNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					 <tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</td>
						<td colspan="4" class="pn-fcontent"><select style="width: 206px;height: 22px;" name="priceBase.vehTypeNo" class="required ">
						<option value="">- ��ѡ�� -</option>
						<option value="1">Ħ�г�</option>
						<option value="2">С��</option>
						<option value="3">���ͳ�</option>
						<option value="4">�����ͳ�</option>
						<option value="0">���г���</option>
						</select><span style="color: red">&nbsp;*</span></td>
					 </tr>
					 <tr>
						<td class="pn-flabel pn-flabel-h">���ͣ����</td>
						<td colspan="4" class="pn-fcontent"><input class="required isNo_NotOverValueInt" type="text" name="priceBase.allowStayTime" value="${priceBase.allowStayTime}" size="28"/>&nbsp;����<span style="color: red">&nbsp;*</span></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">ÿ��</td>
						<td colspan="4" class="pn-fcontent"><input class="required isNo_NotOverValueInt" type="text" name="priceBase.stayAdd" value="${priceBase.stayAdd}" size="8"/>&nbsp;Сʱ���շ�
						<input class="required isNo_NotOverValueInt" type="text" name="priceBase.addFee" value="${priceBase.addFee}" size="8"/>&nbsp;Ԫ<span style="color: red">&nbsp;*</span></td>
					</tr>
					
					<tr>
						<td class="pn-flabel pn-flabel-h">12Сʱ����շѣ�</td>
						<td colspan="4" class="pn-fcontent"><input class="required isNo_NotOverValueInt" type="text" name="priceBase.maxFee" value="${priceBase.maxFee}" size="28"/>&nbsp;Ԫ<span style="color: red">&nbsp;*</span></td>
		            </tr>    
					<tr>
						<td class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
						<td colspan="4" class="pn-fcontent"><input class="required " style="width: 201px;" type="text" name="priceBase.startTime" value="<fmt:formatDate value="${priceBase.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
				    </tr>    	
				</table>
								<br/><span style="color: red">&nbsp;&nbsp;��ѡ�Ϊ����Ĭ�ϸ���ʼֵ���޸�ҳ��ɼ���</span>
					<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
					    <td class="pn-flabel pn-flabel-h">�Ż����ͣ�</td>
						<td class="pn-fcontent"><!--<input type="text" class=" isNo_NotOverValueInt" name="priceBase.rebateType" value="${priceBase.rebateType}" size="22"/></td>
						-->
						<select class="required " id="priceBase.rebateType" name="priceBase.rebateType" style="width: 164px;height: 22px;">
						<option value="0">���Ż�</option>
						</select></td>
						 <td class="pn-flabel pn-flabel-h">�����ڱ�־��</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.inOutSign" value="${priceBase.inOutSign}" size="22"/></td>		
						</tr>
	     			<tr>
	     			    <td class="pn-flabel pn-flabel-h">�׶�ͣ��ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.baseFeeTime" value="${priceBase.baseFeeTime}" size="22"/>&nbsp;����</td>
					    <td class="pn-flabel pn-flabel-h">ʱ��α�־��</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.timesSign" value="${priceBase.timesSign}" size="22"/></td>
						</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">�׶��շѽ�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.baseFee" value="${priceBase.baseFee}" size="22"/>&nbsp;��</td>
						<td class="pn-flabel pn-flabel-h">��λ����ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.addStart" value="${priceBase.addStart}" size="22"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">���ͣ��ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.maxTime" value="${priceBase.maxTime}" size="22"/>&nbsp;����</td>
						<td class="pn-flabel pn-flabel-h">������ʿ��ƣ�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.sumFeeCtr" value="${priceBase.sumFeeCtr}" size="22"/></td>
					</tr>	
					<tr>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;��1��</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16" name="priceBase.backup1" value="${priceBase.backup1}" size="22"/></td>
					    <td class="pn-flabel pn-flabel-h">ÿ���Ʒ���������շ�ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.maxFeeTime" value="${priceBase.maxFeeTime}" size="22"/></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;��2��</td>
						<td colspan="4" class="pn-fcontent"><input class=" maxlength16" type="text" name="priceBase.backup2" value="${priceBase.backup2}" size="22"/></td>
					   </tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;ע&nbsp;��</td>
						<td colspan="4"  width="80%" class="pn-fcontent">
						<textarea class=" maxlength50" name="priceBase.remark" rows="3" cols="48">${priceBase.remark}</textarea></td>
					</tr>	
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� "/>&nbsp;
						    <input type="reset" value=" �� �� "/>&nbsp;
						    <input type="button" value=" �� �� " onclick="return back()"/>
						</td> 
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>