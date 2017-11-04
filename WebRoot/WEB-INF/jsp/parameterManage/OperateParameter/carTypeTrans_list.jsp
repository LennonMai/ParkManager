<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>����ת������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">

		</script>
	</head> 
	<body >
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="operatePara_carTypeTrans_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
					    <td class="pn-flabel pn-flabel-h">��ʼ���ڣ�</td>
						<td class="pn-fcontent"> <input type="text" name="carTypeTrans.startDate" value="${carTypeTrans.startDate }" size="24"/></td>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td class="pn-fcontent"> <input type="text" name="carTypeTrans.class_" value="${carTypeTrans.class_ }" size="24"/></td>
					
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td class="pn-fcontent"> <input type="text" name="carTypeTrans.weight" value="${carTypeTrans.weight }" size="24"/></td>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</td>
						<td class="pn-fcontent"> <input type="text" name="carTypeTrans.vehType" value="${carTypeTrans.vehType }" size="24"/></td>
					
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton" style="padding-bottom: 3px;padding-top: 3px;">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� "/>	
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ʼ����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�߶�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" >
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.startDate}</td>
						    <td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.class_}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.length}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.height}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.width}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.wheelNumber}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.axleNumber}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.weight}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.vehType}</td>
							
							
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		</div>		
	</body>
</html>