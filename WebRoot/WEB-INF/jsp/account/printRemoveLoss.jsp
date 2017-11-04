<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
         <script type="text/javascript">
          function doPrint() { 
                      bdhtml=window.document.body.innerHTML; 
                      sprnstr="<!--startprint-->"; 
                      eprnstr="<!--endprint-->"; 
                      prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17); 
                      prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr)); 
                      window.document.body.innerHTML=prnhtml; 
                      window.print(); 
                    }
        
        </script>
         

  </head>
  
  <body>
  <!--startprint-->
   <table width="450" class="pn-ftable" cellpadding="1" cellspacing="1" border="0" height="20" align="center" style="background-color: #FFFFFF;" >
					<tr>
					<td colspan="4" class="pn-fbutton">
							<input type="text" value=" 解挂帐户信息回执 " style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/> &nbsp;
					</td>
					</tr>
					</table>  
				                                     
				<table width="700" class="pn-ftable" cellpadding="0" cellspacing="0" border="1" height="345" align="center">
					
					
					<tr>
					  <td class="pn-flabel pn-flabel-h">账&nbsp;&nbsp;&nbsp;&nbsp;号</td>
					  <td class="pn-fcontent"><input type="text"  value="${account.sys_id}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">解挂时间</td>
					   <td class="pn-fcontent"><input type="text"  value="<fmt:formatDate value="${updateAccountLog.updateTime}" pattern="yyyy-MM-dd HH:mm:ss" />" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						
					</tr>
					
					
					<tr>
					 
					   <td class="pn-flabel pn-flabel-h">用户名称</td>
					   <td class="pn-fcontent"><input type="text" name="user.userName" value="${user.userName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    <td class="pn-flabel pn-flabel-h">车牌号&nbsp;&nbsp;</td>
					   <td class="pn-fcontent"><input type="text" name="car.vehPlate" value="${car.vehPlate}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					 </tr>
					 <tr>
					    <td class="pn-flabel pn-flabel-h">证件类型</td>
					    <c:if test="${user.credentialsType==0}"><td class="pn-fcontent"><input type="text" value="身份证" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${user.credentialsType==1}"><td class="pn-fcontent"><input type="text" value="其他" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <td class="pn-flabel pn-flabel-h">证件号码</td>
					    <td class="pn-fcontent"><input type="text" name="user.credentialsNo" value="${user.credentialsNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					  <tr>
					   <td class="pn-flabel pn-flabel-h">联系电话</td>
					   <td class="pn-fcontent"><input type="text" name="user.phone" value="${user.phone}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">手机号码</td>
					   <td class="pn-fcontent"><input type="text" name="user.mobileNumber" value="${user.mobileNumber}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>					
					 <tr>
					  <td class="pn-flabel pn-flabel-h">联系地址</td>
					    <td colspan="3" class="pn-fcontent"><input type="text" name="user.address"   value="${user.address}" size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					 </tr>	
					
					<tr>
					   <td class="pn-flabel pn-flabel-h">车辆类型</td>
					  <c:if test="${car.carType==1}"><td colspan="3" class="pn-fcontent"><input type="text" name="car.carType" value="小轿车、吉普车、的士头人货车、摩托车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${car.carType==2}"><td colspan="3" class="pn-fcontent"><input type="text" name="car.carType" value="面包车、小型人货车、轻型货车、小型客车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${car.carType==3}"><td colspan="3" class="pn-fcontent"><input type="text" name="car.carType" value="中型客车、大型客车、中型货车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					      <c:if test="${car.carType==4}"><td colspan="3" class="pn-fcontent"><input type="text" name="car.carType" value="大型客车、大型货车、大型拖（挂）车、20英尺集装箱车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
				           <c:if test="${car.carType==5}"><td colspan="3" class="pn-fcontent"><input type="text" name="car.carType" value="重型货车、重型拖（挂）车、40英尺集装箱车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     															
						
					  </tr>
					  <tr>
					  <td class="pn-flabel pn-flabel-h">车颜色&nbsp;&nbsp;</td>
					   <td class="pn-fcontent"><input type="text" name="car.carColour" value="${car.carColour}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">账号状态</td>
					    <c:if test="${account.status==0}"><td class="pn-fcontent"><input type="text" value="有效" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==1}"><td class="pn-fcontent"><input type="text" value="挂失" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==2}"><td class="pn-fcontent"><input type="text" value="预销户" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==3}"><td class="pn-fcontent"><input type="text" value="余额不足" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==4}"><td class="pn-fcontent"><input type="text" value="其他" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==5}"><td class="pn-fcontent"><input type="text" value="已销户" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==6}"><td class="pn-fcontent"><input type="text" value="余额过低" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==7}"><td class="pn-fcontent"><input type="text" value="黑名单" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					   </tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;&nbsp;&nbsp;号</td>
					   <td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">工本费(元）</td>
					   <td class="pn-fcontent"><input type="text" name="account.cost" value="<fmt:formatNumber value="${account.cost/100}" pattern="#.##" type="number"/>" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">操作员&nbsp;&nbsp;</td>
					   <td  class="pn-fcontent"><input type="text"  value="${operator.name}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">开户时间</td>
					   <td class="pn-fcontent"><input type="text"  value="<fmt:formatDate value="${account.openAccountTime}" pattern="yyyy-MM-dd HH:mm:ss" />" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;注</td>
					  <td colspan="3" class="pn-fcontent"><input type="text" name="account.remark" value="${account.remark}" size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<!--endprint-->
					<tr>
						<td class="pn-fbutton"></td>
						<td colspan="3" class="pn-fbutton"><input type="button"   value=" 打印回执 " onclick="doPrint();"/></td>
                        
                       
					</tr>	
					</table>
  </body>
</html>
