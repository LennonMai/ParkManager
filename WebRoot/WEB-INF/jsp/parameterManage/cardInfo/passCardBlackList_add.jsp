<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>���ͨ�п�������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		
		<script type="text/javascript">
		 function ishasCardNo() {
		    	var cardNo = $("#cardNo").val().trim();
		    	jQuery.post("cardInfo_ishasCardNo.do?passCardBlackList.cardNo="+cardNo, function(data){
		    		if(data == "hasCardNo") {
		    			alert("ͨ�п������Ѵ��ڣ�");
		    			$("#cardNo").val("");
			    		$("#cardNo").focus();
		    		}	
		    	});
		    }
		function back(){
			window.location.href = "cardInfo_passCardBlackList_list.do";
			}

		
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="cardInfo_savePassCardBlackList.do" >
				<table  width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">ͨ�п����룺</td>
						<td colspan="4" class="pn-fcontent"><input id="cardNo" type="text" class="required isNo cardNomaxlength20" name="passCardBlackList.cardNo" value="${passCardBlackList.cardNo}" size="28" onblur="ishasCardNo();"/><span style="color: red">&nbsp;*</span></td>
				    </tr>
	     			<tr>
					    <td class="pn-flabel pn-flabel-h">ʧЧ&nbsp;&nbsp;ԭ��</td>
						<td class="pn-fcontent"><select class="required " name="passCardBlackList.inValidTypeNo" style="width: 207px;">
						<option value="">- ��ѡ�� -</option>
						<option value="1">��ʧ��</option>
						<option value="2">ע����</option>
						<option value="3">α��</option>
						<option value="4">ֹ����</option>
						</select><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">�������ڣ�</td>
						<td class="pn-fcontent"><input style="width: 202px;" type="text" class="required " name="passCardBlackList.opTime" value="<fmt:formatDate value="${passCardBlackList.opTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/><span style="color: red">&nbsp;*</span></td>
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