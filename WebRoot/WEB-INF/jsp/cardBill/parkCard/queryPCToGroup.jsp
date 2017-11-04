 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 使用JavaBean 引入jsonrpc.jar -->
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryPCToGroup.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">卡表面号：</td>
						<td  class="pn-fcontent"> <input type="text" name="userCardInfo.cardNo" value="${userCardInfo.cardNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">车牌号码：</td>
						<td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate"  value="${userCardInfo.vehPlate}"/></td>						
						</td>
					</tr>					 
					<tr>					
						<td  class="pn-flabel pn-flabel-h">组&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
						<td class="pn-fcontent"><input type="text" name="cardGroupInfo.groupName"  value="${cardGroupInfo.groupName}"/>
						  <c:choose> 
                                   <c:when test="${isGroup==0}"><input type="checkbox" name="isGroup"  checked="checked" value="0"  />未分组</td>                  
                                   </c:when>                           
                                   <c:otherwise> 
                                    <input type="checkbox" name="isGroup"  value="0"  />未分组</td>
                                  </c:otherwise>                            
                               </c:choose>
						
						<td  class="pn-flabel pn-flabel-h">用户类型：</td>
						<td  class="pn-fcontent">
						<select name="userCardInfo.userCardType" style="width:150px">
								<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listUserCardFeeRuleType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>
						</td>								
					</tr>					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" 查 询 " />&nbsp;
						<input type="button" value="组信息管理 " onclick="queryCardGroupInfo()"/>
						<input type="reset" value=" 重 置 "/>
						
						
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>用户编号</th>
						<th>卡表面号</th>						
						<th>车牌号码</th>
						<th>用户类型</th>
						<th>组名</th>						
						<th>停车位</th>																	
						<th>房号</th>						
						<th>移动电话</th>
						<th>操作</th>
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
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	                             var result = jsonrpc.ajax.getCardGroupName();	                           	 
	                             for (var i=0;i<result.length;i++){
	                            	 if(result[i][0]==cardNo){
	                            		 exist=0
	                                 }
	                             }
	                             if(exist==1){
	                            	 document.getElementById("${itemUserCardInfo.cardNo}").innerHTML="未分组";
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
                               <td><a href="javascript:queryCGInfoToGroup('${itemUserCardInfo.recNO}')" class="pn-loperator">添加至组</a></td>             
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