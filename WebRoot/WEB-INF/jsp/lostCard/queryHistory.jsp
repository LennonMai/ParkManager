<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			if("${message}"=="12"){
				alert("入口流水中没有该条信息");
			}
			if("${message}"=="13"){
				alert("出口流水中没有该条信息");
			}
			function check(){
			var start = document.getElementById('startTime').value;
			var end = document.getElementById('endTime').value;
			if(start != "" && end != ""){
				if(start > end){
					alert("开始时间不能大于结束时间！");
					return false;
				}
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
			<form name="tableForm" method="post" action="lostCard_queryHistory.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">时 间 段：</td>
						<td class="pn-fcontent">
						  <input type="text" name="startTime" id ="startTime" value= "${startTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
						  	--<input type="text" name="endTime" id ="endTime" value="${endTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
						</td>
						<td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;号：</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNo" value="${cardNo}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">车&nbsp;&nbsp;主：</td>
						<td class="pn-fcontent">
						  	<input type="text" name="owner" value="${owner }" />
						</td>
						<td class="pn-flabel pn-flabel-h">车 牌 号：</td>
						<td class="pn-fcontent">
						  	<input type="text" name="vehPlate" value="${vehPlate}" />
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 查 询 " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value=" 重 置 "/>		
						</td>
					</tr>
				</table>
			<!-- 显示list数据-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>卡    号</th>
						<th>发卡时间</th>
						<th>车 牌 号</th>
						<th>拿卡车主</th>
						<th>流 水 号</th>					
						<th>操作员名</th>
						<th>出口流水</th>
						<th>出口时间</th>
						<th>操 作 员</th>
						<th>卡 状 态</th>
						<th>出口备注</th>
						<th>操    作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.cardNo }</td>
							<td><fmt:formatDate value="${item.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item.vehPlate }</td>
							<td>${item.owner }</td>
							<td>${item.listNo }</td>
							<td>${item.operatorName }</td>
							<td>${item.outListNo }</td>
							<td><fmt:formatDate value="${item.outOpTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item.outOperatorName }</td>
							<td>
								<c:if test="${item.cardStatus==11}">入口发出</c:if>
								<c:if test="${item.cardStatus==12}">出口回收</c:if>
								<c:if test="${item.cardStatus==13}">丢卡(丢失数据不足，无法追回)</c:if>
								<c:if test="${item.cardStatus==14}">未知</c:if>
								<c:if test="${item.cardStatus==15}">坏卡</c:if>
								<c:if test="${item.cardStatus==16}">已罚款</c:if>
							</td>
							<td>${item.outRemark }</td>
							<td>
								<a href="lostCard_historyMessage.do?inListNo=${item.listNo }&outListNo=${item.outListNo }&cardNo=${item.cardNo }&opTime=${item.opTime }&squadDate=${item.squadDate }&OutSquadDate=${item.outSquadDate }" class="pn-loperator">丢卡详细信息</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>