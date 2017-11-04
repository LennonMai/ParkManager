<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>修改大门信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
		var record=null; 
		
		if("${result}" == "FAIL") {
			record="fail";
			alert("大门名称已存在！");
			}
			function back(){
				window.location.href = "baseInfo_gateway_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateGatewayInfo.do?gateName=${gatewayInformation.gateName }">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">区域编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${gatewayInformation.areaNo}<input readonly="readonly" type="hidden"  name="gatewayInformation.areaNo" value="${gatewayInformation.areaNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">小区编码：</td>
						<td class="pn-fcontent">${gatewayInformation.parkNo}<input readonly="readonly" type="hidden"  name="gatewayInformation.parkNo" value="${gatewayInformation.parkNo}" size="28"/></td>
			    		</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">大门编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${gatewayInformation.gateNo}<input readonly="readonly" type="hidden"  name="gatewayInformation.gateNo" value="${gatewayInformation.gateNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">大门名称：</td>
						<td class="pn-fcontent"><input type="text" class="maxlength20" name="gatewayInformation.gateName" value="${gatewayInformation.gateName}" size="28"/><span style="color: red">&nbsp;*</span></td>
			    		</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">大门全称：</td>
						<td colspan="4"  class="pn-fcontent"><input type="text" class="maxlength20" name="gatewayInformation.gateAllName" value="${gatewayInformation.gateAllName}" size="28"/></td>
						</tr>
					<tr>	
						<td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;注：</td>
						<td colspan="4"  class="pn-fcontent"><textarea class="maxlength50" name="gatewayInformation.remark" rows="3" cols="40">${gatewayInformation.remark}</textarea></td>
						</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/>&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
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