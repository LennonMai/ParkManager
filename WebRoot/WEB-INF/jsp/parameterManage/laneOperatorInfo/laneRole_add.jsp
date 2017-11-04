<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>��ӳ�����ɫ��Ϣ</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>		
		<script type="text/javascript">	
		if("${message}"=="exitLaneRole"){
			alert("��ɫ�����Ѵ��ڣ�");
			}
        //������ҳ
		function back(){
			window.location.href = "laneRole_list.do";
			}
	
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="laneRole_save.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">��ɫ���룺</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_smallint" name="laneRole.roleNo" value="${laneRole.roleNo}" size="24"/><span style="color: red">&nbsp;*</span></td>
					  	<td class="pn-flabel pn-flabel-h">��ɫ���ƣ�</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength20" name="laneRole.roleName" value="${laneRole.roleName}" size="24"/><span style="color: red">&nbsp;*</span></td>
					</tr>
	     			<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;ע��</td>
						<td colspan="4" class="pn-fcontent"><textarea class=maxlength100 name="laneRole.remark"  rows="3" cols="48">${laneRole.remark}</textarea></td>
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