<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
	if ("${result}" == "FAIL")
		alert("û�����˻�������Ϣ");

	function check() {
		if (get("updateAccountLog.accountNo").value != "") {
			var partten = /^\+?[0-9][0-9]*$/;
			if (partten.test(get("updateAccountLog.accountNo").value)) {
			} else {
				alert("�û��˺�Ϊ���֣����������룡");
				get("updateAccountLog.accountNo").focus();
				return false;
			}
		}
		if (get("startTime1").value != "" && get("endTime1").value != "") {
			if (get("startTime1").value > get("endTime1").value) {
				alert("��ʼʱ��������ڻ���ڽ���ʱ��");
				return false;
			}
		}

	}
</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="updateAccountLog_query.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2"
					cellspacing="1" border="0">

					<tr>
						<td class="pn-flabel pn-flabel-h">
							�û��˺ţ�
						</td>
						<td class="pn-fcontent">
							<input type="text" name="updateAccountLog.accountNo"
								value="${updateAccountLog.accountNo}" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�
						</td>
						<td class="pn-fcontent">
							<input type="text" name="updateAccountLog.cardNo"
								value="${updateAccountLog.cardNo}" />
						</td>
					</tr>

					<tr>

						<td class="pn-flabel pn-flabel-h">
							��&nbsp;��&nbsp;����
						</td>
						<td class="pn-fcontent">
							<input type="text" name="updateAccountLog.userName"
								value="${updateAccountLog.userName}" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							��&nbsp;��&nbsp;�ţ�
						</td>
						<td class="pn-fcontent">
							<input type="text" name="updateAccountLog.vehPlate"
								value="${updateAccountLog.vehPlate}" />
						</td>
					</tr>
					<tr>	<td class="pn-flabel pn-flabel-h">
							�˺�״̬��
						</td>
						<td  class="pn-fcontent">
							<select name="updateAccountLog.status" style="width: 150px">
								<option value=""
									<c:if test="${updateAccountLog.status==null}">selected</c:if>>
									��ѡ��
								</option>
								<option value="0"
									<c:if test="${updateAccountLog.status==0}">selected</c:if>>
									��Ч
								</option>
								<option value="1"
									<c:if test="${updateAccountLog.status==1}">selected</c:if>>
									��ʧ
								</option>
								<option value="2"
									<c:if test="${updateAccountLog.status==2}">selected</c:if>>
									Ԥ����
								</option>
								<option value="5"
									<c:if test="${updateAccountLog.status==5}">selected</c:if>>
									������
								</option>
								<option value="7"
									<c:if test="${updateAccountLog.status==7}">selected</c:if>>
									������
								</option>
								<option value="4"
									<c:if test="${updateAccountLog.status==4}">selected</c:if>>
									����
								</option>
							</select>
						</td>					
							<td class="pn-flabel pn-flabel-h">
								֤�����룺
							</td>
							<td class="pn-fcontent">
								<input type="text" name="updateAccountLog.credentialsNo"
									value="${updateAccountLog.credentialsNo}" />
							</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							����ʱ�䣺
						</td>
						<td colspan="3" class="pn-fcontent">
							<input type="text" name="startTime"
								value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss" />"
								class="Wdate"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">
								- <input type="text" name="endTime"
									value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss" />"
									class="Wdate"
									onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� ѯ " />
							&nbsp;
							<input type="reset" value=" �� �� " />

						</td>
					</tr>
				</table>
				<table class="pn-ltable" width="100%" cellspacing="1"
					cellpadding="0" border="0">
					<thead class="pn-lthead">
						<tr>
							<th>
								�û��ʺ�
							</th>
							<th>
								��&nbsp;&nbsp;��
							</th>
							<th>
								�û���&nbsp;&nbsp;
							</th>
							<th>
								֤������
							</th>
							<th>
								֤������
							</th>
							<th>
								���ƺ�&nbsp;&nbsp;
							</th>
							<th>
								����ʱ��
							</th>
							<th>
								�˺�״̬
							</th>
							<th>
								��&nbsp;&nbsp;��
							</th>

						</tr>
					</thead>
					<tbody class="pn-ltbody">
						<c:forEach items="${list}" var="item">
							<tr onmouseover="this.className='pn-lhover'"
								onmouseout="this.className=''" align="center">
								<td>
									${item.accountNo}
								</td>
								<td>
									${item.cardNo}
								</td>

								<td>
									${item.userName}
								</td>
								<td>
									<c:if test="${item.credentialsType==0}">���֤</c:if>
									<c:if test="${item.credentialsType==1}">��&nbsp;&nbsp;��</c:if>
								</td>
								<td>
									${item.credentialsNo}
								</td>

								<td>
									${item.vehPlate}
								</td>
								<td>
									${item.updateTime}
								</td>
								<td>
									<c:if test="${item.status==0}">��Ч</c:if>
									<c:if test="${item.status==1}">��ʧ</c:if>
									<c:if test="${item.status==2}">Ԥ����</c:if>
									<c:if test="${item.status==4}">����</c:if>
									<c:if test="${item.status==5}">������</c:if>
									<c:if test="${item.status==7}">������</c:if>
								</td>
								<td>
									<a
										href="updateAccountLog_detail.do?updateAccountLog.accountNo=${item.accountNo}&updateAccountLog.seqNo=${item.seqNo}"
										class="pn-loperator">��ϸ��Ϣ</a>
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