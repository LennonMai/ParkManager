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
         <script type="text/javascript">
          function doPrint() { 
                      bdhtml=window.document.body.innerHTML; 
                      sprnstr="<!--startprint-->"; 
                      eprnstr="<!--endprint-->"; 
                      prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17); 
                      prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr)); 
                      window.document.body.innerHTML=prnhtml; 
                      window.print(); 
                    }
        
        </script>

  </head>
  
  <body>
 <!--startprint-->
   <table width="450" class="pn-ftable" cellpadding="1" cellspacing="1" border="0" height="20" align="center" style="background-color: #FFFFFF;" >
					<tr>
					<td colspan="4" class="pn-fbutton">
						<input type="text" value=" �����ʻ���Ϣ��ִ " style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/> &nbsp;
					</td>
					</tr>
					</table>  
				                                     
		<table width="700" class="pn-ftable" cellpadding="0" cellspacing="0" border="1" height="345" align="center">
					
					
				<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.accountNo" value="${updateAccountLog.accountNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.updateTime" value="<fmt:formatDate value="${updateAccountLog.updateTime}" pattern="yyyy-MM-dd HH:mm:ss" />"
						 readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					
					
					<tr>
					  
					   <td class="pn-flabel pn-flabel-h">�û����ƣ�</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.userName" value="${updateAccountLog.userName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    <td class="pn-flabel pn-flabel-h">���ƺ�&nbsp;&nbsp;��</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.vehPlate" value="${updateAccountLog.vehPlate}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					 </tr>
					 <tr>
					    <td class="pn-flabel pn-flabel-h">֤�����ͣ�</td>
					    <c:if test="${updateAccountLog.credentialsType==0}"><td class="pn-fcontent"><input   type="text"  name="updateAccountLog.credentialsType" value="����֤" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${updateAccountLog.credentialsType==1}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.credentialsType" value="����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <td class="pn-flabel pn-flabel-h">֤�����룺</td>
					    <td class="pn-fcontent"><input type="text" name="updateAccountLog.credentialsNo" value="${updateAccountLog.credentialsNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					  <tr>
					   <td class="pn-flabel pn-flabel-h">��ϵ�绰��</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.phone" value="${updateAccountLog.phone}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">�ֻ����룺</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.mobileNumber" value="${updateAccountLog.mobileNumber}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>					
					 <tr>
					  <td class="pn-flabel pn-flabel-h">��ϵ��ַ��</td>
					    <td colspan="3" class="pn-fcontent"><input type="text" name="updateAccountLog.address"   value="${updateAccountLog.address}" size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					 </tr>	
					 
					 <tr>
					   <td class="pn-flabel pn-flabel-h">�������ͣ�</td>
					  <c:if test="${updateAccountLog.carType==1}"><td colspan="3" class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="С�γ������ճ�����ʿͷ�˻�����Ħ�г�"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${updateAccountLog.carType==2}"><td colspan="3" class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="�������С���˻��������ͻ�����С�Ϳͳ�"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${updateAccountLog.carType==3}"><td colspan="3" class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="���Ϳͳ������Ϳͳ������ͻ���"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					      <c:if test="${updateAccountLog.carType==4}"><td colspan="3" class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="���Ϳͳ������ͻ����������ϣ��ң�����20Ӣ�߼�װ�䳵"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
				           <c:if test="${updateAccountLog.carType==5}"><td colspan="3" class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="���ͻ����������ϣ��ң�����40Ӣ�߼�װ�䳵"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     															
						
					  </tr>
					  <tr>
					  <td class="pn-flabel pn-flabel-h">����ɫ&nbsp;&nbsp;��</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.carColour" value="${updateAccountLog.carColour}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">�˺�״̬��</td>
					    <c:if test="${updateAccountLog.status==0}"><td class="pn-fcontent"><input type="text"  name="updateAccountLog.status" value="��Ч" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${updateAccountLog.status==1}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="��ʧ" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${updateAccountLog.status==2}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="Ԥ����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${updateAccountLog.status==3}"><td class="pn-fcontent"><input type="text"  name="updateAccountLog.status" value="����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${updateAccountLog.status==4}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${updateAccountLog.status==5}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="������" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${updateAccountLog.status==6}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="������" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${updateAccountLog.status==7}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="������" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					  
					   </tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.cardNo" value="${updateAccountLog.cardNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">�����ѣ�Ԫ����</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.cost" value="<fmt:formatNumber value="${updateAccountLog.cost/100}" pattern="#.##" type="number"/>" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">����Ա&nbsp;&nbsp;��</td>
					   <td  class="pn-fcontent"><input type="text"  value="${operator.name}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.openAccountTime" value="<fmt:formatDate value="${updateAccountLog.openAccountTime}" pattern="yyyy-MM-dd HH:mm:ss" />" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
					  <td colspan="3" class="pn-fcontent"><input type="text" name="updateAccountLog.remark" value="${updateAccountLog.remark}" size="77" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<!--endprint-->	
					<tr>
						<td class="pn-fbutton"></td>
						<td colspan="3" class="pn-fbutton"><input type="button"   value=" ��ӡ��ִ " onclick="doPrint();"/></td>
                        
                       
					</tr>
					</table>
  </body>
</html>