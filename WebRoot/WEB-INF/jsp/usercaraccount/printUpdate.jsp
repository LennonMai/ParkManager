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
							<input type="text" value=" 更改帐号信息回执 " style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/> &nbsp;
					</td>
					</tr>
					</table>  
				                                     
				<table width="700" class="pn-ftable" cellpadding="0" cellspacing="0" border="1" height="345" align="center">
					
					
					<tr>
					  <td class="pn-flabel pn-flabel-h">账&nbsp;&nbsp;&nbsp;&nbsp;号</td>
					  <td class="pn-fcontent"><input type="text"  value="${accountTemp.sys_id}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">更改时间</td>
					   <td class="pn-fcontent"><input type="text"  value="<fmt:formatDate value="${updateAccountLog.updateTime}" pattern="yyyy-MM-dd HH:mm:ss" />" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						
					</tr>
					
					
					<tr>
					   
					   <td class="pn-flabel pn-flabel-h">用户名称</td>
					   <td class="pn-fcontent"><input type="text" name="userTemp.userName" value="${userTemp.userName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    <td class="pn-flabel pn-flabel-h">车&nbsp;牌&nbsp;号</td>
					   <td class="pn-fcontent"><input type="text" name="carTemp.vehPlate" value="${carTemp.vehPlate}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					
					 </tr>
					 <tr>
					    <td class="pn-flabel pn-flabel-h">证件类型</td>
					    <c:if test="${userTemp.credentialsType==0}"><td class="pn-fcontent"><input type="text" value="身份证" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${userTemp.credentialsType==1}"><td class="pn-fcontent"><input type="text" value="其他" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <td class="pn-flabel pn-flabel-h">证件号码</td>
					    <td class="pn-fcontent"><input type="text" name="userTemp.credentialsNo" value="${userTemp.credentialsNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					  <tr>
					   <td class="pn-flabel pn-flabel-h">联系电话</td>
					   <td class="pn-fcontent"><input type="text" name="userTemp.phone" value="${userTemp.phone}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">手机号码</td>
					   <td class="pn-fcontent"><input type="text" name="userTemp.mobileNumber" value="${userTemp.mobileNumber}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>					
					 <tr>
					  <td class="pn-flabel pn-flabel-h">联系地址</td>
					    <td colspan="3" class="pn-fcontent"><input type="text" name="userTemp.address"   value="${userTemp.address}" size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					 </tr>	
					 
					  
					<tr>
					   <td class="pn-flabel pn-flabel-h">车辆类型</td>
					  <c:if test="${carTemp.carType==1}"><td colspan="3" class="pn-fcontent"><input type="text" name="carTemp.carType" value="小轿车、吉普车、的士头人货车、摩托车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${carTemp.carType==2}"><td colspan="3" class="pn-fcontent"><input type="text" name="carTemp.carType" value="面包车、小型人货车、轻型货车、小型客车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${carTemp.carType==3}"><td colspan="3" class="pn-fcontent"><input type="text" name="carTemp.carType" value="中型客车、大型客车、中型货车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					      <c:if test="${carTemp.carType==4}"><td colspan="3" class="pn-fcontent"><input type="text" name="carTemp.carType" value="大型客车、大型货车、大型拖（挂）车、20英尺集装箱车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
				           <c:if test="${carTemp.carType==5}"><td colspan="3" class="pn-fcontent"><input type="text" name="carTemp.carType" value="重型货车、重型拖（挂）车、40英尺集装箱车"  size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     															
						
					  </tr>
					  <tr>
					  <td class="pn-flabel pn-flabel-h">车&nbsp;颜&nbsp;色</td>
					   <td class="pn-fcontent"><input type="text" name="carTemp.carColour" value="${carTemp.carColour}" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">账号状态</td>
					    <c:if test="${accountTemp.status==0}"><td class="pn-fcontent"><input type="text" value="有效" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${accountTemp.status==1}"><td class="pn-fcontent"><input type="text" value="挂失" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${accountTemp.status==2}"><td class="pn-fcontent"><input type="text" value="预销户" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${accountTemp.status==3}"><td class="pn-fcontent"><input type="text" value="余额不足" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${accountTemp.status==4}"><td class="pn-fcontent"><input type="text" value="其他" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${accountTemp.status==5}"><td class="pn-fcontent"><input type="text" value="已销户" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${accountTemp.status==6}"><td class="pn-fcontent"><input type="text" value="余额过低" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${accountTemp.status==7}"><td class="pn-fcontent"><input type="text" value="黑名单" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					   </tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;&nbsp;&nbsp;号</td>
					   <td class="pn-fcontent"><input type="text" name="accountTemp.cardNo" value="${accountTemp.cardNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">工本费（元）</td>
					   <td class="pn-fcontent"><input type="text" name="accountTemp.cost" value="<fmt:formatNumber value="${accountTemp.cost/100}" pattern="#.##" type="number"/>" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">操&nbsp;作&nbsp;员</td>
					   <td  class="pn-fcontent"><input type="text"  value="${operator.name}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   <td class="pn-flabel pn-flabel-h">开户时间</td>
					   <td class="pn-fcontent"><input type="text"  value="<fmt:formatDate value="${accountTemp.openAccountTime}" pattern="yyyy-MM-dd HH:mm:ss" />" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;注</td>
					  <td colspan="3" class="pn-fcontent"><input type="text" name="accountTemp.remark" value="${accountTemp.remark}" size="77" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>	
					<!--endprint-->
					<tr>
						<td class="pn-fbutton"></td>
						<td colspan="3" class="pn-fbutton"><input type="button"   value=" 打印回执 " onclick="doPrint();"/></td>
                        
                       
					</tr>
					</table>
  </body>
</html>
