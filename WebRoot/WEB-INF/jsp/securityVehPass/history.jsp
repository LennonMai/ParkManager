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
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			function getGate(){
				$.ajax({
					type:"post",
					url:"securityVehPass_ajaxGate.do?parkNo="+$(document.tableForm.parkNo).val(),
					success:function(res){
						$("#gateNo").empty();
						var op = $("<option value=''>-请选择-</option>");		
						$("#gateNo").append(op);
						$(res).find("gates > gate").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#gateNo").append(op);	
					});
					}
				});
			}
			function getLane(){
				$.ajax({
					type:"post",
					url:"securityVehPass_ajaxLane.do?parkNo="+$(document.tableForm.parkNo).val()
					+ "&gateNo="+$(document.tableForm.gateNo).val(),
					success:function(res){
						$("#laneNo").empty();
						var op = $("<option value=''>-请选择-</option>");		
						$("#laneNo").append(op);
						$(res).find("lanes > lane").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#laneNo").append(op);	
					});
					}
				});
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityVehPass_queryHistory.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">位&nbsp;&nbsp;置：</td>
						<td class="pn-fcontent">
							小区：<select name="parkNo" onchange="getGate();">
									<option value="">-请选择-</option>
									<c:forEach items="${parkList}" var="item">
										<option value="${item.parkNo }"<c:if test="${item.parkNo==parkNo }"> selected="selected" </c:if>>${item.parkName }</option>
									</c:forEach>
								</select>&nbsp;
							大门：<select name="gateNo" id="gateNo" onchange="getLane();">
									<option value="">-请选择-</option>
									<c:forEach items="${gateList}" var="item">
										<option value="${item.gateNo }"<c:if test="${item.gateNo==gateNo }"> selected="selected" </c:if>>${item.gateName }</option>
									</c:forEach>
								</select>&nbsp;
							车道：<select name="laneNo" id="laneNo">
									<option value="">-请选择-</option>
									<c:forEach items="${laneList}" var="item">
										<option value="${item.laneNo }"<c:if test="${item.laneNo==laneNo }"> selected="selected" </c:if>>${item.laneNo }</option>
									</c:forEach>
								</select>
						</td>
						<td class="pn-flabel pn-flabel-h">操作员类型：</td>
						<td class="pn-fcontent">
							<select name="operatorType">
								<option value = "" <c:if test="${operatorType==null }"> selected="selected" </c:if>>-请选择-</option>
								<option value = "1" <c:if test="${operatorType==1 }"> selected="selected" </c:if>>人工</option>
								<option value = "2" <c:if test="${operatorType==2 }"> selected="selected" </c:if>>语音</option>
								<option value = "3" <c:if test="${operatorType==3 }"> selected="selected" </c:if>>车道</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">时间段：</td>
						<td class="pn-fcontent">
							<input type="text" name="startTime" id ="startTime" value= "${startTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" size="23" readonly="readonly"/>
						  	-- <input type="text" name="endTime" id ="endTime" value="${endTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" size="23" readonly="readonly"/>
						</td>
						
						<td class="pn-flabel pn-flabel-h">号码&nbsp;&nbsp;类型：</td>
						<td class="pn-fcontent">
							<select name="numberType">
								<option value = "" <c:if test="${numberType==null }"> selected="selected" </c:if>>-请选择-</option>
								<option value = "1" <c:if test="${numberType==1 }"> selected="selected" </c:if>>卡表面号</option>
								<option value = "2" <c:if test="${numberType==2 }"> selected="selected" </c:if>>车牌号</option>
							</select>
						  <input type="text" name="number" value="${number}" />
						</td>
						
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" 查 询 " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" 重 置 " />
						</td>
					</tr>
				</table>
			<!-- 显示list数据-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>号    码</th>
						<th>请求时间</th>
						<th>请求结果</th>
						<th>结果备注</th>
						<th>小 区 名</th>
						<th>大 门 名</th>
						<th>车 道 号</th>
						<th>操作员类型</th>
						<th>操作员号</th>
						<th>操作员名</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0].number }</td>
							<td><fmt:formatDate value="${item[0].opTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item[0].result==1 }">放行</c:if>
								<c:if test="${item[0].result==2 }">不放行</c:if>
							</td>
							<td>
								<c:if test="${item[0].resultRemark==0 }">有解锁</c:if>
								<c:if test="${item[0].resultRemark==1 }">没解锁</c:if>
								<c:if test="${item[0].resultRemark==2 }">数据库异常</c:if>
							</td>
							<td>${item[1].parkName }</td>
							<td>${item[2].gateName }</td>
							<td>${item[0].laneNo }</td>
							<td>
								<c:if test="${item[0].operatorType==1}">人工</c:if>
								<c:if test="${item[0].operatorType==2}">语音</c:if>
								<c:if test="${item[0].operatorType==3}">车道</c:if>
							</td>
							<td>${item[0].operatorNo}</td>
							<td>${item[0].operatorName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>