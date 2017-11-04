<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>修改车道信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
			<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
		if("${message}"=="exitIP"){
			alert("计算机IP地址已存在！");
			}
			function back(){
				window.location.href = "baseInfo_lane_list.do";
				}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateLaneInfo.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	<tr>
						<td class="pn-flabel pn-flabel-h">区域编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${laneInformation.areaNo}<input readonly="readonly"  type="hidden" name="laneInformation.areaNo" value="${laneInformation.areaNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">小区编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${laneInformation.parkNo}<input readonly="readonly"  type="hidden" name="laneInformation.parkNo" value="${laneInformation.parkNo}" size="28"/></td>
			    		</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">大门编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${laneInformation.gateNo}<input readonly="readonly"  type="hidden" name="laneInformation.gateNo" value="${laneInformation.gateNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">车道类型：</td>
						<td class="pn-fcontent"><c:if test="${laneInformation.laneTypeNo==null}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" selected="selected">- 请选择 -</option>
			               <option value="1">入口</option>
			               <option value="2">出口</option>		          
		                </select>
		                </c:if>
		                <c:if test="${laneInformation.laneTypeNo==1}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" >- 请选择 -</option>
			               <option value="1" selected="selected">入口</option>
			               <option value="2">出口</option>			          
		                </select>
		                </c:if>
		                 <c:if test="${laneInformation.laneTypeNo==2}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" >- 请选择 -</option>
			               <option value="1">入口</option>
			               <option value="2" selected="selected">出口</option>			          
		                </select>
		                </c:if><span style="color: red">*</span></td>
						</tr>	
			    	 
					<tr>
						<td class="pn-flabel pn-flabel-h">车道编码：</td>
						<td style="width: 430px;" class="pn-fcontent">${laneInformation.laneNo}<input readonly="readonly"  type="hidden" name="laneInformation.laneNo" value="${laneInformation.laneNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">计算机名：</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16"  name="laneInformation.laneComputerName" value="${laneInformation.laneComputerName}" size="28"/></td>
						</tr>
					<tr>	
						<td class="pn-flabel pn-flabel-h">计算机IP地址：</td>
						<td class="pn-fcontent"><input type="text" class="required isIP"  name="laneInformation.laneComputerIp" value="${laneInformation.laneComputerIp}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">启用合计：</td>
						<td class="pn-fcontent">
							<select class="required " name="laneInformation.isUse" style="width: 206px;height: 22px;">
				               <option value="1" <c:if test="${laneInformation.isUse==1}">selected="selected"</c:if>>启用</option>
				               <option value="0" <c:if test="${laneInformation.isUse==0}">selected="selected"</c:if>>不启用</option>			          
			                </select>
							<span style="color: red">&nbsp;*</span>
						</td>
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