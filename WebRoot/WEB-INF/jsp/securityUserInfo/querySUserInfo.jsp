<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript">
			if("${message}"=="0"){
				alert("ע��ʧ��");
			}
			if("${message}"=="1"){
				alert("ע��ɹ�");
			}
			if("${message}"=="3"){
				alert("����ʧ��");
			}
			if("${message}"=="4"){
				alert("���³ɹ�");
			}
			if("${message}"=="5"){
				alert("ɾ���ɹ�");
			}
			if("${message}"=="6"){
				alert("ɾ���ɹ�");
			}
			function del(id,sizes,crrPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "securityUserInfo_delete.do?regId="+id+"&pager.pageSize="+sizes+"&pager.currentPage="+crrPage;
				}
			}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
			}
			function toUpdate(regId,pageSize,currentPage) {														
				window.location = "securityUserInfo_toUpdate.do?regId="+regId+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;		
		    }
		    function setRowBGcolor(){
				var rowIndex="${rowIndex}";
				var pageSize="${pageSize}";
				var currentPage="${currentPage}";
				if(rowIndex!=""&&pageSize!=""&&currentPage!=""){
					var trs=document.getElementById("tb").getElementsByTagName("tr");
					for(var i=0;i<trs.length;i++){
						if(i==rowIndex&&get("pager.pageSize").value==pageSize&&get("pager.currentPage").value==currentPage){
							trs[i].style.backgroundColor="#E6E6E6";
						}
					}
				}
			}		 
		</script>
	</head>
	<body onload="setRowBGcolor();">
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityUserInfo_querySecurityUserInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�û�������</td>
						<td class="pn-fcontent">
						  <input type="text" name="owner" value="${owner}" />
						</td>
						<td class="pn-flabel pn-flabel-h">���֤�ţ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="IDCard" value="${IDCard}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="vehPlate" value="${vehPlate}" />
						</td>
						<td class="pn-flabel pn-flabel-h">O&nbsp;B&nbsp;U&nbsp;�ţ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="OBU" value="${OBU}" />
						</td>
					</tr>
					<tr>
					<td  class="pn-flabel pn-flabel-h">�û����ͣ�</td>
						<td  class="pn-fcontent">
						<select name="userType" style="width:150px">
								<option value="" <c:if test="${userType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listUserCardFeeRuleType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>
						</td>
						<td class="pn-flabel pn-flabel-h">������ţ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNO" value="${cardNO}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;״&nbsp;̬��</td>
						<td class="pn-fcontent">
							<select name="status" style="width:150px">
								<option value="" <c:if test="${status==null}">selected</c:if>>-��ѡ��-</option>
								<option value="0" <c:if test="${status==0}">selected</c:if>>����</option>
								<option value="1" <c:if test="${status==1}">selected</c:if>>��ʧ</option>
								<option value="9" <c:if test="${status==9}">selected</c:if>>δ�ɷ�</option>
							</select>
						</td>
						<c:if test="${param_whtherPayType.pvalue!=1}">							
						    <td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
							<td class="pn-fcontent"> 
						    	<select name="feeRuleType" style="width:150px">
									<option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>��ѡ��</option>
								    	<c:forEach items="${listFeeRuleTypeDef}" var="item">
											<option value="${item.feeRuleType}" <c:if test="${feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
								   		</c:forEach>  
								</select>
							</td>
						</c:if>
						<c:if test="${param_whtherPayType.pvalue == 1}">
							<td class="pn-flabel pn-flabel-h">�Ƿ���ע��</td>
							 <td class="pn-fcontent">
								<select name="whtherRegister" style="width:150px">
									<option value="" <c:if test="${whtherRegister==null}">selected</c:if>>-��ѡ��-</option>
									<option value="0" <c:if test="${whtherRegister==0}">selected</c:if>>��ע��</option>
									<option value="1" <c:if test="${whtherRegister==1}">selected</c:if>>ĩע��</option>
								</select>
							</td>
						</c:if>
					</tr>
					<c:if test="${param_whtherPayType.pvalue!=1}">
						<tr>
							 <td class="pn-flabel pn-flabel-h">�Ƿ���ע��</td>
							 <td colspan="3" class="pn-fcontent">
								<select name="whtherRegister" style="width:150px">
									<option value="" <c:if test="${whtherRegister==null}">selected</c:if>>-��ѡ��-</option>
									<option value="0" <c:if test="${whtherRegister==0}">selected</c:if>>��ע��</option>
									<option value="1" <c:if test="${whtherRegister==1}">selected</c:if>>ĩע��</option>
								</select>
							</td>
						</tr>
					</c:if>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� ѯ " />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" �� �� " />		
						</td>
					</tr>
				</table>
			<!-- ��ʾlist����-->
			<table  id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>�û����</th>
						<th>�û�����</th>
						<th>���֤��</th>
						<th>���ƺ���</th>
						<th>ͣ �� ��</th>
						<th>OBU  ��</th>
						<th>�� ״ ̬</th>
						<th>Ѻ��(Ԫ)</th>
						<th>�������</th>
						<th>�û�����</th>
						 <c:if test="${param_whtherPayType.pvalue!=1}">
						<th>�շ�����</th>
						</c:if>
						<th>����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item[1].recNO }</td>
							<td>${item[1].owner }</td>
							<td>${item[1].idcard }</td>
							<td>${fn:trim(item[1].vehPlate)}</td>
							<td>${item[1].parkingSpace }</td>
							<td>${item[1].obu }</td>
							<td>
								<c:if test="${item[1].status==0}">����</c:if>
								<c:if test="${item[1].status==1}">��ʧ</c:if>
								<c:if test="${item[1].status==9}">δ�ɷ�</c:if>
							</td>
							<td>${item[1].deposit }</td>
							<td>${item[1].cardNo }</td>
							<td>
								<c:forEach items="${listUserCardFeeRuleType}" var="itemCardType">
                                	<c:if test="${item[1].userCardType==itemCardType.userCardType}">${itemCardType.typeName}</c:if>
                                </c:forEach>
							</td>
                            <c:if test="${param_whtherPayType.pvalue!=1}">
							<td>
								<c:forEach items="${listFeeRuleTypeDef}" var="itemFeeRuleTypeDef">
									<c:if test="${item[1].feeRuleType==itemFeeRuleTypeDef.feeRuleType}">${itemFeeRuleTypeDef.name}</c:if>
								</c:forEach>
							</td>					
							</c:if>
							<td>
								<c:if test="${item[0]==null}">
									<a href="securityUserInfo_toRegister.do?cardNo=${item[1].cardNo }&pager.pageSize=${pager.pageSize}'&pager.currentPage=${pager.currentPage }" class="pn-loperator">ע��</a>
								</c:if>
								<c:if test="${item[0]!=null}">
									<a  href="javascript:toUpdate(${item[0].regId },${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>��
									<a href="javascript:del(${item[0].regId },${pager.pageSize},${pager.currentPage });" class="pn-loperator">ɾ��</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>