<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>������Ϣ�б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("������Ϣ��ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
			function del(areaNo,parkNo,gateNo,laneNo,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "baseInfo_lane_delete.do?laneInformation.areaNo="+areaNo+"&laneInformation.parkNo="+parkNo+"&laneInformation.gateNo="+gateNo+"&laneInformation.laneNo="+laneNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			
			function add(){
				window.location.href = "baseInfo_lane_add.do";
				}

			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(areaNo,parkNo,gateNo,laneNo,pageSize,currentPage){
				window.location.href ="baseInfo_lane_edit.do?laneInformation.areaNo="+areaNo+"&laneInformation.parkNo="+parkNo+"&laneInformation.gateNo="+gateNo+"&laneInformation.laneNo="+laneNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
			}
			function isUse(areaNo,parkNo,gateNo,laneNo,isUse,pageSize,currentPage){
				if(isUse == 1) {
					var tips = "ȷ��Ҫ��������";
				} else {
					var tips = "ȷ��Ҫ������";
				}
				if(confirm(tips)) {
					window.location.href ="baseInfo_lane_isUse.do?laneInformation.areaNo="+areaNo+"&laneInformation.parkNo="+parkNo+"&laneInformation.gateNo="+gateNo+"&laneInformation.laneNo="+laneNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
				}
			}
			function allUse(){
				if(confirm("ȷ������Ϊȫ������")){
				    window.location.href ="baseInfo_lane_allUse.do";
				}
			}
			function allNotUse(){
				if(confirm("ȷ������Ϊȫ��������")){
				    window.location.href ="baseInfo_lane_allNotUse.do";
				}
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
	<body onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="baseInfo_lane_list.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button" value="&nbsp;��ӳ�����Ϣ&nbsp;" onclick="add();"/>&nbsp;
						<input style="height: 22px;" type="button" value="&nbsp;����Ϊȫ����&nbsp;" onclick="allUse();"/>&nbsp;
						<input style="height: 22px;" type="button" value="&nbsp;����Ϊ������&nbsp;" onclick="allNotUse();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ű���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�����IP��ַ</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���úϼ�</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.parkNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.gateNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:forEach items="${gateList}" var="gate">
             		 		<c:if test="${item.gateNo==gate.gateNo}">${gate.gateName}</c:if> 
             				</c:forEach>
							</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.laneTypeNo==1}">���</c:if>
							<c:if test="${item.laneTypeNo==2}">����</c:if></td>							
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneComputerName}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneComputerIp}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
								<c:if test="${item.isUse == 1}">��</c:if>
								<c:if test="${item.isUse == 0}">��</c:if>
							</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
								<a href="javascript:isUse(${item.areaNo},${item.parkNo},${item.gateNo},${item.laneNo},${item.isUse},${pager.pageSize},${pager.currentPage})" class="pn-loperator">
									<c:if test="${item.isUse == 1}">
										������
									</c:if>
									<c:if test="${item.isUse == 0}">
										����
									</c:if>
								</a>
							�� <a href="javascript:edit(${item.areaNo},${item.parkNo},${item.gateNo},${item.laneNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.areaNo},${item.parkNo},${item.gateNo},${item.laneNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>