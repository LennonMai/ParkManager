<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
	<head>
		<title>设备监控</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script language="javascript">
			//获取车道
			function getLane(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"specialVeh_ajaxLane.do?gateNo="+$(document.tableForm.station).val(),
					success:function(res){
						$("#road").empty();
						var op = $("<option value=''> 请选择 </option>");		
						$("#road").append(op);
						$(res).find("lanes > lane").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#road").append(op);	
					});
					}
				});
			   });
			  })(jQuery);
			}
		</script>
	</head> 
	<body>
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="specialVeh_queryMonitoring.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td class="pn-flabel pn-flabel-h">位&nbsp;&nbsp;置：</td>
						<td class="pn-fcontent">大门:
							<select name="station" id="station" style="width: 100px;" onchange="getLane();">
								<option value=""> 请选择 </option>
								<c:forEach items="${stationList}" var="item">
									<option value="${item.gateNo}" <c:if test="${item.gateNo==station}">selected="selected"</c:if>>${item.gateName}</option>
								</c:forEach> 
							</select>&nbsp;&nbsp;&nbsp;&nbsp;车道:
							<select name="road" id="road" style="width: 70px;">
								<option value=""> 请选择 </option>
								<c:forEach items="${roadList}" var="item">
									<option value="${item.laneNo}" <c:if test="${item.laneNo==road}">selected="selected"</c:if>>${item.laneNo}</option>
								</c:forEach> 
							</select>
						</td>
					    <td class="pn-flabel pn-flabel-h">系统类型：</td>
						<td  class="pn-fcontent">
							<select name="systemType" style="width: 150px;">
								<option value=""> 请选择 </option>
								<option value="0" <c:if test="${systemType==0}">selected="selected"</c:if>> 硬件 </option>
								<option value="1" <c:if test="${systemType==1}">selected="selected"</c:if>> 软件 </option>
							</select>
						</td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">状&nbsp;&nbsp;态：</td>
						<td class="pn-fcontent">
							<select name="status" style="width: 150px;">
							   <option value=""> 请选择 </option>
							   <option value="0" <c:if test="${status==0}">selected="selected"</c:if>> 正常 </option>
							   <c:forEach items="${deviceErrorList}" var="item">
									<option value="${item['deviceErrorNo']}" <c:if test="${item['deviceErrorNo']==status}">selected="selected"</c:if>>${item['deviceErrorName']}</option>
								</c:forEach>
							</select>
						</td>
						<td class="pn-flabel pn-flabel-h">设&nbsp;&nbsp;&nbsp;&nbsp;备：</td>
						<td class="pn-fcontent">
							<select name="device" style="width: 150px;">
							   <option value=""> 请选择 </option>
							   <c:forEach items="${deviceList}" var="item">
									<option value="${item['deviceNo']}" <c:if test="${item['deviceNo']==device}">selected="selected"</c:if>>${item['deviceName']}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" 查 询 " />&nbsp;
							<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 " />	
						</td>
					</tr>
			</table>			
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">大&nbsp;&nbsp;门</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车&nbsp;&nbsp;道</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">设&nbsp;&nbsp;备</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">系统类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">状&nbsp;&nbsp;态</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">更新时间</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">信&nbsp;&nbsp;息</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item[0]}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item[1]}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item[2]}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
								<c:if test="${item[3]==0}">硬件</c:if>
								<c:if test="${item[3]==1}">软件</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item[4] }</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
								<c:choose>
							    	<c:when test="${fn:length(item[5])>19}">
							        	<c:out value="${fn:substring(item[5], 0, 19)}" />
							        </c:when>
							        <c:otherwise>
							        	<c:out value="${item[5]}" />
							    	</c:otherwise>
							    </c:choose>
							</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">${item[6]}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>

		</div>
	</body>
</html>