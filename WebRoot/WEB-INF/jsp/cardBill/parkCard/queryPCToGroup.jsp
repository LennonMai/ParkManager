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
		function queryCGInfoToGroup(recNO) {												
				window.location = "parkCard_queryCGInfoToGroup.do?userCardInfo.recNO=" + recNO;	
		}	
		function queryCardGroupInfo() {												
			window.location = "parkCard_queryCardGroupInfo.do";	
	    }										
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryPCToGroup.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">������ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="userCardInfo.cardNo" value="${userCardInfo.cardNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">���ƺ��룺</td>
						<td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate"  value="${userCardInfo.vehPlate}"/></td>						
						</td>
					</tr>					 
					<tr>					
						<td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td class="pn-fcontent"><input type="text" name="cardGroupInfo.groupName"  value="${cardGroupInfo.groupName}"/>
						  <c:choose> 
                                   <c:when test="${isGroup==0}"><input type="checkbox" name="isGroup"  checked="checked" value="0"  />δ����</td>                  
                                   </c:when>                           
                                   <c:otherwise> 
                                    <input type="checkbox" name="isGroup"  value="0"  />δ����</td>
                                  </c:otherwise>                            
                               </c:choose>
						
						<td  class="pn-flabel pn-flabel-h">�û����ͣ�</td>
						<td  class="pn-fcontent">
						<select name="userCardInfo.userCardType" style="width:150px">
								<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listUserCardFeeRuleType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>
						</td>								
					</tr>					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="button" value="����Ϣ���� " onclick="queryCardGroupInfo()"/>
						<input type="reset" value=" �� �� "/>
						
						
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>�û����</th>
						<th>�������</th>						
						<th>���ƺ���</th>
						<th>�û�����</th>
						<th>����</th>						
						<th>ͣ��λ</th>																	
						<th>����</th>						
						<th>�ƶ��绰</th>
						<th>����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${listUserCardInfo}" var="itemUserCardInfo">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${itemUserCardInfo.recNO}</td>
							<td>${itemUserCardInfo.cardNo}</td>								
							<td>${itemUserCardInfo.vehPlate}</td>
							<td><c:forEach items="${listUserCardFeeRuleType}" var="itemlistUserCardFeeRuleType"><c:if test="${itemUserCardInfo.userCardType==itemlistUserCardFeeRuleType.userCardType}">${itemlistUserCardFeeRuleType.typeName}</c:if></c:forEach></td>							 
							<c:choose> 
                            <c:when test="${itemUserCardInfo.userCardType==15}">
                            <td id="${itemUserCardInfo.cardNo}"></td>
							<script language="javascript">	
							     var exist=1;		    	                            
	                             var cardNo=${itemUserCardInfo.cardNo};	                          
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	                             var result = jsonrpc.ajax.getCardGroupName();	                           	 
	                             for (var i=0;i<result.length;i++){
	                            	 if(result[i][0]==cardNo){
	                            		 exist=0
	                                 }
	                             }
	                             if(exist==1){
	                            	 document.getElementById("${itemUserCardInfo.cardNo}").innerHTML="δ����";
	                             }else{		                             
	                                   for (var i=0;i<result.length;i++){	                    	 
		                                  var no=result[i][0];
		                                  var name=result[i][1];
		                                  if(no==cardNo){      		                        
		                            	     document.getElementById("${itemUserCardInfo.cardNo}").innerHTML=name;
			                              }   	
	                         	      }
	                              }	                         	
                            </script>
							</c:when>                           
                             <c:otherwise> 
                              <td></td>
                             </c:otherwise>                            
                               </c:choose>
						    <td>${itemUserCardInfo.parkingSpace}</td>
							<td>${itemUserCardInfo.roomNo}</td>
							<td>${itemUserCardInfo.mobileNumber}</td>										
					 		<c:choose> 
                            <c:when test="${itemUserCardInfo.userCardType==15}">
                               <td><a href="javascript:queryCGInfoToGroup('${itemUserCardInfo.recNO}')" class="pn-loperator">�������</a></td>             
                             </c:when>                           
                             <c:otherwise> 
                              <td></td>
                             </c:otherwise>                            
                               </c:choose>	
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>