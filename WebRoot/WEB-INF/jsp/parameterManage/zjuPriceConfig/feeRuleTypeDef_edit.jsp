<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>�޸��շ�����</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		 //jquery�첽��֤����������Ƿ����
	    function ishasName() {
	    	var _name = $("#_name").val();
	    	jQuery.post("zjuPriceConfig_ishasName.do?feeRuleTypeDef.name="+_name, function(data){
	    		if(data == "hasName") {
	    			alert("����������Ѵ��ڣ�");
	    			$("#_name").val("");
		    		$("#_name").focus();
		    		
	    		}	
	    	});
	    }
		function back(){
			window.location.href = "zjuPriceConfig_feeRuleTypeDef_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_updateFeeRuleTypeDef.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<td style="width: 430px;" class="pn-fcontent">${feeRuleTypeDef.feeRuleType}<input readonly="readonly" type="hidden" name="feeRuleTypeDef.feeRuleType" value="${feeRuleTypeDef.feeRuleType}" size="28" /></td>
						<td class="pn-flabel pn-flabel-h">�����������</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength20" id="_name" name="feeRuleTypeDef.name" value="${feeRuleTypeDef.name}" size="28" onblur="ishasName();"/><span style="color: red">&nbsp;*</span></td>
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