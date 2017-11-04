<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>�޸Ļ�������</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		
		function back(){
			window.location.href = "zjuPriceConfig_priceBase_list.do";
			}

		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_updatePriceBase.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					  <tr>
						<td class="pn-flabel pn-flabel-h">���ʰ汾��</td>
						<td class="pn-fcontent">${zju_PriceBase.verNo}<input readonly="readonly" type="hidden"  name="zju_PriceBase.verNo" value="${zju_PriceBase.verNo}" size="24"/></td>
					    <td class="pn-flabel pn-flabel-h">���ʱ�ţ�</td>
						<td class="pn-fcontent">${zju_PriceBase.feeNo}<input readonly="readonly" type="hidden" name="zju_PriceBase.feeNo" value="${zju_PriceBase.feeNo}" size="24"/></td>
					  </tr>
					  <tr>
						<td class="pn-flabel pn-flabel-h">�Ż����ͣ�</td>
						<td class="pn-fcontent">${zju_PriceBase.rebateType}<input readonly="readonly" type="hidden"  name="zju_PriceBase.rebateType" value="${zju_PriceBase.rebateType}" size="24"/></td>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</td>
						<td class="pn-fcontent">
						<c:if test="${zju_PriceBase.vehTypeNo==1}"><select class="required " style="height: 22px;width: 178px;" name="zju_PriceBase.vehTypeNo">
						<option value="1">Ħ�г�</option>
						</select></c:if>
						<c:if test="${zju_PriceBase.vehTypeNo==2}"><select class="required " style="height: 22px;width: 178px;" name="zju_PriceBase.vehTypeNo">
						<option value="2">С��</option>
						</select></c:if>
						<c:if test="${zju_PriceBase.vehTypeNo==3}"><select class="required " style="height: 22px;width: 178px;" name="zju_PriceBase.vehTypeNo">
						<option value="3">�����ͳ�</option>
						</select></c:if>
						<c:if test="${zju_PriceBase.vehTypeNo==4}"><select class="required " style="height: 22px;width: 178px;" name="zju_PriceBase.vehTypeNo">
						<option value="3">�����ͳ�</option>
						</select></c:if>
						</td>
					 </tr>
					 <tr>
					   	<td class="pn-flabel pn-flabel-h">ʱ��α�־��</td>
						<td class="pn-fcontent">
						<c:if test="${zju_PriceBase.timesSign==0}">�������</c:if>
						<c:if test="${zju_PriceBase.timesSign==1}">ҹ�����</c:if>
						<input readonly="readonly" type="hidden"  name="zju_PriceBase.timesSign" value="${zju_PriceBase.timesSign}" size="24"/></td>
					  	<td class="pn-flabel pn-flabel-h">�����ڱ�־��</td>
						<td class="pn-fcontent">
						<c:if test="${zju_PriceBase.inOutSign==0}">ͬ��</c:if>
						<c:if test="${zju_PriceBase.inOutSign==1}">����</c:if>
						<input readonly="readonly" type="hidden"  name="zju_PriceBase.inOutSign" value="${zju_PriceBase.inOutSign}" size="24"/></td>		
					 </tr>
					 <tr>
						<td class="pn-flabel pn-flabel-h">��λ����ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.addStart" value="${zju_PriceBase.addStart}" size="24"/>&nbsp;����</td>
						<td class="pn-flabel pn-flabel-h">����ͣ��ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.allowStayTime" value="${zju_PriceBase.allowStayTime}" size="24"/>&nbsp;����</td>
					</tr>	
					<tr>
	     			    <td class="pn-flabel pn-flabel-h">�׶�ͣ��ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.baseFeeTime" value="${zju_PriceBase.baseFeeTime}" size="24"/>&nbsp;����</td>
					    <td class="pn-flabel pn-flabel-h">�׶��շѽ�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.baseFee" value="${zju_PriceBase.baseFee}" size="24"/>&nbsp;��</td>
						</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��λ�շ�ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.stayAdd" value="${zju_PriceBase.stayAdd}" size="24"/>&nbsp;����<span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">��λ�շѽ�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.addFee" value="${zju_PriceBase.addFee}" size="24"/>&nbsp;��<span style="color: red">&nbsp;*</span></td>
					</tr>				
					<tr>
						<td class="pn-flabel pn-flabel-h">���ͣ��ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.maxTime" value="${zju_PriceBase.maxTime}" size="24"/>&nbsp;����</td>
						<td class="pn-flabel pn-flabel-h">����շѽ�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.maxFee" value="${zju_PriceBase.maxFee}" size="24"/>&nbsp;��<span style="color: red">&nbsp;*</span></td>
		            </tr>    
					<tr>
						<td class="pn-flabel pn-flabel-h">������ʿ��ƣ�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.sumFeeCtr" value="${zju_PriceBase.sumFeeCtr}" size="24"/></td>
						<td class="pn-flabel pn-flabel-h">��������շ�ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.maxFeeTime" value="${zju_PriceBase.maxFeeTime}" size="24"/>&nbsp;����</td>
					</tr>	
					
					<tr>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��1&nbsp;��</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16"  name="zju_PriceBase.backup1" value="${zju_PriceBase.backup1}" size="24"/></td>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��2&nbsp;��</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16"  name="zju_PriceBase.backup2" value="${zju_PriceBase.backup2}" size="24"/></td>
					   </tr>    						
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;ʱ&nbsp;��&nbsp;��</td>
						<td colspan="3" class="pn-fcontent"><input size="24" type="text" class="required " name="zju_PriceBase.startTime" value="<fmt:formatDate value="${zju_PriceBase.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""/><span style="color: red">&nbsp;*</span></td>
				     </tr> 
				     <tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע&nbsp;&nbsp;��</td>
						<td colspan="3"  width="80%" class="pn-fcontent">
						<textarea class=" maxlength50"  name="zju_PriceBase.remark" rows="3" cols="50">${zju_PriceBase.remark}</textarea></td>
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