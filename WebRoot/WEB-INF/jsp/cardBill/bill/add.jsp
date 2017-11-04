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
			if((document.getElementsByName("billStorage.hankNo")[0].value).trim()!=""){			 
				var v="succuss";
				var val=(document.getElementsByName("billStorage.hankNo")[0].value).trim();			  
			    jQuery.ajax({type:"post",url:"bill_getBillStorageByHankNo.do?billStorage.hankNo="+val,async:false, success:function(data,textStatus){			    
			    if(data=="fail"){v="fail";alert("��Ʊ�ݺ��Ѵ��ڣ�����������."); }			   
				 }
				 });				 					 
				 if(v=="fail"){document.getElementsByName("billStorage.hankNo")[0].focus();return false;}
				 }				 			
			 
		}     

		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="bill_addEdit.do" onsubmit="return check();">  				   
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" height="200">					 					
					<tr>
					  <td class="pn-flabel pn-flabel-h">Ʊ�ݺţ�</td>
					  <td   class="pn-fcontent"><input type="text" name="billStorage.hankNo"  class="required digits max2147483647" />&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">���ͣ�</td>
					  <td   class="pn-fcontent">
					        <select name="billStorage.billType" style="width:150px">							
							    <option value="1" <c:if test="${billStorage.billType==1}">selected</c:if>>��˺Ʊ</option>
								<option value="2" <c:if test="${billStorage.billType==2}">selected</c:if>>�� &nbsp;Ʊ </option>
							</select>
					 </td>					 
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">��ʼƱ�ݺţ�</td>
					   <td class="pn-fcontent"><input type="text" name="billStorage.startBillNo"  class="required digits max2147483647"/>&nbsp;<font style="color:red">*</font></td>
					   <td class="pn-flabel pn-flabel-h">����Ʊ�ݺţ�</td>
					   <td class="pn-fcontent"><input type="text" name="billStorage.endBillNo" class=" required digits max2147483647"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">Ʊ��������</td>
					   <td class="pn-fcontent"><input type="text" name="billStorage.amount" class=" required digits max2147483647"/>&nbsp;<font style="color:red">*</font></td>
					   <td class="pn-flabel pn-flabel-h">Ʊ�ݴ��룺</td>
					   <td class="pn-fcontent"><input type="text" name="billStorage.billHead" class="required maxlengthTen"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� �� "/> &nbsp;
						<input type="reset" value=" �� �� "/>	&nbsp;
						<input type="button" value=" �� �� " onclick="history.back();"/>
						</td>
					</tr>
					
			</table>
					
			</form>
		</div>
	</body>
</html>
