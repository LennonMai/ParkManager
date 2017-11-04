<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>��ӳ�����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
			//��֤���б����Ƿ����
		    function ishasCityNo() {
		    	var cityNo = $("#cityNo").val();
		    	jQuery.post("baseInfo_ishasCityNo.do?cityInformation.cityNo="+cityNo, function(data){
		    		if(data == "hasCityNo") {
		    			$("#cityNo").val("");
			    		$("#cityNo").focus();
		    			alert("���б����Ѵ��ڣ�");
		    		
		    		}	
		    	});
		    }
		    //caijunhua jquery�첽��֤�������Ƿ����
		    function getCityByName() {
		    	var cityName = $("#cityName").val();
		    	jQuery.post("baseInfo_getCityByName.do?cityInformation.cityName="+cityName, function(data){
		    		if(data == "fail") {
		    			$("#cityName").val("");
			    		$("#cityName").focus();
		    			alert("���������Ѵ��ڣ�");
		    		
		    		}	
		    	});
		    }
		    
			//������ҳ 
			function back(){
				window.location.href = "baseInfo_city_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_saveCityInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">���б��룺</td>
						<td width="80%" class="pn-fcontent"><input type="text" id="cityNo" class="required isNo_NotOverValue" name="cityInformation.cityNo" value="${cityInformation.cityNo}" size="28" onblur="ishasCityNo();"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td width="80%" class="pn-fcontent"><input type="text" id="cityName" class="required maxlength20" name="cityInformation.cityName" value="${cityInformation.cityName}" onblur="getCityByName();" size="28"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;ע��</td>
						<td width="80%" class="pn-fcontent">
						<textarea class="maxlength100" name="cityInformation.remark" rows="3" cols="40">${cityInformation.remark}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
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