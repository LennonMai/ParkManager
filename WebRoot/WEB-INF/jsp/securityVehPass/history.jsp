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
						var op = $("<option value=''>-��ѡ��-</option>");		
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
						var op = $("<option value=''>-��ѡ��-</option>");		
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityVehPass_queryHistory.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">λ&nbsp;&nbsp;�ã�</td>
						<td class="pn-fcontent">
							С����<select name="parkNo" onchange="getGate();">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${parkList}" var="item">
										<option value="${item.parkNo }"<c:if test="${item.parkNo==parkNo }"> selected="selected" </c:if>>${item.parkName }</option>
									</c:forEach>
								</select>&nbsp;
							���ţ�<select name="gateNo" id="gateNo" onchange="getLane();">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${gateList}" var="item">
										<option value="${item.gateNo }"<c:if test="${item.gateNo==gateNo }"> selected="selected" </c:if>>${item.gateName }</option>
									</c:forEach>
								</select>&nbsp;
							������<select name="laneNo" id="laneNo">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${laneList}" var="item">
										<option value="${item.laneNo }"<c:if test="${item.laneNo==laneNo }"> selected="selected" </c:if>>${item.laneNo }</option>
									</c:forEach>
								</select>
						</td>
						<td class="pn-flabel pn-flabel-h">����Ա���ͣ�</td>
						<td class="pn-fcontent">
							<select name="operatorType">
								<option value = "" <c:if test="${operatorType==null }"> selected="selected" </c:if>>-��ѡ��-</option>
								<option value = "1" <c:if test="${operatorType==1 }"> selected="selected" </c:if>>�˹�</option>
								<option value = "2" <c:if test="${operatorType==2 }"> selected="selected" </c:if>>����</option>
								<option value = "3" <c:if test="${operatorType==3 }"> selected="selected" </c:if>>����</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">ʱ��Σ�</td>
						<td class="pn-fcontent">
							<input type="text" name="startTime" id ="startTime" value= "${startTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" size="23" readonly="readonly"/>
						  	-- <input type="text" name="endTime" id ="endTime" value="${endTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" size="23" readonly="readonly"/>
						</td>
						
						<td class="pn-flabel pn-flabel-h">����&nbsp;&nbsp;���ͣ�</td>
						<td class="pn-fcontent">
							<select name="numberType">
								<option value = "" <c:if test="${numberType==null }"> selected="selected" </c:if>>-��ѡ��-</option>
								<option value = "1" <c:if test="${numberType==1 }"> selected="selected" </c:if>>�������</option>
								<option value = "2" <c:if test="${numberType==2 }"> selected="selected" </c:if>>���ƺ�</option>
							</select>
						  <input type="text" name="number" value="${number}" />
						</td>
						
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� ѯ " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" �� �� " />
						</td>
					</tr>
				</table>
			<!-- ��ʾlist����-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>��    ��</th>
						<th>����ʱ��</th>
						<th>������</th>
						<th>�����ע</th>
						<th>С �� ��</th>
						<th>�� �� ��</th>
						<th>�� �� ��</th>
						<th>����Ա����</th>
						<th>����Ա��</th>
						<th>����Ա��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0].number }</td>
							<td><fmt:formatDate value="${item[0].opTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item[0].result==1 }">����</c:if>
								<c:if test="${item[0].result==2 }">������</c:if>
							</td>
							<td>
								<c:if test="${item[0].resultRemark==0 }">�н���</c:if>
								<c:if test="${item[0].resultRemark==1 }">û����</c:if>
								<c:if test="${item[0].resultRemark==2 }">���ݿ��쳣</c:if>
							</td>
							<td>${item[1].parkName }</td>
							<td>${item[2].gateName }</td>
							<td>${item[0].laneNo }</td>
							<td>
								<c:if test="${item[0].operatorType==1}">�˹�</c:if>
								<c:if test="${item[0].operatorType==2}">����</c:if>
								<c:if test="${item[0].operatorType==3}">����</c:if>
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