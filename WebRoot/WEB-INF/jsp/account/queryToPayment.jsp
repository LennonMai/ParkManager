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
				alert("没有此账户交易信息，请重新输入");
				if("${result}"=="FAIL1")
				alert("账号状态为挂失，不能充值");
				if("${result}"=="FAIL2")
				alert("账号状态为预销户，不能充值");
				if("${result}"=="FAIL3")
				alert("账号状态为其他，不能充值");
				if("${result}"=="FAIL4")
				alert("账号状态为已销户，不能充值");
				if("${result}"=="FAIL5")
				alert("此记录已被冲正过，不能再冲正");
			
			 
		       function check(){
		         if(get("account.sys_id").value!=""){
				var partten = /^\+?[0-9][0-9]*$/;
				if(partten.test(get("account.sys_id").value)){
				
               
                 }else{
                   alert("用户账号为数字，请重新输入！");
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="account_queryAccountToPayment.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">用户账号：</td>
						<td  class="pn-fcontent"> <input type="text" name="account.sys_id" value="${account.sys_id}" /></td>
						<td  class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
						<td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}" /></td>
					</tr>
					 
					<tr>
						
						<td  class="pn-flabel pn-flabel-h">用&nbsp;户&nbsp;名：</td>
						<td class="pn-fcontent"><input type="text" name="user.userName"  value="${user.userName}"/></td>
							<td   class="pn-flabel pn-flabel-h">车&nbsp;牌&nbsp;号：</td>
						<td   class="pn-fcontent"> <input type="text" name="car.vehPlate"  value="${car.vehPlate}"/></td>
						
					</tr>
					<tr>
						<td  class="pn-flabel pn-flabel-h">账号状态：</td>
						<td  class="pn-fcontent"> 
						  <select name="account.status" style="width:150px">
								<option value="" <c:if test="${account.status==null}">selected</c:if>>请选择</option>
							    <option value="0" <c:if test="${account.status==0}">selected</c:if>>有效</option>
								<option value="1" <c:if test="${account.status==1}">selected</c:if>>挂失 </option>
								<option value="2" <c:if test="${account.status==2}">selected</c:if>>预销户</option>							  
								<option value="5" <c:if test="${account.status==5}">selected</c:if>>已销户</option>							
								<option value="7" <c:if test="${account.status==7}">selected</c:if>>黑名单</option>
								<option value="4" <c:if test="${account.status==4}">selected</c:if>>其他 </option>
							</select>			
						 
						</td>
						<td  class="pn-flabel pn-flabel-h">证件号码：</td>
						<td class="pn-fcontent"><input type="text" name="user.credentialsNo"  value="${user.credentialsNo}"/></td>
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
						<th>用户帐号</th>
						<th>卡&nbsp;&nbsp;号</th>						
						<th>用户名&nbsp;&nbsp;</th>
						<th>证件类型</th>
						<th>证件号码</th>						
						<th>车牌号&nbsp;&nbsp;</th>											
						<th>账号状态</th>
						<th>余额情况</th>	
						<th>余额（元）</th>
						<th>操&nbsp;&nbsp;作</th>
						

					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.sys_id}</td>
							<td>${item.cardNo}</td>
							
							<td>${item.user.userName}</td>
							<td><c:if test="${item.user.credentialsType==0}">身份证</c:if><c:if test="${item.user.credentialsType==1}">其&nbsp;&nbsp;他</c:if></td>
							<td>${item.user.credentialsNo}</td>
						
							<td>${item.car.vehPlate}</td>
							
							<td><c:if test="${item.status==0}">有效</c:if><c:if test="${item.status==1}">挂失</c:if><c:if test="${item.status==2}">预销户</c:if><c:if test="${item.status==4}">其他</c:if><c:if test="${item.status==5}">已销户</c:if><c:if test="${item.status==7}">黑名单</c:if></td>
							<td><c:if test="${item.balance<item.noEntryBalance&&item.status!=5}">余额不足</c:if><c:if test="${item.balance>=item.noEntryBalance&&item.balance<item.lowBalanceNotice&&item.status!=5}">余额过低</c:if><c:if test="${item.balance>=item.lowBalanceNotice&&item.status!=5}">正常</c:if></td>
							<td><fmt:formatNumber value="${item.balance/100}" pattern="#.##" type="number"/>元</td>
							<c:choose> 
                            <c:when test="${item.status==0}"> 
                               <td><a href="account_payment.do?account.sys_id=${item.sys_id}" class="pn-loperator">充值</a></td>
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






































