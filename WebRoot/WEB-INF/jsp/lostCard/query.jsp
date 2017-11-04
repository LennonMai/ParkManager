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
	</head>
	<script type="text/javascript">
		if("${message}"=="11"){
			alert("�����ˮ��û�и�����Ϣ");
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
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="lostCard_queryCardDynamic.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">ʱ �� �Σ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="startTime" id ="startTime" value= "${startTime }" class="Wdate" size="16" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						  	-- <input type="text" name="endTime" id ="endTime" value="${endTime }" class="Wdate" size="16" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;�ţ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNo" value="${cardNo}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">״&nbsp;&nbsp;̬��</td>
						<td class="pn-fcontent">
						  	<select name="status" style="width: 185px">
						  		<option value="" <c:if test="${status==null}">selected</c:if>>-��ѡ��-</option>
						  		<option value="11" <c:if test="${status==11}">selected</c:if>>��ڷ���</option>
						  		<option value="13" <c:if test="${status==13}">selected</c:if>>����(��ʧ���ݲ��㣬�޷�׷��)</option>
						  		<option value="14" <c:if test="${status==14}">selected</c:if>>δ֪</option>
						  		<option value="15" <c:if test="${status==15}">selected</c:if>>����</option>
						  		<option value="16" <c:if test="${status==16}">selected</c:if>>�ѷ���</option>
						  	</select>
						</td>
						<td class="pn-flabel pn-flabel-h">���ƺţ�</td>
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
						<th>��ʱ�������</th>
						<th>����ʱ��</th>
						<th>�� ״ ̬</th>
						<th>ʶ����</th>
						<th>����Ա���</th>
						<th>����Ա����</th>					
						<th>�����ˮ��</th>
						<th>�ÿ�����</th>
						<th>��    ��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.cardNo }</td>
							<td><fmt:formatDate value="${item.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item.status==11}">��ڷ���</c:if>
								<c:if test="${item.status==13}">����(��ʧ���ݲ��㣬�޷�׷��)</c:if>
								<c:if test="${item.status==14}">δ֪</c:if>
								<c:if test="${item.status==15}">����</c:if>
								<c:if test="${item.status==16}">�ѷ���</c:if>
							</td>
							<td>${item.vehPlate }</td>
							<td>${item.operatorNo }</td>
							<td>${item.operatorName }</td>
							<td>${item.inListNo }</td>
							<td>${item.owner }</td>
							<td>
								<a href="lostCard_cardDynamicOk.do?queryCardNo=${item.cardNo }&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage }
									&startTime=${startTime }&endTime=${endTime }&cardNo=${cardNo }&status=${status }&vehPlate=${vehPlate }" class="pn-loperator">״̬ȷ��</a>
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