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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="tableForm" name="tableForm" method="post" action="parkCard_queryWhite.do" >
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
					    <td  class="pn-flabel pn-flabel-h">卡表面号：</td>
						<td  class="pn-fcontent"> 
							<input type="text" name="cardNo" id="cardNo" value="${cardNo}">
						</td> 
						<td  class="pn-flabel pn-flabel-h">车&nbsp;牌&nbsp;号：</td>
						<td  class="pn-fcontent"> 
							<input type="text" name="vehplate" id="vehplate" value="${vehplate}">
						</td>
																									 					
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">车主姓名：</td>
						<td  class="pn-fcontent"> 
							<input type="text" name="ownerName" id="ownerName" value="${ownerName}">
						</td>	
						<td  class="pn-flabel pn-flabel-h">OBU&nbsp;&nbsp;&nbsp;号：</td>
						<td  class="pn-fcontent"> 
							<input type="text" name="obuId" id="obuId" value="${obuId}">
						</td>
																										 					
					</tr>
					<tr>
					<td  class="pn-flabel pn-flabel-h">帐号状态：</td>
						<td  class="pn-fcontent">
							<select name="status" id="status" style="width:150px">
								<option value="" <c:if test="${status==null}">selected</c:if>>请选择</option>
							    <option value="0" <c:if test="${status==0}">selected</c:if>>正常</option>
							    <option value="1" <c:if test="${status==1}">selected</c:if>>挂失</option>
							    <option value="9" <c:if test="${status==9}">selected</c:if>>未缴费</option>  
							</select>
						</td>
					     <td  class="pn-flabel pn-flabel-h">费率类型：</td>
						 <td  class="pn-fcontent" >
							<select name="feeRuleType" id="feeRuleType" style="width:150px">
								<option value="" <c:if test="${feeRuleType==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listFeeRuleTypeDef}" var="item">
									<option value="${item.feeRuleType}" <c:if test="${feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
							   </c:forEach>  
							</select>
					    </td>							 
						
					</tr>
					<tr>
						<td  class="pn-flabel pn-flabel-h">用户卡类型：</td>
						<td   class="pn-fcontent">
							<select name="cardType" id="cardType" style="width:150px">
								<option value="" <c:if test="${cardType==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${userCardTypeList}" var="item">
									<option value="${item.userCardType}" <c:if test="${cardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
							</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">是否有图片：</td>
						<td  class="pn-fcontent">
							<select name="isImage" id="isImage" style="width:150px">
								<option value="" <c:if test="${isImage==null}">selected</c:if>>请选择</option>
							    <option value="0" <c:if test="${isImage==0}">selected</c:if>>无</option>
							    <option value="1" <c:if test="${isImage==1}">selected</c:if>>有</option>  
							</select>
						</td>																				 					
					</tr>																			 					
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit"   value=" 查 询 " />&nbsp;					
							<input type="reset" value=" 重 置 "/>&nbsp;
							<input type="button" value=" 导 出 " onclick="doExport('a.php');"/>&nbsp;					
							<input type="button" value=" 打 印 " onclick="doPrint();"/>
						</td>
					</tr>
				</table>
				<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>卡表面号</th>
						<th>车 牌 号</th>
						<th>车主姓名</th>
						<th>OBU  号</th>
						<th>帐号状态</th>
						<th>用户卡类型</th>
						<th>费率类型</th>
						<th>启用时间</th>
						<th>结束时间</th>	
						
							
						<th>是否有图片</th>
							
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
								<c:if test="${item[7]==0}">正常</c:if>
								<c:if test="${item[7]==1}">挂失</c:if>
								<c:if test="${item[7]==9}">未缴费</c:if>
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
								<c:if test="${item[8]==0}">无</c:if>
								<c:if test="${item[8]==1}">有</c:if>
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