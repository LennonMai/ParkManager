<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>��λ��Ϣ�б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("��λ��Ϣ��ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
			function del(parkNo,gateNo,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "baseInfo_carSpace_delete.do?carSpaceInformation.parkNo="+parkNo+"&carSpaceInformation.gateNo="+gateNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			
			function add(){
				window.location.href = "baseInfo_carSpace_add.do";
				}

			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(parkNo,gateNo,pageSize,currentPage){
				window.location.href ="baseInfo_carSpace_edit.do?carSpaceInformation.parkNo="+parkNo+"&carSpaceInformation.gateNo="+gateNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
			}
			function setRowBGcolor(){
				var rowIndex="${rowIndex}";
				var pageSize="${pageSize}";
				var currentPage="${currentPage}";
				if(rowIndex!=""&&pageSize!=""&&currentPage!=""){
					var trs=document.getElementById("tb").getElementsByTagName("tr");
					for(var i=0;i<trs.length;i++){
						if(i==rowIndex&&get("pager.pageSize").value==pageSize&&get("pager.currentPage").value==currentPage){
							trs[i].style.backgroundColor="#E6E6E6";
						}
					}
				}
			}		
		</script>
	</head> 
	<body  onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="baseInfo_carSpace_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;��ӳ�λ��Ϣ&nbsp;"  onclick="add();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���λ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��㳵����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��λ�ٽ�ֵ</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ʱ��</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center"  onclick="getRowIndex(this)">
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;"><c:forEach items="${parkList}" var="item1"><c:if test="${item1.parkNo==item.parkNo}">${item1.parkName}</c:if></c:forEach></td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
								<c:choose>
									<c:when test="${item.gateNo=='all'}">
										${item.gateNo}
									</c:when>
									<c:otherwise>
										<c:forEach items="${gatewayList}" var="item2"><c:if test="${item2.parkNo==item.parkNo&&item2.gateNo==item.gateNo}">${item2.gateName}</c:if></c:forEach>
									</c:otherwise>
								</c:choose>					
							</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.maxSpace}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.carCount}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.criticalNum}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.modifyTime}</td>

							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:edit(${item.parkNo},'${item.gateNo}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.parkNo},'${item.gateNo}',${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>