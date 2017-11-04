<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>修改有用车道</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
			<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
		if("${message}"=="exitIP"){
			alert("计算机IP地址已存在！");
			}
			function back(){
				window.location.href = "baseInfo_laneUse_list.do";
				}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateLaneUse.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	<tr>
						<td style="width: 200px;" class="pn-flabel pn-flabel-h">区域编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${laneUse.areaNo}<input readonly="readonly"  type="hidden" name="laneUse.areaNo" value="${laneUse.areaNo}" size="28"/></td>
			    		<td style="width: 200px;" class="pn-flabel pn-flabel-h">小区编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${laneUse.parkNo}<input readonly="readonly"  type="hidden" name="laneUse.parkNo" value="${laneUse.parkNo}" size="28"/></td>
			    		</tr>
			    	<tr>
						<td style="width: 200px;" class="pn-flabel pn-flabel-h">大门编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${laneUse.gateNo}<input readonly="readonly"  type="hidden" name="laneUse.gateNo" value="${laneUse.gateNo}" size="28"/></td>
			    		<td style="width: 200px;" class="pn-flabel pn-flabel-h">车道编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${laneUse.laneNo}<input readonly="readonly"  type="hidden" name="laneUse.laneNo" value="${laneUse.laneNo}" size="28"/></td>
					</tr>	
			    	 
					<tr>	
						<td style="width: 200px;" class="pn-flabel pn-flabel-h">是否启用：</td>
						<td class="pn-fcontent"><c:if test="${laneUse.isUse==null}">
						<select class="required " name="laneUse.isUse" style="width: 206px;height: 22px;">
			               <option value="0" selected="selected">不启用</option>
			               <option value="1">启用</option>		          
		                </select>
		                </c:if>
		                <c:if test="${laneUse.isUse==0}">
						<select class="required " name="laneUse.isUse" style="width: 206px;height: 22px;">
			               <option value="0" selected="selected">不启用</option>
			               <option value="1">启用</option>			          
		                </select>
		                </c:if>
		                <c:if test="${laneUse.isUse==1}">
						<select class="required " name="laneUse.isUse" style="width: 206px;height: 22px;">
			               <option value="0">不启用</option>
			               <option value="1" selected="selected">启用</option>			          
		                </select>
		                </c:if></td>
						<td style="width: 200px;"class="pn-flabel pn-flabel-h">计算机IP地址：</td>
						<td class="pn-fcontent">${laneUse.laneComputerIp}<input type="hidden" class="required isIP"  name="laneUse.laneComputerIp" value="${laneUse.laneComputerIp}" size="28"/></td>
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
	</body>
</html>