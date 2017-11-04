 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title></title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
        <script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>		
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
						
		<script type="text/javascript">		 
		function check(){
		  if((document.getElementsByName("idCardInfoTemp.idcardNo")[0].value).trim()!=""){			 
				var v="succuss";
				var val=(document.getElementsByName("idCardInfoTemp.idcardNo")[0].value).trim();			  
			    jQuery.ajax({type:"post",url:"iDCard_checkByidcardNo.do?idCardInfoTemp.idcardNo="+val,async:false, success:function(data,textStatus){			    
			    if(data=="fail"){v="fail";alert("此卡已被运用."); }	
			    if(data=="fail1"){v="fail1";alert("此卡还没登记."); }			   
				 }
				 });				 					 
				 if(v=="fail"||v=="fail1"){document.getElementsByName("idCardInfoTemp.idcardNo")[0].focus();return false;}
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
			<form id="dataform" method="post" action="iDCard_addIDCardInfoEdit.do" onsubmit="return check();" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    <tr>
					    <td  class="pn-flabel pn-flabel-h">姓名：</td>
						<td  class="pn-fcontent"> <input type="text" name="idCardInfoTemp.userName" value="${idCardInfoTemp.userName}" class="required maxlengthSixteen">&nbsp;<font style="color:red">*</font></td>
						<td  class="pn-flabel pn-flabel-h">卡号：</td>
						<td  class="pn-fcontent"> <input type="text" name="idCardInfoTemp.idcardNo" value="${idCardInfoTemp.idcardNo}" class="required maxlengthTen" >&nbsp;<font style="color:red">*</font></td>																					 					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" 注册 " />&nbsp;								
						<input type="reset" value=" 重 置 "/>&nbsp;
						<input type="button" value=" 返 回 " onclick="history.back();"/>
						
						
						</td>
					</tr>
				</table>
				
			</form> 
		</div>
	</body>
</html>