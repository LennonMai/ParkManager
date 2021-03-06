<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>添加身份卡黑名单</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		
		<script type="text/javascript">
		 function ishasOPCardNo() {
		    	var OPcardNo = $("#OPcardNo").val().trim();
		    	jQuery.post("cardInfo_ishasOPCardNo.do?opCardBlackList.cardNo="+OPcardNo, function(data){
		    		if(data == "hasOPCardNo") {
		    			alert("身份卡编码已存在！");
		    			$("#OPcardNo").val("");
			    		$("#OPcardNo").focus();
		    		}	
		    	});
		    }
		function back(){
			window.location.href = "cardInfo_opCardBlackList_list.do";
			}

	
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="cardInfo_saveOpCardBlackList.do" >
				<table  width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">身份卡编码：</td>
						<td colspan="4" class="pn-fcontent"><input id="OPcardNo" type="text" class="required isNo cardNomaxlength20" name="opCardBlackList.cardNo" value="${opCardBlackList.cardNo}" size="28" onblur="ishasOPCardNo();"/><span style="color: red">&nbsp;*</span></td>
				    </tr>
	     			<tr>
					    <td class="pn-flabel pn-flabel-h">失效&nbsp;&nbsp;原因：</td>
						<td class="pn-fcontent"><select class="required " name="opCardBlackList.inValidTypeNo" style="width: 207px;">
						<option value="">- 请选择 -</option>
						<option value="1">挂失卡</option>
						<option value="2">注销卡</option>
						<option value="3">伪卡</option>
						<option value="4">止付卡</option>
						</select><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">生成日期：</td>
						<td class="pn-fcontent"><input style="width: 202px;" type="text" class="required " name="opCardBlackList.opTime" value="<fmt:formatDate value="${opCardBlackList.opTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" /><span style="color: red">&nbsp;*</span></td>
				    </tr> 
				    <tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/>&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>

	</body>
</html>