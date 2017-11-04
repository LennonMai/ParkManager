<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>����û�������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasUserCardRate"){
			alert("�Ѵ��ڸ��û������ʣ�");
		    }
		function back(){
			window.location.href = "userCardRate_list.do";
			}

</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="userCardRate_saveUserCardRate.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;��&nbsp;&nbsp;�ţ�</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_smallint" name="userCardRate.version" value="${userCardRate.version}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">�����</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" name="userCardRate.money" value="${userCardRate.money}" size="28"/><span style="color: red">&nbsp;*</span></td>
					</tr>
	     			<tr>
					    <td class="pn-flabel pn-flabel-h">�û������ͣ�</td>
						<td colspan="4" class="pn-fcontent"><select style="width: 206px;height: 22px;"  class="required " name="userCardRate.userCardType">					
								<option value="" <c:if test="${userCardRate.userCardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${uctList}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardRate.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>												
						<span style="color: red">&nbsp;*</span></td></tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� "/>&nbsp;
						    <input type="reset" value=" �� �� "/>&nbsp;
						    <input type="button" value=" �� �� " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>