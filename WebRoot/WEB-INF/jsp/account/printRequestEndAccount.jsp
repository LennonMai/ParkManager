<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script language=javascript> 
		if("${result}"=="SUCCESS")
				alert("��ӡ�ɹ�");
		 function doPrint() { 
             window.open("account_printRequestEnd.do?account.sys_id=${account.sys_id}")
            }
        </script> 
		
		
		
	</head>
	<body>
	
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <form method="post" action="" >  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				   <!--startprint-->
				 <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0"  style="background-color: #FFFFFF;">
					<tr>
					<td colspan="4" class="pn-fbutton">
							<input type="text" value=" ����������Ϣ��ִ " style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/> &nbsp;
					</td>
					</tr>
					</table>                                    
				
					<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" >
					
					
					<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					  <td class="pn-fcontent"><input type="text" name="account.sys_id" value="${account.sys_id}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">��������ʱ��</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.updateTime" value="<fmt:formatDate value="${updateAccountLog.updateTime}" pattern="yyyy-MM-dd HH:mm:ss" />"
						 readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					
					
					<tr>
					   
					   <td class="pn-flabel pn-flabel-h">�û�����</td>
					   <td class="pn-fcontent"><input type="text" name="user.userName" value="${user.userName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;��</td>
					   <td class="pn-fcontent"><input type="text" name="car.vehPlate" value="${car.vehPlate}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					 </tr>
					 <tr>
					    <td class="pn-flabel pn-flabel-h">֤������</td>
					    <c:if test="${user.credentialsType==0}"><td class="pn-fcontent"><input   type="text" value="���֤"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${user.credentialsType==1}"><td class="pn-fcontent"><input type="text" value="��&nbsp;&nbsp;��" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <td class="pn-flabel pn-flabel-h">֤������</td>
					    <td class="pn-fcontent"><input type="text" name="user.credentialsNo" value="${user.credentialsNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					  <tr>
					   <td class="pn-flabel pn-flabel-h">��ϵ�绰</td>
					   <td class="pn-fcontent"><input type="text" name="user.phone" value="${user.phone}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">�ֻ�����</td>
					   <td class="pn-fcontent"><input type="text" name="user.mobileNumber" value="${user.mobileNumber}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>					
					 <tr>
					  <td class="pn-flabel pn-flabel-h">��ϵ��ַ</td>
					    <td colspan="3" class="pn-fcontent"><input type="text" name="user.address"   value="${user.address}" size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					 </tr>	
					
					 <tr>
					   <td class="pn-flabel pn-flabel-h">��������</td>
					  <c:if test="${car.carType==1}"><td colspan="3" class="pn-fcontent"><input type="text"  value="С�γ������ճ�����ʿͷ�˻�����Ħ�г�"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${car.carType==2}"><td colspan="3" class="pn-fcontent"><input type="text"  value="�������С���˻��������ͻ�����С�Ϳͳ�"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${car.carType==3}"><td colspan="3" class="pn-fcontent"><input type="text"  value="���Ϳͳ������Ϳͳ������ͻ���"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					      <c:if test="${car.carType==4}"><td colspan="3" class="pn-fcontent"><input type="text"  value="���Ϳͳ������ͻ����������ϣ��ң�����20Ӣ�߼�װ�䳵"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
				           <c:if test="${car.carType==5}"><td colspan="3" class="pn-fcontent"><input type="text"  value="���ͻ����������ϣ��ң�����40Ӣ�߼�װ�䳵"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     															
						
					  </tr>
					  <tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;ɫ</td>
					   <td class="pn-fcontent"><input type="text" name="car.carColour" value="${car.carColour}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">�˺�״̬</td>
					    <c:if test="${account.status==0}"><td class="pn-fcontent"><input type="text" value="��Ч" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==1}"><td class="pn-fcontent"><input type="text" value="��ʧ" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==2}"><td class="pn-fcontent"><input type="text" value="Ԥ����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==3}"><td class="pn-fcontent"><input type="text" value="����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==4}"><td class="pn-fcontent"><input type="text" value="����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==5}"><td class="pn-fcontent"><input type="text" value="������" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==6}"><td class="pn-fcontent"><input type="text" value="������" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==7}"><td class="pn-fcontent"><input type="text" value="������" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					  
					   </tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					   <td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">�����ѣ�Ԫ��</td>
					   <td class="pn-fcontent"><input type="text" name="account.cost" value="<fmt:formatNumber value="${account.cost/100}" pattern="#.##" type="number"/>" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;Ա</td>
					   <td  class="pn-fcontent"><input type="text"  value="${operator.name}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">��������ʱ��</td>
					   <td class="pn-fcontent"><input type="text" name="param_endAccount_amongTime.pvalue" value="${param_endAccount_amongTime.pvalue}���" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;ע</td>
					  <td colspan="3" class="pn-fcontent"><input type="text" name="account.remark" value="${account.remark}" size="77" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>	
					<!--endprint-->				 					  														
					<tr>
						
						<td colspan="4" class="pn-fbutton"><input type="button"   value=" ��ӡ��ִ " onclick="doPrint();"/></td>
                        
                      
					</tr>
					</table>
					 
					
			</form>
		</div>
	</body>
</html>