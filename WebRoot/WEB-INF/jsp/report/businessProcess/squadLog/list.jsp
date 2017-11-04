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
			/*function del(areaNo,parkNo,gateNo,laneNo,squadDate,squadNo){
				if(confirm("ȷ��Ҫɾ����")){
					//alert(areaNo+"-"+parkNo+"-"+gateNo+"-"+laneNo+"-"+squadDate+"-"+squadNo);
					window.location.href = "handInMoney_delete.do?handInMoney.areaNo="+areaNo+"&handInMoney.parkNo="+parkNo+"&handInMoney.gateNo="+gateNo
						+"&handInMoney.laneNo="+laneNo+"&handInMoney.squadDate="+squadDate+"&handInMoney.squadNo="+squadNo;
				}
			}*/
			if("${result}"=="SUCCESS")
			  alert("�޸ĳɹ�");
			function getLane() {
				$.ajax({
					type:"post",
					url:"squadLog_ajaxLane.do?squadLog.gateNo="+document.getElementsByName("squadLog.gateNo")[0].value,
					success:function(res) {
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
			function resetCondition(){
				get("squadLog.gateNo").value="";
				get("squadLog.laneNo").value="";
				get("squadLog.squadDate").value="";
				get("squadLog.squadNo").value=" ";
				get("squadLog.operatorNo").value="";
			}
		/*function check() {
			//var countDay = compTime(get("startTime1").value, get("endTime1").value);
			if(countDay > 10) {
				if(confirm("��ѡ���ڳ���10�죬��ѯ������Ҫ�ϳ�ʱ�䣬�Ƿ�����ѡ���ѯʱ�䣿")) {
				  	return false;
			  	}
		  	} //
		    if(get("startTime1").value == "" && get("endTime1").value == "" ) {
		      	alert("��ѯʱ�䲻��Ϊ��");
		      	return false;
		    }
		    if(get("startTime1").value != "" && get("endTime1").value != "" ) {
		    	if(get("startTime1").value > get("endTime1").value) {
		      		alert("��ʼʱ��������ڻ���ڽ���ʱ��");
		      		return false;
		      	}
		    }
		    else {
		      	return true;
		    }
		}
		//�������ڲ�
		function compTime(beginTime,endTime) {
		  	var s1 = beginTime.replace(/-/g, "/");
			var s2 = endTime.replace(/-/g, "/");
			d1 = new Date(s1);
			d2 = new Date(s2);
			
			var time= d2.getTime() - d1.getTime();
			var days = parseInt(time / (1000 * 60 * 60 * 24));
			
			//alert("�������: " + days);   
			return days;
		}*/
		/*
		function query(){
			var obj = document.all.laneTypeNo;
			if(obj){
             	for(var i=0;i<obj.length;i++){//�ʺ�length>=2ʱ����obj.length==nullʱ������ֱ��ȡobj.valueֵ
               		if(obj[i].checked){
               			window.location="report_queryPassThrough.do?laneTypeNo="+obj[i].value+"&startTime1="+get("startTime1").value+"&endTime1="+get("endTime1").value
               				+"&inlist.cardNo="+get("inlist.cardNo").value+"&inlist.vehPlate="+get("inlist.vehPlate").value+"&inlist.vehClass="+get("inlist.vehClass").value
               				+"&inlist.listNo="+get("inlist.listNo").value;
                 		break;
               		} 
             	} 
           	}   
		}*/
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="squadLog_querySquadLog.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						  <select id="gateNo" name="squadLog.gateNo" onchange="getLane();" style="width: 150px">
						  		<option value="" <c:if test="${squadLog.gateNo==null}">selected</c:if>>��ѡ��</option>
						  	<c:forEach items="${listGate}" var="item">
						  		<option value="${item.gateNo}" <c:if test="${squadLog.gateNo==item.gateNo}">selected</c:if> >${item.gateName}</option>
						  	</c:forEach>
						  </select>
						  <!-- <input type="text" name="squadLog.gateNo" value="${squadLog.gateNo}" /> -->
						</td>
						<td class="pn-flabel pn-flabel-h">�������룺</td>
						<td class="pn-fcontent">
						  <select id="laneNo" name="squadLog.laneNo" style="width: 150px">
						  		<option value="">-��ѡ��-</option>
						  	<c:forEach items="${listLane}" var="item">
						  		<option value="${item.laneNo}" <c:if test="${squadLog.laneNo==item.laneNo}">selected</c:if> >${item.laneNo}</option>
						  	</c:forEach>
						  </select>
						  <!-- <input type="text" name="squadLog.laneNo" value="${squadLog.laneNo}" /> -->
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">�������ڣ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="squadLog.squadDate" value="<fmt:formatDate value="${squadLog.squadDate }" pattern="yyyy-MM-dd"/>" class="Wdate" onClick="WdatePicker()">
						</td>
						
						<td class="pn-flabel pn-flabel-h">����ţ�</td>
						<td class="pn-fcontent">
						  <select name="squadLog.squadNo" style="width: 150px">
						  		<option value="" <c:if test="${squadLog.squadNo==item.squadNo}">selected</c:if> >���й���</option>
						  	<c:forEach items="${listSquad}" var="item">
						  		<option value="${item.squadNo}" <c:if test="${squadLog.squadNo==item.squadNo}">selected</c:if> >${item.squadName}</option>
						  	</c:forEach>
						  </select>
						  <!-- <input type="text" name="squadLog.squadNo" value="${squadLog.squadNo }" /> -->
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">�շ�Ա��</td>
						<td class="pn-fcontent" colspan="3">
						  <select name="squadLog.operatorNo" style="width: 150px">
						  		<option value="" <c:if test="${squadLog.operatorNo==item.operatorNo}">selected</c:if> >�����շ�Ա</option>
						  	<c:forEach items="${listOperator}" var="item">
						  		<option value="${item.operatorNo}" <c:if test="${squadLog.operatorNo==item.operatorNo}">selected</c:if> >${item.operatorName}</option>
						  	</c:forEach>
						  </select>
						  <!-- <input type="text" name="squadLog.operatorNo" value="${squadLog.operatorNo }" /> -->
						</td>
					</tr>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� ѯ " />&nbsp;
						<input type="button" value=" �� �� " onclick="resetCondition()"/>
						</td>
					</tr>
				</table>
			<!-- ${fn:length(list)} ��ʾlist����-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>��&nbsp;&nbsp;��</th>
						<th>��&nbsp;&nbsp;��</th>
						<th>��&nbsp;&nbsp;��</th>
						<th>�շ�Ա</th>
						<th>��������</th>
						<th>��&nbsp;&nbsp;��</th>
						<th>�ϰ�ʱ��</th>
						<th>�°�ʱ��</th>
						<th>��ˮ��</th>
						<th>ͨ�з�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>
								<c:forEach items="${listGate}" var="itemGate">
									<c:if test="${item.gateNo==itemGate.gateNo}">${itemGate.gateName}</c:if>
								</c:forEach>
							</td>
							<td>${item.laneNo }</td>
							<td>${item.operatorNo }</td>
							<td><c:forEach items="${listOperator}" var="itemOPerator"><c:if test="${item.operatorNo==itemOPerator.operatorNo}">${itemOPerator.operatorName}</c:if></c:forEach></td>
							<td><fmt:formatDate value="${item.squadDate}" pattern="yyyy-MM-dd" /></td>
							<td><c:forEach items="${listSquad}" var="squadListItem"><c:if test="${squadListItem.squadNo==item.squadNo}">${squadListItem.squadName}</c:if></c:forEach></td>					
							<td>${item.loginTime }</td>
							<td>${item.logOutTime }</td>
							<td>${item.totalVehCnt }</td>
							<td>${item.totalVehMoney }</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
								<a href="squadLog_edit.do?squadLog.areaNo=${item.areaNo}&squadLog.parkNo=${item.parkNo}
									&squadLog.gateNo=${item.gateNo}&squadLog.laneNo=${item.laneNo}&squadLog.operatorNo=${item.operatorNo}
									&squadLog.squadDate=${item.squadDate}&squadLog.squadNo=${item.squadNo}&squadLog.listName=${item.listName}
									&squadLog.loginTime=${item.loginTime}&pager.pageSize=${pager.pageSize}
									&pager.currentPage=${pager.currentPage }" class="pn-loperator">�޸���ˮͨ�з�</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../../../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>