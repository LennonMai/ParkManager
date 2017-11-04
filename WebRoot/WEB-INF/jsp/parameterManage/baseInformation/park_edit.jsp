<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>�޸�С����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
		var record=null; 
		
		if("${result}" == "FAIL") {
			record="fail";
			alert("С�������Ѵ��ڣ�");
		}
		function back(){
			window.location.href = "baseInfo_park_list.do";
		}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateParkInfo.do?parkName=${parkInformation.parkName }">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">������룺</td>
						<td class="pn-fcontent">${parkInformation.areaNo}<input readonly="readonly"  type="hidden"  name="parkInformation.areaNo" value="${parkInformation.areaNo}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">С�����룺</td>
						<td class="pn-fcontent">${parkInformation.parkNo}<input readonly="readonly" type="hidden"  name="parkInformation.parkNo" value="${parkInformation.parkNo}" size="28"/></td>
			    		</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">С�����ƣ�</td>
						<td class="pn-fcontent"><input id="parkInformation.parkName" type="text" class="required maxlength20" name="parkInformation.parkName" value="${parkInformation.parkName}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength30" name="parkInformation.parkDomain" value="${parkInformation.parkDomain}" size="28"/></td>
						</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">С��ȫ�ƣ�</td>
						<td class="pn-fcontent"><input type="text" class="maxlength40" name="parkInformation.parkFullName" value="${parkInformation.parkFullName}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">������IP��</td>
						<td class="pn-fcontent"><input type="text" class=" isIP" name="parkInformation.parkServerIp" value="${parkInformation.parkServerIp}" size="28"/></td>
						</tr>
					<tr>
				    	<td class="pn-flabel pn-flabel-h">���������ƣ�</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16" name="parkInformation.parkServerName" value="${parkInformation.parkServerName}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">���ݿ�����</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="parkInformation.parkDbname" value="${parkInformation.parkDbname}" size="28"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ݿ��û�����</td>
						<td class="pn-fcontent"><input type="text" class="maxlength8" name="parkInformation.parkDbuserName" value="${parkInformation.parkDbuserName}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">���ݿ����룺</td>
						<td class="pn-fcontent"><input type="text" class="maxlength6" name="parkInformation.parkDbpassword" value="${parkInformation.parkDbpassword}" size="28"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">С������</td>
						<td  class="pn-fcontent">${parkInformation.parkLevel}<input readonly="readonly" type="hidden" name="parkInformation.parkLevel" value="${parkInformation.parkLevel}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">�ϼ�С�����룺</td>
						<td  class="pn-fcontent"><input type="text" class="isNo_NotOverValue" name="parkInformation.uplevelParkNo" value="${parkInformation.uplevelParkNo}" size="28"/></td>
					    
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��λ������</td>
						<td colspan="4" class="pn-fcontent"><input class="isNo_NotOverValueInt" type="text" name="parkInformation.parkSpaceCnt" value="${parkInformation.parkSpaceCnt}" size="28"/></td>
					   
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
		<script type="text/javascript">
		if(record == "fail") {
			get("parkInformation.parkName").focus();
		}
		</script>
		</div>
	</body>
</html>