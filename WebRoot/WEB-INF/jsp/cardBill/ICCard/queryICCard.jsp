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
</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0"><%--
				    <tr>
				    <td class="pn-fcontent">�����Ϣ</td>
				    <td class="pn-fcontent">IC����Ϣ</td>
				    </tr>
					--%><tr><%--
					
					  <td class="pn-fcontent" valign="top">
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0" height="100">
				<thead class="pn-lthead">
					<tr>
						<th>λ��</th>
						<th>����</th>						
						<th>����ʱ��</th>					
				
					</tr>
				</thead>
				<tbody class="pn-ltbody">
				    <tr align="center">
				     <td>��������</td>
				     <td>${ICCardStoragePosition.amount}</td>
				     <td><fmt:formatDate value="${ICCardStoragePosition.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>	
				    </tr>
					<c:forEach items="${listTemp}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[1].gateName}</td>
							<td>${item[0].amount}</td>	
							<td><fmt:formatDate value="${item[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>							
						</tr>
					</c:forEach>
				</tbody>
				<tr><td colspan="3" class="pn-fcontent"></td></tr>
				<tr><td colspan="3" class="pn-fcontent"></td></tr>
				<tr>
				   <td colspan="3" class="pn-fcontent">ͨ�п�������<input type="text" name="passCardAmount"  value="${passCardAmount}"/ readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"></td>				   
				</tr>
				<tr><td colspan="3" class="pn-fcontent"></td></tr>
				<tr>
				   <td colspan="3"  class="pn-fcontent">��ͨ��������<input type="text" name="yuetongAmount"  value="${yuetongAmount}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>				   
				</tr>
			</table>
			
			
					  </td>
					    --%><td class="pn-fcontent" valign="top">
					    <form name="tableForm" method="post" action="iCCard_queryICCardToCheck.do">
					    <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">������ţ�</td>
						<td   class="pn-fcontent"> <input type="text" name="cardInfo.cardNo" value="${cardInfo.cardNo}" /></td>	
						<td   class="pn-flabel pn-flabel-h">��&nbsp;״&nbsp;̬��</td>
						<td  class="pn-fcontent">
						<select name="cardInfo.status" style="width:150px">
								<option value="" <c:if test="${cardInfo.status==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${cardInfo.status==0}">selected</c:if>>����</option>
								<option value="1" <c:if test="${cardInfo.status==1}">selected</c:if>>��ʧ </option>
						</select>						
						</td>			
					</tr>					 
					<tr>					
						<td  class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ͣ�</td>
						<td  class="pn-fcontent">
						<select name="cardInfo.cardType" style="width:150px">
								<option value="" <c:if test="${cardInfo.cardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listCardType}" var="item">
								<option value="${item.cardType}" <c:if test="${cardInfo.cardType==item.cardType}">selected</c:if>>${item.typeName}</option>
							 </c:forEach>  
						</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">�û����ͣ�</td>
						<td  class="pn-fcontent">
						<select name="cardInfo.userCardType" style="width:150px">
								<option value="" <c:if test="${cardInfo.userCardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listUserCardType}" var="item">
								<option value="${item.userCardType}" <c:if test="${cardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							 </c:forEach>  
						</select>
						</td>		
				     </tr>																
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="reset" value=" �� �� "/>						
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0" >
				<thead class="pn-lthead">
					<tr>
						<th>�������</th>
						<th>��&nbsp;��&nbsp;��</th>						
						<th>��&nbsp;״&nbsp;̬</th>
						<th>�û�����</th>
						<th>����ʱ��</th>					
				
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0].cardNo}</td>
							<td>${item[1].typeName}</td>																				
							<td><c:if test="${item[0].status==0}">����</c:if><c:if test="${item[0].status==1}">��ʧ</c:if></td>
							<td>
							 <c:forEach items="${listUserCardType}" var="itemlistUserCardType"><c:if test="${item[0].userCardType==itemlistUserCardType.userCardType}">${itemlistUserCardType.typeName}</c:if></c:forEach>
                            </td>
							<td><fmt:formatDate value="${item[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>	
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
					  </td>
		 </tr>
					  
					  
				
			</table>
			
		</div>
	</body>
</html>