<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>�޸Ĵ�����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
		var record=null; 
		
		if("${result}" == "FAIL") {
			record="fail";
			alert("���������Ѵ��ڣ�");
			}
			function back(){
				window.location.href = "baseInfo_gateway_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateGatewayInfo.do?gateName=${gatewayInformation.gateName }">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">������룺</td>
						<td style="width: 430px;" class="pn-fcontent">${gatewayInformation.areaNo}<input readonly="readonly" type="hidden"  name="gatewayInformation.areaNo" value="${gatewayInformation.areaNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">С�����룺</td>
						<td class="pn-fcontent">${gatewayInformation.parkNo}<input readonly="readonly" type="hidden"  name="gatewayInformation.parkNo" value="${gatewayInformation.parkNo}" size="28"/></td>
			    		</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">���ű��룺</td>
						<td style="width: 430px;" class="pn-fcontent">${gatewayInformation.gateNo}<input readonly="readonly" type="hidden"  name="gatewayInformation.gateNo" value="${gatewayInformation.gateNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent"><input type="text" class="maxlength20" name="gatewayInformation.gateName" value="${gatewayInformation.gateName}" size="28"/><span style="color: red">&nbsp;*</span></td>
			    		</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">����ȫ�ƣ�</td>
						<td colspan="4"  class="pn-fcontent"><input type="text" class="maxlength20" name="gatewayInformation.gateAllName" value="${gatewayInformation.gateAllName}" size="28"/></td>
						</tr>
					<tr>	
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;ע��</td>
						<td colspan="4"  class="pn-fcontent"><textarea class="maxlength50" name="gatewayInformation.remark" rows="3" cols="40">${gatewayInformation.remark}</textarea></td>
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
		<script type="text/javascript">
		if(record == "fail") {
			get("gatewayInformation.gateName").focus();
		}
		</script>
	</body>
</html>