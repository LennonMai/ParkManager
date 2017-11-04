<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>�޸ĳ�������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">

		function back(){
			window.location.href = "carType_getCarTypeList.do";
		}	
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="carType_update.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr> 
						<td class="pn-flabel pn-flabel-h" width="20%">�������ͱ��룺</td>
						<td class="pn-fcontent"  width="30%">
							${carType.carType}
							<input type="hidden" name="carType.carType" value="${carType.carType}"/>
						</td>
					    <td class="pn-flabel pn-flabel-h" width="20%">�����������ƣ�</td>
						<td class="pn-fcontent" width="30%">
						<input type="text" class="required maxlength20" name="carType.carTypeName" value="${carType.carTypeName}"/>
						<span style="color: red">&nbsp;*</span></td>
			    	</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� "/>&nbsp;
						    <input type="reset" value=" �� �� "/>&nbsp;
						    <input type="button" value=" �� �� " onclick="return back()"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>