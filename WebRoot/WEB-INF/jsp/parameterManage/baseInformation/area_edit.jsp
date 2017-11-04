<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>�޸�������Ϣ</title>
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
			window.location.href = "baseInfo_area_list.do";
		}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateAreaInfo.do?areaName=${areaInformation.areaName}">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">���б��룺</td>
						<td class="pn-fcontent">${areaInformation.cityNo}<input readonly="readonly" type="hidden" name="areaInformation.cityNo" value="${areaInformation.cityNo}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">������룺</td>
						<td class="pn-fcontent">${areaInformation.areaNo}<input readonly="readonly" type="hidden" name="areaInformation.areaNo" value="${areaInformation.areaNo}" size="28"/></td>
			    		</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent"><input  type="text" class="required maxlength20" name="areaInformation.areaName" value="${areaInformation.areaName}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td class="pn-fcontent"><input type="text" class="maxlength30" name="areaInformation.areaDomain" value="${areaInformation.areaDomain}" size="28"/></td>
						</tr>
					<tr>
				    	<td class="pn-flabel pn-flabel-h">������IP��</td>
						<td class="pn-fcontent"><input type="text" class="isIP" name="areaInformation.areaServerIp" value="${areaInformation.areaServerIp}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">���������ƣ�</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="areaInformation.areaServerName" value="${areaInformation.areaServerName}" size="28"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ݿ�����</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="areaInformation.areaDbname" value="${areaInformation.areaDbname}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">���ݿ����룺</td>
						<td class="pn-fcontent"><input type="text" class="maxlength6" name="areaInformation.areaDbpassword" value="${areaInformation.areaDbpassword}" size="28"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ݿ��û�����</td>
						<td colspan="4" class="pn-fcontent"><input type="text" class="maxlength8" name="areaInformation.areaDbuserName" value="${areaInformation.areaDbuserName}" size="28"/></td>
					    
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
			get("areaInformation.areaName").focus();
		}
		</script>
	</body>
</html>