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
			function del(squadDate,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ���ü�¼��")){
					window.location.href ="unitollInterface_deleteUnitollIntfUpload.do?unitollIntfUpload.squadDate="+squadDate+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
				}else{
					return ;
				}
			}
   			function doExport() {
   				document.getElementById("tableForm").action = "unitollInterface_exportUnitollIntfUpload.do";
   				document.getElementById("tableForm").submit();
   				document.getElementById("tableForm").action = "unitollInterface_listUnitollIntfUpload.do"; 
				} 
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="tableForm" name="tableForm" method="post" action="unitollInterface_listUnitollIntfUpload.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">
							�������ڷ�Χ��
						</td>
						<td class="pn-fcontent">
						  	<input type="text" id="startTime" name="startTime" value="${startTime }" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}'})"> 
						  	- <input type="text" id="endTime" name="endTime" value="${endTime }" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}'})">
						</td>
						<td class="pn-flabel pn-flabel-h">
							�Ƿ��ϴ���
						</td>
						<td class="pn-fcontent">
						<select name="unitollIntfUpload.isUpload" style="width:150px">
								<option value="" <c:if test="${unitollIntfUpload.isUpload==null}">selected</c:if>>��ѡ��</option>
							    <option value="1" <c:if test="${unitollIntfUpload.isUpload==1}">selected</c:if>>��</option>
								<option value="0" <c:if test="${unitollIntfUpload.isUpload==0}">selected</c:if>>�� </option>
						</select>							
						</td>						
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� ѯ " />&nbsp;
							<input type="reset" value=" �� �� "/>&nbsp;
							<input type="button" value=" �� �� "  onclick="doExport();"/>	
						</td>
					</tr>
				</table>
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>��������</th>
						<th>�Ƿ��ϴ�</th>
						<th>��ˮ����</th>
						<th>�ܽ��</th>
						<th>����ʱ��</th>
						<th>����</th>						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${unitollIntfUploadList}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td><fmt:formatDate value="${item.squadDate}" pattern="yyyy-MM-dd" /></td>
							<td><c:if test="${item.isUpload==0}">��</c:if><c:if test="${item.isUpload==1}">��</c:if></td>
							<td>${item.recCount }</td>
							<td>${item.totalMoney }</td>
							<td><fmt:formatDate value="${item.opTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							 <td style="white-space:nowrap;padding-left:5px;padding-right:5px;"><a href="javascript:del('${item.squadDate}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">ɾ��</a></td>  							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>