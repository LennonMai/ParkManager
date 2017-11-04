 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title></title>
		<%@include file="../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
        <script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>		
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>						
		<script type="text/javascript">		 
		function check(){
		}
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="carSpaceDynamic_save.do" onsubmit="return check();" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    <tr>					    
						<td  class="pn-flabel pn-flabel-h">ͣ������ţ�</td>
						<td  colspan="3" class="pn-fcontent"> <input type="text" name="carSpaceDynamic.parkNo" value="${carSpaceDynamic.parkNo}" class="required maxlengthTen" >&nbsp;<font style="color:red">*</font></td>																			 					
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">�ܳ�λ����</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.totalSpace" value="${carSpaceDynamic.totalSpace}" class="required number isNo_NotOverValueInt">&nbsp;<font style="color:red">*</font></td>
						<td  class="pn-flabel pn-flabel-h">��ǰ�ճ�λ����</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.currentEmptySpace" value="${carSpaceDynamic.currentEmptySpace}" class="required number isNo_NotOverValueInt" >&nbsp;<font style="color:red">*</font></td>																					 					
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">�±���λ����</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.monthlyRentSpace" value="${carSpaceDynamic.monthlyRentSpace}" class="required number isNo_NotOverValueInt" >&nbsp;<font style="color:red">*</font></td>
						<td  class="pn-flabel pn-flabel-h">�ٱ���λ����</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.temporarySpace" value="${carSpaceDynamic.temporarySpace}" class="required number isNo_NotOverValueInt" >&nbsp;<font style="color:red">*</font></td>																				 					
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">������������</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.inParkTotal" value="${carSpaceDynamic.inParkTotal}" class="required number isNo_NotOverValueInt" >&nbsp;<font style="color:red">*</font></td>
					    <td  class="pn-flabel pn-flabel-h">������������</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.outParkTotal" value="${carSpaceDynamic.outParkTotal}" class="required number isNo_NotOverValueInt">&nbsp;<font style="color:red">*</font></td>																								 					
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">�±�����������</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.monthlyRentInPark" value="${carSpaceDynamic.monthlyRentInPark}" class="required number isNo_NotOverValueInt">&nbsp;<font style="color:red">*</font></td>
						<td  class="pn-flabel pn-flabel-h">�±�����������</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.monthlyRentOutPark" value="${carSpaceDynamic.monthlyRentOutPark}" class="required number isNo_NotOverValueInt" >&nbsp;<font style="color:red">*</font></td>																					 					
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">�ٱ�����������</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.temporaryInPark" value="${carSpaceDynamic.temporaryInPark}" class="required number isNo_NotOverValueInt">&nbsp;<font style="color:red">*</font></td>
						<td  class="pn-flabel pn-flabel-h">�ٱ�����������</td>
						<td  class="pn-fcontent"> <input type="text" name="carSpaceDynamic.temporaryOutPark" value="${carSpaceDynamic.temporaryOutPark}" class="required number isNo_NotOverValueInt" >&nbsp;<font style="color:red">*</font></td>																					 					
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" ���" />&nbsp;								
						<input type="reset" value=" �� �� "/>&nbsp;
						<input type="button" value=" �� �� " onclick="history.back();"/>	
						</td>
					</tr>
				</table>				
			</form> 
		</div>
	</body>
</html>