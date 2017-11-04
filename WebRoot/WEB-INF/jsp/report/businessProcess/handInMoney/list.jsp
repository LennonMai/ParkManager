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
			function del(areaNo,parkNo,gateNo,laneNo,squadDate,squadNo) {
				if(confirm("确认要删除吗？")){
					//alert(areaNo+"-"+parkNo+"-"+gateNo+"-"+laneNo+"-"+squadDate+"-"+squadNo);
					window.location.href = "handInMoney_delete.do?handInMoney.areaNo="+areaNo+"&handInMoney.parkNo="+parkNo+"&handInMoney.gateNo="+gateNo
						+"&handInMoney.laneNo="+laneNo+"&handInMoney.squadDate="+squadDate+"&handInMoney.squadNo="+squadNo;
				}
			}
			function getLane() {
				$.ajax({
					type:"post",
					url:"handInMoney_ajaxLane.do?handInMoney.gateNo="+document.getElementsByName("handInMoney.gateNo")[0].value,
					success:function(res) {
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
		/*function check() {
			//var countDay = compTime(get("startTime1").value, get("endTime1").value);
			if(countDay > 10) {
				if(confirm("所选日期超过10天，查询可能需要较长时间，是否重新选择查询时间？")) {
				  	return false;
			  	}
		  	} //
		    if(get("startTime1").value == "" && get("endTime1").value == "" ) {
		      	alert("查询时间不能为空");
		      	return false;
		    }
		    if(get("startTime1").value != "" && get("endTime1").value != "" ) {
		    	if(get("startTime1").value > get("endTime1").value) {
		      		alert("开始时间必须早于或等于结束时间");
		      		return false;
		      	}
		    }
		    else {
		      	return true;
		    }
		}
		//计算日期差
		function compTime(beginTime,endTime) {
		  	var s1 = beginTime.replace(/-/g, "/");
			var s2 = endTime.replace(/-/g, "/");
			d1 = new Date(s1);
			d2 = new Date(s2);
			
			var time= d2.getTime() - d1.getTime();
			var days = parseInt(time / (1000 * 60 * 60 * 24));
			
			//alert("相差天数: " + days);   
			return days;
		}*/
		/*
		function query(){
			var obj = document.all.laneTypeNo;
			if(obj){
             	for(var i=0;i<obj.length;i++){//适合length>=2时，当obj.length==null时，可以直接取obj.value值
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="handInMoney_queryHandInMoney.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">大门名称：</td>
						<td class="pn-fcontent">
						  <select id="gateNo" name="handInMoney.gateNo" onchange="getLane();" style="width: 150px">
						  		<option value="" <c:if test="${handInMoney.gateNo==null}">selected</c:if>>请选择</option>
						  	<c:forEach items="${listGate}" var="item">
						  		<option value="${item.gateNo}" <c:if test="${handInMoney.gateNo==item.gateNo}">selected</c:if> >${item.gateName}</option>
						  	</c:forEach>
						  </select>
						  <!-- <input type="text" name="handInMoney.gateNo" value="${handInMoney.gateNo}" /> -->
						</td>
						<td class="pn-flabel pn-flabel-h">车道编码：</td>
						<td class="pn-fcontent">
						  <select id="laneNo" name="handInMoney.laneNo" style="width: 150px">
						  		<option value="">-请选择-</option>
						  	<c:forEach items="${listLane}" var="item">
						  		<option value="${item.laneNo}" <c:if test="${handInMoney.laneNo==item.laneNo}">selected</c:if> >${item.laneNo}</option>
						  	</c:forEach>
						  </select>
						  <!-- <input type="text" name="handInMoney.laneNo" value="${handInMoney.laneNo}" /> -->
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">工班日期：</td>
						<td class="pn-fcontent">
						  <input type="text" name="handInMoney.squadDate" value="<fmt:formatDate value="${handInMoney.squadDate }" pattern="yyyy-MM-dd"/>" class="Wdate" onClick="WdatePicker()">
						</td>
						<td class="pn-flabel pn-flabel-h">工班号：</td>
						<td class="pn-fcontent">
						  <select name="handInMoney.squadNo" style="width: 150px">
						  		<option value="" <c:if test="${handInMoney.squadNo==item.squadNo}">selected</c:if> >所有工班</option>
						  	<c:forEach items="${listSquad}" var="item">
						  		<option value="${item.squadNo}" <c:if test="${handInMoney.squadNo==item.squadNo}">selected</c:if> >${item.squadName}</option>
						  	</c:forEach>
						  </select>
						  <!-- <input type="text" name="handInMoney.squadNo" value="${handInMoney.squadNo }" /> -->
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" 查 询 " />&nbsp;
						<input type="reset" value=" 重 置 "/>	
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
						<th>车道号</th>
						<th>工班日期</th>
						<th>工班号</th>
						<th>应交金额</th>
						<th>实交金额</th>
						<th>币&nbsp;&nbsp;种</th>
						<th>收费员编号</th>
						<th>收费员名称</th>
						<th>操作员编码</th>
						<th>操作员名称</th>
						<th>操作时间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>
								<c:forEach items="${listArea}" var="itemArea">
									<c:if test="${item.areaNo==itemArea.areaNo}">${itemArea.areaName}</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${listPark}" var="itemPark">
									<c:if test="${item.parkNo==itemPark.parkNo}">${itemPark.parkName}</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${listGate}" var="itemGate">
									<c:if test="${item.gateNo==itemGate.gateNo}">${itemGate.gateName}</c:if>
								</c:forEach>
							</td>
							<td>${item.laneNo }</td>
							<td><fmt:formatDate value="${item.squadDate}" pattern="yyyy-MM-dd" /></td>
							<td>${item.squadNo }</td>
							<td>${item.money }</td>
							<td>${item.handInMoney }</td>
							<td>${item.moneyTypeString }</td>
							<td>${item.laneOperatorNo }</td>
							<td>${item.laneOperatorName }</td>
							<td>${item.operatorNo }</td>
							<td>${item.operatorName }</td>
							<td><fmt:formatDate value="${item.opTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
								<a href="handInMoney_edit.do?handInMoney.areaNo=${item.areaNo}&handInMoney.parkNo=${item.parkNo}
									&handInMoney.gateNo=${item.gateNo}&handInMoney.laneNo=${item.laneNo}
									&handInMoney.squadDate=${item.squadDate}&handInMoney.squadNo=${item.squadNo}
									&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage }" class="pn-loperator">修改</a>
								┆ <a href="javascript:del(${item.areaNo},${item.parkNo},${item.gateNo},
									${item.laneNo},'${item.squadDate}', ${item.squadNo});" class="pn-loperator">删除</a>
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