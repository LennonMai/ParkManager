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
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityCommandBackup_query.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�û�����</td>
						<td class="pn-fcontent">
						  <input type="text" name="owner" value="${owner}" />
						</td>
						<td class="pn-flabel pn-flabel-h">ָ�����ͣ�</td>
						<td class="pn-fcontent">
						  	<select name="type">
						  		<option value="" <c:if test="${type==null}">selected</c:if>>-��ѡ��-</option>
						  		<option value="1" <c:if test="${type==1}">selected</c:if>>����</option>
						  		<option value="2" <c:if test="${type==2}">selected</c:if>>����</option>
						  	</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;�ţ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNo" value="${cardNo}" />
						</td>
						<td class="pn-flabel pn-flabel-h">��Ч���ͣ�</td>
						<td class="pn-fcontent">
							<select name="validType">
								<option value="" <c:if test="${validType==null}">selected</c:if>>-��ѡ��-</option>
						  		<option value="1" <c:if test="${validType==1}">selected</c:if>>ÿ����Ч</option>
						  		<option value="2" <c:if test="${validType==2}">selected</c:if>>������Ч</option>
								<option value="3" <c:if test="${validType==3}">selected</c:if>>������Ч</option>
								<option value="4" <c:if test="${validType==4}">selected</c:if>>����ʱ</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ƺţ�</td>
						<td class="pn-fcontent" colspan="3">
						  <input type="text" name="vehPlate" value="${vehPlate}" />
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
						<th>�û�����</th>
						<th>�������</th>
						<th>�� �� ��</th>
						<th>ָ������</th>
						<th>��Ч����</th>
						<th>��ӷ�ʽ</th>					
						<th>״    ̬</th>
						<th>���ʱ��</th>
						<th>��Чʱ��</th>
						<th>ʧЧʱ��</th>
						<th>�޸�ʱ��</th>
						<th>����Ա����</th>
						<th>�� �� Ա</th>
						<th>������ʷ</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[1].owner }</td>
							<td>${item[0].cardNo }</td>
							<td>${item[1].vehPlate }</td>
							<td>
								<c:if test="${item[0].type==1}">����</c:if>
								<c:if test="${item[0].type==2}">����</c:if>
							</td>
							<td>
								<c:if test="${item[0].validType==1}">ÿ����Ч</c:if>
								<c:if test="${item[0].validType==2}">������Ч</c:if>
								<c:if test="${item[0].validType==3}">������Ч</c:if>
								<c:if test="${item[0].validType==4}">����ʱ</c:if>
							</td>
							<td>
								<c:if test="${item[0].useType==1}">����</c:if>
								<c:if test="${item[0].useType==2}">����</c:if>
								<c:if test="${item[0].useType==3}">�˹�</c:if>
							</td>
							<td>
								<c:if test="${item[0].attribute==0}">����</c:if>
								<c:if test="${item[0].attribute==1}">��ɾ��</c:if>
								<c:if test="${item[0].attribute==2}">�Ѵ���</c:if>
								<c:if test="${item[0].attribute==3}">��ʱδ����</c:if>
							</td>
							<td><fmt:formatDate value="${item[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item[0].startTime}</td>
							<td>${item[0].endTime}</td>
							<td><fmt:formatDate value="${item[0].addTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item[0].operatorType==1}">�˹�</c:if>
								<c:if test="${item[0].operatorType==2}">����</c:if>
								<c:if test="${item[0].operatorType==3}">����</c:if>
								<c:if test="${item[0].operatorType==4}">���ݿ���ҵ</c:if>
							</td>
							<td>${item[0].operatorNo }</td>		
							<td>
								<a href="securityCommandBackup_show.do?commandId=${item[0].commandId }&modId=${item[0].modId }" class="pn-loperator">�� ��</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>