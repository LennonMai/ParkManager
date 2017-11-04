<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			if("${message}"=="12"){
				alert("�����ˮ��û�и�����Ϣ");
			}
			if("${message}"=="13"){
				alert("������ˮ��û�и�����Ϣ");
			}
			function check(){
			var start = document.getElementById('startTime').value;
			var end = document.getElementById('endTime').value;
			if(start != "" && end != ""){
				if(start > end){
					alert("��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡");
					return false;
				}
			}
			return true;
		}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="lostCard_queryHistory.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">ʱ �� �Σ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="startTime" id ="startTime" value= "${startTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
						  	--<input type="text" name="endTime" id ="endTime" value="${endTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
						</td>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;�ţ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNo" value="${cardNo}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;����</td>
						<td class="pn-fcontent">
						  	<input type="text" name="owner" value="${owner }" />
						</td>
						<td class="pn-flabel pn-flabel-h">�� �� �ţ�</td>
						<td class="pn-fcontent">
						  	<input type="text" name="vehPlate" value="${vehPlate}" />
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� ѯ " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value=" �� �� "/>		
						</td>
					</tr>
				</table>
			<!-- ��ʾlist����-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>��    ��</th>
						<th>����ʱ��</th>
						<th>�� �� ��</th>
						<th>�ÿ�����</th>
						<th>�� ˮ ��</th>					
						<th>����Ա��</th>
						<th>������ˮ</th>
						<th>����ʱ��</th>
						<th>�� �� Ա</th>
						<th>�� ״ ̬</th>
						<th>���ڱ�ע</th>
						<th>��    ��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.cardNo }</td>
							<td><fmt:formatDate value="${item.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item.vehPlate }</td>
							<td>${item.owner }</td>
							<td>${item.listNo }</td>
							<td>${item.operatorName }</td>
							<td>${item.outListNo }</td>
							<td><fmt:formatDate value="${item.outOpTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item.outOperatorName }</td>
							<td>
								<c:if test="${item.cardStatus==11}">��ڷ���</c:if>
								<c:if test="${item.cardStatus==12}">���ڻ���</c:if>
								<c:if test="${item.cardStatus==13}">����(��ʧ���ݲ��㣬�޷�׷��)</c:if>
								<c:if test="${item.cardStatus==14}">δ֪</c:if>
								<c:if test="${item.cardStatus==15}">����</c:if>
								<c:if test="${item.cardStatus==16}">�ѷ���</c:if>
							</td>
							<td>${item.outRemark }</td>
							<td>
								<a href="lostCard_historyMessage.do?inListNo=${item.listNo }&outListNo=${item.outListNo }&cardNo=${item.cardNo }&opTime=${item.opTime }&squadDate=${item.squadDate }&OutSquadDate=${item.outSquadDate }" class="pn-loperator">������ϸ��Ϣ</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>