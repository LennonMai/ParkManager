<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>��ӳ�λ��Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
			if("${message}"=="hascarSpace"){
				alert("�Ѵ��ڸ�С�����ŵĳ�λ��Ϣ��");
		 	}
			function back(){
				window.location.href = "baseInfo_carSpace_list.do";
			}			
			function check(){
				if(document.getElementById('maxSpace').value==""){
					alert("���λ������Ϊ��");
					return false;
				}
				if(document.getElementById('carCount').value==""){
					alert("��㳵��������Ϊ��");
					return false;
				}
				if(document.getElementById('criticalNum').value==""){
					alert("��λ�ٽ�ֵ����Ϊ��");
					return false;
				}
				if(parseInt(document.getElementById('carCount').value)>parseInt(document.getElementById('maxSpace').value)){
					alert("��㳵�������ܴ������λ��");
					return false;
				}
				if(parseInt(document.getElementById('criticalNum').value)>parseInt(document.getElementById('maxSpace').value)){
					alert("��λ�ٽ�ֵ���ܴ������λ��");
					return false;
				}
				return true;
			}
			function getGate(){
				(function($) { 
	  				$(function() {
					$.ajax({
						type:"post",
						url:"lostCard_ajaxGate.do?parkNo="+document.getElementById("parkNo").value,
						success:function(res){
							$("#gateNo").empty();
							var op = $("<option value='all'>-all-</option>");		
							$("#gateNo").append(op);
							$(res).find("gates > gate").each(function(){								
							var op = $("<option value=" + $(this).attr("id") + ">" 
									+ $(this).attr("name") + "</option>");
							$("#gateNo").append(op);	
						});
						}
					});
					 });
					})(jQuery);
				}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_savecarSpaceInfo.do" onsubmit="return check()">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">С�����ƣ�</td>
						<td class="pn-fcontent">
							<select name="carSpaceInformation.parkNo" id ="parkNo" onchange="getGate();" style="width:208px" class="required">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${parkList}" var="item">
										<option value="${item.parkNo }"<c:if test="${item.parkNo==carSpaceInformation.parkNo }"> selected="selected" </c:if>>${item.parkName }</option>
									</c:forEach>
							</select><span style="color: red">&nbsp;*</span>
						</td>
			    		<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
							<select name="carSpaceInformation.gateNo" id="gateNo" style="width:208px" class="required">
									<option value="all">-all-</option>									
							</select><span style="color: red">&nbsp;*</span>
						</td>
					    </tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">���λ����</td>
						<td class="pn-fcontent"><input type="text" id="maxSpace" class="required isNo_NotOverValue" name="carSpaceInformation.maxSpace" value="${carSpaceInformation.maxSpace}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">��㳵������</td>
						<td class="pn-fcontent"><input type="text" id="carCount" class="required isNo_NotOverValue" name="carSpaceInformation.carCount" value="${carSpaceInformation.carCount}" size="28"/><span style="color: red">&nbsp;*</span></td>
						
						</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">��λ�ٽ�ֵ��</td>
						<td class="pn-fcontent"><input type="text" id="criticalNum" class="required isNo_NotOverValue" name="carSpaceInformation.criticalNum" value="${carSpaceInformation.criticalNum}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
						<td class="pn-fcontent"><input style="width: 204px;" type="text" class="required" name="carSpaceInformation.modifyTime" value="<fmt:formatDate value="${carSpaceInformation.modifyTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""/><span style="color: red">&nbsp;*</span></td>
					    
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