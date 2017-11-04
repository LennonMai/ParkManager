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
		  function back(){
				window.location.href = "parkCard_queryToPayment.do";
			}
				
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm" method="post" action="parkCard_queryUserCardBill.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">卡表面号：</td>
						<td  class="pn-fcontent"> <input type="text" name="userCardInfo.cardNo" value="${userCardInfo.cardNo}" /></td>						
						<td  class="pn-flabel pn-flabel-h">车牌号码：</td>
						<td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate"  value="${userCardInfo.vehPlate}"/></td>
					</tr>
					<tr>					  
						<td  class="pn-flabel pn-flabel-h">用户姓名：</td>				
						<td   class="pn-fcontent"> <input type="text" name="userCardInfo.owner"  value="${userCardInfo.owner}"/></td>				
						<td  class="pn-flabel pn-flabel-h">缴费总金额：</td>				
						<td   class="pn-fcontent"> <input type="text" name="sumMoney"  value="${sumMoney}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>						
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" 查 询 " />&nbsp;
						<input type="reset" value=" 重 置 "/>	&nbsp;
						<input type="button" value=" 返 回 " onclick="return back();"/>					
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
					    <th>用户姓名</th>
					    <th>卡表面号</th>
					    <th>车牌号码</th>			           						
						<th>缴费时间</th>
						<th>缴费启用时间</th>						
						<th>缴费结束时间</th>
						<th>缴费数量</th>
						<th>缴费总金额</th>						
						<th>费率版本</th>					
						<th>费率编号</th>									 
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0].owner}</td>
							<td>${item[0].cardNo}</td>						
							<td>${item[0].vehPlate}</td>
							<td><fmt:formatDate value="${item[1].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>												
							<td>${item[1].startTime}</td>
							<td>${item[1].endTime}</td>
							<td>${item[1].amount}</td>
							<td>${item[1].money}</td>
							<td>${item[1].version}</td>
							<td>${item[1].rateRecNo}</td>							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>