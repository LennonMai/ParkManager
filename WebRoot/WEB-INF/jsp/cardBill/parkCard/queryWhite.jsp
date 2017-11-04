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
			function doExport(){
				document.getElementById("tableForm").action="parkCard_exportWhite.do";   
				document.getElementById("tableForm").submit();
				document.getElementById("tableForm").action="parkCard_queryWhite.do";
			}
			function doPrint(){
				document.getElementById("tableForm").action="parkCard_printsWhite.do";   
				document.getElementById("tableForm").submit();
				document.getElementById("tableForm").action="parkCard_queryWhite.do";
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="tableForm" name="tableForm" method="post" action="parkCard_queryWhite.do" >
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
					    <td  class="pn-flabel pn-flabel-h">������ţ�</td>
						<td  class="pn-fcontent"> 
							<input type="text" name="cardNo" id="cardNo" value="${cardNo}">
						</td> 
						<td  class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
						<td  class="pn-fcontent"> 
							<input type="text" name="vehplate" id="vehplate" value="${vehplate}">
						</td>
																									 					
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">����������</td>
						<td  class="pn-fcontent"> 
							<input type="text" name="ownerName" id="ownerName" value="${ownerName}">
						</td>	
						<td  class="pn-flabel pn-flabel-h">OBU&nbsp;&nbsp;&nbsp;�ţ�</td>
						<td  class="pn-fcontent"> 
							<input type="text" name="obuId" id="obuId" value="${obuId}">
						</td>
																										 					
					</tr>
					<tr>
					<td  class="pn-flabel pn-flabel-h">�ʺ�״̬��</td>
						<td  class="pn-fcontent">
							<select name="status" id="status" style="width:150px">
								<option value="" <c:if test="${status==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${status==0}">selected</c:if>>����</option>
							    <option value="1" <c:if test="${status==1}">selected</c:if>>��ʧ</option>
							    <option value="9" <c:if test="${status==9}">selected</c:if>>δ�ɷ�</option>  
							</select>
						</td>
					     <td  class="pn-flabel pn-flabel-h">�������ͣ�</td>
						 <td  class="pn-fcontent" >
							<select name="feeRuleType" id="feeRuleType" style="width:150px">
								<option value="" <c:if test="${feeRuleType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listFeeRuleTypeDef}" var="item">
									<option value="${item.feeRuleType}" <c:if test="${feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
							   </c:forEach>  
							</select>
					    </td>							 
						
					</tr>
					<tr>
						<td  class="pn-flabel pn-flabel-h">�û������ͣ�</td>
						<td   class="pn-fcontent">
							<select name="cardType" id="cardType" style="width:150px">
								<option value="" <c:if test="${cardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${userCardTypeList}" var="item">
									<option value="${item.userCardType}" <c:if test="${cardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
							</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">�Ƿ���ͼƬ��</td>
						<td  class="pn-fcontent">
							<select name="isImage" id="isImage" style="width:150px">
								<option value="" <c:if test="${isImage==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${isImage==0}">selected</c:if>>��</option>
							    <option value="1" <c:if test="${isImage==1}">selected</c:if>>��</option>  
							</select>
						</td>																				 					
					</tr>																			 					
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit"   value=" �� ѯ " />&nbsp;					
							<input type="reset" value=" �� �� "/>&nbsp;
							<input type="button" value=" �� �� " onclick="doExport('a.php');"/>&nbsp;					
							<input type="button" value=" �� ӡ " onclick="doPrint();"/>
						</td>
					</tr>
				</table>
				<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>�������</th>
						<th>�� �� ��</th>
						<th>��������</th>
						<th>OBU  ��</th>
						<th>�ʺ�״̬</th>
						<th>�û�������</th>
						<th>��������</th>
						<th>����ʱ��</th>
						<th>����ʱ��</th>	
						
							
						<th>�Ƿ���ͼƬ</th>
							
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item[0]}</td>
							<td>${item[1]}</td>
							<td>${item[2]}</td>
							<td>${item[3]}</td>	
							<td>
								<c:if test="${item[7]==0}">����</c:if>
								<c:if test="${item[7]==1}">��ʧ</c:if>
								<c:if test="${item[7]==9}">δ�ɷ�</c:if>
							</td>
							<td>
								<c:forEach items="${userCardTypeList}" var="item1">
									<c:if test="${item[6]==item1.userCardType}">${item1.typeName}</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${listFeeRuleTypeDef}" var="item1">
									<c:if test="${item[9]==item1.feeRuleType}">${item1.name}</c:if>
								</c:forEach>
							</td>
							<td>${item[4]}</td>
							<td>${item[5]}</td>	
							
								
							<td>
								<c:if test="${item[8]==0}">��</c:if>
								<c:if test="${item[8]==1}">��</c:if>
							</td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>