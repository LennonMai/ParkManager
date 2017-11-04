 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript">  
		if("${result}"=="SUCCESS")
			alert("修改成功"); 
		function carSpaceDynamicToUpdate(recNo){
			window.location.href ="carSpaceDynamic_carSpaceDynamicToUpdate.do?carSpaceDynamic.recNo="+recNo;
		}	
		function add(){
			window.location.href = "carSpaceDynamic_add.do";
		}					
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryParkCard.do"><%--
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px" type="button"  value="添加车位动态信息"  onclick="add();"/>
						</td>
					</tr>
			</table>
			 --%><table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">序号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">编号</th>
						<%--<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">总车位数</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">月保车位数</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">临保车位数</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">当前空车位数</th>
						--%><th style="white-space:nowrap;padding-left:5px;padding-right:5px;">出场总数量</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">进场总数量</th>					
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">校内车进场数量</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">校内车出场数量</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">外来车进场数量</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">外来车出场数量</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">更新时间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center"> 
							<td>${item.recNo}</td>
							<td>${item.parkNo}</td>	
							<%--<td>${item.totalSpace}</td>							
							<td>${item.monthlyRentSpace}</td>
							<td>${item.temporarySpace}</td>	
							<td>${item.currentEmptySpace}</td>
							--%><td>${item.outParkTotal}</td>	
							<td>${item.inParkTotal}</td>
							<td>${item.monthlyRentInPark}</td>	
							<td>${item.monthlyRentOutPark}</td>
							<td>${item.temporaryInPark}</td>		
							<td>${item.temporaryOutPark}</td>	
							<td>${item.modifyTime}</td>						
							<td style="white-space:nowrap;padding-left:5px;padding-right:5px;"><a href="javascript:carSpaceDynamicToUpdate(${item.recNo})" class="pn-loperator">修改</a></td>                               
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>