<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>�޸�λ����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
			function back(){
				window.location.href = "baseInfo_position_list.do";
				}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updatePositionInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                     <tr>
						<td class="pn-flabel pn-flabel-h">λ�ñ��룺</td>
						<td class="pn-fcontent">${positionInformation.no}<input type="hidden" readonly="readonly" name="positionInformation.no" value="${positionInformation.no}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</td>
						<td class="pn-fcontent"><c:if test="${positionInformation.class_==null}">
						<select class="required"  name="positionInformation.class_" style="width: 206px;height: 22px;">
						   <option value="" selected="selected">��ѡ��</option>    		          
		                </select>
		                </c:if>
		                <c:if test="${positionInformation.class_==1}">
						<select class="required"  name="positionInformation.class_" style="width: 206px;height: 22px;">
			               <option value="1" selected="selected">����</option>			              	          
		                </select>
		                </c:if>
		                <c:if test="${positionInformation.class_==2}">
						<select class="required"  name="positionInformation.class_" style="width: 206px;height: 22px;">  
			               <option value="2" selected="selected">վ�����ţ�</option>			          
		                </select>
		                </c:if>
		                <c:if test="${positionInformation.class_==3}">
						<select class="required"  name="positionInformation.class_" style="width: 206px;height: 22px;">
			               <option value="3" selected="selected">����</option>         
		                </select>
		                </c:if>
		                <c:if test="${positionInformation.class_==9}">
						<select class="required"  name="positionInformation.class_" style="width: 206px;height: 22px;">
			               <option value="9" selected="selected">����</option>			          
		                </select>
		                </c:if>
		                <span style="color: red">&nbsp;*</span></td></tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">λ�����ƣ�</td>
						<td class="pn-fcontent"><input type="text" class="maxlength20" name="positionInformation.name" value="${positionInformation.name}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">Ψһ��ţ�</td>
						<td class="pn-fcontent">${positionInformation.iid}<input type="hidden"  name="positionInformation.iid" value="${positionInformation.iid}" size="28"/></td>
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