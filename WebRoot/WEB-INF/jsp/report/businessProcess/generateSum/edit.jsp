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
			//跳转打印页面
			function doPrint() {
				window.location.href="generateSum_printLaneSum.do?areaNo="+${areaNo}+"&parkNo="+${parkNo}
					+"&gateNo="+${gateNo}+"&squadDatejs="+'${squadDatejs}';
			}
			function sumAllLane() {
				window.location.href="generateSum_sumAllLane.do?areaNo="+${areaNo}+"&parkNo="+${parkNo}
					+"&gateNo="+${gateNo}+"&squadDatejs="+'${squadDatejs}'+"&gateNoTemp="+'${gateNoTemp}'+"&squadDateTemp="+'${squadDateTemp}'+"&stationYNSumTemp="+'${stationYNSumTemp}';
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="generateSum_sumAllLane.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="button" value=" 合计全部车道 " onclick="sumAllLane();" />&nbsp;
						<input type="button" value=" 返 回 " onclick="history.back();" />&nbsp;
						<input type="reset" value=" 打 印 " onclick="doPrint();"/>	
						</td>
					</tr>
				</table>
				
			<!-- ${fn:length(list)} 显示list长度-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>区&nbsp;&nbsp;域</th>
						<th>小&nbsp;&nbsp;区</th>
						<th>大&nbsp;&nbsp;门</th>
						<th>车&nbsp;&nbsp;道</th>
						<th>工班日期</th>
						<th>工班号</th>
						<th>车道类型</th>
						<th>工班记录数</th>
						<th>工班通行费</th>
						<th>流水记录数</th>
						<th>流水通行费</th>
						<th>已合计</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.AreaName }</td>
							<td>${item.ParkName }</td>
							<td>${item.GateName }</td>
							<td>${item.LaneNo }</td>
							<td>${item.SquadDate}</td>
							<td>${item.SquadNo}</td>
							<td>${item.LaneType}</td>
							<td>${item.TVCount }</td>
							<td>${item.TVMoney }</td>
							<td>${item.count }</td>
							<td>${item.money }</td>
							<td>${item.LaneYNSum }</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<c:choose> 
                            <c:when test="${item.LaneYNSum =='是'}"> 
                                <a href="generateSum_sumLane.do?areaNo=${item.areaNo}&parkNo=${item.parkNo}
									&gateNo=${item.gateNo}&gateName=${item.gateName}&laneNo=${item.laneNo}&squadDate=${item.squadDate}
									&squadNo=${item.squadNo}&laneType=${item.laneType}&tvCount=${item.tvCount}
									&tvMoney=${item.tvMoney}" class="pn-loperator">重新合计</a>                             
                             </c:when>                           
                             <c:otherwise> 
                             <a href="generateSum_sumLane.do?areaNo=${item.areaNo}&parkNo=${item.parkNo}
									&gateNo=${item.gateNo}&gateName=${item.gateName}&laneNo=${item.laneNo}&squadDate=${item.squadDate}
									&squadNo=${item.squadNo}&laneType=${item.laneType}&tvCount=${item.tvCount}
									&tvMoney=${item.tvMoney}" class="pn-loperator">合&nbsp&nbsp;&nbsp&nbsp;计</a>                            
                             </c:otherwise> 
                               </c:choose>							
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!--<jsp:include page="../../../include/pager.jsp"/>-->
			</form>
		</div>
	</body>
</html>