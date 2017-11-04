 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<%@include file="../../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript">
		if("${result}"=="SUCCESS")
			alert("挂失成功");
		if("${result}"=="SUCCESS1")
			alert("解挂成功");
		  
		function loss(cardNo) {	
			if(confirm("确定要挂失吗？")) {								
				window.location = "parkCard_parkCardLoss.do?userCardInfo.cardNo=" + cardNo;	
			}	
		}
		function removeLoss(cardNo) {	
			if(confirm("确定要解挂吗？")) {								
				window.location = "parkCard_parkCardRemoveLoss.do?userCardInfo.cardNo=" + cardNo;	
			}	
		}
		
		function getCarSmallType(){
			var carType = document.getElementsByName("userCardInfo.carType")[0].value; 
			$.ajax({
				type:"post",
				url:"parkCard_findCarSmallType.do?carType="+carType,
				success:function(res){
					$("#parkingSpace").empty();
					var op = $("<option value=''>请选择</option>");		
					$("#parkingSpace").append(op);
					$(res).find("CarSmallTypes > CarSmallType").each(function(){
						var o = $("<option value="+$(this).attr("id") +">"
								+$(this).attr("name")+"</option>");
						$("#parkingSpace").append(o);
					});
				}
			});
		}
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryToLossAndRLoss.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">卡表面号：</td>
						<td  class="pn-fcontent"> <input type="text" name="userCardInfo.cardNo" value="${userCardInfo.cardNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">卡&nbsp;状&nbsp;态：</td>
						<td  class="pn-fcontent">
						<select name="userCardInfo.status" style="width:150px">
								<option value="" <c:if test="${userCardInfo.status==null}">selected</c:if>>请选择</option>
							    <option value="0" <c:if test="${userCardInfo.status==0}">selected</c:if>>正常</option>
								<option value="1" <c:if test="${userCardInfo.status==1}">selected</c:if>>挂失 </option>
								<option value="9" <c:if test="${userCardInfo.status==9}">selected</c:if>>未缴费 </option>
						</select>	
						</td>
					</tr>					 
					<tr>
					    <td  class="pn-flabel pn-flabel-h">用户类型：</td>
						<td  class="pn-fcontent">
						<select name="userCardInfo.userCardType" style="width:150px">
								<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listUserCardType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">车牌号码：</td>
						<td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate"  value="${userCardInfo.vehPlate}"/></td>
					</tr>
					<tr>
					  
						<td  class="pn-flabel pn-flabel-h">车主姓名：</td>				
						<td   class="pn-fcontent"> <input type="text" name="userCardInfo.owner"  value="${userCardInfo.owner}"/></td>				
						<td  class="pn-flabel pn-flabel-h">身份证号：</td>						
						<td   class="pn-fcontent"><input type="text" name="userCardInfo.idcard"  value="${userCardInfo.idcard}"/></td>
					</tr>
					 <c:if test="${param_whtherPayType.pvalue!=1}">					
					<tr>						
					    <td   class="pn-flabel pn-flabel-h">收费类型：</td>
						<td    class="pn-fcontent"> 
					     <select name="userCardInfo.feeRuleType" style="width:150px">
								<option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listFeeRuleTypeDef}" var="item">
								<option value="${item.feeRuleType}" <c:if test="${userCardInfo.feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
							   </c:forEach>  
						</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">移动电话：</td>						
						<td   class="pn-fcontent"><input type="text" name="userCardInfo.mobileNumber"  value="${userCardInfo.mobileNumber}"/></td>
					</tr>
					</c:if>
						
					<tr>						
						<td class="pn-flabel pn-flabel-h">车辆类型：</td>
						<td class="pn-fcontent">
							<select name="userCardInfo.carType" style="width:150px" onchange="getCarSmallType()">
								<option value="" <c:if test="${userCardInfo.carType==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listCarType}" var="item">
									<option value="${item.carType}" <c:if test="${userCardInfo.carType==item.carType}">selected</c:if>>${item.carTypeName}</option>
								</c:forEach>  
						</select>
						</td>
						 <td class="pn-flabel pn-flabel-h">停&nbsp;车&nbsp;位：</td>
					   	 <td class="pn-fcontent">
							<select name="userCardInfo.parkingSpace" id="parkingSpace" style="width:150px" >
								<option value=""  <c:if test="${userCardInfo.parkingSpace==null}">selected</c:if>>请选择</option>
								<c:forEach items="${listCarSmallTypeInCarType}" var="CarSmallType">
									<option value="${CarSmallType.carSmallType}" 
									  <c:if test="${userCardInfo.parkingSpace==CarSmallType.carSmallType}">selected</c:if>>${CarSmallType.carSmallName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<td class="pn-flabel pn-flabel-h">车主身份：</td>
						<td class="pn-fcontent">
							<select name="userCardInfo.ownerIdentity"  style="width:150px">
								<option value="">请选择</option>
								<c:forEach items="${listIdentity}" var="identity">
									<option value="${identity.identityType}" <c:if test="${identity.identityType==userCardInfo.ownerIdentity}">selected</c:if> >${identity.identityName}</option>
								</c:forEach>
							</select>
						</td>
						<td class="pn-flabel pn-flabel-h"> </td>
						<td class="pn-flabel pn-flabel-h"> </td>
					</tr>
					
				
					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" 查 询 " />&nbsp;
						<input type="reset" value=" 重 置 "/>
						
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">用户编号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">卡表面号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">卡状态</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车主姓名</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车主身份</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">身份证号码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">移动电话</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车牌号码</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">OBU号</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">用户类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">缴费期限</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车辆类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">停车位</th>
						 <c:if test="${param_whtherPayType.pvalue!=1}">
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">收费类型</th>
						</c:if>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">注册时间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">用户住址</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>

					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${listUserCardInfo}" var="itemUserCardInfo">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${itemUserCardInfo.recNO}</td>
							<td>${itemUserCardInfo.cardNo}</td>	
							<td><c:if test="${itemUserCardInfo.status==0}">正常</c:if><c:if test="${itemUserCardInfo.status==1}">挂失</c:if><c:if test="${itemUserCardInfo.status==9}">未缴费</c:if></td>						
							<td>${itemUserCardInfo.owner}</td>
							<td>
								<c:forEach items="${listIdentity}" var="identity">
									<c:if test="${itemUserCardInfo.ownerIdentity==identity.identityType}">${identity.identityName}</c:if>
								</c:forEach>
							</td>
							<td>${itemUserCardInfo.idcard}</td>
							<td>${itemUserCardInfo.mobileNumber}</td>
							<td>${itemUserCardInfo.vehPlate}</td>
							
							<td>${itemUserCardInfo.obu}</td>
							<td>
							  <c:forEach items="${listUserCardType}" var="itemlistUserCardType"><c:if test="${itemUserCardInfo.userCardType==itemlistUserCardType.userCardType}">${itemlistUserCardType.typeName}</c:if></c:forEach>
                            </td>
                            <td><fmt:formatDate value="${itemUserCardInfo.payEndTime}" pattern="yyyy-MM-dd" /></td>             
                             <td>
								<c:forEach items="${listCarType}" var="itemlistCarType"><c:if test="${itemlistCarType.carType==itemUserCardInfo.carType}">${itemlistCarType.carTypeName}</c:if></c:forEach>
							</td>
							<td>
								<c:forEach items="${listCarSmallType}" var="CarSmallType">
									<c:if test="${itemUserCardInfo.carType==CarSmallType.carType && itemUserCardInfo.parkingSpace==CarSmallType.carSmallType}">${CarSmallType.carSmallName}</c:if>
								</c:forEach>
							</td>
                             <c:if test="${param_whtherPayType.pvalue!=1}">
							<td><c:forEach items="${listFeeRuleTypeDef}" var="itemFeeRuleTypeDef"><c:if test="${itemUserCardInfo.feeRuleType==itemFeeRuleTypeDef.feeRuleType}">${itemFeeRuleTypeDef.name}</c:if></c:forEach></td>					
							</c:if>
							<td><fmt:formatDate value="${itemUserCardInfo.registerTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td ><input type="text"  value="${itemUserCardInfo.address}" size="20" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>			
							<c:choose> 
                                 <c:when test="${(itemUserCardInfo.status==0||itemUserCardInfo.status==9)}">
                                   <td style="white-space:nowrap;padding-left:5px;padding-right:5px;"><a href="javascript:loss('${itemUserCardInfo.cardNo}')" class="pn-loperator">挂失</a></td>             
                                 </c:when>                           
                                   <c:otherwise> 
                                     <c:choose> 
                                       <c:when test="${(itemUserCardInfo.status==1)}">
                                         <td style="white-space:nowrap;padding-left:5px;padding-right:5px;"><a href="javascript:removeLoss('${itemUserCardInfo.cardNo}')" class="pn-loperator">解挂</a></td>              
                                       </c:when>                           
                                        <c:otherwise> 
                                           <td></td>
                                        </c:otherwise>                            
                                   </c:choose>
                                 </c:otherwise>                            
                            </c:choose>
							
                        
                            
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>