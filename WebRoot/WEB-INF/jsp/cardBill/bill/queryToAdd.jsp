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
		if("${result}"=="SUCCESS")
			alert("�Ǽǳɹ�"); 
		if("${result}"=="SUCCESS1")
			alert("�޸ĳɹ�"); 
		if("${result}"=="SUCCESS2")
			alert("ɾ���ɹ�");
		
	function check() {
		if (get("billStorage.hankNo").value != "") {
			var partten = /^\+?[0-9][0-9]*$/;
			if (partten.test(get("billStorage.hankNo").value)) {

			} else {
				alert("Ʊ�ݺ�Ϊ���֣����������룡");
				get("billStorage.hankNo").focus();
				return false;
			}
		}
	}
	function add() {
		window.location = "bill_add.do";
	}
	 function cancel(hankNo) {	
		 if(confirm("ȷ��Ҫɾ����")) {								
				window.location = "bill_cancel.do?billStorage.hankNo=" + hankNo;	
		 }	
	  }
	function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
	function update(hankNo,pageSize,currentPage){
			window.location.href ="bill_update.do?billStorage.hankNo="+hankNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form name="tableForm" method="post" action="bill_queryBillStorageToAdd.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">Ʊ&nbsp;��&nbsp;�ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="billStorage.hankNo" value="${billStorage.hankNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">λ&nbsp;&nbsp;&nbsp;&nbsp;�ã�</td>
						<td  class="pn-fcontent">
						<select name="billStorage.position" style="width:150px">	
							<option value="" <c:if test="${billStorage.position==null}">selected</c:if>>��ѡ��</option>
							<option value="99" <c:if test="${billStorage.position==99}">selected</c:if>>��������</option>
							   <c:forEach items="${listgatewayInformation}" var="item">
								 <option value="${item.gateNo}" <c:if test="${billStorage.position==item.gateNo}">selected</c:if>>${item.gateName}</option>
							    </c:forEach> 															
						</select>	
						</td>
					</tr>					 
					<tr>
						
						<td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</td>
						<td  class="pn-fcontent">
						<select name="billStorage.billType" style="width:150px">
								<option value="" <c:if test="${billStorage.billType==null}">selected</c:if>>��ѡ��</option>
							    <option value="1" <c:if test="${billStorage.billType==1}">selected</c:if>>��˺Ʊ</option>
								<option value="2" <c:if test="${billStorage.billType==2}">selected</c:if>>�� &nbsp;Ʊ </option>
							</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">Ʊ�ݴ��룺</td>
						<td class="pn-fcontent"><input type="text" name="billStorage.billHead"  value="${billStorage.billHead}"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="button"  value=" �Ǽ� "  onclick="add();"/> &nbsp;
						<input type="reset" value=" �� �� "/>
						
						</td>
					</tr>
				</table>
					<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>Ʊ�ݺ�</th>
						<th>λ��</th>
						<th>Ʊ������</th>
						<th>Ʊ�ݴ���</th>						
						<th>��ʼƱ��</th>
						<th>����Ʊ��</th>
						<th>������</th>						
						<th>���ÿ�ʼƱ��</th>					
						<th>�Ѿ�ʹ������</th>						
						<th>����ʱ��</th>
						<th>����</th>						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.hankNo}</td>
							<td>
							  <c:choose> 
                                 <c:when test="${item.position==99}">��������                  
                                  </c:when>                           
                                  <c:otherwise> 
                                     <c:forEach items="${listgatewayInformation}" var="itemgatewayInformation"><c:if test="${item.position==itemgatewayInformation.gateNo}">${itemgatewayInformation.gateName}</c:if></c:forEach>
                                  </c:otherwise>                            
                              </c:choose>
							</td>	
							<td><c:if test="${item.billType==1}">��˺Ʊ</c:if><c:if test="${item.billType==2}">�� &nbsp;Ʊ</c:if></td>						
							<td>${item.billHead}</td>
							<td>${item.startBillNo}</td>
							<td>${item.endBillNo}</td>
							<td>${item.amount}</td>
							<td>${item.usedBillNo}</td>
							<td>${item.usedAmount}</td>							
							<td><fmt:formatDate value="${item.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><a href="javascript:update(${item.hankNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>��<a href="javascript:cancel(${item.hankNo})" class="pn-loperator">ɾ��</a></td> 							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>