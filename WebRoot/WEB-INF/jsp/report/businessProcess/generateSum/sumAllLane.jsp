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
				if(confirm("确认要删除吗？")){
					//alert(areaNo+"-"+parkNo+"-"+gateNo+"-"+laneNo+"-"+squadDate+"-"+squadNo);
					window.location.href = "handInMoney_delete.do?handInMoney.areaNo="+areaNo+"&handInMoney.parkNo="+parkNo+"&handInMoney.gateNo="+gateNo
						+"&handInMoney.laneNo="+laneNo+"&handInMoney.squadDate="+squadDate+"&handInMoney.squadNo="+squadNo;
				}
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
		window.onload = function() {
			if("${buttonStatus}" == "1") {
				get("button").disabled = true;
			}
		}
		function generateLaneSum() {
			window.location.href = "generateSum_generateLaneSum.do?";
		}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="generateSum_generateLaneSum.do" >
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input id="button" type="submit" value=" 确 定 "  />&nbsp;
						<input type="button" value=" 取 消 " onclick="history.back();" />	
						</td>
						<input type="hidden" name="listSumAllLane" value="${list }"/>
						<input type="hidden" name="parkNo" value="${parkNo }"/>
						<input type="hidden" name="areaNo" value="${areaNo }"/>
						<input type="hidden" name="gateNo" value="${gateNo }"/>
						<input type="hidden" name="squadDatejs" value="${squadDatejs }"/>
						<input type="hidden" name="gateNoTemp" value="${gateNoTemp }"/>
						<input type="hidden" name="squadDateTemp" value="${squadDateTemp }"/>
						<input type="hidden" name="stationYNSumTemp" value="${stationYNSumTemp }"/>
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
							<td>${item[0] }</td>
							<td>${item[1] }</td>
							<td>${item[2]}</td>
							<td>${item[3]}</td>
							<td>${item[4]}</td>
							<td>${item[5] }</td>
							<td>${item[6] }</td>
							<td>${item[7]}</td>
							<td>${item[8]+item[9] }</td>
							<td>${item[8]}</td>
							<td>${item[9] }</td>
							
							<c:if test="${item[10]==0}">
								<td>数据一致</td>
							</c:if>
							<c:if test="${item[10]==1}">
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