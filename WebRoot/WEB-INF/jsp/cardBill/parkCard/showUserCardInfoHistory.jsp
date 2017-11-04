<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title></title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
        <script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>		
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>					
		<script type="text/javascript">		
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  method="post" action="">  				   
				<table width="871" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" height="345">					 					
					<c:forEach items="${listUserCardInfoHistory}" var="itemUserCardInfoHistory">
					<tr>
					  <td class="pn-flabel pn-flabel-h">用户编号：</td>
					  <td class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[0]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>	
					    <td class="pn-flabel pn-flabel-h">修改时间：</td>
					  <td class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[11]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>					   				 				   				 
					  
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">车主姓名：</td>
					  <td   class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[1]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    <td class="pn-flabel pn-flabel-h">身份证号：</td>
					     <td   class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[2]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr> 
						<td class="pn-flabel pn-flabel-h">车主身份：</td>
						<td class="pn-fcontent">
							<c:forEach items="${listIdentity}" var="identity">
								<c:if test="${itemUserCardInfoHistory[22]==identity.identityType}">
									<input type="text" value="${identity.identityName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
								</c:if>
							</c:forEach>
						</td>
						<td class="pn-flabel pn-flabel-h">用户房号：</td>
					   <td class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[13]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">固定号码：</td>
					   <td class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[14]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">移动电话：</td>
					   <td class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[16]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">车辆类型：</td>
					   <td class="pn-fcontent">
                           	<c:forEach items="${listCarType}" var="itemlistCarType">
								<c:if test="${itemlistCarType.carType==itemUserCardInfoHistory[23]}">
									<input type="text" value="${itemlistCarType.carTypeName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
								</c:if>
							</c:forEach>
                       </td> 
					   <td class="pn-flabel pn-flabel-h">停&nbsp;车&nbsp;位：</td>
					   <td class="pn-fcontent">
					   		<c:forEach items="${listCarSmallType}" var="CarSmallType">
								<c:if test="${itemUserCardInfoHistory[23]==CarSmallType.carType && itemUserCardInfoHistory[4]==CarSmallType.carSmallType}">
									<input type="text"  value="${CarSmallType.carSmallName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
								</c:if>
							</c:forEach>
					   </td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">联&nbsp;系&nbsp;人：</td>
					    <td  class="pn-fcontent"><input type="text"   value="${itemUserCardInfoHistory[20]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    <td class="pn-flabel pn-flabel-h">押&nbsp;&nbsp;&nbsp;&nbsp;金：</td>
					    <td  class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[8]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td> 
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">联系地址：</td>
					     <td colspan="3" class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[17]}" size="71" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					
					<tr>
					 <td class="pn-flabel pn-flabel-h">卡表面号：</td>
					    <td class="pn-fcontent">					    
					    <input type="text"  value="${itemUserCardInfoHistory[9]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>				    
					    </td>
					    <td class="pn-flabel pn-flabel-h">OBU&nbsp;&nbsp;&nbsp;号：</td>
					    <td class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[5]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>					  
					</tr>
			
					<tr>
					  <td class="pn-flabel pn-flabel-h">车&nbsp;牌&nbsp;号：</td>
					  <td class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[3]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">车辆品牌：</td>
					  <td class="pn-fcontent"><input type="text"  value="${itemUserCardInfoHistory[19]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>					  
					</tr>
					 
				       <tr>	
				        <td class="pn-flabel pn-flabel-h">注册时间：</td>
					    <td  class="pn-fcontent"><input type="text"    value="${itemUserCardInfoHistory[6]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>			 
					    <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
					    <td  class="pn-fcontent"><input type="text"    value="${itemUserCardInfoHistory[21]}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
				      </tr>
				   
					<tr>
				      <c:if test="${param_whtherPayType.pvalue!=1}">
				        <td class="pn-flabel pn-flabel-h">用户类型：</td>
					    <td   class="pn-fcontent">
					      <c:forEach items="${listUserCardType}" var="item">
					      <c:if test="${itemUserCardInfoHistory[10]==item.userCardType}">
					            <input type="text" value="${item.typeName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
					      </c:if>
					      </c:forEach>
						</td>
						
					 <td class="pn-flabel pn-flabel-h">收费类型：</td>					  
					   <td  class="pn-fcontent">				    
						<c:forEach items="${listFeeRuleTypeDef}" var="item">
						    <c:if test="${itemUserCardInfoHistory[12]==item.feeRuleType}">					      
					             <input type="text" value="${item.name}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
					       </c:if>
					   </c:forEach>  						
						</td>
					</c:if>
					<c:if test="${param_whtherPayType.pvalue==1}">
					<td class="pn-flabel pn-flabel-h">用户类型：</td>
					  <td  colspan="3" class="pn-fcontent">
					      <c:forEach items="${listUserCardType}" var="item">
					      <c:if test="${itemUserCardInfoHistory[10]==item.userCardType}">					      
					        <input type="text" value="${item.typeName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
					      </c:if>
					      </c:forEach>
						</td>
					  </c:if>				  
				  </tr>
				   		 									
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="button" value=" 返 回 " onclick="history.back();"/>
						</td>						
					</tr>	
					</c:forEach>				
					</table>					
			</form>
		</div>
	</body>
</html>
