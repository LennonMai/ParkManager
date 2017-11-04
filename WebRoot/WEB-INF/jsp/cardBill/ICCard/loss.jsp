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
                 <%-- function check(){
                    if(Len((document.getElementsByName("cardOperation.remark")[0].value).trim())>40){
					alert("��ע���Ȳ��ܴ���40����һ��������������");
					document.getElementsByName("cardOperation.remark")[0].focus();
					return false;
				   }
				}--%>
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <form id="dataform" method="post" action="iCCard_lossEdit.do?">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" >			
					<tr>					 
					    <td  class="pn-flabel pn-flabel-h">������ţ�</td>
					    <td class="pn-fcontent"><input type="text" name="cardInfo.cardNo" value="${cardInfo.cardNo}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    <td  class="pn-flabel pn-flabel-h">�����ͣ�</td>
					    <td class="pn-fcontent"><input type="text" name="cardTypeTemp.cardType" value="${cardTypeTemp.typeName}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">��״̬��</td>
					    <c:if test="${cardInfo.status==0}"><td  class="pn-fcontent"><input type="text" value="����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${cardInfo.status==1}"><td  class="pn-fcontent"><input type="text" value="��ʧ" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <td class="pn-flabel pn-flabel-h">״̬����ʱ�䣺</td>
					    <td class="pn-fcontent"><input type="text" name="cardInfo.opTime" value="${cardInfo.opTime}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">��ʧԭ��</td>
					  <td colspan="3" class="pn-fcontent"><textarea rows='2' cols='87' name="cardOperation.remark" class="maxlengthForty">${cardOperation.remark}</textarea></td>					   
					</tr>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" ��ʧ "/> &nbsp;
							<input type="button" value=" �� �� " onclick="history.back();"/>
						    
					</tr>
					
					 </table>
					
			</form>
		</div>
	</body>
</html>
