<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>�޸ĳ�����Ѵ�����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		
		function back(){
			window.location.href = "zjuPriceConfig_vehFreeTimes_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform"  method="post" action="zjuPriceConfig_updateVehFreeTimes.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">���ƺ��룺</td>
						<td style="width: 430px;" class="pn-fcontent">${vehFreeTimes.vehPlate}<input readonly="readonly"  type="hidden" name="vehFreeTimes.vehPlate" value="${vehFreeTimes.vehPlate}" size="24"/></td>
						<td class="pn-flabel pn-flabel-h">�꣺</td>
						<td class="pn-fcontent"><input class="required isNo_NotOverValueInt" type="text" name="vehFreeTimes.year" value="${vehFreeTimes.year}" size="24"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">ʣ�������</td>
						<td colspan="4" class="pn-fcontent"><input class="required isNo_NotOverValueInt" type="text" name="vehFreeTimes.leftFreeTimes" value="${vehFreeTimes.leftFreeTimes}" size="24"/><span style="color: red">&nbsp;*</span></td>
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