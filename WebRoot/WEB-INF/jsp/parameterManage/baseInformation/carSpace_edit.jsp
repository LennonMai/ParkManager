<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>修改车位信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			function back(){
				window.location.href = "baseInfo_carSpace_list.do";
			}
			
			function check(){
				if(document.getElementById('maxSpace').value==""){
					alert("最大车位数不能为空");
					return false;
				}
				if(document.getElementById('carCount').value==""){
					alert("零点车辆数不能为空");
					return false;
				}
				if(document.getElementById('criticalNum').value==""){
					alert("车位临界值不能为空");
					return false;
				}
				if(parseInt(document.getElementById('carCount').value)>parseInt(document.getElementById('maxSpace').value)){
					alert("零点车辆数不能大于最大车位数");
					return false;
				}
				if(parseInt(document.getElementById('criticalNum').value)>parseInt(document.getElementById('maxSpace').value)){
					alert("车位临界值不能大于最大车位数");
					return false;
				}
				return true;
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updatecarSpaceInfo.do" onsubmit="return check()">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">小区名称：</td>
						<td class="pn-fcontent">
							<c:forEach items="${parkList}" var="item1"><c:if test="${item1.parkNo==carSpaceInformation.parkNo}">${item1.parkName}</c:if></c:forEach>
							<input readonly="readonly"  type="hidden" name="carSpaceInformation.parkNo" value="${carSpaceInformation.parkNo}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">大门名称：</td>
						<td class="pn-fcontent">
							<c:choose>
									<c:when test="${carSpaceInformation.gateNo=='all'}">
										${carSpaceInformation.gateNo}
									</c:when>
									<c:otherwise>
										<c:forEach items="${gatewayList}" var="item2"><c:if test="${item2.parkNo==carSpaceInformation.parkNo&&item2.gateNo==carSpaceInformation.gateNo}">${item2.gateName}</c:if></c:forEach>
									</c:otherwise>
								</c:choose>	
						<input readonly="readonly"  type="hidden" name="carSpaceInformation.gateNo" value="${carSpaceInformation.gateNo}" size="28"/></td>			    		
					    </tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">最大车位数：</td>
						<td class="pn-fcontent"><input type="text" id="maxSpace" class="required isNo_NotOverValue" name="carSpaceInformation.maxSpace" value="${carSpaceInformation.maxSpace}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">零点车辆数：</td>
						<td class="pn-fcontent"><input type="text" id="carCount" class="required isNo_NotOverValue" name="carSpaceInformation.carCount" value="${carSpaceInformation.carCount}" size="28"/><span style="color: red">&nbsp;*</span></td>
						
						</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">车位临界值：</td>
						<td class="pn-fcontent"><input type="text" id="criticalNum" class="required isNo_NotOverValue" name="carSpaceInformation.criticalNum" value="${carSpaceInformation.criticalNum}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">更新时间：</td>
						<td class="pn-fcontent"><input style="width: 204px;" type="text" class="required" name="carSpaceInformation.modifyTime" value="<fmt:formatDate value="${carSpaceInformation.modifyTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""/><span style="color: red">&nbsp;*</span></td>
					    
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