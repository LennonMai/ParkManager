<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>交接班信息修改</title>
		<%@include file="../../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript">
			function check(){
				if(confirm("您确认要修改？")) {
					return true;
				}
				return false;
			}
			function getLaneOperNo() { //修改获取收费员工号
				document.getElementById("laneOperatorNo").value="";
	    	   	document.getElementById("laneOperatorNo").value=document.getElementById("operatorNo").value;	
				
			}
			function back(id,count){
				window.location.href = "handInMoney_list.do?pager.currentPage="+id+"&pager.pageSize="+count;
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="handInMoney_update.do?" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">区域名称：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="areaInformation.areaName" value="${areaInformation.areaName}" size="40" readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">小区名称：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="parkInformation.parkName" value="${parkInformation.parkName}" size="40" readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">大门名称：</td>
						<!-- <td width="80%" class="pn-fcontent" >
						  <select name="handInMoney.gateNo" style="width:292px" >
						  		<c:forEach items="${listGate}" var="item">
						  			<option value="${item.gateNo}" <c:if test="${handInMoney.gateNo==item.gateNo}">selected</c:if> >${item.gateName}</option>
						  		</c:forEach>
						  </select>
						  <span style="color: red">&nbsp;*</span>
						</td> -->
						<td width="80%" class="pn-fcontent">
							<input type="text"  name="gatewayInformation.gateName" value="${gatewayInformation.gateName}" size="40" readonly />
						</td>
						
						
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">车道编码：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="handInMoney.laneNo" value="${handInMoney.laneNo}" size="40" readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">工班日期：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="handInMoney.squadDate" value="<fmt:formatDate value="${handInMoney.squadDate}" pattern="yyyy-MM-dd" />" size="40" readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">工班号：</td>
						<td width="80%" class="pn-fcontent">
							<input type="text"  name="handInMoney.squadNo" value="${handInMoney.squadNo}" size="40" readonly="readonly"/>
						</td>
						<!-- <td width="80%" class="pn-fcontent">
							<select name="handInMoney.squadNo" style="width:292px">
								<c:forEach items="${listSquad}" var="item">
									<option value="${item.squadNo}" <c:if test="${handInMoney.squadNo==item.squadNo}">selected</c:if> >${item.squadName}</option>
								</c:forEach>
							</select>
							<span style="color: red">&nbsp;*</span>
						</td> -->
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">收费员：</td>
						<td width="80%" class="pn-fcontent" >
						  <select id="operatorNo" name="handInMoney.laneOperatorName" class="required" style="width:292px" onchange="getLaneOperNo();" >
						  		<c:forEach items="${list}" var="item">
						  			<option value="${item.operatorNo}" <c:if test="${handInMoney.laneOperatorNo==item.operatorNo}">selected</c:if> >${item.operatorName}</option>
						  		</c:forEach>
						  </select>
						  <span style="color: red">&nbsp;*</span>
						</td>
						<!-- <td width="80%" class="pn-fcontent">
								<input type="text"  name="handInMoney.laneOperatorName" value="${handInMoney.laneOperatorName}" size="40"/>
								<span style="color: red">&nbsp;*</span>
							</td> -->
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">收费工号：</td>
						<td width="80%" class="pn-fcontent"><input id="laneOperatorNo" type="text"  name="handInMoney.laneOperatorNo" value="${handInMoney.laneOperatorNo}" size="40" readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">币种：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="handInMoney.moneyTypeString" value="${handInMoney.moneyTypeString}" size="40" readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">应交金额：（元）</td>
						<td width="80%" class="pn-fcontent">
							<input type="text"  name="handInMoney.money" value="${handInMoney.money}" size="40" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">实交金额：（元）</td>
						<td width="80%" class="pn-fcontent">
							<input type="text"  name="handInMoney.handInMoney" value="${handInMoney.handInMoney}" class="required isNo_NotOverDecimal" size="40"/>
							<span style="color: red">&nbsp;*</span>
						</td>
					</tr>
					<input type="hidden"  name="handInMoney.areaNo" value="${handInMoney.areaNo}" size="40"/>
					<input type="hidden"  name="handInMoney.parkNo" value="${handInMoney.parkNo}" size="40"/>
					<input type="hidden"  name="handInMoney.gateNo" value="${handInMoney.gateNo}" size="40"/>
					<input type="hidden"  name="handInMoney.moneyTypeNo" value="${handInMoney.moneyTypeNo}" size="40"/>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="submit" value=" 修 改 " /> &nbsp;
						    <input type="reset"" value=" 重 置 " /> &nbsp;
						     <input type="button" value=" 返 回 " onclick="return back(${pager.currentPage },${pager.pageSize })"/></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>