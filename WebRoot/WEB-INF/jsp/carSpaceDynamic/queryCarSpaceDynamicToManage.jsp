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
			alert("�޸ĳɹ�"); 
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryParkCard.do"><%--
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px" type="button"  value="��ӳ�λ��̬��Ϣ"  onclick="add();"/>
						</td>
					</tr>
			</table>
			 --%><table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���</th>
						<%--<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ܳ�λ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�±���λ��</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ٱ���λ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ǰ�ճ�λ��</th>
						--%><th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����������</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����������</th>					
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">У�ڳ���������</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">У�ڳ���������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ʱ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
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
							<td style="white-space:nowrap;padding-left:5px;padding-right:5px;"><a href="javascript:carSpaceDynamicToUpdate(${item.recNo})" class="pn-loperator">�޸�</a></td>                               
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>