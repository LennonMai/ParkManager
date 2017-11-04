<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			window.onload = function() {
				if("${buttonStatus}" == "1") {	//数据不一致不可提交
					get("button").disabled = true;
				}
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="generateSum_generateOneLaneSum.do" >
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input id="button" type="submit" value=" 确 定 " />&nbsp;
						<input type="button" value=" 取 消 " onclick="history.back()" />	
						</td>
						<input type="hidden" name="areaNo" value="${areaNo }"/>
						<input type="hidden" name="parkNo" value="${parkNo }"/>
						<input type="hidden" name="gateNo" value="${gateNo }"/>
						<input type="hidden" name="laneNo" value="${laneNo }"/>
						<input type="hidden" name="squadDatejs" value="<fmt:formatDate value="${squadDate}" pattern="yyyy-MM-dd" />"/>
						<input type="hidden" name="squadNo" value="${squadNo }"/>
						<input type="hidden" name="tvCount" value="${tvCount }"/>
						<input type="hidden" name="tvMoney" value="${tvMoney }"/>
						<input type="hidden" name="squadDate" value="<fmt:formatDate value="${squadDate}" pattern="yyyy-MM-dd" />"/>
					</tr>
				</table>
			<!-- ${fn:length(list)} 显示list长度-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>大&nbsp;&nbsp;门</th>
						<th>车&nbsp;&nbsp;道</th>
						<th>工班日期</th>
						<th>工班号</th>
						<th>车道类型</th>
						<th>车道记录数</th>
						<th>车道通行费</th>
						<th>流水记录数</th>
						<th>流水通行费</th>
						<th>现金金额</th>
						<th>粤通卡金额</th>							
						<th>车道中心数据对比</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${gateName }</td>
							<td>${laneNo }</td>
							<td><fmt:formatDate value="${squadDate}" pattern="yyyy-MM-dd" /></td>
							<td>${squadNo}</td>
							<td>${laneType}</td>
							<td>${tvCount }</td>
							<td>${tvMoney }</td>
							<td>${item.ListCount}</td>
							<td>${item.ListCashM+item.ListETCM }</td>
							<td>${item.ListCashM}</td>
							<td>${item.ListETCM }</td>							
							<c:if test="${item.status==0}">
								<td>数据一致</td>
							</c:if>
							<c:if test="${item.status==1}">
								<td><font color="red">数据不一致</font></td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!--<jsp:include page="../../../include/pager.jsp"/>-->
			</form>
		</div>
	</body>
</html>