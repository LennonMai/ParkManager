<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			//��ӡ
			function doPrint() {
				// ���body��html
				bdhtml=window.document.body.innerHTML;
				// ��ӡ��ʼ�ı�־
				sprnstr="<!--startprint-->";
				// ��ӡ�����ı�־
				eprnstr="<!--endprint-->";
				// �Ӵ�ӡ��ʼ��λ�ý�ȡ��ĩβ
				prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17);
				// �ӿ�ʼ��ȡ����ӡ������λ��
				prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
				// �滻html
				window.document.body.innerHTML=prnhtml;
				// ��ӡ
				window.print();
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="generateSum_queryGateSum.do" >
				
			<!-- ${fn:length(list)} ��ʾlist����-->
			<!--startprint-->
			<div align="center"><font size="5">�����ܺϼ���</font></div>
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>��&nbsp;&nbsp;��</th>
						<th>С&nbsp;&nbsp;��</th>
						<th>��&nbsp;&nbsp;��</th>
						<th>��������</th>
						<th>��¼��</th>
						<th>ͨ�з�</th>
						<th>�Ƿ�ϼ�</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.AreaName }</td>
							<td>${item.ParkName }</td>
							<td>${item.GateName }</td>
							<td>${item.SquadDate}</td>
							<td>${item.RecordCnt }</td>
							<td>${item.MoneySummation }</td>
							<td>${item.StationYNSum }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!--endprint-->
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="button" value=" �� �� " onclick="history.back();"/>&nbsp;
						<input type="button" value=" �� ӡ " onclick="doPrint();"/>
						</td>
					</tr>
				</table>
			<!--<jsp:include page="../../../include/pager.jsp"/>-->
			</form>
		</div>
	</body>
</html>