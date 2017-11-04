 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		if("${result}"=="SUCCESS")
			alert("ע��ɹ�");  
		if("${result}"=="SUCCESS1")
			alert("�޸ĳɹ�"); 			
		 if("${result}"=="SUCCESS2")
			alert("ע���ɹ�");
			  function register(){
		          window.location="parkCard_register.do";
		       }
			 			  
			  function cancel(cardNo) {	
				 if(confirm("ȷ��Ҫע����")) {								
						window.location = "parkCard_parkCardCancel.do?userCardInfo.cardNo=" + cardNo;	
				 }	
			  }
			  function getRowIndex(obj){
					get("pager.rowIndex").value=obj.rowIndex;
					}
				function userCardInfoList(recNo,pageSize,currentPage){
					window.location.href ="parkCard_userCardInfoList.do?userCardInfo.recNO="+recNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form name="tableForm" method="post" action="parkCard_queryParkCard.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">������ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="userCardInfo.cardNo" value="${userCardInfo.cardNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">��&nbsp;״&nbsp;̬��</td>
						<td  class="pn-fcontent">
						<select name="userCardInfo.status" style="width:150px">
								<option value="" <c:if test="${userCardInfo.status==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${userCardInfo.status==0}">selected</c:if>>����</option>
								<option value="1" <c:if test="${userCardInfo.status==1}">selected</c:if>>��ʧ </option>
								<option value="9" <c:if test="${userCardInfo.status==9}">selected</c:if>>δ�ɷ� </option>
						</select>	
						</td>
					</tr>					 
					<tr>						
						<td  class="pn-flabel pn-flabel-h">�û����ͣ�</td>
						<td  class="pn-fcontent">
						<select name="userCardInfo.userCardType" style="width:150px">								
							   <option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listUserCardType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>   
						</select>
						
						</td>
						<td  class="pn-flabel pn-flabel-h">���ƺ��룺</td>
						<td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate"  value="${userCardInfo.vehPlate}"/></td>
					</tr>
					<tr>
					  
						<td  class="pn-flabel pn-flabel-h">����������</td>				
						<td   class="pn-fcontent"> <input type="text" name="userCardInfo.owner"  value="${userCardInfo.owner}"/></td>				
						<td  class="pn-flabel pn-flabel-h">���֤�ţ�</td>						
						<td   class="pn-fcontent"><input type="text" name="userCardInfo.idcard"  value="${userCardInfo.idcard}"/></td>
					</tr>
					 <c:if test="${param_whtherPayType.pvalue!=1}">					
					<tr>						
					    <td   class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<td   class="pn-fcontent"> 
					     <select name="userCardInfo.feeRuleType" style="width:150px">
								<option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listFeeRuleTypeDef}" var="item">
								<option value="${item.feeRuleType}" <c:if test="${userCardInfo.feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
							   </c:forEach>  
						</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">�ƶ��绰��</td>						
						<td   class="pn-fcontent"><input type="text" name="userCardInfo.mobileNumber"  value="${userCardInfo.mobileNumber}"/></td>
					</tr>
					</c:if>
						
					
					
				
					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="button"  value=" ע�� "  onclick="register();"/> &nbsp;
						<input type="reset" value=" �� �� "/>
						
						</td>
					</tr>
				</table>
					<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��״̬</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�̹�����</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���֤����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ƶ��绰</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ƺ���</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ͣ��λ</th>					
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">OBU��</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ɷ�����</th>
						 <c:if test="${param_whtherPayType.pvalue!=1}">
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շ�����</th>
						</c:if>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ע��ʱ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�̹���λ</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${listUserCardInfo}" var="itemUserCardInfo">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)"> 
							<td>${itemUserCardInfo.recNO}</td>
							<td>${itemUserCardInfo.cardNo}</td>	
							<td><c:if test="${itemUserCardInfo.status==0}">����</c:if><c:if test="${itemUserCardInfo.status==1}">��ʧ</c:if><c:if test="${itemUserCardInfo.status==9}">δ�ɷ�</c:if></td>						
							<td>${itemUserCardInfo.owner}</td>
							<td id="${itemUserCardInfo.recNO}"></td>
							
							<td>${itemUserCardInfo.idcard}</td>
							<td>${itemUserCardInfo.mobileNumber}</td>
							<td>${itemUserCardInfo.vehPlate}</td>
							<td>${itemUserCardInfo.parkingSpace}</td>
							<td>${itemUserCardInfo.obu}</td>
							<td>
							 <c:forEach items="${listUserCardType}" var="itemlistUserCardType"><c:if test="${itemUserCardInfo.userCardType==itemlistUserCardType.userCardType}">${itemlistUserCardType.typeName}</c:if></c:forEach>
                            </td>
                            <td><fmt:formatDate value="${itemUserCardInfo.payEndTime}" pattern="yyyy-MM-dd" /></td>             
                             <c:if test="${param_whtherPayType.pvalue!=1}">
							<td><c:forEach items="${listFeeRuleTypeDef}" var="itemFeeRuleTypeDef"><c:if test="${itemUserCardInfo.feeRuleType==itemFeeRuleTypeDef.feeRuleType}">${itemFeeRuleTypeDef.name}</c:if></c:forEach></td>					
							</c:if>
							<td><fmt:formatDate value="${itemUserCardInfo.registerTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
							<input  type="text"  id="0${itemUserCardInfo.cardNo}" size="23" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
							<script language="javascript">			    	                            
	                             var cardNo=${itemUserCardInfo.cardNo};	                          
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	                             var result = jsonrpc.ajax.getStaffNameAndStaffAddress(cardNo);	                           	                     	 
		                         var staffName=result[0][0];
		                         var staffAddress=result[0][1]; 
		                         if(staffName==null){  
		                        	 document.getElementById("${itemUserCardInfo.recNO}").innerHTML="";	  		                        
		                         }else{
		                        	 document.getElementById("${itemUserCardInfo.recNO}").innerHTML=staffName;
		                         }
		                         if(staffAddress==null){  
		                        	 document.getElementById("0${itemUserCardInfo.cardNo}").value=""; 		                        
		                         }else{
		                        	 document.getElementById("0${itemUserCardInfo.cardNo}").value=staffAddress;
		                         }		                   		                         			                                                      	
                            </script>
							
							<%--<td ><input  type="text"  value="${itemUserCardInfo.address}" size="25" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
							 --%><td style="white-space:nowrap;padding-left:5px;padding-right:5px;"><a href="javascript:userCardInfoList(${itemUserCardInfo.recNO},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>��<a href="javascript:cancel('${itemUserCardInfo.cardNo}')" class="pn-loperator">ע��</a></td>                               
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>