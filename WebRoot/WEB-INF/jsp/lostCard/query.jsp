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
	</head>
	<script type="text/javascript">
		if("${message}"=="11"){
			alert("入口流水中没有该条信息");
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
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="lostCard_queryCardDynamic.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">时 间 段：</td>
						<td class="pn-fcontent">
						  <input type="text" name="startTime" id ="startTime" value= "${startTime }" class="Wdate" size="16" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						  	-- <input type="text" name="endTime" id ="endTime" value="${endTime }" class="Wdate" size="16" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
						<td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;号：</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNo" value="${cardNo}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">状&nbsp;&nbsp;态：</td>
						<td class="pn-fcontent">
						  	<select name="status" style="width: 185px">
						  		<option value="" <c:if test="${status==null}">selected</c:if>>-请选择-</option>
						  		<option value="11" <c:if test="${status==11}">selected</c:if>>入口发出</option>
						  		<option value="13" <c:if test="${status==13}">selected</c:if>>丢卡(丢失数据不足，无法追回)</option>
						  		<option value="14" <c:if test="${status==14}">selected</c:if>>未知</option>
						  		<option value="15" <c:if test="${status==15}">selected</c:if>>坏卡</option>
						  		<option value="16" <c:if test="${status==16}">selected</c:if>>已罚款</option>
						  	</select>
						</td>
						<td class="pn-flabel pn-flabel-h">车牌号：</td>
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
						<th>临时卡表面号</th>
						<th>发卡时间</th>
						<th>卡 状 态</th>
						<th>识别车牌</th>
						<th>发卡员编号</th>
						<th>发卡员姓名</th>					
						<th>入口流水号</th>
						<th>拿卡车主</th>
						<th>操    作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.cardNo }</td>
							<td><fmt:formatDate value="${item.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item.status==11}">入口发出</c:if>
								<c:if test="${item.status==13}">丢卡(丢失数据不足，无法追回)</c:if>
								<c:if test="${item.status==14}">未知</c:if>
								<c:if test="${item.status==15}">坏卡</c:if>
								<c:if test="${item.status==16}">已罚款</c:if>
							</td>
							<td>${item.vehPlate }</td>
							<td>${item.operatorNo }</td>
							<td>${item.operatorName }</td>
							<td>${item.inListNo }</td>
							<td>${item.owner }</td>
							<td>
								<a href="lostCard_cardDynamicOk.do?queryCardNo=${item.cardNo }&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage }
									&startTime=${startTime }&endTime=${endTime }&cardNo=${cardNo }&status=${status }&vehPlate=${vehPlate }" class="pn-loperator">状态确认</a>
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