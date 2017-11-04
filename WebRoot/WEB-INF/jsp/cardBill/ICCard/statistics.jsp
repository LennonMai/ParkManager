<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>IC�����ͳ��</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script> 
		<script type="text/javascript" src="${basePath}/js/CJL.0.1.min.js"></script>  
		<script type="text/javascript" src="${basePath}/js/MSGalert.js"></script>
	</head> 
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">
					��ǰλ�ã� ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
				<table align="left" class="pn-ltable" width="800"	cellspacing="1" cellpadding="0" border="0">
					<br/>
					<div><font size="2">���û�������ͳ�ƣ�</font></div>
					<thead class="pn-lthead">
						<tr>
							<c:forEach items="${userCardTypeList}" var="type">
								<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">${type.typeName }</th>
							</c:forEach>
						</tr>
					</thead>
					<tbody class="pn-ltbody">
						<tr>
							<c:forEach items="${listTypeStatistics}" var="typeStat">
								<td align="center">${typeStat }</td>
							</c:forEach>
						</tr>
					</tbody>
				</table>
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<table align="left" class="pn-ltable" width="800"	cellspacing="1" cellpadding="0" border="0" >
					<br/>
					<div><font size="2">���û���״̬ͳ�ƣ�</font></div>
					<thead class="pn-lthead">
						<tr>
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">������</th>
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">��&nbsp;&nbsp;ʧ</th>
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">��&nbsp;&nbsp;ʧ</th>
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">��&nbsp;&nbsp;��</th>
						</tr>
					</thead>
					<tbody class="pn-ltbody">
						<tr>
							<c:forEach items="${listStatusStatistics}" var="statusStat">
								<td align="center">${statusStat }</td>
							</c:forEach>
						</tr>
					</tbody>
				</table>
				
		</div>
	</body>
</html>