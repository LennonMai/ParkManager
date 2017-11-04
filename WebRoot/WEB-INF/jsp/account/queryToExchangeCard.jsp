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
			if("${result}"=="FAIL")
				alert("û�д���Ϣ�˻�������������");
				if("${result}"=="FAIL1")
				alert("û�����˺���Ϣ������������");
				if("${result}"=="FAIL2")
				alert("û����ɷѿ���Ϣ������������");
				if("${result}"=="FAIL4")
				alert("û�д���Ϣ�˻�������������");			 			 
		        function check(){
		            if(get("account.sys_id").value!=""){
				    var partten = /^\+?[0-9][0-9]*$/;
				    if(partten.test(get("account.sys_id").value)){				            
                    }else{
                      alert("�û��˺�Ϊ���֣����������룡");
                      get("account.sys_id").focus();
					  return false;
                    }
                  }				       				
		       }						
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="account_queryAccountToExchangeCard.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">�û��˺ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="account.sys_id" value="${account.sys_id}" /></td>
						<td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
						<td  class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}" /></td>
					</tr>					 
					<tr>						
						<td  class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;����</td>
						<td  class="pn-fcontent"><input type="text" name="user.userName"  value="${user.userName}"/></td>
						<td  class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="car.vehPlate"  value="${car.vehPlate}"/></td>						
					</tr>
					<tr>
						<td  class="pn-flabel pn-flabel-h">�˺�״̬��</td>
						<td  class="pn-fcontent"> 
						  <select name="account.status" style="width:150px">
								<option value="" <c:if test="${account.status==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${account.status==0}">selected</c:if>>��Ч</option>
								<option value="1" <c:if test="${account.status==1}">selected</c:if>>��ʧ </option>
								<option value="2" <c:if test="${account.status==2}">selected</c:if>>Ԥ����</option>							  
								<option value="5" <c:if test="${account.status==5}">selected</c:if>>������</option>							
								<option value="7" <c:if test="${account.status==7}">selected</c:if>>������</option>
								<option value="4" <c:if test="${account.status==4}">selected</c:if>>���� </option>
						 </select>									 
						</td>
						<td  class="pn-flabel pn-flabel-h">֤�����룺</td>
						<td class="pn-fcontent"><input type="text" name="user.credentialsNo"  value="${user.credentialsNo}"/></td>
					</tr>						
					<tr>
						<td colspan="4" class="pn-fbutton">
						  <input type="submit"   value=" �� ѯ "/>&nbsp;
						  <input type="reset" value=" �� �� "/>						
						</td>
					</tr>
				</table>
				<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				  <thead class="pn-lthead">
					<tr>
						<th>�û��ʺ�</th>
						<th>��&nbsp;&nbsp;��</th>						
						<th>�û���&nbsp;&nbsp;</th>
						<th>֤������</th>
						<th>֤������</th>					
						<th>���ƺ�&nbsp;&nbsp;</th>					
						<th>������(Ԫ��</th>
						<th>�˺�״̬</th>
						<th>���(Ԫ��</th>
						<th>��&nbsp;&nbsp;��</th>						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.sys_id}</td>
							<td>${item.cardNo}</td>							
							<td>${item.user.userName}</td>
							<td><c:if test="${item.user.credentialsType==0}">���֤</c:if><c:if test="${item.user.credentialsType==1}">��&nbsp;&nbsp;��</c:if></td>
							<td>${item.user.credentialsNo}</td>					
							<td>${item.car.vehPlate}</td>
							<td><fmt:formatNumber value="${item.cost/100}" pattern="#.##" type="number"/>Ԫ</td>
							<td><c:if test="${item.status==0}">��Ч</c:if><c:if test="${item.status==1}">��ʧ</c:if><c:if test="${item.status==2}">Ԥ����</c:if><c:if test="${item.status==4}">����</c:if><c:if test="${item.status==5}">������</c:if><c:if test="${item.status==7}">������</c:if></td>								
						    <td><fmt:formatNumber value="${item.balance/100}" pattern="#.##" type="number"/>Ԫ</td> 
						      <c:choose> 
                                <c:when test="${(item.status==0||item.status==3||item.status==6)&&item.status!=7}"> 
                                  <td><a href="account_exchangeCard.do?account.sys_id=${item.sys_id}" class="pn-loperator">����</a></td>
                                </c:when>                            
                             <c:otherwise> 
                              <td/> &nbsp;</td>
                             </c:otherwise> 
                             </c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>