 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
	<head>
		<title></title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">		
		</script>		
		
		<script type="text/javascript">
		function getCarSmallType(){
			var carType = document.getElementsByName("userCardInfo.carType")[0].value; 
			$.ajax({
				type:"post",
				url:"parkCard_findCarSmallType.do?carType="+carType,
				success:function(res){
					$("#parkingSpace").empty();
					var op = $("<option value=''>��ѡ��</option>");		
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryUserCardInfoHistory.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
					    <td  class="pn-flabel pn-flabel-h">�û���ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="userCardInfo.recNO" value="${userCardInfo.recNO}" /></td>
						<td  class="pn-flabel pn-flabel-h">������ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="userCardInfo.cardNo" value="${userCardInfo.cardNo}" /></td>
						
					</tr>					 
					<tr>
					    <td  class="pn-flabel pn-flabel-h">��&nbsp;״&nbsp;̬��</td>
						<td  class="pn-fcontent">
						<select name="userCardInfo.status" style="width:150px">
								<option value="" <c:if test="${userCardInfo.status==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${userCardInfo.status==0}">selected</c:if>>����</option>
								<option value="1" <c:if test="${userCardInfo.status==1}">selected</c:if>>��ʧ </option>
								<option value="9" <c:if test="${userCardInfo.status==9}">selected</c:if>>δ�ɷ� </option>
						</select>	
						</td>
						<td  class="pn-flabel pn-flabel-h">�û����ͣ�</td>
						<td  class="pn-fcontent">
						<select name="userCardInfo.userCardType" style="width:150px">
								<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listUserCardType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>
						</td>
					</tr>
					<tr>
					  
						<td  class="pn-flabel pn-flabel-h">����������</td>				
						<td   class="pn-fcontent"> <input type="text" name="userCardInfo.owner"  value="${userCardInfo.owner}"/></td>				
						<td  class="pn-flabel pn-flabel-h">���ƺ��룺</td>
						<td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate"  value="${userCardInfo.vehPlate}"/></td>
					</tr>
					 <c:if test="${param_whtherPayType.pvalue!=1}">					
					<tr>						
					    <td   class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<td    class="pn-fcontent"> 
					     <select name="userCardInfo.feeRuleType" style="width:150px">
								<option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listFeeRuleTypeDef}" var="item">
								<option value="${item.feeRuleType}" <c:if test="${userCardInfo.feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
							   </c:forEach>  
						</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">�޸�ʱ�䣺</td>						
						<td   class="pn-fcontent">
						  <input type="text" name="modifyTime"  value="${modifyTime}"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
						<%--<input type="text" name="payEndTime"  value="${payEndTime}" style="display: " s class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>						
					--%>
					</td>
					</tr>
					</c:if>	
					
					<tr>						
						<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td class="pn-fcontent">
							<select name="userCardInfo.carType" style="width:150px" onchange="getCarSmallType()">
								<option value="" <c:if test="${userCardInfo.carType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listCarType}" var="item">
									<option value="${item.carType}" <c:if test="${userCardInfo.carType==item.carType}">selected</c:if>>${item.carTypeName}</option>
								</c:forEach>  
						</select>
						</td>
						 <td class="pn-flabel pn-flabel-h">ͣ&nbsp;��&nbsp;λ��</td>
					   	 <td class="pn-fcontent">
							<select name="userCardInfo.parkingSpace" id="parkingSpace" style="width:150px" >
								<option value=""  <c:if test="${userCardInfo.parkingSpace==null}">selected</c:if>>��ѡ��</option>
								<c:forEach items="${listCarSmallTypeInCarType}" var="CarSmallType">
									<option value="${CarSmallType.carSmallType}" 
									  <c:if test="${userCardInfo.parkingSpace==CarSmallType.carSmallType}">selected</c:if>>${CarSmallType.carSmallName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<td class="pn-flabel pn-flabel-h">������ݣ�</td>
						<td class="pn-fcontent">
							<select name="userCardInfo.ownerIdentity"  style="width:150px">
								<option value="">��ѡ��</option>
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
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="reset" value=" �� �� "/>
						
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��״̬</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���֤����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ƶ��绰</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ƺ���</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">OBU��</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�޸�ʱ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ͣ��λ</th>
						 <c:if test="${param_whtherPayType.pvalue!=1}">
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շ�����</th>
						</c:if>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û�סַ</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>

					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${listUserCardInfoHistory}" var="itemUserCardInfoHistory">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${itemUserCardInfoHistory[0]}</td>
							<td>${itemUserCardInfoHistory[9]}</td>	
							<td><c:if test="${itemUserCardInfoHistory[7]==0}">����</c:if><c:if test="${itemUserCardInfoHistory[7]==1}">��ʧ</c:if><c:if test="${itemUserCardInfoHistory[7]==9}">δ�ɷ�</c:if></td>						
							<td>${itemUserCardInfoHistory[1]}</td>
							<td>
								<c:forEach items="${listIdentity}" var="identity">
									<c:if test="${itemUserCardInfoHistory[22]==identity.identityType}">${identity.identityName}</c:if>
								</c:forEach>
							</td>
							<td>${itemUserCardInfoHistory[2]}</td>
							<td>${itemUserCardInfoHistory[16]}</td>
							<td>${itemUserCardInfoHistory[3]}</td>
							<td>${itemUserCardInfoHistory[5]}</td>							
							<td>
							 <c:forEach items="${listUserCardType}" var="itemlistUserCardType"><c:if test="${itemUserCardInfoHistory[10]==itemlistUserCardType.userCardType}">${itemlistUserCardType.typeName}</c:if></c:forEach>
                            </td>                            	                           
                            <td>${itemUserCardInfoHistory[11]}</td> 
                            <td>
                           		 <c:forEach items="${listCarType}" var="itemlistCarType">
									<c:if test="${itemlistCarType.carType==itemUserCardInfoHistory[23]}">${itemlistCarType.carTypeName}</c:if>
								 </c:forEach>
                            </td> 
                            <td>
                            	<c:forEach items="${listCarSmallType}" var="CarSmallType">
										<c:if test="${itemUserCardInfoHistory[23]==CarSmallType.carType && itemUserCardInfoHistory[4]==CarSmallType.carSmallType}">${CarSmallType.carSmallName}</c:if>
								</c:forEach>
                            </td>                                                                                      									
							<c:if test="${param_whtherPayType.pvalue!=1}">
							<td><c:forEach items="${listFeeRuleTypeDef}" var="itemFeeRuleTypeDef"><c:if test="${itemUserCardInfoHistory[12]==itemFeeRuleTypeDef.feeRuleType}">${itemFeeRuleTypeDef.name}</c:if></c:forEach></td>					
							</c:if>						
							<td><input type="text"  value="${itemUserCardInfoHistory[17]}" size="25" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
                            <td style="white-space:nowrap;padding-left:5px;padding-right:5px;"><a href="parkCard_showUserCardInfoHistory.do?userCardInfo.recNO=${itemUserCardInfoHistory[0]}&modifyTime=${itemUserCardInfoHistory[11]}" class="pn-loperator">��ϸ��Ϣ</a></td>                           
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>