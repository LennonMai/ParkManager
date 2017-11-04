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
							<input type="text" value=" 充值信息回执 " style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/> &nbsp;
					</td>
					</tr>
					</table>  
				                                     
				<table width="700" class="pn-ftable" cellpadding="0" cellspacing="0" border="1" height="200" align="center">
					<tr>
					  <td class="pn-flabel pn-flabel-h"> 账号</td>
					  <td class="pn-fcontent"><input type="text" name="account.sys_id" value="${account.sys_id}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    
					</tr>
					<tr>
					<td class="pn-flabel pn-flabel-h"> 账号序号</td>
					  <td class="pn-fcontent"><input type="text" name="accountTrade.seqNo" value="${accountTrade.seqNo}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					
					
					<tr>
					 <td class="pn-flabel pn-flabel-h">充值前余额（元）</td>
					 <td  class="pn-fcontent"><input type="text" name="account.balance"  value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>"   readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					 <td class="pn-flabel pn-flabel-h">充值金额（元）</td>
					 <td  class="pn-fcontent"><input type="text" name="accountTrade.fee"  value="<fmt:formatNumber value="${accountTrade.fee/100}" pattern="#.##" type="number"/>"   readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					 <td class="pn-flabel pn-flabel-h">充值后余额（元）</td>
					 <td  class="pn-fcontent"><input type="text" name="accountTrade.balance"  value="<fmt:formatNumber value="${accountTrade.balance/100}" pattern="#.##" type="number"/>"   readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
				
					 <td class="pn-flabel pn-flabel-h">充值时间</td>
					 <td  class="pn-fcontent"><input type="text" name="accountTrade.tradeTime" value="${accountTrade.tradeTime}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>
					 <td class="pn-flabel pn-flabel-h">操作员&nbsp;&nbsp;</td>
					   <td   class="pn-fcontent"><input type="text"  value="${operator.name}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<!--endprint-->
					<tr>
						<td class="pn-fbutton"></td>
						<td class="pn-fcontent"><input type="button"   value=" 打印回执 " onclick="doPrint();"/></td>
                        
                       
					</tr>
					</table>
  </body>
</html>
