<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>�޸ĳ�����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
			<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
		if("${message}"=="exitIP"){
			alert("�����IP��ַ�Ѵ��ڣ�");
			}
			function back(){
				window.location.href = "baseInfo_lane_list.do";
				}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateLaneInfo.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	<tr>
						<td class="pn-flabel pn-flabel-h">������룺</td>
						<td style="width: 430px;" class="pn-fcontent">${laneInformation.areaNo}<input readonly="readonly"  type="hidden" name="laneInformation.areaNo" value="${laneInformation.areaNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">С�����룺</td>
						<td style="width: 430px;" class="pn-fcontent">${laneInformation.parkNo}<input readonly="readonly"  type="hidden" name="laneInformation.parkNo" value="${laneInformation.parkNo}" size="28"/></td>
			    		</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">���ű��룺</td>
						<td style="width: 430px;" class="pn-fcontent">${laneInformation.gateNo}<input readonly="readonly"  type="hidden" name="laneInformation.gateNo" value="${laneInformation.gateNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td class="pn-fcontent"><c:if test="${laneInformation.laneTypeNo==null}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" selected="selected">- ��ѡ�� -</option>
			               <option value="1">���</option>
			               <option value="2">����</option>		          
		                </select>
		                </c:if>
		                <c:if test="${laneInformation.laneTypeNo==1}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" >- ��ѡ�� -</option>
			               <option value="1" selected="selected">���</option>
			               <option value="2">����</option>			          
		                </select>
		                </c:if>
		                 <c:if test="${laneInformation.laneTypeNo==2}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" >- ��ѡ�� -</option>
			               <option value="1">���</option>
			               <option value="2" selected="selected">����</option>			          
		                </select>
		                </c:if><span style="color: red">*</span></td>
						</tr>	
			    	 
					<tr>
						<td class="pn-flabel pn-flabel-h">�������룺</td>
						<td style="width: 430px;" class="pn-fcontent">${laneInformation.laneNo}<input readonly="readonly"  type="hidden" name="laneInformation.laneNo" value="${laneInformation.laneNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">���������</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16"  name="laneInformation.laneComputerName" value="${laneInformation.laneComputerName}" size="28"/></td>
						</tr>
					<tr>	
						<td class="pn-flabel pn-flabel-h">�����IP��ַ��</td>
						<td class="pn-fcontent"><input type="text" class="required isIP"  name="laneInformation.laneComputerIp" value="${laneInformation.laneComputerIp}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">���úϼƣ�</td>
						<td class="pn-fcontent">
							<select class="required " name="laneInformation.isUse" style="width: 206px;height: 22px;">
				               <option value="1" <c:if test="${laneInformation.isUse==1}">selected="selected"</c:if>>����</option>
				               <option value="0" <c:if test="${laneInformation.isUse==0}">selected="selected"</c:if>>������</option>			          
			                </select>
							<span style="color: red">&nbsp;*</span>
						</td>
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