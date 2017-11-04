<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>�޸Ĺ�����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		var record=null; 
		
		if("${result}" == "FAIL") {
			record="fail";
			alert("���������Ѵ��ڣ�");
		}

		function isTime(str){
			//��ʽΪ�� HH:MM:SS  	
            var a=str.match(/^(\d{1,2})(:)?(\d{1,2})\2(\d{1,2})$/); 
            //alert(a);
            if (a==null){return false;} 
            if (a[1]>24 || a[3]>60 || a[4]>60) {return false;} 
		}
		function GetStringLen(str) { 
			var len=0; 
			for(var i=0;i<str.length;i++) { 
			  char = str.charCodeAt(i); 
			   if(!(char>255)) { 
			     len = len + 1; 
			  } else { 
			     len = len + 2; 
			  } 
			} 
			return len; 
			} 
			function back(){
				window.location.href = "baseInfo_squad_list.do";
				}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateSquadInfo.do?squadName=${squadInformation.squadName }">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                     <tr>
						<td class="pn-flabel pn-flabel-h">�����ţ�</td>
						<td class="pn-fcontent">${squadInformation.squadNo}<input readonly="readonly" type="hidden" name="squadInformation.squadNo" value="${squadInformation.squadNo}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength20"  name="squadInformation.squadName" value="${squadInformation.squadName}" size="28"/><span style="color: red">&nbsp;*</span></td>
					    </tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��ʼʱ�䣺</td>
						<td class="pn-fcontent"><input  style="width: 204px;" class="required maxlength8" type="text" name="squadInformation.startTime" value="${squadInformation.startTime }"  class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
				     	<td class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
						<td class="pn-fcontent"><input style="width: 204px;" type="text" class="required maxlength8" name="squadInformation.endTime"  value="${squadInformation.endTime }"  class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
				
					 </tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��Ч���ڣ�</td>
						<td class="pn-fcontent"><input style="width: 204px;" class="required " type="text" name="squadInformation.startDate" value="<fmt:formatDate value="${squadInformation.startDate }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">����ƫ�ƣ�</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValue" name="squadInformation.timeDiff" value="${squadInformation.timeDiff}" size="28"/><span style="color: red">&nbsp;*</span></td>
					    </tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;����</td>
						<td colspan="4"  class="pn-fcontent">
						<textarea class=" maxlength30" name="squadInformation.remark" rows="3" cols="40">${squadInformation.remark}</textarea></td>
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
		<script type="text/javascript">
		if(record == "fail") {
			get("squadInformation.squadName").focus();
		}
		</script>
	</body>
</html>