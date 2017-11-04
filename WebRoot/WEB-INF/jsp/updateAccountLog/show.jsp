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
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <form method="post" action="">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" >
					 
					<tr>
					  
					  <td class="pn-flabel pn-flabel-h">�û�����</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.userName" value="${updateAccountLog.userName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">���ƺţ�</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.vehPlate" value="${updateAccountLog.vehPlate}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					
					  <td class="pn-flabel pn-flabel-h">֤�����ͣ�</td>
					    <c:if test="${updateAccountLog.credentialsType==0}"> <td class="pn-fcontent"><input type="text" name="updateAccountLog.credentialsType" value="���֤" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					     </c:if>
					    <c:if test="${updateAccountLog.credentialsType==1}"><td class="pn-fcontent"> <input type="text" name="updateAccountLog.credentialsType" value="����" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					     </c:if>
					  <td class="pn-flabel pn-flabel-h">֤������:</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.credentialsNo" value="${updateAccountLog.credentialsNo}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">��ϵ�绰��</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.phone" value="${updateAccountLog.phone}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">�ֻ����룺</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.mobileNumber" value="${updateAccountLog.mobileNumber}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">��ϵ��ַ��</td>
					     <td colspan="3" class="pn-fcontent"><textarea rows='1' cols='98' name="updateAccountLog.address" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px">${updateAccountLog.address}</textarea></td>
					</tr>												
					<tr>
					  <td class="pn-flabel pn-flabel-h">�����ͣ�</td>
					     <c:if test="${updateAccountLog.carType==1}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="С�γ������ճ�����ʿͷ�˻�����Ħ�г�" size="40" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					      </c:if>
					     <c:if test="${updateAccountLog.carType==2}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="�������С���˻��������ͻ�����С�Ϳͳ�" size="40" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					      </c:if>
					     <c:if test="${updateAccountLog.carType==3}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="���Ϳͳ������Ϳͳ������ͻ���" size="40"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						  </c:if>
						 <c:if test="${updateAccountLog.carType==4}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="���Ϳͳ������ͻ����������ϣ��ң�����20Ӣ�߼�װ�䳵" size="40" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						 </c:if>
						 <c:if test="${updateAccountLog.carType==5}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.carType" value="���ͻ����������ϣ��ң�����40Ӣ�߼�װ�䳵" size="40" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						 </c:if>
						<td class="pn-flabel pn-flabel-h">����ɫ��</td>
					   <td class="pn-fcontent"><input type="text" name="updateAccountLog.carColour" value="${updateAccountLog.carColour}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
				   </tr>				
					
					<tr>
					  <td class="pn-flabel pn-flabel-h">�˺ţ�</td>
					  <td  class="pn-fcontent"><input type="text" name="updateAccountLog.accountNo" value="${updateAccountLog.accountNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td> 
					  <td class="pn-flabel pn-flabel-h">���ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.cardNo" value="${updateAccountLog.cardNo}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>				
					<tr>
					  <td class="pn-flabel pn-flabel-h">�����ѣ�Ԫ����</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.cost" value="<fmt:formatNumber value="${updateAccountLog.cost/100}" pattern="#.##" type="number"/>" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>					 
					  <td class="pn-flabel pn-flabel-h">�˺�״̬��</td>
					   <c:if test="${updateAccountLog.status==0}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="��Ч"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${updateAccountLog.status==1}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="��ʧ"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${updateAccountLog.status==2}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="Ԥ����"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${updateAccountLog.status==3}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="����"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${updateAccountLog.status==4}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="����"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${updateAccountLog.status==5}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="������"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${updateAccountLog.status==6}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="������"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${updateAccountLog.status==7}"><td class="pn-fcontent"><input type="text" name="updateAccountLog.status" value="������"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					   
					 </tr>
					  <c:if test="${param_card_type.pvalue!=1}">
					 <tr>
					   <td class="pn-flabel pn-flabel-h">�����Ԫ����</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.lowestBalanceAfterConsume" value="<fmt:formatNumber value="${updateAccountLog.lowestBalanceAfterConsume/100}" pattern="#.##" type="number"/>" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">����������(Ԫ��:</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.tollyLowestBalanceAC" value="<fmt:formatNumber value="${updateAccountLog.tollyLowestBalanceAC/100}" pattern="#.##" type="number"/>" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  
					</tr>
					 <tr>
					 <td class="pn-flabel pn-flabel-h">��ֹʻ��������(Ԫ��:</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.noEntryBalance" value="<fmt:formatNumber value="${updateAccountLog.noEntryBalance/100}" pattern="#.##" type="number"/>" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">��ʾ�û�ȥ���ѵ�������(Ԫ��:</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.lowBalanceNotice" value="<fmt:formatNumber value="${updateAccountLog.lowBalanceNotice/100}" pattern="#.##" type="number"/>" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   
					 </tr>
					 </c:if>
					 
					 <tr>
					 <td class="pn-flabel pn-flabel-h">����ʱ��:</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.openAccountTime" value="${updateAccountLog.openAccountTime}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">״̬����ʱ��:</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.statusUpdateTime" value="${updateAccountLog.statusUpdateTime}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					 <tr>
					 <td class="pn-flabel pn-flabel-h">����Ա���:</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.operator_id" value="${updateAccountLog.operator_id}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">����Ա����:</td>
					  <td class="pn-fcontent"><input type="text" name="updateAccountLog.operatorName" value="${updateAccountLog.operatorName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					
					  <td class="pn-flabel pn-flabel-h">��ע��</td>
					  <td colspan="3" class="pn-fcontent"><textarea rows='2' cols='98' name="updateAccountLog.remark" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px">${updateAccountLog.remark}</textarea></td>
					</tr>
					<tr>
					<td colspan="4" class="pn-fbutton"><input type="button" value=" �� �� " onclick="history.back();"/>
					</td>
					</tr>
					
					
					 </table>
					
			</form>
		</div>
	</body>
</html>
