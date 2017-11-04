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
					alert("备注长度不能大于40个（一个汉字算两个）");
					document.getElementsByName("cardOperation.remark")[0].focus();
					return false;
				   }
				}--%>
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <form id="dataform" method="post" action="iCCard_lossEdit.do?">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" >			
					<tr>					 
					    <td  class="pn-flabel pn-flabel-h">卡表面号：</td>
					    <td class="pn-fcontent"><input type="text" name="cardInfo.cardNo" value="${cardInfo.cardNo}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    <td  class="pn-flabel pn-flabel-h">卡类型：</td>
					    <td class="pn-fcontent"><input type="text" name="cardTypeTemp.cardType" value="${cardTypeTemp.typeName}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">卡状态：</td>
					    <c:if test="${cardInfo.status==0}"><td  class="pn-fcontent"><input type="text" value="正常" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${cardInfo.status==1}"><td  class="pn-fcontent"><input type="text" value="挂失" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <td class="pn-flabel pn-flabel-h">状态更改时间：</td>
					    <td class="pn-fcontent"><input type="text" name="cardInfo.opTime" value="${cardInfo.opTime}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">挂失原因：</td>
					  <td colspan="3" class="pn-fcontent"><textarea rows='2' cols='87' name="cardOperation.remark" class="maxlengthForty">${cardOperation.remark}</textarea></td>					   
					</tr>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 挂失 "/> &nbsp;
							<input type="button" value=" 返 回 " onclick="history.back();"/>
						    
					</tr>
					
					 </table>
					
			</form>
		</div>
	</body>
</html>
